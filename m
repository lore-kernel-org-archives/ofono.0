Content-Type: multipart/mixed; boundary="===============5445608995557179528=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 1/4] bluetooth: Fix reading Bluetooth Adapters
Date: Tue, 20 Nov 2012 09:12:16 -0300
Message-ID: <1353413539-19693-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5445608995557179528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch replaces GetProperties method by the Get method of the
object manager to read the available Bluetooth adapters.
---
 plugins/bluetooth.c | 30 ++++++++++++++++++++++--------
 plugins/bluetooth.h |  2 ++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 5d28530..f35c755 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -749,7 +749,7 @@ static gboolean device_removed(DBusConnection *conn,
 	return TRUE;
 }
 =

-static void parse_adapters(DBusMessageIter *array, gpointer user_data)
+static void parse_adapters(DBusMessageIter *array)
 {
 	DBusMessageIter value;
 =

@@ -776,26 +776,35 @@ static void parse_adapters(DBusMessageIter *array, gp=
ointer user_data)
 	}
 }
 =

-static void manager_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
+static void adapters_objects_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
 	DBusError derr;
+	DBusMessageIter array, variant;
+
+	DBG("");
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

 	dbus_error_init(&derr);
 =

 	if (dbus_set_error_from_message(&derr, reply)) {
-		ofono_error("Manager.GetProperties() replied an error: %s, %s",
+		ofono_error("Get(\"%s\", \"Adapters\") replied an error: %s, "
+					"%s", FREEDESKTOP_PROPERTIES_INTERFACE,
 					derr.name, derr.message);
 		dbus_error_free(&derr);
 		goto done;
 	}
 =

-	DBG("");
+	if (dbus_message_iter_init(reply, &variant) =3D=3D FALSE)
+		goto done;
 =

-	bluetooth_parse_properties(reply, "Adapters", parse_adapters, NULL,
-						NULL);
+	if (dbus_message_iter_get_arg_type(&variant) !=3D DBUS_TYPE_VARIANT)
+		goto done;
+
+	dbus_message_iter_recurse(&variant, &array);
+
+	parse_adapters(&array);
 =

 done:
 	dbus_message_unref(reply);
@@ -803,8 +812,13 @@ done:
 =

 static void bluetooth_connect(DBusConnection *conn, void *user_data)
 {
-	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
-				NULL, manager_properties_cb, NULL, NULL, -1,
+	const char *interface =3D BLUEZ_MANAGER_INTERFACE;
+	const char *property =3D "Adapters";
+
+	bluetooth_send_with_reply("/", FREEDESKTOP_PROPERTIES_INTERFACE, "Get",
+				NULL, adapters_objects_cb, NULL, NULL, -1,
+				DBUS_TYPE_STRING, &interface,
+				DBUS_TYPE_STRING, &property,
 				DBUS_TYPE_INVALID);
 =

 	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "FindAdapter",
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 4fc16ad..af59d3d 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -29,6 +29,8 @@
 #define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
 #define BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
 =

+#define	FREEDESKTOP_PROPERTIES_INTERFACE	"org.freedesktop.DBus.Properties"
+
 #define DBUS_TIMEOUT 15
 =

 #define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
-- =

1.7.11.7


--===============5445608995557179528==--

