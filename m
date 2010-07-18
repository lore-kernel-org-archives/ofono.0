Content-Type: multipart/mixed; boundary="===============3620051170005818743=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 1/4] remove log to make bluetooth.c a static library
Date: Sun, 18 Jul 2010 19:57:26 -0300
Message-ID: <1279493849-22930-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3620051170005818743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   27 +++------------------------
 1 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 5a85eaa..1079838 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -77,7 +77,6 @@ int bluetooth_send_with_reply(const char *path, const cha=
r *interface,
 	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, path,
 						interface, method);
 	if (!msg) {
-		ofono_error("Unable to allocate new D-Bus %s message", method);
 		err =3D -ENOMEM;
 		goto fail;
 	}
@@ -96,7 +95,6 @@ int bluetooth_send_with_reply(const char *path, const cha=
r *interface,
 		timeout *=3D 1000;
 =

 	if (!dbus_connection_send_with_reply(connection, msg, &call, timeout)) {
-		ofono_error("Sending %s failed", method);
 		err =3D -EIO;
 		goto fail;
 	}
@@ -246,18 +244,11 @@ static void device_properties_cb(DBusPendingCall *cal=
l, gpointer user_data)
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

-	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
-		DBG("Bluetooth daemon is apparently not available.");
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN))
 		goto done;
-	}
-
-	if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR) {
-		if (!dbus_message_is_error(reply, DBUS_ERROR_UNKNOWN_METHOD))
-			ofono_info("Error from GetProperties reply: %s",
-					dbus_message_get_error_name(reply));
 =

+	if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR)
 		goto done;
-	}
 =

 	bluetooth_parse_properties(reply, "UUIDs", has_uuid, &have_uuid,
 				"Adapter", parse_string, &adapter,
@@ -285,8 +276,6 @@ static void parse_devices(DBusMessageIter *array, gpoin=
ter user_data)
 	DBusMessageIter value;
 	GSList **device_list =3D user_data;
 =

-	DBG("");
-
 	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
 		return;
 =

@@ -380,7 +369,6 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 	reply =3D dbus_pending_call_steal_reply(call);
 =

 	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
-		DBG("Bluetooth daemon is apparently not available.");
 		goto done;
 	}
 =

@@ -389,7 +377,6 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 					"Address", parse_string, &addr,
 					NULL);
 =

-	DBG("Adapter Address: %s, Path: %s", addr, path);
 	g_hash_table_insert(adapter_address_hash,
 				g_strdup(path), g_strdup(addr));
 =

@@ -439,8 +426,6 @@ static void parse_adapters(DBusMessageIter *array, gpoi=
nter user_data)
 {
 	DBusMessageIter value;
 =

-	DBG("");
-
 	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
 		return;
 =

@@ -452,8 +437,6 @@ static void parse_adapters(DBusMessageIter *array, gpoi=
nter user_data)
 =

 		dbus_message_iter_get_basic(&value, &path);
 =

-		DBG("Calling GetProperties on %s", path);
-
 		bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
 				"GetProperties", adapter_properties_cb,
 				g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
@@ -468,12 +451,8 @@ static void manager_properties_cb(DBusPendingCall *cal=
l, gpointer user_data)
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

-	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
-		DBG("Bluetooth daemon is apparently not available.");
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN))
 		goto done;
-	}
-
-	DBG("");
 =

 	bluetooth_parse_properties(reply, "Adapters", parse_adapters, NULL,
 						NULL);
-- =

1.7.1.1


--===============3620051170005818743==--

