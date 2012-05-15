Content-Type: multipart/mixed; boundary="===============7558259416537754336=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3] gprs: Fix wrong behavior when network is lost
Date: Tue, 15 May 2012 15:32:01 +0200
Message-ID: <1337088721-4015-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7558259416537754336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  106 ++++++++++++++++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 85 insertions(+), 21 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0d25506..9428003 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1436,6 +1436,78 @@ void ofono_gprs_resume_notify(struct ofono_gprs *gpr=
s)
 	update_suspended_property(gprs, FALSE);
 }
 =

+static void gprs_attached_update(struct ofono_gprs *gprs);
+
+static void gprs_deactivate_for_release(const struct ofono_error *error,
+						void *data)
+{
+	struct pri_context *ctx =3D data;
+	struct ofono_gprs *gprs =3D ctx->gprs;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t value;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Deactivating context failed with error: %s",
+				telephony_error_to_str(error));
+
+		return;
+	}
+
+	pri_reset_context_settings(ctx);
+	release_context(ctx);
+
+	value =3D FALSE;
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					"Active", DBUS_TYPE_BOOLEAN, &value);
+
+	/*
+	 * If "Attached" property was about to be signalled as TRUE but there
+	 * were still active contexts, try again to signal "Attached" property
+	 * to registered applications after active contexts have been released.
+	 */
+	gprs_attached_update(gprs);
+}
+
+static gboolean check_active_contexts(struct ofono_gprs *gprs)
+{
+	GSList *l;
+	struct pri_context *ctx;
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		ctx =3D l->data;
+
+		if (ctx->active =3D=3D TRUE)
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+static void deactivate_active_contexts(struct ofono_gprs *gprs)
+{
+	GSList *l;
+	struct pri_context *ctx;
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct ofono_gprs_context *gc;
+
+		ctx =3D l->data;
+
+		if (ctx->active =3D=3D FALSE)
+			continue;
+
+		/* This context is already being messed with */
+		if (ctx->pending)
+			continue;
+
+		gc =3D ctx->context_driver;
+
+		gc->driver->deactivate_primary(gc, ctx->context.cid,
+					gprs_deactivate_for_release, ctx);
+	}
+}
+
 static void gprs_attached_update(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -1450,30 +1522,22 @@ static void gprs_attached_update(struct ofono_gprs =
*gprs)
 	if (attached =3D=3D gprs->attached)
 		return;
 =

-	gprs->attached =3D attached;
-
-	if (gprs->attached =3D=3D FALSE) {
-		GSList *l;
-		struct pri_context *ctx;
-
-		for (l =3D gprs->contexts; l; l =3D l->next) {
-			ctx =3D l->data;
-
-			if (ctx->active =3D=3D FALSE)
-				continue;
-
-			pri_reset_context_settings(ctx);
-			release_context(ctx);
-
-			value =3D FALSE;
-			ofono_dbus_signal_property_changed(conn, ctx->path,
-					OFONO_CONNECTION_CONTEXT_INTERFACE,
-					"Active", DBUS_TYPE_BOOLEAN, &value);
-		}
-
+	/*
+	 * If an active context is found, a PPP session might be still active
+	 * at driver level. "Attached" =3D TRUE property can't be signalled to
+	 * the applications registered on GPRS properties.
+	 * Active contexts have to be deactivated.
+	 */
+	if (attached =3D=3D FALSE) {
+		deactivate_active_contexts(gprs);
 		gprs->bearer =3D -1;
+	} else if (check_active_contexts(gprs) =3D=3D TRUE) {
+		deactivate_active_contexts(gprs);
+		return;
 	}
 =

+	gprs->attached =3D attached;
+
 	path =3D __ofono_atom_get_path(gprs->atom);
 	value =3D attached;
 	ofono_dbus_signal_property_changed(conn, path,
-- =

1.7.5.4


--===============7558259416537754336==--

