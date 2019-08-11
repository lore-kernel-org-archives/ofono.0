Content-Type: multipart/mixed; boundary="===============0739147823462097214=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH 1/2] gprs: Ignore activated contexts during init,
 list them later
Date: Sun, 11 Aug 2019 18:46:30 +0200
Message-ID: <20190811164631.16804-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0739147823462097214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

There is an issue if an context gets auto activated early,
then provisioning might not have run yet for instance,
so a "new" context is created, which might be duplicated
by a provisioning context later.
So ignore the activated contexts until gprs is ready,
then it calls the driver to list active contexts.
---
 include/gprs.h |  7 +++++++
 src/gprs.c     | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/gprs.h b/include/gprs.h
index 988d6102..38e3c508 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -36,6 +36,10 @@ typedef void (*ofono_gprs_status_cb_t)(const struct ofon=
o_error *error,
 =

 typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *dat=
a);
 =

+typedef void (*ofono_gprs_active_context_cb_t)(const struct ofono_error *e=
rror,
+						int cid, const char *apn,
+						void *data);
+
 struct ofono_gprs_driver {
 	const char *name;
 	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
@@ -45,6 +49,9 @@ struct ofono_gprs_driver {
 				ofono_gprs_cb_t cb, void *data);
 	void (*attached_status)(struct ofono_gprs *gprs,
 					ofono_gprs_status_cb_t cb, void *data);
+	void (*get_active_auto_context)(struct ofono_gprs *gprs,
+					ofono_gprs_active_context_cb_t cb,
+					void *data);
 };
 =

 enum gprs_suspend_cause {
diff --git a/src/gprs.c b/src/gprs.c
index 9cb69d14..05b413c5 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1959,6 +1959,11 @@ void ofono_gprs_cid_activated(struct ofono_gprs  *gp=
rs, unsigned int cid,
 =

 	DBG("");
 =

+	if (!__ofono_atom_get_registered(gprs->atom)) {
+		DBG("cid %u activated before atom registered", cid);
+		return;
+	}
+
 	if (l_uintset_contains(gprs->used_cids, cid)) {
 		DBG("cid %u already activated", cid);
 		return;
@@ -3338,11 +3343,24 @@ remove:
 		storage_sync(imsi, SETTINGS_STORE, gprs->settings);
 }
 =

+static void gprs_get_active_context_callback(const struct ofono_error *err=
or,
+						int cid, const char *apn,
+						void *data)
+{
+	struct ofono_gprs *gprs =3D data;
+
+	DBG("error =3D %d", error->type);
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR && apn !=3D NULL && cid =
> 0)
+		ofono_gprs_cid_activated(gprs, cid, apn);
+}
+
 static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
+	const struct ofono_gprs_driver *drv =3D gprs->driver;
 =

 	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
 		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
@@ -3366,6 +3384,12 @@ static void ofono_gprs_finish_register(struct ofono_=
gprs *gprs)
 					netreg_watch, gprs, NULL);
 =

 	__ofono_atom_register(gprs->atom, gprs_unregister);
+
+	/* Find any context activated during init */
+	if (drv->get_active_auto_context)
+		drv->get_active_auto_context(gprs,
+					      gprs_get_active_context_callback,
+					      gprs);
 }
 =

 static void spn_read_cb(const char *spn, const char *dc, void *data)
-- =

2.20.1


--===============0739147823462097214==--

