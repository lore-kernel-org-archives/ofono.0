Content-Type: multipart/mixed; boundary="===============2383175265948374325=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH] Add send_method_call to g_dbus
Date: Tue, 20 Apr 2010 03:51:21 -0300
Message-ID: <1271746281-26784-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2383175265948374325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Puting send_method_call and send_method_call_with_reply on g_dbus will
avoid some code duplication and will make things easier mainly for the
Bluetooth plugins (HFP, DUN, SAP) inside oFono.
---
 gdbus/gdbus.h  |   12 ++++
 gdbus/object.c |   81 +++++++++++++++++++++++++++++
 plugins/hfp.c  |  154 +++++++++++++---------------------------------------=
---
 3 files changed, 130 insertions(+), 117 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 47e18cf..ac488c5 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -106,12 +106,24 @@ DBusMessage *g_dbus_create_error_valist(DBusMessage *=
message, const char *name,
 DBusMessage *g_dbus_create_reply(DBusMessage *message, int type, ...);
 DBusMessage *g_dbus_create_reply_valist(DBusMessage *message,
 						int type, va_list args);
+DBusMessage *g_dbus_create_method_call(const char *dest, const char *path,
+				const char *interface, const char *method,
+				int type, va_list args);
 =

 gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *mess=
age);
 gboolean g_dbus_send_reply(DBusConnection *connection,
 				DBusMessage *message, int type, ...);
 gboolean g_dbus_send_reply_valist(DBusConnection *connection,
 				DBusMessage *message, int type, va_list args);
+gboolean g_dbus_send_method_call(DBusConnection *connection, const char *d=
est,
+				const char *path, const char *interface,
+				const char *method, int type, ...);
+gboolean g_dbus_send_method_call_with_reply(DBusConnection *connection,
+				const char *dest, const char *path,
+				const char *interface, const char *method,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, DBusFreeFunction free_func,
+				int timeout, int type, ...);
 =

 gboolean g_dbus_emit_signal(DBusConnection *connection,
 				const char *path, const char *interface,
diff --git a/gdbus/object.c b/gdbus/object.c
index 8da2dab..887fc6c 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -608,6 +608,24 @@ DBusMessage *g_dbus_create_reply(DBusMessage *message,=
 int type, ...)
 	return reply;
 }
 =

+DBusMessage *g_dbus_create_method_call(const char *dest, const char *path,
+				const char *interface, const char *method,
+				int type, va_list args)
+{
+	DBusMessage *msg;
+
+	msg =3D dbus_message_new_method_call(dest, path, interface, method);
+	if (!msg)
+		return NULL;
+
+	if (!dbus_message_append_args_valist(msg, type, args)) {
+		dbus_message_unref(msg);
+		return NULL;
+	}
+
+	return msg;
+}
+
 gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *mess=
age)
 {
 	dbus_bool_t result;
@@ -654,6 +672,69 @@ gboolean g_dbus_send_reply(DBusConnection *connection,
 	return result;
 }
 =

+gboolean g_dbus_send_method_call(DBusConnection *connection, const char *d=
est,
+				const char *path, const char *interface,
+				const char *method, int type, ...)
+{
+	DBusMessage *msg;
+	va_list args;
+
+	va_start(args, type);
+
+	msg =3D g_dbus_create_method_call(dest, path, interface, method,
+			type, args);
+
+	va_end(args);
+
+	if (!msg)
+		return FALSE;
+
+	return g_dbus_send_message(connection, msg);
+}
+
+gboolean g_dbus_send_method_call_with_reply(DBusConnection *connection,
+				const char *dest, const char *path,
+				const char *interface, const char *method,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, DBusFreeFunction free_func,
+				int timeout, int type, ...)
+{
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	va_list args;
+
+	va_start(args, type);
+
+	msg =3D g_dbus_create_method_call(dest, path, interface, method,
+			type, args);
+
+	va_end(args);
+
+	if (!msg)
+		goto fail;
+
+	if (timeout > 0)
+		timeout *=3D 1000;
+
+	if (!dbus_connection_send_with_reply(connection, msg, &call, timeout))
+		goto fail;
+
+	dbus_pending_call_set_notify(call, cb, user_data, free_func);
+	dbus_pending_call_unref(call);
+	dbus_message_unref(msg);
+
+	return TRUE;
+
+fail:
+	if (free_func && user_data)
+		free_func(user_data);
+
+	if (msg)
+		dbus_message_unref(msg);
+
+	return FALSE;
+}
+
 gboolean g_dbus_emit_signal(DBusConnection *connection,
 				const char *path, const char *interface,
 				const char *name, int type, ...)
diff --git a/plugins/hfp.c b/plugins/hfp.c
index e37c9fc..82037e9 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -183,86 +183,6 @@ static void cmer_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 		sevice_level_conn_established(modem);
 }
 =

-static int send_method_call(const char *dest, const char *path,
-				const char *interface, const char *method,
-				int type, ...)
-{
-	DBusMessage *msg;
-	va_list args;
-
-	msg =3D dbus_message_new_method_call(dest, path, interface, method);
-	if (!msg) {
-		ofono_error("Unable to allocate new D-Bus %s message", method);
-		return -ENOMEM;
-	}
-
-	va_start(args, type);
-
-	if (!dbus_message_append_args_valist(msg, type, args)) {
-		dbus_message_unref(msg);
-		va_end(args);
-		return -EIO;
-	}
-
-	va_end(args);
-
-	g_dbus_send_message(connection, msg);
-	return 0;
-}
-
-static int send_method_call_with_reply(const char *dest, const char *path,
-				const char *interface, const char *method,
-				DBusPendingCallNotifyFunction cb,
-				void *user_data, DBusFreeFunction free_func,
-				int timeout, int type, ...)
-{
-	DBusMessage *msg;
-	DBusPendingCall *call;
-	va_list args;
-	int err;
-
-	msg =3D dbus_message_new_method_call(dest, path, interface, method);
-	if (!msg) {
-		ofono_error("Unable to allocate new D-Bus %s message", method);
-		err =3D -ENOMEM;
-		goto fail;
-	}
-
-	va_start(args, type);
-
-	if (!dbus_message_append_args_valist(msg, type, args)) {
-		va_end(args);
-		err =3D -EIO;
-		goto fail;
-	}
-
-	va_end(args);
-
-	if (timeout > 0)
-		timeout *=3D1000;
-
-	if (!dbus_connection_send_with_reply(connection, msg, &call, timeout)) {
-		ofono_error("Sending %s failed", method);
-		err =3D -EIO;
-		goto fail;
-	}
-
-	dbus_pending_call_set_notify(call, cb, user_data, free_func);
-	dbus_pending_call_unref(call);
-	dbus_message_unref(msg);
-
-	return 0;
-
-fail:
-	if (free_func && user_data)
-		free_func(user_data);
-
-	if (msg)
-		dbus_message_unref(msg);
-
-	return err;
-}
-
 typedef void (*PropertyHandler)(DBusMessageIter *iter, gpointer user_data);
 =

 struct property_handler {
@@ -753,8 +673,8 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 	for (l =3D device_list; l; l =3D l->next) {
 		const char *device =3D l->data;
 =

-		send_method_call_with_reply(BLUEZ_SERVICE, device,
-				BLUEZ_DEVICE_INTERFACE, "GetProperties",
+		g_dbus_send_method_call_with_reply(connection, BLUEZ_SERVICE,
+				device, BLUEZ_DEVICE_INTERFACE, "GetProperties",
 				device_properties_cb, g_strdup(device), g_free,
 				-1, DBUS_TYPE_INVALID);
 	}
@@ -768,17 +688,15 @@ static gboolean adapter_added(DBusConnection *connect=
ion, DBusMessage *message,
 				void *user_data)
 {
 	const char *path;
-	int ret;
 =

 	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
 =

-	ret =3D send_method_call_with_reply(BLUEZ_SERVICE, path,
-			BLUEZ_ADAPTER_INTERFACE, "GetProperties",
+	return g_dbus_send_method_call_with_reply(connection, BLUEZ_SERVICE,
+			path, BLUEZ_ADAPTER_INTERFACE, "GetProperties",
 			adapter_properties_cb, g_strdup(path), g_free,
 			-1, DBUS_TYPE_INVALID);
 =

-	return TRUE;
 }
 =

 static gboolean adapter_removed(DBusConnection *connection,
@@ -829,10 +747,12 @@ static gboolean property_changed(DBusConnection *conn=
ection, DBusMessage *msg,
 		 * refetch everything again
 		 */
 		if (have_hfp)
-			send_method_call_with_reply(BLUEZ_SERVICE, path,
-				BLUEZ_DEVICE_INTERFACE, "GetProperties",
-				device_properties_cb, g_strdup(path), g_free,
-				-1, DBUS_TYPE_INVALID);
+			g_dbus_send_method_call_with_reply(connection,
+					BLUEZ_SERVICE, path,
+					BLUEZ_DEVICE_INTERFACE,
+					"GetProperties", device_properties_cb,
+					g_strdup(path), g_free, -1,
+					DBUS_TYPE_INVALID);
 	} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
 		const char *path =3D dbus_message_get_path(msg);
 		struct ofono_modem *modem =3D
@@ -878,8 +798,8 @@ static void parse_adapters(DBusMessageIter *array, gpoi=
nter user_data)
 =

 		DBG("Calling GetProperties on %s", path);
 =

-		send_method_call_with_reply(BLUEZ_SERVICE, path,
-				BLUEZ_ADAPTER_INTERFACE, "GetProperties",
+		g_dbus_send_method_call_with_reply(connection, BLUEZ_SERVICE,
+				path, BLUEZ_ADAPTER_INTERFACE, "GetProperties",
 				adapter_properties_cb, g_strdup(path), g_free,
 				-1, DBUS_TYPE_INVALID);
 =

@@ -921,30 +841,30 @@ static void bluetooth_disconnect(DBusConnection *conn=
ection, void *user_data)
 	g_hash_table_foreach_remove(uuid_hash, hfp_remove_each_modem, NULL);
 }
 =

-static int hfp_register_ofono_handsfree(struct ofono_modem *modem)
+static gboolean hfp_register_ofono_handsfree(struct ofono_modem *modem)
 {
 	const char *obj_path =3D ofono_modem_get_path(modem);
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("Registering oFono Agent to bluetooth daemon");
 =

-	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent",
-				DBUS_TYPE_OBJECT_PATH, &obj_path,
-				DBUS_TYPE_INVALID);
+	return g_dbus_send_method_call(connection, BLUEZ_SERVICE,
+				data->handsfree_path, BLUEZ_GATEWAY_INTERFACE,
+				"RegisterAgent", DBUS_TYPE_OBJECT_PATH,
+				&obj_path, DBUS_TYPE_INVALID);
 }
 =

-static int hfp_unregister_ofono_handsfree(struct ofono_modem *modem)
+static gboolean hfp_unregister_ofono_handsfree(struct ofono_modem *modem)
 {
 	const char *obj_path =3D ofono_modem_get_path(modem);
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("Unregistering oFono Agent from bluetooth daemon");
 =

-	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent",
-				DBUS_TYPE_OBJECT_PATH, &obj_path,
-				DBUS_TYPE_INVALID);
+	return g_dbus_send_method_call(connection, BLUEZ_SERVICE,
+				data->handsfree_path, BLUEZ_GATEWAY_INTERFACE,
+				"UnregisterAgent", DBUS_TYPE_OBJECT_PATH,
+				&obj_path, DBUS_TYPE_INVALID);
 }
 =

 static int hfp_probe(struct ofono_modem *modem)
@@ -960,7 +880,7 @@ static int hfp_probe(struct ofono_modem *modem)
 =

 	data->agent_registered =3D TRUE;
 =

-	if (hfp_register_ofono_handsfree(modem) !=3D 0)
+	if (hfp_register_ofono_handsfree(modem) =3D=3D FALSE)
 		return -EINVAL;
 =

 	return 0;
@@ -989,7 +909,7 @@ static void hfp_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 	DBusError derr;
 	DBusMessage *reply;
-	int ret;
+	gboolean ret;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

@@ -1003,10 +923,11 @@ static void hfp_connect_reply(DBusPendingCall *call,=
 gpointer user_data)
 	DBG("Connect reply: %s", derr.message);
 =

 	if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) {
-		ret =3D send_method_call(BLUEZ_SERVICE, data->handsfree_path,
+		ret =3D g_dbus_send_method_call(connection, BLUEZ_SERVICE,
+					data->handsfree_path,
 					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
 					DBUS_TYPE_INVALID);
-		if (ret < 0)
+		if (!ret)
 			ofono_error("Disconnect failed(%d)", ret);
 	}
 =

@@ -1022,17 +943,16 @@ done:
 static int hfp_enable(struct ofono_modem *modem)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	int status;
+	gboolean status;
 =

 	DBG("%p", modem);
 =

-	status =3D send_method_call_with_reply(BLUEZ_SERVICE,
-				data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "Connect",
-				hfp_connect_reply, modem, NULL,
+	status =3D g_dbus_send_method_call_with_reply(connection, BLUEZ_SERVICE,
+				data->handsfree_path, BLUEZ_GATEWAY_INTERFACE,
+				"Connect", hfp_connect_reply, modem, NULL,
 				15, DBUS_TYPE_INVALID);
 =

-	if (status < 0)
+	if (!status)
 		return -EINVAL;
 =

 	return -EINPROGRESS;
@@ -1062,20 +982,20 @@ done:
 static int hfp_disable(struct ofono_modem *modem)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	int status;
+	gboolean status;
 =

 	DBG("%p", modem);
 =

 	clear_data(modem);
 =

 	if (data->agent_registered) {
-		status =3D send_method_call_with_reply(BLUEZ_SERVICE,
-					data->handsfree_path,
+		status =3D g_dbus_send_method_call_with_reply(connection,
+					BLUEZ_SERVICE, data->handsfree_path,
 					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
 					hfp_power_down, modem, NULL, 15,
 					DBUS_TYPE_INVALID);
 =

-		if (status < 0)
+		if (!status)
 			return -EINVAL;
 	}
 =

@@ -1156,7 +1076,7 @@ static int hfp_init()
 	if (err < 0)
 		goto remove;
 =

-	send_method_call_with_reply(BLUEZ_SERVICE, "/",
+	g_dbus_send_method_call_with_reply(connection, BLUEZ_SERVICE, "/",
 				BLUEZ_MANAGER_INTERFACE, "GetProperties",
 				manager_properties_cb, NULL, NULL, -1,
 				DBUS_TYPE_INVALID);
-- =

1.7.0.4


--===============2383175265948374325==--

