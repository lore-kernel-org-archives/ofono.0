Content-Type: multipart/mixed; boundary="===============4841246169881809786=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/4] gprs: Add new external APIs to create,
 activate and remove a PDP context
Date: Wed, 04 May 2011 19:26:40 +0200
Message-ID: <1304530002-13336-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1304530002-13336-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4841246169881809786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs.h |   16 ++++
 src/gprs.c     |  234 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 246 insertions(+), 4 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index 157a6f9..0bb37f7 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -36,6 +36,10 @@ typedef void (*ofono_gprs_status_cb_t)(const struct ofon=
o_error *error,
 =

 typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *dat=
a);
 =

+typedef void (*ofono_gprs_add_pdp_context_cb_t)(int error, char *interface,
+						char *ipv4, char *ipv6,
+						void *data);
+
 struct ofono_gprs_driver {
 	const char *name;
 	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
@@ -77,7 +81,19 @@ void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
 				unsigned int min, unsigned int max);
 void ofono_gprs_add_context(struct ofono_gprs *gprs,
 				struct ofono_gprs_context *gc);
+unsigned int ofono_gprs_add_pdp_context(struct ofono_gprs *gprs,
+					const char *type,
+					const char *protocol,
+					const char *apn,
+					const char *username,
+					const char *password,
+					const char *host);
+
+int ofono_gprs_remove_pdp_context(struct ofono_gprs *gprs, unsigned int id=
);
 =

+int ofono_gprs_activate_pdp_context(struct ofono_gprs *gprs, unsigned int =
id,
+					ofono_gprs_add_pdp_context_cb_t cb,
+					void *data);
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gprs.c b/src/gprs.c
index 9657a3e..2b88324 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -147,6 +147,8 @@ struct pri_context {
 	struct ofono_gprs_primary_context context;
 	struct ofono_gprs_context *context_driver;
 	struct ofono_gprs *gprs;
+	void *notify;
+	void *notify_data;
 };
 =

 static void gprs_netreg_update(struct ofono_gprs *gprs);
@@ -356,6 +358,35 @@ static struct pri_context *gprs_context_by_path(struct=
 ofono_gprs *gprs,
 	return NULL;
 }
 =

+static struct pri_context *gprs_context_by_id(struct ofono_gprs *gprs,
+						unsigned int id)
+{
+	GSList *l;
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+
+		if (ctx->id =3D=3D id)
+			return ctx;
+	}
+
+	return NULL;
+}
+
+static struct pri_context *gprs_get_default_context(struct ofono_gprs *gpr=
s)
+{
+	GSList *l;
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+
+		if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_INTERNET)
+			return ctx;
+	}
+
+	return NULL;
+}
+
 static void context_settings_free(struct context_settings *settings)
 {
 	if (settings->ipv4) {
@@ -870,15 +901,21 @@ static void pri_activate_callback(const struct ofono_=
error *error, void *data)
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Activating context failed with error: %s",
 				telephony_error_to_str(error));
-		__ofono_dbus_pending_reply(&ctx->pending,
+		if (ctx->pending)
+			__ofono_dbus_pending_reply(&ctx->pending,
 					__ofono_error_failed(ctx->pending));
 		context_settings_free(ctx->context_driver->settings);
 		release_context(ctx);
+
+		if (ctx->notify)
+			((ofono_gprs_add_pdp_context_cb_t) ctx->notify)
+				(-ENOSYS, NULL, NULL, NULL, ctx->notify_data);
 		return;
 	}
 =

 	ctx->active =3D TRUE;
-	__ofono_dbus_pending_reply(&ctx->pending,
+	if (ctx->pending)
+		__ofono_dbus_pending_reply(&ctx->pending,
 				dbus_message_new_method_return(ctx->pending));
 =

 	if (gc->settings->interface !=3D NULL) {
@@ -896,6 +933,20 @@ static void pri_activate_callback(const struct ofono_e=
rror *error, void *data)
 	ofono_dbus_signal_property_changed(conn, ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
+
+	if (ctx->notify) {
+		char *ipv4 =3D NULL;
+		char *ipv6 =3D NULL;
+
+		if (gc->settings->ipv4)
+			ipv4 =3D gc->settings->ipv4->ip;
+		else if (gc->settings->ipv6)
+			ipv6 =3D gc->settings->ipv6->ip;
+
+		((ofono_gprs_add_pdp_context_cb_t) ctx->notify)
+					(0, gc->settings->interface, ipv4, ipv6,
+							ctx->notify_data);
+	}
 }
 =

 static void pri_deactivate_callback(const struct ofono_error *error, void =
*data)
@@ -1844,7 +1895,8 @@ static void gprs_deactivate_for_remove(const struct o=
fono_error *error,
 		DBG("Removing context failed with error: %s",
 				telephony_error_to_str(error));
 =

-		__ofono_dbus_pending_reply(&gprs->pending,
+		if (gprs->pending)
+			__ofono_dbus_pending_reply(&gprs->pending,
 					__ofono_error_failed(gprs->pending));
 		return;
 	}
@@ -1863,7 +1915,8 @@ static void gprs_deactivate_for_remove(const struct o=
fono_error *error,
 	context_dbus_unregister(ctx);
 	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
 =

-	__ofono_dbus_pending_reply(&gprs->pending,
+	if (gprs->pending)
+		__ofono_dbus_pending_reply(&gprs->pending,
 				dbus_message_new_method_return(gprs->pending));
 =

 	atompath =3D __ofono_atom_get_path(gprs->atom);
@@ -2968,3 +3021,176 @@ void *ofono_gprs_get_data(struct ofono_gprs *gprs)
 {
 	return gprs->driver_data;
 }
+
+unsigned int ofono_gprs_add_pdp_context(struct ofono_gprs *gprs,
+					const char *type,
+					const char *protocol,
+					const char *apn,
+					const char *username,
+					const char *password,
+					const char *host)
+{
+	unsigned int id;
+	struct pri_context *context;
+	struct pri_context *default_ctx =3D NULL;
+	const char *name;
+	enum ofono_gprs_proto proto;
+	enum ofono_gprs_context_type context_type;
+
+	/* Sanity check */
+	if (apn && strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH)
+		return 0;
+
+	if (username && strlen(username) > OFONO_GPRS_MAX_USERNAME_LENGTH)
+		return 0;
+
+	if (password && strlen(password) > OFONO_GPRS_MAX_PASSWORD_LENGTH)
+		return 0;
+
+	if (apn =3D=3D NULL || (username =3D=3D NULL && password =3D=3D NULL)) {
+		/* take the default primary internet context */
+		default_ctx =3D gprs_get_default_context(gprs);
+
+		if (default_ctx =3D=3D NULL && apn =3D=3D NULL)
+			return 0;
+	}
+
+	if (apn && is_valid_apn(apn) =3D=3D FALSE)
+		return 0;
+
+	if (gprs_proto_from_string(protocol, &proto) =3D=3D FALSE)
+		return 0;
+
+	if (gprs_context_string_to_type(type, &context_type) =3D=3D FALSE)
+		return 0;
+
+	name =3D gprs_context_default_name(context_type);
+	if (name =3D=3D NULL)
+		return 0;
+
+	if (gprs->last_context_id)
+		id =3D idmap_alloc_next(gprs->pid_map, gprs->last_context_id);
+	else
+		id =3D idmap_alloc(gprs->pid_map);
+
+	if (id > idmap_get_max(gprs->pid_map))
+		return 0;
+
+	context =3D pri_context_create(gprs, name, context_type);
+	if (context =3D=3D NULL) {
+		idmap_put(gprs->pid_map, id);
+		return 0;
+	}
+
+	context->id =3D id;
+
+	if (username !=3D NULL)
+		strcpy(context->context.username, username);
+
+	if (password !=3D NULL)
+		strcpy(context->context.password, password);
+
+	if (username =3D=3D NULL && password =3D=3D NULL && default_ctx) {
+		if (default_ctx->context.username)
+			strcpy(context->context.username,
+					default_ctx->context.username);
+		if (default_ctx->context.password)
+			strcpy(context->context.password,
+					default_ctx->context.password);
+	}
+
+	if (apn)
+		strcpy(context->context.apn, apn);
+	else if (default_ctx) {
+		strcpy(context->context.apn, default_ctx->context.apn);
+		if (default_ctx->context.username)
+			strcpy(context->context.username,
+					default_ctx->context.username);
+		if (default_ctx->context.password)
+			strcpy(context->context.password,
+					default_ctx->context.password);
+	}
+
+	context->context.proto =3D proto;
+
+	if (context_dbus_register(context) =3D=3D FALSE)
+		return 0;
+
+	gprs->last_context_id =3D id;
+
+	if (gprs->settings) {
+		write_context_settings(gprs, context);
+		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
+	}
+
+	gprs->contexts =3D g_slist_append(gprs->contexts, context);
+
+	return id;
+}
+
+int ofono_gprs_activate_pdp_context(struct ofono_gprs *gprs, unsigned int =
id,
+					ofono_gprs_add_pdp_context_cb_t cb,
+					void *data)
+{
+	struct pri_context *ctx;
+	struct ofono_gprs_context *gc;
+
+	ctx =3D gprs_context_by_id(gprs, id);
+	if (ctx =3D=3D NULL)
+		return -EINVAL;
+
+	if (ctx->active =3D=3D TRUE)
+		return 0;
+
+	if (assign_context(ctx) =3D=3D FALSE)
+		return -ENOSYS;
+
+	gc =3D ctx->context_driver;
+
+	ctx->notify =3D cb;
+	ctx->notify_data =3D data;
+
+	gc->driver->activate_primary(gc, &ctx->context, pri_activate_callback,
+					ctx);
+	return 0;
+}
+
+int ofono_gprs_remove_pdp_context(struct ofono_gprs *gprs, unsigned int id)
+{
+	struct pri_context *ctx;
+	DBusConnection *conn;
+	char *path;
+	const char *atompath;
+
+	ctx =3D gprs_context_by_id(gprs, id);
+	if (ctx =3D=3D NULL)
+		return -EINVAL;
+
+	if (ctx->active) {
+		struct ofono_gprs_context *gc =3D ctx->context_driver;
+
+		gc->driver->deactivate_primary(gc, ctx->context.cid,
+					gprs_deactivate_for_remove, ctx);
+		return 0;
+	}
+
+	if (gprs->settings) {
+		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
+		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
+	}
+
+	path =3D g_strdup(ctx->path);
+
+	DBG("Unregistering context: %s", ctx->path);
+	context_dbus_unregister(ctx);
+	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
+
+	atompath =3D __ofono_atom_get_path(gprs->atom);
+	conn =3D ofono_dbus_get_connection();
+	g_dbus_emit_signal(conn, atompath, OFONO_CONNECTION_MANAGER_INTERFACE,
+				"ContextRemoved", DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+	g_free(path);
+
+	return 0;
+}
-- =

1.7.1


--===============4841246169881809786==--

