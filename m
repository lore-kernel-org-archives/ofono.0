Content-Type: multipart/mixed; boundary="===============0228252130910509917=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 03/15] emulator: Add status watches for ofono emulator
Date: Wed, 07 Jul 2010 18:01:40 +0800
Message-ID: <1278496912-13777-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0228252130910509917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The status watches monitor the emulator activities. Other atoms like
gprs, netreg could register notification to watch emulator status
changes.
---
 include/emulator.h |    6 +++++
 src/emulator.c     |   55 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h        |   11 ++++++++++
 3 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 2d23795..c76dbc7 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -30,6 +30,12 @@ extern "C" {
 =

 struct ofono_emulator;
 =

+enum ofono_emulator_status {
+	OFONO_EMULATOR_STATUS_IDLE =3D 0,
+	OFONO_EMULATOR_STATUS_CREATE,
+	OFONO_EMULATOR_STATUS_DESTROY,
+};
+
 enum ofono_emulator_type {
 	OFONO_EMULATOR_TYPE_NONE,
 	OFONO_EMULATOR_TYPE_DUN,
diff --git a/src/emulator.c b/src/emulator.c
index c47152e..7551eb6 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -41,6 +41,8 @@ struct ofono_emulator {
 	void *user_data;
 	GAtServer *server;
 	ofono_bool_t powered;
+	enum ofono_emulator_status status;
+	struct ofono_watchlist *status_watches;
 };
 =

 static GSList *emulator_list;
@@ -149,6 +151,20 @@ void *ofono_emulator_get_data(struct ofono_emulator *e)
 	return e->user_data;
 }
 =

+static void notify_status_watches(struct ofono_emulator *e, void *data)
+{
+	struct ofono_watchlist_item *item;
+	ofono_emulator_status_notify_cb_t notify;
+	GSList *l;
+
+	for (l =3D e->status_watches->items; l; l =3D l->next) {
+		item =3D l->data;
+		notify =3D item->notify;
+
+		notify(e, e->status, data, item->notify_data);
+	}
+}
+
 static void emulator_remove(struct ofono_atom *atom)
 {
 	struct ofono_emulator *e =3D  __ofono_atom_get_data(atom);
@@ -163,6 +179,7 @@ static void emulator_remove(struct ofono_atom *atom)
 	if (e->driver->remove)
 		e->driver->remove(e);
 =

+	__ofono_watchlist_free(e->status_watches);
 	ofono_emulator_release_id(e->id);
 	g_free(e);
 	e =3D NULL;
@@ -173,6 +190,9 @@ void ofono_emulator_disable(struct ofono_emulator *e)
 	if (e->server =3D=3D NULL)
 		return;
 =

+	e->status =3D OFONO_EMULATOR_STATUS_DESTROY;
+	notify_status_watches(e, NULL);
+
 	g_at_server_shutdown(e->server);
 	g_at_server_unref(e->server);
 	e->server =3D NULL;
@@ -224,6 +244,9 @@ ofono_bool_t ofono_emulator_enable(struct ofono_emulato=
r *e, int fd)
 =

 	e->powered =3D TRUE;
 =

+	e->status =3D OFONO_EMULATOR_STATUS_CREATE;
+	notify_status_watches(e, NULL);
+
 	return TRUE;
 =

 error:
@@ -253,6 +276,7 @@ static struct ofono_emulator *create_emulator(struct of=
ono_modem *modem,
 =

 	e->modem =3D modem;
 	e->driver =3D driver;
+	e->status_watches =3D __ofono_watchlist_new(g_free);
 	e->id =3D ofono_emulator_next_id();
 =

 	return e;
@@ -351,6 +375,37 @@ static gboolean ofono_emulator_dbus_register(struct of=
ono_modem *modem,
 	return TRUE;
 }
 =

+unsigned int __ofono_emulator_add_status_watch(struct ofono_emulator *e,
+				ofono_emulator_status_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	DBG("%p", e);
+
+	if (e =3D=3D NULL)
+		return 0;
+
+	if (notify =3D=3D NULL)
+		return 0;
+
+	item =3D g_new0(struct ofono_watchlist_item, 1);
+
+	item->notify =3D notify;
+	item->destroy =3D destroy;
+	item->notify_data =3D data;
+
+	return __ofono_watchlist_add_item(e->status_watches, item);
+}
+
+gboolean __ofono_emulator_remove_status_watch(struct ofono_emulator *e,
+						unsigned int id)
+{
+	DBG("%p", e);
+
+	return __ofono_watchlist_remove_item(e->status_watches, id);
+}
+
 struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
 					struct ofono_emulator_driver *driver)
 {
diff --git a/src/ofono.h b/src/ofono.h
index b2f83c2..dc560df 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -285,3 +285,14 @@ void __ofono_nettime_info_received(struct ofono_modem =
*modem,
 =

 void __ofono_emulator_probe_drivers(struct ofono_modem *modem);
 =

+typedef void (*ofono_emulator_status_notify_cb_t)(struct ofono_emulator *e,
+					enum ofono_emulator_status status,
+					void *data, void *user_data);
+
+unsigned int __ofono_emulator_add_status_watch(struct ofono_emulator *e,
+				ofono_emulator_status_notify_cb_t notify,
+				void *data, ofono_destroy_func destroy);
+
+gboolean __ofono_emulator_remove_status_watch(struct ofono_emulator *e,
+						unsigned int id);
+
-- =

1.6.3.3


--===============0228252130910509917==--

