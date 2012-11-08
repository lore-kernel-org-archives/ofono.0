Content-Type: multipart/mixed; boundary="===============1085318746625067770=="
MIME-Version: 1.0
From: Wu Zheng <wu.zheng@intel.com>
Subject: [PATCH] Ofono need to match the new interfaces of Bluez
Date: Thu, 08 Nov 2012 14:29:17 +0800
Message-ID: <1352356157-20039-1-git-send-email-wu.zheng@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1085318746625067770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some dbus methods of bluez have been modified in the latest verion of bluez.
It results in HFP can't work well.
Ofono need to modify the related methods to match it.
---
 plugins/bluetooth.c |  110 ++++++++++++-----------------------------------=
----
 plugins/bluetooth.h |    2 +
 2 files changed, 27 insertions(+), 85 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 5d28530..0c22dcb 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -350,71 +350,6 @@ static void parse_devices(DBusMessageIter *array, gpoi=
nter user_data)
 	}
 }
 =

-static gboolean property_changed(DBusConnection *conn, DBusMessage *msg,
-				void *user_data)
-{
-	const char *property;
-	DBusMessageIter iter;
-
-	dbus_message_iter_init(msg, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
-		return FALSE;
-
-	dbus_message_iter_get_basic(&iter, &property);
-	if (g_str_equal(property, "UUIDs") =3D=3D TRUE) {
-		GSList *uuids =3D NULL;
-		const char *path =3D dbus_message_get_path(msg);
-		DBusMessageIter variant;
-
-		if (!dbus_message_iter_next(&iter))
-			return FALSE;
-
-		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
-			return FALSE;
-
-		dbus_message_iter_recurse(&iter, &variant);
-
-		parse_uuids(&variant, &uuids);
-
-		/* We need the full set of properties to be able to create
-		 * the modem properly, including Adapter and Alias, so
-		 * refetch everything again
-		 */
-		if (uuids)
-			bluetooth_send_with_reply(path, BLUEZ_DEVICE_INTERFACE,
-					"GetProperties", NULL,
-					device_properties_cb, g_strdup(path),
-					g_free, -1, DBUS_TYPE_INVALID);
-	} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
-		const char *path =3D dbus_message_get_path(msg);
-		struct bluetooth_profile *profile;
-		const char *alias =3D NULL;
-		DBusMessageIter variant;
-		GHashTableIter hash_iter;
-		gpointer key, value;
-
-		if (!dbus_message_iter_next(&iter))
-			return FALSE;
-
-		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
-			return FALSE;
-
-		dbus_message_iter_recurse(&iter, &variant);
-
-		parse_string(&variant, &alias);
-
-		g_hash_table_iter_init(&hash_iter, uuid_hash);
-		while (g_hash_table_iter_next(&hash_iter, &key, &value)) {
-			profile =3D value;
-			if (profile->set_alias)
-				profile->set_alias(path, alias);
-		}
-	}
-
-	return TRUE;
-}
-
 static void adapter_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
 {
 	const char *path =3D user_data;
@@ -423,6 +358,7 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 	GSList *device_list =3D NULL;
 	GSList *l;
 	const char *addr;
+	const char *interfaces =3D BLUEZ_DEVICE_INTERFACE;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

@@ -449,10 +385,11 @@ static void adapter_properties_cb(DBusPendingCall *ca=
ll, gpointer user_data)
 	for (l =3D device_list; l; l =3D l->next) {
 		const char *device =3D l->data;
 =

-		bluetooth_send_with_reply(device, BLUEZ_DEVICE_INTERFACE,
-					"GetProperties", NULL,
+		bluetooth_send_with_reply(device, DBUS_INTERFACE_PROPERTIES,
+					"GetAll", NULL,
 					device_properties_cb, g_strdup(device),
-					g_free, -1, DBUS_TYPE_INVALID);
+					g_free, -1, DBUS_TYPE_STRING, &interfaces,
+					DBUS_TYPE_INVALID);
 	}
 =

 done:
@@ -463,9 +400,12 @@ done:
 static void get_adapter_properties(const char *path, const char *handle,
 						gpointer user_data)
 {
-	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-			"GetProperties", NULL, adapter_properties_cb,
-			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+	const char *interfaces =3D BLUEZ_ADAPTER_INTERFACE;
+
+	bluetooth_send_with_reply(path, DBUS_INTERFACE_PROPERTIES,
+			"GetAll", NULL, adapter_properties_cb,
+			g_strdup(path), g_free, -1, DBUS_TYPE_STRING, &interfaces,
+			DBUS_TYPE_INVALID);
 }
 =

 static void remove_record(struct server *server)
@@ -702,13 +642,15 @@ static gboolean adapter_added(DBusConnection *conn, D=
BusMessage *message,
 				void *user_data)
 {
 	const char *path;
+	const char *interfaces =3D BLUEZ_ADAPTER_INTERFACE;
 =

 	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
 =

-	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-			"GetProperties", NULL, adapter_properties_cb,
-			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+	bluetooth_send_with_reply(path, DBUS_INTERFACE_PROPERTIES,
+			"GetAll", NULL, adapter_properties_cb,
+			g_strdup(path), g_free, -1, DBUS_TYPE_STRING, &interfaces,
+			DBUS_TYPE_INVALID);
 =

 	return TRUE;
 }
@@ -752,6 +694,7 @@ static gboolean device_removed(DBusConnection *conn,
 static void parse_adapters(DBusMessageIter *array, gpointer user_data)
 {
 	DBusMessageIter value;
+	const char *interfaces =3D BLUEZ_ADAPTER_INTERFACE;
 =

 	DBG("");
 =

@@ -768,9 +711,10 @@ static void parse_adapters(DBusMessageIter *array, gpo=
inter user_data)
 =

 		DBG("Calling GetProperties on %s", path);
 =

-		bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-				"GetProperties", NULL, adapter_properties_cb,
-				g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+		bluetooth_send_with_reply(path, DBUS_INTERFACE_PROPERTIES,
+				"GetAll", NULL, adapter_properties_cb,
+				g_strdup(path), g_free, -1, DBUS_TYPE_STRING, &interfaces,
+				DBUS_TYPE_INVALID);
 =

 		dbus_message_iter_next(&value);
 	}
@@ -803,8 +747,10 @@ done:
 =

 static void bluetooth_connect(DBusConnection *conn, void *user_data)
 {
-	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
+	const char *interfaces =3D BLUEZ_MANAGER_INTERFACE;
+	bluetooth_send_with_reply("/", DBUS_INTERFACE_PROPERTIES, "GetAll",
 				NULL, manager_properties_cb, NULL, NULL, -1,
+				DBUS_TYPE_STRING, &interfaces,
 				DBUS_TYPE_INVALID);
 =

 	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "FindAdapter",
@@ -857,14 +803,8 @@ static void bluetooth_ref(void)
 						"DeviceRemoved",
 						device_removed, NULL, NULL);
 =

-	property_watch =3D g_dbus_add_signal_watch(connection,
-						BLUEZ_SERVICE, NULL,
-						BLUEZ_DEVICE_INTERFACE,
-						"PropertyChanged",
-						property_changed, NULL, NULL);
-
 	if (bluetooth_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
-			adapter_removed_watch =3D=3D 0 || property_watch =3D=3D 0) {
+			adapter_removed_watch =3D=3D 0) {
 		goto remove;
 	}
 =

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 4fc16ad..9f83c7d 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -29,6 +29,8 @@
 #define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
 #define BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
 =

+#define DBUS_INTERFACE_PROPERTIES "org.freedesktop.DBus.Properties"
+
 #define DBUS_TIMEOUT 15
 =

 #define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
-- =

1.7.7


--===============1085318746625067770==--

