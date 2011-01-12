Content-Type: multipart/mixed; boundary="===============4394725749385335887=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 17/21] gprs: Add DUN server GPRS connect support
Date: Wed, 12 Jan 2011 18:16:00 +0100
Message-ID: <1294852564-1258-18-git-send-email-frederic.dalleau@intel.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4394725749385335887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zhenhua Zhang <zhenhua.zhang@intel.com>

Implement dial up networking in GPRS atom.
---
 src/gprs.c |  229 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 227 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 0feb344..e90f043 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -57,6 +57,10 @@
 #define MAX_CONTEXTS 256
 #define SUSPEND_TIMEOUT 8
 =

+#define DUN_LOCAL "192.168.1.1"
+#define DUN_PEER "192.168.1.2"
+#define DUN_CONNECT_TIMEOUT 20
+
 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
 =

@@ -95,6 +99,9 @@ struct ofono_gprs {
 	unsigned int dun_watch;
 	unsigned int dun_status_watch;
 	struct gprs_dun_data dun_data;
+	int attach_source;
+	int context_source;
+	int timeout_source;
 };
 =

 struct ofono_gprs_context {
@@ -136,6 +143,7 @@ struct pri_context {
 };
 =

 static void gprs_netreg_update(struct ofono_gprs *gprs);
+static gboolean dun_connect_remove(gpointer user_data);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
 =

 static const char *gprs_context_default_name(enum ofono_gprs_context_type =
type)
@@ -676,7 +684,9 @@ static void pri_activate_callback(const struct ofono_er=
ror *error,
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Activating context failed with error: %s",
 				telephony_error_to_str(error));
-		__ofono_dbus_pending_reply(&ctx->pending,
+
+		if (ctx->pending)
+			__ofono_dbus_pending_reply(&ctx->pending,
 					__ofono_error_failed(ctx->pending));
 =

 		gprs_cid_release(ctx->gprs, ctx->context.cid);
@@ -684,11 +694,15 @@ static void pri_activate_callback(const struct ofono_=
error *error,
 		ctx->context_driver->inuse =3D FALSE;
 		ctx->context_driver =3D NULL;
 =

+		if (ctx->gprs->dun)
+			dun_connect_remove(ctx->gprs);
+
 		return;
 	}
 =

 	ctx->active =3D TRUE;
-	__ofono_dbus_pending_reply(&ctx->pending,
+	if (ctx->pending)
+		__ofono_dbus_pending_reply(&ctx->pending,
 				dbus_message_new_method_return(ctx->pending));
 =

 	/*
@@ -1967,6 +1981,27 @@ void ofono_gprs_set_cid_range(struct ofono_gprs *gpr=
s,
 	gprs->cid_map =3D idmap_new_from_range(min, max);
 }
 =

+static void ofono_gprs_remove_sources(struct ofono_gprs *gprs)
+{
+	if (gprs =3D=3D NULL)
+		return;
+
+	if (gprs->timeout_source) {
+		g_source_remove(gprs->timeout_source);
+		gprs->timeout_source =3D 0;
+	}
+
+	if (gprs->attach_source) {
+		g_source_remove(gprs->attach_source);
+		gprs->attach_source =3D 0;
+	}
+
+	if (gprs->context_source) {
+		g_source_remove(gprs->context_source);
+		gprs->context_source =3D 0;
+	}
+}
+
 static void gprs_context_unregister(struct ofono_atom *atom)
 {
 	struct ofono_gprs_context *gc =3D __ofono_atom_get_data(atom);
@@ -1974,6 +2009,8 @@ static void gprs_context_unregister(struct ofono_atom=
 *atom)
 	if (gc->gprs =3D=3D NULL)
 		return;
 =

+	ofono_gprs_remove_sources(gc->gprs);
+
 	gc->gprs->context_drivers =3D g_slist_remove(gc->gprs->context_drivers,
 							gc);
 	gc->gprs =3D NULL;
@@ -2026,6 +2063,183 @@ void ofono_gprs_context_deactivated(struct ofono_gp=
rs_context *gc,
 	}
 }
 =

+static ofono_bool_t set_primary_context_powered(struct pri_context *ctx,
+						ofono_bool_t value)
+{
+	struct ofono_gprs_context *gc =3D ctx->context_driver;
+
+	if (gc =3D=3D NULL || gc->driver->activate_primary =3D=3D NULL ||
+			gc->driver->deactivate_primary =3D=3D NULL ||
+			ctx->gprs->cid_map =3D=3D NULL)
+		return FALSE;
+
+	if (ctx->pending)
+		return FALSE;
+
+	if (ctx->active =3D=3D value)
+		return FALSE;
+
+	if (value && !ctx->gprs->attached)
+		return FALSE;
+
+	if (ctx->gprs->flags & GPRS_FLAG_ATTACHING)
+		return FALSE;
+
+	if (value) {
+		ctx->context.cid =3D gprs_cid_alloc(ctx->gprs);
+
+		if (ctx->context.cid =3D=3D 0)
+			return FALSE;
+
+		if (ctx->context.cid !=3D
+				idmap_get_min(ctx->gprs->cid_map)) {
+			ofono_error("Multiple active contexts are"
+					" not yet supported");
+
+			gprs_cid_release(ctx->gprs, ctx->context.cid);
+			ctx->context.cid =3D 0;
+
+			return FALSE;
+		}
+	}
+
+	if (value)
+		gc->driver->activate_primary(gc, &ctx->context,
+					pri_activate_callback, ctx);
+	else
+		gc->driver->deactivate_primary(gc, ctx->context.cid,
+					pri_deactivate_callback, ctx);
+
+	return TRUE;
+}
+
+static void ofono_gprs_dun_disconnect(struct ofono_gprs *gprs,
+				struct ofono_emulator_req *req)
+{
+	struct pri_context *context =3D gprs->dun_data.context;
+
+	ofono_gprs_remove_sources(gprs);
+
+	if (context->active) {
+		struct ofono_gprs_context *gc =3D context->context_driver;
+
+		gc->driver->deactivate_primary(gc, context->context.cid,
+					gprs_deactivate_for_remove, context);
+	} else
+		remove_context(context);
+}
+
+static gboolean dun_connect_remove(gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_dun_data *data =3D &gprs->dun_data;
+	struct ofono_error error;
+
+	ofono_gprs_remove_sources(gprs);
+	remove_context(data->context);
+
+	error.type =3D OFONO_ERROR_TYPE_FAILURE;
+	data->cb(&error, NULL, NULL, NULL, NULL, data->cb_data);
+
+	data->cb =3D NULL;
+	data->cb_data =3D NULL;
+	data->context =3D NULL;
+	data->dun =3D NULL;
+
+	return FALSE;
+}
+
+static gboolean pri_context_update(gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_dun_data *data =3D &gprs->dun_data;
+	struct pri_context *context =3D data->context;
+	struct context_settings *settings =3D context->settings;
+	struct ofono_error error;
+
+	DBG("active %d\n", context->active);
+
+	if (context->active !=3D TRUE)
+		return TRUE;
+
+	gprs->context_source =3D 0;
+	g_source_remove(gprs->timeout_source);
+
+	error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+
+	data->cb(&error, settings->interface, DUN_LOCAL, DUN_PEER,
+					(const char **)settings->dns,
+					data->cb_data);
+
+	return FALSE;
+}
+
+static gboolean gprs_attach_update(gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_dun_data *data =3D &gprs->dun_data;
+	struct pri_context *context =3D data->context;
+
+	DBG("attached %d driver attached %d\n", gprs->attached,
+						gprs->driver_attached);
+
+	if (gprs->attached !=3D TRUE || gprs->driver_attached !=3D TRUE)
+		return TRUE;
+
+	gprs->attach_source =3D 0;
+
+	if (context->active !=3D TRUE) {
+		set_primary_context_powered(context, TRUE);
+
+		/* wait until the primary context is actived */
+		gprs->context_source =3D g_timeout_add_seconds(1,
+						pri_context_update, gprs);
+		return FALSE;
+	}
+
+	pri_context_update(gprs);
+
+	return FALSE;
+}
+
+static void ofono_gprs_dun_connect(struct ofono_gprs *gprs,
+				struct ofono_emulator_gprs_connect_req *req)
+{
+	const char *dial_str =3D req->dial_str;
+	struct gprs_dun_data *data =3D &gprs->dun_data;
+	struct ofono_error error;
+
+	DBG("%s", dial_str);
+
+	if (data->context =3D=3D NULL)
+		goto error;
+
+	data->cb =3D req->cb;
+	data->cb_data =3D req->cb_data;
+
+	gprs->timeout_source =3D g_timeout_add_seconds(DUN_CONNECT_TIMEOUT,
+						dun_connect_remove, gprs);
+
+	/* check gprs attaching status */
+	if (!gprs->powered || !gprs->attached || !gprs->driver_attached) {
+		gprs->powered =3D TRUE;
+
+		gprs_netreg_update(gprs);
+
+		/* wait until GPRS is attached */
+		gprs->attach_source =3D g_timeout_add_seconds(1,
+						gprs_attach_update, gprs);
+		return;
+	}
+
+	gprs_attach_update(gprs);
+
+	return;
+error:
+	error.type =3D OFONO_ERROR_TYPE_FAILURE;
+	req->cb(&error, NULL, NULL, NULL, NULL, req->cb_data);
+}
+
 static void ofono_gprs_set_cgatt(struct ofono_gprs *gprs,
 				struct ofono_emulator_req *req)
 {
@@ -2083,12 +2297,21 @@ static void dun_status_watch(struct ofono_emulator =
*e,
 		return;
 =

 	switch (status) {
+	case OFONO_EMULATOR_STATUS_DUN_CONNECT:
+		ofono_gprs_dun_connect(gprs, data);
+		break;
+	case OFONO_EMULATOR_STATUS_DUN_DISCONNECTED:
+		ofono_gprs_dun_disconnect(gprs, data);
+		break;
 	case OFONO_EMULATOR_STATUS_SET_CGATT:
 		ofono_gprs_set_cgatt(gprs, data);
 		break;
 	case OFONO_EMULATOR_STATUS_SET_CGDCONT:
 		ofono_gprs_set_cgdcont(gprs, data);
 		break;
+	case OFONO_EMULATOR_STATUS_DESTROY:
+		ofono_gprs_remove_sources(gprs);
+		break;
 	default:
 		break;
 	}
@@ -2287,6 +2510,8 @@ static void gprs_unregister(struct ofono_atom *atom)
 		gprs->dun =3D NULL;
 	}
 =

+	ofono_gprs_remove_sources(gprs);
+
 	ofono_modem_remove_interface(modem,
 					OFONO_CONNECTION_MANAGER_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============4394725749385335887==--

