Content-Type: multipart/mixed; boundary="===============3740295420548367153=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 10/15] emulator: Add emulator dial up support in GPRS
Date: Wed, 07 Jul 2010 18:01:47 +0800
Message-ID: <1278496912-13777-11-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-10-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3740295420548367153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement dial up support in GPRS atom.
---
 src/gprs.c |  439 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 437 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index dd58c51..cb83e23 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -39,6 +39,7 @@
 #include "common.h"
 #include "storage.h"
 #include "idmap.h"
+#include "gatserver.h"
 =

 #define GPRS_FLAG_ATTACHING 0x1
 #define GPRS_FLAG_RECHECK 0x2
@@ -48,6 +49,10 @@
 #define MAX_CONTEXT_NAME_LENGTH 127
 #define MAX_CONTEXTS 256
 =

+#define DUN_LOCAL "192.168.1.1"
+#define DUN_PEER "192.168.1.2"
+#define EMULATOR_GPRS_TIMEOUT 20
+
 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
 =

@@ -55,6 +60,7 @@ enum gprs_context_type {
 	GPRS_CONTEXT_TYPE_INTERNET =3D 0,
 	GPRS_CONTEXT_TYPE_MMS,
 	GPRS_CONTEXT_TYPE_WAP,
+	GPRS_CONTEXT_TYPE_DUN,
 	GPRS_CONTEXT_TYPE_INVALID,
 };
 =

@@ -81,6 +87,9 @@ struct ofono_gprs {
 	struct ofono_emulator *dun;
 	unsigned int dun_watch;
 	unsigned int dun_status_watch;
+	int attach_source;
+	int context_source;
+	int timeout_source;
 	const struct ofono_gprs_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -115,6 +124,13 @@ struct pri_context {
 	struct ofono_gprs *gprs;
 };
 =

+struct gprs_dun_data {
+	struct ofono_gprs *gprs;
+	ofono_emulator_gprs_connect_cb cb;
+	void *cb_data;
+	struct pri_context *context;
+};
+
 static void gprs_netreg_update(struct ofono_gprs *gprs);
 =

 static const char *gprs_context_type_to_string(int type)
@@ -168,6 +184,21 @@ static struct pri_context *gprs_context_by_path(struct=
 ofono_gprs *gprs,
 	return NULL;
 }
 =

+static struct pri_context *gprs_context_by_type(struct ofono_gprs *gprs,
+						enum gprs_context_type type)
+{
+	GSList *l;
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+
+		if (type =3D=3D ctx->type)
+			return ctx;
+	}
+
+	return NULL;
+}
+
 static void context_settings_free(struct context_settings *settings)
 {
 	g_free(settings->interface);
@@ -401,6 +432,53 @@ static DBusMessage *pri_get_properties(DBusConnection =
*conn,
 	return reply;
 }
 =

+static void dun_activate(const char *interface, const char *local,
+						const char *peer,
+						const char **dns,
+						void *data)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct pri_context *ctx =3D data;
+	const char *netmask =3D "255.255.255.255";
+	dbus_bool_t value;
+
+	DBG("%p %s", ctx, interface);
+
+	ctx->active =3D TRUE;
+
+	/* If we don't have the interface, don't bother emitting any settings,
+	 * as nobody can make use of them
+	 */
+	if (interface !=3D NULL)
+		pri_update_context_settings(ctx, interface, TRUE,
+						local, netmask, peer, dns);
+
+	value =3D ctx->active;
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+						OFONO_DATA_CONTEXT_INTERFACE,
+						"Active", DBUS_TYPE_BOOLEAN,
+						&value);
+}
+
+static void dun_deactivate(struct pri_context *ctx)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	dbus_bool_t value;
+
+	gprs_cid_release(ctx->gprs, ctx->context.cid);
+	ctx->context.cid =3D 0;
+
+	ctx->active =3D FALSE;
+
+	pri_reset_context_settings(ctx);
+
+	value =3D ctx->active;
+	ofono_dbus_signal_property_changed(conn, ctx->path,
+						OFONO_DATA_CONTEXT_INTERFACE,
+						"Active", DBUS_TYPE_BOOLEAN,
+						&value);
+}
+
 static void pri_activate_callback(const struct ofono_error *error,
 					const char *interface, ofono_bool_t static_ip,
 					const char *ip, const char *netmask,
@@ -417,7 +495,8 @@ static void pri_activate_callback(const struct ofono_er=
ror *error,
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Activating context failed with error: %s",
 				telephony_error_to_str(error));
-		__ofono_dbus_pending_reply(&gc->pending,
+		if (gc && gc->pending)
+			__ofono_dbus_pending_reply(&gc->pending,
 					__ofono_error_failed(gc->pending));
 =

 		gprs_cid_release(ctx->gprs, ctx->context.cid);
@@ -427,7 +506,9 @@ static void pri_activate_callback(const struct ofono_er=
ror *error,
 	}
 =

 	ctx->active =3D TRUE;
-	__ofono_dbus_pending_reply(&gc->pending,
+
+	if (gc && gc->pending)
+		__ofono_dbus_pending_reply(&gc->pending,
 				dbus_message_new_method_return(gc->pending));
 =

 	/* If we don't have the interface, don't bother emitting any settings,
@@ -693,6 +774,12 @@ static DBusMessage *pri_set_property(DBusConnection *c=
onn,
 =

 		gc->pending =3D dbus_message_ref(msg);
 =

+		if (ctx->type =3D=3D GPRS_CONTEXT_TYPE_DUN) {
+			/* Not support yet */
+			ofono_error("Active DUN context are not yet supported");
+			return __ofono_error_failed(msg);
+		}
+
 		if (value)
 			gc->driver->activate_primary(gc, &ctx->context,
 						pri_activate_callback, ctx);
@@ -1095,6 +1182,82 @@ static DBusMessage *gprs_set_property(DBusConnection=
 *conn,
 	return dbus_message_new_method_return(msg);
 }
 =

+static struct pri_context *ofono_gprs_create_context(
+					struct ofono_gprs *gprs,
+					const char *name, const char *typestr)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct pri_context *context;
+	const char *path;
+	enum gprs_context_type type;
+	char **objpath_list;
+	unsigned int id;
+
+	if (strlen(name) =3D=3D 0 || strlen(name) > MAX_CONTEXT_NAME_LENGTH)
+		return NULL;
+
+	type =3D gprs_context_string_to_type(typestr);
+
+	if (type =3D=3D GPRS_CONTEXT_TYPE_INVALID)
+		return NULL;
+
+	if (gprs->last_context_id)
+		id =3D idmap_alloc_next(gprs->pid_map, gprs->last_context_id);
+	else
+		id =3D idmap_alloc(gprs->pid_map);
+
+	if (id > idmap_get_max(gprs->pid_map))
+		return NULL;
+
+	context =3D pri_context_create(gprs, name, type);
+	context->id =3D id;
+
+	if (!context) {
+		ofono_error("Unable to allocate context struct");
+		return NULL;
+	}
+
+	DBG("Registering new context");
+
+	if (!context_dbus_register(context)) {
+		ofono_error("Unable to register primary context");
+		return NULL;
+	}
+
+	gprs->last_context_id =3D id;
+
+	if (gprs->settings) {
+		g_key_file_set_string(gprs->settings, context->key,
+					"Name", context->name);
+		g_key_file_set_string(gprs->settings, context->key,
+					"AccessPointName",
+					context->context.apn);
+		g_key_file_set_string(gprs->settings, context->key,
+					"Username", context->context.username);
+		g_key_file_set_string(gprs->settings, context->key,
+					"Password", context->context.password);
+		g_key_file_set_string(gprs->settings, context->key, "Type",
+				gprs_context_type_to_string(context->type));
+		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
+	}
+
+	gprs->contexts =3D g_slist_append(gprs->contexts, context);
+
+	objpath_list =3D gprs_contexts_path_list(gprs->contexts);
+
+	if (objpath_list) {
+		path =3D __ofono_atom_get_path(gprs->atom);
+		ofono_dbus_signal_array_property_changed(conn, path,
+					OFONO_DATA_CONNECTION_MANAGER_INTERFACE,
+					"PrimaryContexts",
+					DBUS_TYPE_OBJECT_PATH, &objpath_list);
+
+		g_strfreev(objpath_list);
+	}
+
+	return context;
+}
+
 static DBusMessage *gprs_create_context(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1390,14 +1553,284 @@ void ofono_gprs_context_deactivated(struct ofono_g=
prs_context *gc,
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
+static void ofono_emulator_dun_disconnect(struct ofono_gprs *gprs,
+				struct ofono_emulator_req *req)
+{
+	struct pri_context *dun;
+
+	dun =3D gprs_context_by_type(gprs, GPRS_CONTEXT_TYPE_DUN);
+	if (!dun) {
+		req->cb(G_AT_SERVER_RESULT_NO_CARRIER, req->cb_data);
+		return;
+	}
+
+	dun_deactivate(dun);
+
+	context_dbus_unregister(dun);
+	gprs->contexts =3D g_slist_remove(gprs->contexts, dun);
+
+	req->cb(G_AT_SERVER_RESULT_NO_CARRIER, req->cb_data);
+}
+
+static void ofono_emulator_dun_connect(struct ofono_gprs *gprs,
+				struct ofono_emulator_dun_connect_req *req)
+{
+	struct pri_context *dun;
+	const char *dns[3];
+
+	dun =3D gprs_context_by_type(gprs, GPRS_CONTEXT_TYPE_DUN);
+	if (!dun) {
+		req->cb(G_AT_SERVER_RESULT_ERROR, req->cb_data);
+		return;
+	}
+
+	dns[0] =3D req->dns1;
+	dns[1] =3D req->dns2;
+	dns[2] =3D 0;
+
+	dun_activate(req->iface, req->local, req->peer, dns, dun);
+
+	req->cb(G_AT_SERVER_RESULT_OK, req->cb_data);
+}
+
+static void ofono_emulator_remove_sources(struct ofono_gprs *gprs)
+{
+	if (gprs =3D=3D NULL)
+		return;
+
+	if (gprs->timeout_source)
+		g_source_remove(gprs->timeout_source);
+
+	if (gprs->attach_source)
+		g_source_remove(gprs->attach_source);
+
+	if (gprs->context_source)
+		g_source_remove(gprs->context_source);
+}
+
+static gboolean emulator_gprs_timeout(gpointer user_data)
+{
+	struct gprs_dun_data *data =3D user_data;
+	struct ofono_gprs *gprs =3D data->gprs;
+	struct pri_context *context =3D data->context;
+	struct ofono_error error;
+
+	ofono_emulator_remove_sources(gprs);
+
+	if (context->active =3D=3D TRUE)
+		goto done;
+
+	error.type =3D OFONO_ERROR_TYPE_FAILURE;
+	data->cb(&error, NULL, NULL, NULL, NULL, data->cb_data);
+
+done:
+	g_free(data);
+
+	return FALSE;
+}
+
+static gboolean pri_context_update(gpointer user_data)
+{
+	struct gprs_dun_data *data =3D user_data;
+	struct ofono_gprs *gprs =3D data->gprs;
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
+	g_free(data);
+
+	return FALSE;
+}
+
+static gboolean gprs_attach_update(gpointer user_data)
+{
+	struct gprs_dun_data *data =3D user_data;
+	struct ofono_gprs *gprs =3D data->gprs;
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
+						pri_context_update, data);
+		return FALSE;
+	}
+
+	pri_context_update(data);
+
+	return FALSE;
+}
+
+static ofono_bool_t gprs_dun_connect(struct pri_context *dun,
+					ofono_emulator_gprs_connect_cb cb,
+					void *cb_data)
+{
+	struct ofono_gprs *gprs =3D dun->gprs;
+	struct pri_context *context;
+	struct gprs_dun_data *data =3D g_try_new0(struct gprs_dun_data, 1);
+
+	if (!data)
+		return FALSE;
+
+	/* Create context for real modem if not connected yet */
+	if (gprs->contexts)
+		context =3D gprs_context_by_type(gprs,
+						GPRS_CONTEXT_TYPE_INTERNET);
+	else
+		context =3D ofono_gprs_create_context(gprs,
+						"default", "internet");
+
+	if (!context)
+		return FALSE;
+
+	data->gprs =3D gprs;
+	data->cb =3D cb;
+	data->cb_data =3D cb_data;
+	data->context =3D context;
+
+	gprs->timeout_source =3D g_timeout_add_seconds(EMULATOR_GPRS_TIMEOUT,
+						emulator_gprs_timeout, data);
+
+	/* check gprs attaching status */
+	if (!gprs->powered || !gprs->attached || !gprs->driver_attached) {
+		gprs->powered =3D TRUE;
+
+		gprs_netreg_update(gprs);
+
+		/* wait until GPRS is attached */
+		gprs->attach_source =3D g_timeout_add_seconds(1,
+						gprs_attach_update, data);
+		return TRUE;
+	}
+
+	gprs_attach_update(data);
+
+	return TRUE;
+}
+
+static void ofono_emulator_gprs_connect(struct ofono_gprs *gprs,
+				struct ofono_emulator_gprs_connect_req *req)
+{
+	const char *dial_str =3D req->dial_str;
+	struct pri_context *dun;
+	struct ofono_error error;
+
+	DBG("dial call %s", dial_str);
+
+	/* Create DUN context if not exists */
+	dun =3D gprs_context_by_type(gprs, GPRS_CONTEXT_TYPE_DUN);
+	if (!dun) {
+		dun =3D ofono_gprs_create_context(gprs, "dun", "dun");
+		if (!dun)
+			goto error;
+	}
+
+	if (!gprs_dun_connect(dun, req->cb, req->cb_data))
+		goto error;
+
+	return;
+error:
+	error.type =3D OFONO_ERROR_TYPE_FAILURE;
+	req->cb(&error, NULL, NULL, NULL, NULL, req->cb_data);
+}
+
 static void dun_status_watch(struct ofono_emulator *e,
 					enum ofono_emulator_status status,
 					void *data, void *user_data)
 {
+	struct ofono_gprs *gprs =3D user_data;
+
 	if (e =3D=3D NULL)
 		return;
 =

 	switch (status) {
+	case OFONO_EMULATOR_STATUS_GPRS_CONNECT:
+		ofono_emulator_gprs_connect(gprs, data);
+		break;
+	case OFONO_EMULATOR_STATUS_DUN_CONNECTING:
+		ofono_emulator_dun_connect(gprs, data);
+		break;
+	case OFONO_EMULATOR_STATUS_DUN_CONNECTED:
+		break;
+	case OFONO_EMULATOR_STATUS_DUN_DISCONNECTED:
+		ofono_emulator_dun_disconnect(gprs, data);
+		break;
+	case OFONO_EMULATOR_STATUS_DESTROY:
+		ofono_emulator_remove_sources(gprs);
+		break;
 	default:
 		break;
 	}
@@ -1584,6 +2017,8 @@ static void gprs_unregister(struct ofono_atom *atom)
 		gprs->dun =3D NULL;
 	}
 =

+	ofono_emulator_remove_sources(gprs);
+
 	ofono_modem_remove_interface(modem,
 					OFONO_DATA_CONNECTION_MANAGER_INTERFACE);
 	g_dbus_unregister_interface(conn, path,
-- =

1.6.3.3


--===============3740295420548367153==--

