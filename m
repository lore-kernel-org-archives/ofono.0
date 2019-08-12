Content-Type: multipart/mixed; boundary="===============0511876741871136842=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH v2 2/3] gprs: Ignore activated contexts during init,
 list them later
Date: Mon, 12 Aug 2019 23:31:29 +0200
Message-ID: <20190812213130.23420-2-richard.rojfors@gmail.com>
In-Reply-To: <20190812213130.23420-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0511876741871136842==
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
 src/gprs.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index f7a2b739..3c6a8deb 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1965,7 +1965,12 @@ void ofono_gprs_cid_activated(struct ofono_gprs  *gp=
rs, unsigned int cid,
 	struct pri_context *pri_ctx;
 	struct ofono_gprs_context *gc;
 =

-	DBG("");
+	DBG("cid %u", cid);
+
+	if (!__ofono_atom_get_registered(gprs->atom)) {
+		DBG("cid %u activated before atom registered", cid);
+		return;
+	}
 =

 	if (l_uintset_contains(gprs->used_cids, cid)) {
 		DBG("cid %u already activated", cid);
@@ -3355,11 +3360,20 @@ remove:
 		storage_sync(imsi, SETTINGS_STORE, gprs->settings);
 }
 =

+static void gprs_list_active_contexts_callback(const struct ofono_error *e=
rror,
+						void *data)
+{
+	(void)data;
+
+	DBG("error =3D %d", error->type);
+}
+
 static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
+	const struct ofono_gprs_driver *driver =3D gprs->driver;
 =

 	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
 		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
@@ -3383,6 +3397,12 @@ static void ofono_gprs_finish_register(struct ofono_=
gprs *gprs)
 					netreg_watch, gprs, NULL);
 =

 	__ofono_atom_register(gprs->atom, gprs_unregister);
+
+	/* Find any context activated during init */
+	if (driver->list_active_contexts)
+		driver->list_active_contexts(gprs,
+					     gprs_list_active_contexts_callback,
+					     gprs);
 }
 =

 static void spn_read_cb(const char *spn, const char *dc, void *data)
-- =

2.20.1


--===============0511876741871136842==--

