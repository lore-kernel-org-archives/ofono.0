Content-Type: multipart/mixed; boundary="===============7378803950952843397=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/3] gprs: attach on demand
Date: Thu, 02 Dec 2010 18:16:20 +0200
Message-ID: <1291306582-19024-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1291306582-19024-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7378803950952843397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Attach automatically when a GPRS context is activated
---
 src/gprs.c |  153 ++++++++++++++++++++++++++++++++------------------------=
---
 1 files changed, 83 insertions(+), 70 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 610f3b2..d4b4e24 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -106,6 +106,7 @@ struct context_settings {
 =

 struct pri_context {
 	ofono_bool_t active;
+	ofono_bool_t activation_pending;
 	enum ofono_gprs_context_type type;
 	char name[MAX_CONTEXT_NAME_LENGTH + 1];
 	char message_proxy[MAX_MESSAGE_PROXY_LENGTH + 1];
@@ -647,6 +648,49 @@ static DBusMessage *pri_get_properties(DBusConnection =
*conn,
 	return reply;
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
+static void free_context(struct pri_context *ctx)
+{
+	gprs_cid_release(ctx->gprs, ctx->context.cid);
+	ctx->context.cid =3D 0;
+	ctx->active =3D FALSE;
+	ctx->activation_pending =3D FALSE;
+	if (ctx->context_driver)
+		ctx->context_driver->inuse =3D FALSE;
+	ctx->context_driver =3D NULL;
+}
+
 static void pri_activate_callback(const struct ofono_error *error,
 					const char *interface,
 					ofono_bool_t static_ip,
@@ -666,11 +710,7 @@ static void pri_activate_callback(const struct ofono_e=
rror *error,
 		__ofono_dbus_pending_reply(&ctx->pending,
 					__ofono_error_failed(ctx->pending));
 =

-		gprs_cid_release(ctx->gprs, ctx->context.cid);
-		ctx->context.cid =3D 0;
-		ctx->context_driver->inuse =3D FALSE;
-		ctx->context_driver =3D NULL;
-
+		free_context(ctx);
 		return;
 	}
 =

@@ -706,15 +746,9 @@ static void pri_deactivate_callback(const struct ofono=
_error *error, void *data)
 		return;
 	}
 =

-	gprs_cid_release(ctx->gprs, ctx->context.cid);
-	ctx->context.cid =3D 0;
-	ctx->active =3D FALSE;
-	ctx->context_driver->inuse =3D FALSE;
-	ctx->context_driver =3D NULL;
-
+	free_context(ctx);
 	__ofono_dbus_pending_reply(&ctx->pending,
 				dbus_message_new_method_return(ctx->pending));
-
 	pri_reset_context_settings(ctx);
 =

 	value =3D ctx->active;
@@ -957,38 +991,6 @@ static DBusMessage *pri_set_message_center(struct pri_=
context *ctx,
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
@@ -1030,8 +1032,19 @@ static DBusMessage *pri_set_property(DBusConnection =
*conn,
 		if (ctx->active =3D=3D (ofono_bool_t) value)
 			return dbus_message_new_method_return(msg);
 =

-		if (value && !ctx->gprs->attached)
-			return __ofono_error_not_attached(msg);
+		if (value && !ctx->gprs->attached) {
+			gprs_netreg_update(ctx->gprs);
+
+			if (!(ctx->gprs->flags & GPRS_FLAG_ATTACHING))
+				return __ofono_error_not_attached(msg);
+
+			if (!assign_context(ctx))
+				return __ofono_error_not_implemented(msg);
+
+			ctx->activation_pending =3D TRUE;
+			ctx->pending =3D dbus_message_ref(msg);
+			return NULL;
+		}
 =

 		if (ctx->gprs->flags & GPRS_FLAG_ATTACHING)
 			return __ofono_error_attach_in_progress(msg);
@@ -1284,6 +1297,8 @@ static void gprs_attached_update(struct ofono_gprs *g=
prs)
 	const char *path;
 	ofono_bool_t attached;
 	dbus_bool_t value;
+	GSList *l;
+	struct pri_context *ctx;
 =

 	attached =3D gprs->driver_attached &&
 		(gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
@@ -1294,24 +1309,32 @@ static void gprs_attached_update(struct ofono_gprs =
*gprs)
 =

 	gprs->attached =3D attached;
 =

-	if (gprs->attached =3D=3D FALSE) {
-		GSList *l;
-		struct pri_context *ctx;
-
-		for (l =3D gprs->contexts; l; l =3D l->next) {
-			ctx =3D l->data;
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+		struct ofono_gprs_context *gc =3D ctx->context_driver;
 =

-			if (ctx->active =3D=3D FALSE)
+		if (attached) {
+			if (!ctx->activation_pending)
 				continue;
 =

-			gprs_cid_release(gprs, ctx->context.cid);
-			ctx->context.cid =3D 0;
-			ctx->active =3D FALSE;
-			ctx->context_driver->inuse =3D FALSE;
-			ctx->context_driver =3D NULL;
+			ctx->activation_pending =3D FALSE;
 =

+			gc->driver->activate_primary(gc, &ctx->context,
+							pri_activate_callback,
+							ctx);
+		} else {
+			ofono_bool_t active =3D ctx->active;
+
+			if (ctx->activation_pending)
+				__ofono_dbus_pending_reply(&ctx->pending,
+					__ofono_error_failed(ctx->pending));
+
+			free_context(ctx);
 			pri_reset_context_settings(ctx);
 =

+			if (!active)
+				continue;
+
 			value =3D FALSE;
 			ofono_dbus_signal_property_changed(conn, ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
@@ -1758,12 +1781,7 @@ static void gprs_deactivate_for_all(const struct ofo=
no_error *error,
 		return;
 	}
 =

-	gprs_cid_release(gprs, ctx->context.cid);
-	ctx->active =3D FALSE;
-	ctx->context.cid =3D 0;
-	ctx->context_driver->inuse =3D FALSE;
-	ctx->context_driver =3D NULL;
-
+	free_context(ctx);
 	pri_reset_context_settings(ctx);
 =

 	value =3D ctx->active;
@@ -1997,12 +2015,7 @@ void ofono_gprs_context_deactivated(struct ofono_gpr=
s_context *gc,
 		if (ctx->context.cid !=3D cid)
 			continue;
 =

-		gprs_cid_release(ctx->gprs, ctx->context.cid);
-		ctx->context.cid =3D 0;
-		ctx->active =3D FALSE;
-		ctx->context_driver->inuse =3D FALSE;
-		ctx->context_driver =3D NULL;
-
+		free_context(ctx);
 		pri_reset_context_settings(ctx);
 =

 		value =3D FALSE;
-- =

1.7.1


--===============7378803950952843397==--

