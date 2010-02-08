Content-Type: multipart/mixed; boundary="===============2669808127944894843=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] hfp: break down send_method_call in two functions
Date: Mon, 08 Feb 2010 16:53:00 -0200
Message-ID: <1265655180-14232-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2669808127944894843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now we have send_method_call_with_reply, for DBus messages that needs a
reply. A timeout callback was added to this funcion too.
The other funcion is called send_method_call with no timeout or reply
parameters.
---
 plugins/hfp.c |  102 ++++++++++++++++++++++++++++++++++++++++-------------=
----
 1 files changed, 72 insertions(+), 30 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 02258b9..6d32899 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -186,11 +186,9 @@ static void cmer_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 =

 static int send_method_call(const char *dest, const char *path,
 				const char *interface, const char *method,
-				DBusPendingCallNotifyFunction cb,
-				void *user_data, int type, ...)
+				int type, ...)
 {
 	DBusMessage *msg;
-	DBusPendingCall *call;
 	va_list args;
 =

 	msg =3D dbus_message_new_method_call(dest, path, interface, method);
@@ -209,11 +207,36 @@ static int send_method_call(const char *dest, const c=
har *path,
 =

 	va_end(args);
 =

-	if (!cb) {
-		g_dbus_send_message(connection, msg);
-		return 0;
+	g_dbus_send_message(connection, msg);
+	return 0;
+}
+
+static int send_method_call_with_reply(const char *dest, const char *path,
+				const char *interface, const char *method,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, void *timeout_cb, int timeout,
+				void *timeout_data, int type, ...)
+{
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	va_list args;
+
+	msg =3D dbus_message_new_method_call(dest, path, interface, method);
+	if (!msg) {
+		ofono_error("Unable to allocate new D-Bus %s message", method);
+		return -ENOMEM;
+	}
+
+	va_start(args, type);
+
+	if (!dbus_message_append_args_valist(msg, type, args)) {
+		dbus_message_unref(msg);
+		va_end(args);
+		return -EIO;
 	}
 =

+	va_end(args);
+
 	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
 		ofono_error("Sending %s failed", method);
 		dbus_message_unref(msg);
@@ -224,6 +247,9 @@ static int send_method_call(const char *dest, const cha=
r *path,
 	dbus_pending_call_unref(call);
 	dbus_message_unref(msg);
 =

+	if (timeout_data)
+		g_timeout_add_seconds(timeout, timeout_cb, timeout_data);
+
 	return 0;
 }
 =

@@ -603,10 +629,10 @@ static void list_devices_cb(DBusPendingCall *call, gp=
ointer user_data)
 	}
 =

 	for (i =3D 0 ; i < num ; i++) {
-		ret =3D send_method_call(BLUEZ_SERVICE, device[i],
+		ret =3D send_method_call_with_reply(BLUEZ_SERVICE, device[i],
 				BLUEZ_DEVICE_INTERFACE, "GetProperties",
-				get_properties_cb, (void *)device[i],
-				DBUS_TYPE_INVALID);
+				get_properties_cb, (void *)device[i], NULL, 0,
+				NULL, DBUS_TYPE_INVALID);
 		if (ret < 0)
 			ofono_error("GetProperties failed(%d)", ret);
 	}
@@ -624,9 +650,9 @@ static gboolean adapter_added(DBusConnection *connectio=
n, DBusMessage *message,
 	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
 =

-	ret =3D send_method_call(BLUEZ_SERVICE, path,
+	ret =3D send_method_call_with_reply(BLUEZ_SERVICE, path,
 			BLUEZ_ADAPTER_INTERFACE, "ListDevices",
-			list_devices_cb, NULL,
+			list_devices_cb, NULL, NULL, 0, NULL,
 			DBUS_TYPE_INVALID);
 =

 	if (ret < 0)
@@ -695,9 +721,9 @@ static void list_adapters_cb(DBusPendingCall *call, gpo=
inter user_data)
 	}
 =

 	for (i =3D 0 ; i < num ; i++) {
-		ret =3D send_method_call(BLUEZ_SERVICE, adapter[i],
+		ret =3D send_method_call_with_reply(BLUEZ_SERVICE, adapter[i],
 				BLUEZ_ADAPTER_INTERFACE, "ListDevices",
-				list_devices_cb, NULL,
+				list_devices_cb, NULL, NULL, 0, NULL,
 				DBUS_TYPE_INVALID);
 =

 		if (ret < 0)
@@ -712,9 +738,9 @@ done:
 =

 static int hfp_load_modems()
 {
-	return send_method_call(BLUEZ_SERVICE, "/",
+	return send_method_call_with_reply(BLUEZ_SERVICE, "/",
 				BLUEZ_MANAGER_INTERFACE, "ListAdapters",
-				list_adapters_cb, NULL,
+				list_adapters_cb, NULL, NULL, 0, NULL,
 				DBUS_TYPE_INVALID);
 }
 =

@@ -727,8 +753,8 @@ static int hfp_register_ofono_handsfree(struct ofono_mo=
dem *modem)
 =

 	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
 				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent",
-				NULL, NULL, DBUS_TYPE_OBJECT_PATH,
-				&obj_path, DBUS_TYPE_INVALID);
+				DBUS_TYPE_OBJECT_PATH, &obj_path,
+				DBUS_TYPE_INVALID);
 }
 =

 static int hfp_unregister_ofono_handsfree(struct ofono_modem *modem)
@@ -740,8 +766,8 @@ static int hfp_unregister_ofono_handsfree(struct ofono_=
modem *modem)
 =

 	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
 				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent",
-				NULL, NULL, DBUS_TYPE_OBJECT_PATH,
-				&obj_path, DBUS_TYPE_INVALID);
+				DBUS_TYPE_OBJECT_PATH, &obj_path,
+				DBUS_TYPE_INVALID);
 }
 =

 static int hfp_probe(struct ofono_modem *modem)
@@ -774,15 +800,20 @@ static void hfp_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 }
 =

-static int hfp_connect_ofono_handsfree(struct ofono_modem *modem)
+static void hfp_connect_failed(DBusPendingCall *call, gpointer user_data)
 {
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusError derr;
+	DBusMessage *reply;
 =

-	ofono_debug("Connect to bluetooth daemon");
+	reply =3D dbus_pending_call_steal_reply(call);
 =

-	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "Connect",
-				NULL, NULL, DBUS_TYPE_INVALID);
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_debug("Connect reply: %s", derr.message);
+		dbus_error_free(&derr);
+	}
+
+	dbus_message_unref(reply);
 }
 =

 static gboolean hfp_enable_timeout(gpointer user_data)
@@ -796,20 +827,30 @@ static gboolean hfp_enable_timeout(gpointer user_data)
 =

 	ret =3D send_method_call(BLUEZ_SERVICE, data->handsfree_path,
 				BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-				NULL, NULL, DBUS_TYPE_INVALID);
+				DBUS_TYPE_INVALID);
 	if (ret < 0)
 		ofono_error("Disconnect failed(%d)", ret);
 =

 	return FALSE;
 }
 =

+static int hfp_connect_ofono_handsfree(struct ofono_modem *modem)
+{
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_debug("Connect to bluetooth daemon");
+
+	return send_method_call_with_reply(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "Connect",
+				hfp_connect_failed, NULL, hfp_enable_timeout,
+				15, modem, DBUS_TYPE_INVALID);
+}
+
 /* power up hardware */
 static int hfp_enable(struct ofono_modem *modem)
 {
 	DBG("%p", modem);
 =

-	g_timeout_add_seconds(15, hfp_enable_timeout, modem);
-
 	if (hfp_connect_ofono_handsfree(modem) < 0)
 		return -EINVAL;
 =

@@ -841,9 +882,10 @@ static int hfp_disconnect_ofono_handsfree(struct ofono=
_modem *modem)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 =

-	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
+	return send_method_call_with_reply(BLUEZ_SERVICE, data->handsfree_path,
 				BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-				hfp_power_down, modem, DBUS_TYPE_INVALID);
+				hfp_power_down, modem, NULL, 0, NULL,
+				DBUS_TYPE_INVALID);
 }
 =

 static int hfp_disable(struct ofono_modem *modem)
-- =

1.6.4.4


--===============2669808127944894843==--

