Content-Type: multipart/mixed; boundary="===============0958784536384614482=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 01/13] gprs: factor out common code
Date: Tue, 08 Feb 2011 17:22:14 +0200
Message-ID: <1297178546-9371-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1297178546-9371-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0958784536384614482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |  111 +++++++++++++++++++++++++++-----------------------------=
----
 1 files changed, 50 insertions(+), 61 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 7d36633..fa56f62 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -255,6 +255,49 @@ static void gprs_cid_release(struct ofono_gprs *gprs, =
unsigned int id)
 	idmap_put(gprs->cid_map, id);
 }
 =

+static gboolean assign_context(struct pri_context *ctx)
+{
+	struct idmap *cidmap =3D ctx->gprs->cid_map;
+	unsigned int cid_min;
+	GSList *l;
+
+	if (cidmap =3D=3D NULL)
+		return FALSE;
+
+	cid_min =3D idmap_get_min(cidmap);
+
+	ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);
+	if (ctx->context.cid =3D=3D 0)
+		return FALSE;
+
+	for (l =3D ctx->gprs->context_drivers; l; l =3D l->next) {
+		struct ofono_gprs_context *gc =3D l->data;
+
+		if (gc->inuse =3D=3D TRUE)
+			continue;
+
+		if (gc->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_ANY ||
+						gc->type =3D=3D ctx->type) {
+			ctx->context_driver =3D gc;
+			ctx->context_driver->inuse =3D TRUE;
+			return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
+static void release_context(struct pri_context *ctx)
+{
+	if (ctx =3D=3D NULL || ctx->gprs =3D=3D NULL || ctx->context_driver =3D=
=3D NULL)
+		return;
+
+	gprs_cid_release(ctx->gprs, ctx->context.cid);
+	ctx->context.cid =3D 0;
+	ctx->context_driver->inuse =3D FALSE;
+	ctx->context_driver =3D NULL;
+}
+
 static struct pri_context *gprs_context_by_path(struct ofono_gprs *gprs,
 						const char *ctx_path)
 {
@@ -703,12 +746,7 @@ static void pri_activate_callback(const struct ofono_e=
rror *error,
 				telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&ctx->pending,
 					__ofono_error_failed(ctx->pending));
-
-		gprs_cid_release(ctx->gprs, ctx->context.cid);
-		ctx->context.cid =3D 0;
-		ctx->context_driver->inuse =3D FALSE;
-		ctx->context_driver =3D NULL;
-
+		release_context(ctx);
 		return;
 	}
 =

@@ -744,11 +782,8 @@ static void pri_deactivate_callback(const struct ofono=
_error *error, void *data)
 		return;
 	}
 =

-	gprs_cid_release(ctx->gprs, ctx->context.cid);
-	ctx->context.cid =3D 0;
+	release_context(ctx);
 	ctx->active =3D FALSE;
-	ctx->context_driver->inuse =3D FALSE;
-	ctx->context_driver =3D NULL;
 =

 	__ofono_dbus_pending_reply(&ctx->pending,
 				dbus_message_new_method_return(ctx->pending));
@@ -995,38 +1030,6 @@ static DBusMessage *pri_set_message_center(struct pri=
_context *ctx,
 	return NULL;
 }
 =

-static gboolean assign_context(struct pri_context *ctx)
-{
-	struct idmap *cidmap =3D ctx->gprs->cid_map;
-	unsigned int cid_min;
-	GSList *l;
-
-	if (cidmap =3D=3D NULL)
-		return FALSE;
-
-	cid_min =3D idmap_get_min(cidmap);
-
-	ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);
-	if (ctx->context.cid =3D=3D 0)
-		return FALSE;
-
-	for (l =3D ctx->gprs->context_drivers; l; l =3D l->next) {
-		struct ofono_gprs_context *gc =3D l->data;
-
-		if (gc->inuse =3D=3D TRUE)
-			continue;
-
-		if (gc->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_ANY ||
-						gc->type =3D=3D ctx->type) {
-			ctx->context_driver =3D gc;
-			ctx->context_driver->inuse =3D TRUE;
-			return TRUE;
-		}
-	}
-
-	return FALSE;
-}
-
 static DBusMessage *pri_set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1344,14 +1347,9 @@ static void gprs_attached_update(struct ofono_gprs *=
gprs)
 			if (ctx->active =3D=3D FALSE)
 				continue;
 =

-			gprs_cid_release(gprs, ctx->context.cid);
-			ctx->context.cid =3D 0;
+			release_context(ctx);
 			ctx->active =3D FALSE;
-			ctx->context_driver->inuse =3D FALSE;
-			ctx->context_driver =3D NULL;
-
 			pri_reset_context_settings(ctx);
-
 			value =3D FALSE;
 			ofono_dbus_signal_property_changed(conn, ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
@@ -1736,10 +1734,7 @@ static void gprs_deactivate_for_remove(const struct =
ofono_error *error,
 		return;
 	}
 =

-	gprs_cid_release(gprs, ctx->context.cid);
-	ctx->context.cid =3D 0;
-	ctx->context_driver->inuse =3D FALSE;
-	ctx->context_driver =3D NULL;
+	release_context(ctx);
 =

 	if (gprs->settings) {
 		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
@@ -1831,12 +1826,9 @@ static void gprs_deactivate_for_all(const struct ofo=
no_error *error,
 		return;
 	}
 =

-	gprs_cid_release(gprs, ctx->context.cid);
-	ctx->active =3D FALSE;
-	ctx->context.cid =3D 0;
-	ctx->context_driver->inuse =3D FALSE;
-	ctx->context_driver =3D NULL;
+	release_context(ctx);
 =

+	ctx->active =3D FALSE;
 	pri_reset_context_settings(ctx);
 =

 	value =3D ctx->active;
@@ -2087,11 +2079,8 @@ void ofono_gprs_context_deactivated(struct ofono_gpr=
s_context *gc,
 		if (ctx->active =3D=3D FALSE)
 			break;
 =

-		gprs_cid_release(ctx->gprs, ctx->context.cid);
-		ctx->context.cid =3D 0;
+		release_context(ctx);
 		ctx->active =3D FALSE;
-		ctx->context_driver->inuse =3D FALSE;
-		ctx->context_driver =3D NULL;
 =

 		pri_reset_context_settings(ctx);
 =

-- =

1.7.1


--===============0958784536384614482==--

