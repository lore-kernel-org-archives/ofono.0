Content-Type: multipart/mixed; boundary="===============3323898986976852687=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 1/2] gprs: Add ResetProperties method to ConnectionContext
 interface
Date: Thu, 19 Feb 2015 13:59:52 +0200
Message-ID: <1424347193-6828-2-git-send-email-tommi.kenakkala@tieto.com>
In-Reply-To: <1424347193-6828-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3323898986976852687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Slava Monich <slava.monich@jolla.com>

Allows to reset connection context properties back to default.
---
 src/gprs.c |  292 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 286 insertions(+), 6 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 05ab499..cd3a567 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -130,6 +130,13 @@ struct ofono_gprs_context {
 	struct ofono_atom *atom;
 };
 =

+struct context_reset {
+	GSList *msgs;
+	const struct ofono_gprs_provision_data *ap;
+	struct ofono_gprs_provision_data *settings;
+	int count;
+};
+
 struct pri_context {
 	ofono_bool_t active;
 	enum ofono_gprs_context_type type;
@@ -142,6 +149,7 @@ struct pri_context {
 	char *proxy_host;
 	uint16_t proxy_port;
 	DBusMessage *pending;
+	struct context_reset *pending_reset;
 	struct ofono_gprs_primary_context context;
 	struct ofono_gprs_context *context_driver;
 	struct ofono_gprs *gprs;
@@ -149,6 +157,10 @@ struct pri_context {
 =

 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
+static void write_context_settings(struct ofono_gprs *gprs,
+						struct pri_context *context);
+static void pri_deactivate_callback(const struct ofono_error *error,
+								void *data);
 =

 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
@@ -802,6 +814,256 @@ static void pri_update_mms_context_settings(struct pr=
i_context *ctx)
 		pri_setproxy(settings->interface, ctx->proxy_host);
 }
 =

+static gboolean pri_str_changed(const char *val, const char *newval)
+{
+	return newval ? (strcmp(val, newval) !=3D 0) : !val[0];
+}
+
+static gboolean pri_str_update(char *val, const char *newval)
+{
+	if (newval) {
+		if (strcmp(val, newval)) {
+			strcpy(val, newval);
+			return TRUE;
+		}
+	} else {
+		if (val[0]) {
+			val[0] =3D 0;
+			return TRUE;
+		}
+	}
+	return FALSE;
+}
+
+static void pri_str_signal_change(struct pri_context *ctx,
+					const char *name, const char *value)
+{
+	ofono_dbus_signal_property_changed(ofono_dbus_get_connection(),
+			ctx->path, OFONO_CONNECTION_CONTEXT_INTERFACE,
+					name, DBUS_TYPE_STRING, &value);
+}
+
+static void pri_reset_context_properties(struct pri_context *ctx,
+				const struct ofono_gprs_provision_data *ap)
+{
+	struct ofono_gprs *gprs =3D ctx->gprs;
+	gboolean changed =3D FALSE;
+
+	DBG("%s", ctx->path);
+
+	if (strcmp(ctx->context.apn, ap->apn)) {
+		changed =3D TRUE;
+		strcpy(ctx->context.apn, ap->apn);
+		pri_str_signal_change(ctx, "AccessPointName", ap->apn);
+	}
+
+	if (ap->name && strncmp(ctx->name, ap->name, MAX_CONTEXT_NAME_LENGTH)) {
+		changed =3D TRUE;
+		strncpy(ctx->name, ap->name, MAX_CONTEXT_NAME_LENGTH);
+		pri_str_signal_change(ctx, "Name", ap->name);
+	}
+
+	if (pri_str_update(ctx->context.username, ap->username)) {
+		changed =3D TRUE;
+		pri_str_signal_change(ctx, "Username", ap->username);
+	}
+
+	if (pri_str_update(ctx->context.password, ap->password)) {
+		changed =3D TRUE;
+		pri_str_signal_change(ctx, "Password", ap->password);
+	}
+
+	if (ctx->context.proto !=3D ap->proto) {
+		ctx->context.proto =3D ap->proto;
+		changed =3D TRUE;
+		pri_str_signal_change(ctx, "Protocol",
+					gprs_proto_to_string(ap->proto));
+	}
+
+	if (ap->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
+		if (pri_str_update(ctx->message_proxy, ap->message_proxy)) {
+			changed =3D TRUE;
+			pri_str_signal_change(ctx, "MessageProxy",
+							ap->message_proxy);
+		}
+
+		if (pri_str_update(ctx->message_center, ap->message_center)) {
+			changed =3D TRUE;
+			pri_str_signal_change(ctx, "MessageCenter",
+							ap->message_center);
+		}
+	}
+
+	if (gprs->settings && changed) {
+		write_context_settings(gprs, ctx);
+		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
+	}
+}
+
+static gboolean ap_valid(const struct ofono_gprs_provision_data *ap)
+{
+	if (!ap->apn || strlen(ap->apn) > OFONO_GPRS_MAX_APN_LENGTH ||
+							!is_valid_apn(ap->apn))
+		return FALSE;
+
+	if (ap->username &&
+			strlen(ap->username) > OFONO_GPRS_MAX_USERNAME_LENGTH)
+		return FALSE;
+
+	if (ap->password &&
+			strlen(ap->password) > OFONO_GPRS_MAX_PASSWORD_LENGTH)
+		return FALSE;
+
+	if (ap->message_proxy &&
+			strlen(ap->message_proxy) > MAX_MESSAGE_PROXY_LENGTH)
+		return FALSE;
+
+	if (ap->message_center &&
+			strlen(ap->message_center) > MAX_MESSAGE_CENTER_LENGTH)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean pri_deactivation_required(struct pri_context *ctx,
+				const struct ofono_gprs_provision_data *ap)
+{
+	if (ctx->context.proto !=3D ap->proto)
+		return TRUE;
+
+	if (strcmp(ctx->context.apn, ap->apn))
+		return TRUE;
+
+	if (pri_str_changed(ctx->context.username, ap->username))
+		return TRUE;
+
+	if (pri_str_changed(ctx->context.password, ap->password))
+		return TRUE;
+
+	if (ap->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS) {
+		if (pri_str_changed(ctx->message_proxy, ap->message_proxy))
+			return TRUE;
+
+		if (pri_str_changed(ctx->message_center, ap->message_center))
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+static void pri_pending_reply_ok(gpointer data)
+{
+	DBusMessage *msg =3D data;
+	__ofono_dbus_pending_reply(&msg, dbus_message_new_method_return(msg));
+}
+
+static void pri_pending_reply_error(gpointer data)
+{
+	DBusMessage *msg =3D data;
+	__ofono_dbus_pending_reply(&msg, __ofono_error_failed(msg));
+}
+
+static void pri_reset_finish(struct pri_context *ctx, gboolean ok)
+{
+	struct context_reset *pr;
+
+	if (!ctx->pending_reset)
+		return;
+
+	pr =3D ctx->pending_reset;
+	ctx->pending_reset =3D NULL;
+
+	if (ok) {
+		pri_reset_context_properties(ctx, pr->ap);
+		g_slist_free_full(pr->msgs, pri_pending_reply_ok);
+	} else {
+		g_slist_free_full(pr->msgs, pri_pending_reply_error);
+	}
+
+	__ofono_gprs_provision_free_settings(pr->settings, pr->count);
+	g_free(pr);
+}
+
+static DBusMessage *pri_reset_async(struct pri_context *ctx, DBusMessage *=
msg,
+			struct ofono_gprs_provision_data *settings, int count,
+				const struct ofono_gprs_provision_data *ap)
+{
+	struct context_reset *pr;
+	struct ofono_gprs_context *gc =3D ctx->context_driver;
+
+	if (gc =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	pr =3D g_new0(struct context_reset, 1);
+	pr->msgs =3D g_slist_append(NULL, dbus_message_ref(msg));
+	pr->settings =3D settings;
+	pr->count =3D count;
+	pr->ap =3D ap;
+
+	ctx->pending_reset =3D pr;
+
+	/*
+	 * Context activation/deactivation or DeactivateAll may already
+	 * be in progress. In that case reset will complete once those
+	 * are done.
+	 */
+	if (!ctx->pending && !ctx->gprs->pending)
+		gc->driver->deactivate_primary(gc, ctx->context.cid,
+					pri_deactivate_callback, ctx);
+
+	return NULL;
+}
+
+static DBusMessage *pri_reset_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct pri_context *ctx =3D data;
+	struct ofono_gprs *gprs =3D ctx->gprs;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
+	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	struct ofono_gprs_provision_data *settings;
+	DBusMessage *reply =3D NULL;
+	int i, count =3D 0;
+
+	if (sim =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	if (ctx->pending_reset) {
+		ctx->pending_reset->msgs =3D g_slist_append(
+			ctx->pending_reset->msgs, dbus_message_ref(msg));
+		return NULL;
+	}
+
+	if (__ofono_gprs_provision_get_settings(ofono_sim_get_mcc(sim),
+				ofono_sim_get_mnc(sim), ofono_sim_get_spn(sim),
+						 &settings, &count) =3D=3D FALSE)
+		return __ofono_error_failed(msg);
+
+	for (i =3D 0; i < count; i++) {
+		const struct ofono_gprs_provision_data *ap =3D settings + i;
+		if (ap->type =3D=3D ctx->type && ap_valid(ap)) {
+			if (!(ctx->active || ctx->pending) ||
+					!pri_deactivation_required(ctx, ap)) {
+				/* Can do it right away */
+				pri_reset_context_properties(ctx, ap);
+				reply =3D  dbus_message_new_method_return(msg);
+				break;
+			}
+
+			/* Otherwise have to wait for context to deactivate */
+			reply =3D pri_reset_async(ctx, msg, settings, count, ap);
+			if (!reply)
+				return NULL;
+
+			break;
+		}
+	}
+
+	__ofono_gprs_provision_free_settings(settings, count);
+
+	return reply ? reply : __ofono_error_not_available(msg);
+}
+
 static void append_context_properties(struct pri_context *ctx,
 					DBusMessageIter *dict)
 {
@@ -895,6 +1157,7 @@ static void pri_activate_callback(const struct ofono_e=
rror *error, void *data)
 					__ofono_error_failed(ctx->pending));
 		context_settings_free(ctx->context_driver->settings);
 		release_context(ctx);
+		pri_reset_finish(ctx, TRUE);
 		return;
 	}
 =

@@ -917,6 +1180,11 @@ static void pri_activate_callback(const struct ofono_=
error *error, void *data)
 	ofono_dbus_signal_property_changed(conn, ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"Active", DBUS_TYPE_BOOLEAN, &value);
+
+	/* Immediately deactivate if reset was requested */
+	if (ctx->pending_reset)
+		gc->driver->deactivate_primary(gc, ctx->context.cid,
+					pri_deactivate_callback, ctx);
 }
 =

 static void pri_deactivate_callback(const struct ofono_error *error, void =
*data)
@@ -928,16 +1196,20 @@ static void pri_deactivate_callback(const struct ofo=
no_error *error, void *data)
 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Deactivating context failed with error: %s",
 				telephony_error_to_str(error));
-		__ofono_dbus_pending_reply(&ctx->pending,
+		pri_reset_finish(ctx, FALSE);
+		if (ctx->pending)
+			__ofono_dbus_pending_reply(&ctx->pending,
 					__ofono_error_failed(ctx->pending));
 		return;
 	}
 =

-	__ofono_dbus_pending_reply(&ctx->pending,
+	if (ctx->pending)
+		__ofono_dbus_pending_reply(&ctx->pending,
 				dbus_message_new_method_return(ctx->pending));
 =

 	pri_reset_context_settings(ctx);
 	release_context(ctx);
+	pri_reset_finish(ctx, TRUE);
 =

 	value =3D ctx->active;
 	ofono_dbus_signal_property_changed(conn, ctx->path,
@@ -1240,7 +1512,7 @@ static DBusMessage *pri_set_property(DBusConnection *=
conn,
 		if (ctx->gprs->pending)
 			return __ofono_error_busy(msg);
 =

-		if (ctx->pending)
+		if (ctx->pending || ctx->pending_reset)
 			return __ofono_error_busy(msg);
 =

 		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
@@ -1358,6 +1630,8 @@ static const GDBusMethodTable context_methods[] =3D {
 	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
 			NULL, pri_set_property) },
+	{ GDBUS_ASYNC_METHOD("ResetProperties", NULL, NULL,
+			pri_reset_properties) },
 	{ }
 };
 =

@@ -1395,6 +1669,7 @@ static void pri_context_destroy(gpointer userdata)
 {
 	struct pri_context *ctx =3D userdata;
 =

+	pri_reset_finish(ctx, FALSE);
 	g_free(ctx->proxy_host);
 	g_free(ctx->path);
 	g_free(ctx);
@@ -1538,7 +1813,7 @@ static void release_active_contexts(struct ofono_gprs=
 *gprs)
 			continue;
 =

 		/* This context is already being messed with */
-		if (ctx->pending)
+		if (ctx->pending || ctx->pending_reset)
 			continue;
 =

 		gc =3D ctx->context_driver;
@@ -1964,6 +2239,7 @@ static void gprs_deactivate_for_remove(const struct o=
fono_error *error,
 =

 	pri_reset_context_settings(ctx);
 	release_context(ctx);
+	pri_reset_finish(ctx, FALSE);
 =

 	value =3D FALSE;
 	ofono_dbus_signal_property_changed(conn, ctx->path,
@@ -2017,7 +2293,7 @@ static DBusMessage *gprs_remove_context(DBusConnectio=
n *conn,
 		struct ofono_gprs_context *gc =3D ctx->context_driver;
 =

 		/* This context is already being messed with */
-		if (ctx->pending)
+		if (ctx->pending || ctx->pending_reset)
 			return __ofono_error_busy(msg);
 =

 		gprs->pending =3D dbus_message_ref(msg);
@@ -2054,6 +2330,7 @@ static void gprs_deactivate_for_all(const struct ofon=
o_error *error,
 	dbus_bool_t value;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		pri_reset_finish(ctx, FALSE);
 		__ofono_dbus_pending_reply(&gprs->pending,
 					__ofono_error_failed(gprs->pending));
 		return;
@@ -2061,6 +2338,7 @@ static void gprs_deactivate_for_all(const struct ofon=
o_error *error,
 =

 	pri_reset_context_settings(ctx);
 	release_context(ctx);
+	pri_reset_finish(ctx, TRUE);
 =

 	value =3D ctx->active;
 	conn =3D ofono_dbus_get_connection();
@@ -2110,7 +2388,7 @@ static DBusMessage *gprs_deactivate_all(DBusConnectio=
n *conn,
 	for (l =3D gprs->contexts; l; l =3D l->next) {
 		ctx =3D l->data;
 =

-		if (ctx->pending)
+		if (ctx->pending || ctx->pending_reset)
 			return __ofono_error_busy(msg);
 	}
 =

@@ -2296,6 +2574,7 @@ static void gprs_context_unregister(struct ofono_atom=
 *atom)
 =

 		pri_reset_context_settings(ctx);
 		release_context(ctx);
+		pri_reset_finish(ctx, FALSE);
 =

 		value =3D FALSE;
 		ofono_dbus_signal_property_changed(conn, ctx->path,
@@ -2367,6 +2646,7 @@ void ofono_gprs_context_deactivated(struct ofono_gprs=
_context *gc,
 =

 		pri_reset_context_settings(ctx);
 		release_context(ctx);
+		pri_reset_finish(ctx, TRUE);
 =

 		value =3D FALSE;
 		ofono_dbus_signal_property_changed(conn, ctx->path,
-- =

1.7.9.5


--===============3323898986976852687==--

