Content-Type: multipart/mixed; boundary="===============6179273427759982496=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC_v2 3/3] gprs: Release context in driver and core when network is
 lost
Date: Fri, 13 Jul 2012 15:44:28 +0200
Message-ID: <1342187068-10418-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1342187068-10418-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6179273427759982496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   84 +++++++++++++++++++++++++++++++++++++++++++++-----------=
----
 1 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index a8f584c..0808c56 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -48,6 +48,7 @@
 =

 #define GPRS_FLAG_ATTACHING 0x1
 #define GPRS_FLAG_RECHECK 0x2
+#define GPRS_FLAG_ATTACHED_UPDATE 0x4
 =

 #define SETTINGS_STORE "gprs"
 #define SETTINGS_GROUP "Settings"
@@ -1440,6 +1441,45 @@ void ofono_gprs_resume_notify(struct ofono_gprs *gpr=
s)
 	update_suspended_property(gprs, FALSE);
 }
 =

+static gboolean have_active_contexts(struct ofono_gprs *gprs)
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
+static void release_active_contexts(struct ofono_gprs *gprs)
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
+		if (gc->driver->detach_shutdown !=3D NULL)
+			gc->driver->detach_shutdown(gc, ctx->context.cid);
+	}
+}
+
 static void gprs_attached_update(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -1454,30 +1494,22 @@ static void gprs_attached_update(struct ofono_gprs =
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
+	 * Active contexts have to be release at driver level.
+	 */
+	if (attached =3D=3D FALSE) {
+		release_active_contexts(gprs);
 		gprs->bearer =3D -1;
+	} else if (have_active_contexts(gprs) =3D=3D TRUE) {
+		gprs->flags |=3D GPRS_FLAG_ATTACHED_UPDATE;
+		return;
 	}
 =

+	gprs->attached =3D attached;
+
 	path =3D __ofono_atom_get_path(gprs->atom);
 	value =3D attached;
 	ofono_dbus_signal_property_changed(conn, path,
@@ -2266,6 +2298,16 @@ void ofono_gprs_context_deactivated(struct ofono_gpr=
s_context *gc,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
 	}
+
+	/*
+	 * If "Attached" property was about to be signalled as TRUE but there
+	 * were still active contexts, try again to signal "Attached" property
+	 * to registered applications after active contexts have been released.
+	 */
+	if (gc->gprs->flags & GPRS_FLAG_ATTACHED_UPDATE) {
+		gc->gprs->flags &=3D ~GPRS_FLAG_ATTACHED_UPDATE;
+		gprs_attached_update(gc->gprs);
+	}
 }
 =

 int ofono_gprs_context_driver_register(
-- =

1.7.5.4


--===============6179273427759982496==--

