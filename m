Content-Type: multipart/mixed; boundary="===============0582074417888515616=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 12/16] gprs: Add DUN server GPRS connect support
Date: Wed, 11 Aug 2010 10:26:37 +0800
Message-ID: <1281493601-14351-13-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0582074417888515616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement dial up networking in GPRS atom.
---
 src/gprs.c |  232 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 229 insertions(+), 3 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 2313f52..95f7ab2 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -49,6 +49,10 @@
 #define MAX_CONTEXT_NAME_LENGTH 127
 #define MAX_CONTEXTS 256
 =

+#define DUN_LOCAL "192.168.1.1"
+#define DUN_PEER "192.168.1.2"
+#define DUN_CONNECT_TIMEOUT 20
+
 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
 =

@@ -92,6 +96,9 @@ struct ofono_gprs {
 	unsigned int dun_watch;
 	unsigned int dun_status_watch;
 	struct gprs_dun_data dun_data;
+	int attach_source;
+	int context_source;
+	int timeout_source;
 };
 =

 struct ofono_gprs_context {
@@ -124,6 +131,7 @@ struct pri_context {
 };
 =

 static void gprs_netreg_update(struct ofono_gprs *gprs);
+static gboolean dun_connect_remove(gpointer user_data);
 =

 static const char *gprs_context_type_to_string(int type)
 {
@@ -453,17 +461,24 @@ static void pri_activate_callback(const struct ofono_=
error *error,
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Activating context failed with error: %s",
 				telephony_error_to_str(error));
-		__ofono_dbus_pending_reply(&gc->pending,
+
+		if (gc->pending)
+			__ofono_dbus_pending_reply(&gc->pending,
 					__ofono_error_failed(gc->pending));
 =

 		gprs_cid_release(ctx->gprs, ctx->context.cid);
 		ctx->context.cid =3D 0;
 =

+		if (ctx->gprs->dun)
+			dun_connect_remove(ctx->gprs);
+
 		return;
 	}
 =

 	ctx->active =3D TRUE;
-	__ofono_dbus_pending_reply(&gc->pending,
+
+	if (gc->pending)
+		__ofono_dbus_pending_reply(&gc->pending,
 				dbus_message_new_method_return(gc->pending));
 =

 	/* If we don't have the interface, don't bother emitting any settings,
@@ -1488,12 +1503,35 @@ void ofono_gprs_set_cid_range(struct ofono_gprs *gp=
rs,
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
 =

-	if (gc->gprs)
+	if (gc->gprs) {
 		gc->gprs->context_driver =3D NULL;
+		ofono_gprs_remove_sources(gc->gprs);
+	}
 =

 	gc->gprs =3D NULL;
 }
@@ -1538,6 +1576,183 @@ void ofono_gprs_context_deactivated(struct ofono_gp=
rs_context *gc,
 	}
 }
 =

+static ofono_bool_t set_primary_context_powered(struct pri_context *ctx,
+						ofono_bool_t value)
+{
+	struct ofono_gprs_context *gc =3D ctx->gprs->context_driver;
+
+	if (gc =3D=3D NULL || gc->driver->activate_primary =3D=3D NULL ||
+			gc->driver->deactivate_primary =3D=3D NULL ||
+			ctx->gprs->cid_map =3D=3D NULL)
+		return FALSE;
+
+	if (gc->pending)
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
+		struct ofono_gprs_context *gc =3D gprs->context_driver;
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
@@ -1602,12 +1817,21 @@ static void dun_status_watch(struct ofono_emulator =
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
@@ -1794,6 +2018,8 @@ static void gprs_unregister(struct ofono_atom *atom)
 		gprs->dun =3D NULL;
 	}
 =

+	ofono_gprs_remove_sources(gprs);
+
 	ofono_modem_remove_interface(modem,
 					OFONO_DATA_CONNECTION_MANAGER_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
-- =

1.7.0.4


--===============0582074417888515616==--

