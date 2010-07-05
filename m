Content-Type: multipart/mixed; boundary="===============8426017292029620624=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 6/6] dun_gw: Probe emulator when we have new adapter
Date: Mon, 05 Jul 2010 13:45:09 +0800
Message-ID: <1278308709-13908-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278308709-13908-6-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8426017292029620624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create emulator when we receive Bluetooth adapter property changes. In
order to do that, we iterate all active modems. If it has GPRS atom and
has not associated DUN emulator yet, create new emulator for it.
---
 include/emulator.h |    4 ++++
 plugins/dun_gw.c   |   29 +++++++++++++++++++++++++++++
 src/emulator.c     |   28 ++++++++++++++++++++++++++++
 src/modem.c        |   15 +++++++++++++++
 src/ofono.h        |    6 ++++++
 5 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 9d96d67..2d23795 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -45,6 +45,10 @@ struct ofono_emulator_driver {
 };
 =

 const char *ofono_emulator_get_path(struct ofono_emulator *e);
+
+struct ofono_emulator *ofono_emulator_find(struct ofono_modem *modem,
+						const char *type_str);
+
 void ofono_emulator_set_data(struct ofono_emulator *e, void *user_data);
 void *ofono_emulator_get_data(struct ofono_emulator *e);
 =

diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
index 43a0b0a..8169228 100644
--- a/plugins/dun_gw.c
+++ b/plugins/dun_gw.c
@@ -57,6 +57,33 @@ struct dun_data {
 =

 static struct ofono_emulator_driver dun_gw_driver;
 =

+static gboolean dun_gw_probe_emulator(struct ofono_modem *modem,
+					gpointer user_data)
+{
+	struct ofono_emulator *e;
+	ofono_bool_t powered;
+	struct ofono_atom *gprs_atom;
+
+	powered =3D ofono_modem_get_powered(modem);
+	if (!powered)
+		return TRUE;
+
+	/* Verify that modem has GPRS atom */
+	gprs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
+	if (!gprs_atom || !__ofono_atom_get_registered(gprs_atom))
+		return TRUE;
+
+	/* Ignore if DUN already has associated adapter */
+	e =3D ofono_emulator_find(modem, "dun");
+	if (e)
+		return TRUE;
+
+	ofono_emulator_create(modem, &dun_gw_driver);
+
+	 /* Only create DUN emulator on one modem */
+	return FALSE;
+}
+
 static int dun_gw_create_adapter(const char *path, const char *dev_addr,
 				const char *adapter, const char *alias)
 {
@@ -80,6 +107,8 @@ static int dun_gw_create_adapter(const char *path, const=
 char *dev_addr,
 =

 	g_hash_table_insert(adapter_hash, g_strdup(adapter), data);
 =

+	__ofono_modem_foreach(dun_gw_probe_emulator, NULL);
+
 	return 0;
 }
 =

diff --git a/src/emulator.c b/src/emulator.c
index 1155769..c47152e 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -94,6 +94,14 @@ static const char *ofono_emulator_type_to_str(enum ofono=
_emulator_type type)
 	}
 }
 =

+static enum ofono_emulator_type ofono_emulator_str_to_type(const char *typ=
e)
+{
+	if (!strcmp(type, "dun"))
+		return OFONO_EMULATOR_TYPE_DUN;
+
+	return OFONO_EMULATOR_TYPE_NONE;
+}
+
 const char *ofono_emulator_get_path(struct ofono_emulator *e)
 {
 	static char path[256];
@@ -105,6 +113,26 @@ const char *ofono_emulator_get_path(struct ofono_emula=
tor *e)
 	return path;
 }
 =

+struct ofono_emulator *ofono_emulator_find(struct ofono_modem *modem,
+						const char *type_str)
+{
+	GSList *l;
+	enum ofono_emulator_type type;
+
+	type =3D ofono_emulator_str_to_type(type_str);
+	if (type =3D=3D OFONO_EMULATOR_TYPE_NONE)
+		return NULL;
+
+	for (l =3D emulator_list; l; l =3D l->next) {
+		struct ofono_emulator *e =3D l->data;
+
+		if (e->modem =3D=3D modem && e->driver->type =3D=3D type)
+			return e;
+	}
+
+	return NULL;
+}
+
 void ofono_emulator_set_data(struct ofono_emulator *e, void *user_data)
 {
 	if (!e)
diff --git a/src/modem.c b/src/modem.c
index 8137f97..697b068 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1092,6 +1092,21 @@ void *ofono_devinfo_get_data(struct ofono_devinfo *i=
nfo)
 	return info->driver_data;
 }
 =

+void __ofono_modem_foreach(ofono_modem_foreach_cb func, gpointer user_data)
+{
+	GSList *l;
+	struct ofono_modem *modem;
+	gboolean ret;
+
+	for (l =3D g_modem_list; l; l =3D l->next) {
+		modem =3D l->data;
+
+		ret =3D (*func)(modem, user_data);
+		if (!ret)
+			break;
+	}
+}
+
 /* Clients only need to free *modems
  *
  * Note: this function will never return NULL. It will abort if it
diff --git a/src/ofono.h b/src/ofono.h
index ac2a5b0..b2f83c2 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -30,6 +30,12 @@ void __ofono_exit();
 int __ofono_manager_init();
 void __ofono_manager_cleanup();
 =

+struct ofono_modem;
+
+typedef gboolean (*ofono_modem_foreach_cb)(struct ofono_modem *modem,
+						gpointer user_data);
+
+void __ofono_modem_foreach(ofono_modem_foreach_cb func, gpointer user_data=
);
 const char **__ofono_modem_get_list();
 void __ofono_modem_shutdown();
 =

-- =

1.6.3.3


--===============8426017292029620624==--

