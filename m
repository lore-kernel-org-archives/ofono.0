Content-Type: multipart/mixed; boundary="===============8606088175606711193=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 10/13] dundee: Add BlueZ Profile handler
Date: Thu, 14 Mar 2013 10:32:51 -0300
Message-ID: <1363267974-13518-11-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363267974-13518-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8606088175606711193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch declares the external dundee Profile handler. It
contains the initial implementation of the D-Bus Profile1
interface and methods responsible for handling Bluetooth
connections.
---
 dundee/bluez5.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 68 insertions(+)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index b4f6918..82bb7aa 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -25,6 +25,7 @@
 #include <stdint.h>
 #include <sys/socket.h>
 #include <gdbus.h>
+#include <errno.h>
 =

 #include "dundee.h"
 #include "plugins/bluez5.h"
@@ -42,6 +43,59 @@ struct bluetooth_device {
 	char *name;
 };
 =

+static DBusMessage *profile_new_connection(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".NotImplemented",
+						"Implementation not provided");
+}
+
+static DBusMessage *profile_release(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".NotImplemented",
+						"Implementation not provided");
+}
+
+static DBusMessage *profile_cancel(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".NotImplemented",
+						"Implementation not provided");
+}
+
+static DBusMessage *profile_disconnection(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".NotImplemented",
+						"Implementation not provided");
+}
+
+static const GDBusMethodTable profile_methods[] =3D {
+	{ GDBUS_ASYNC_METHOD("NewConnection",
+				GDBUS_ARGS({ "device", "o"}, { "fd", "h"},
+						{ "fd_properties", "a{sv}" }),
+				NULL, profile_new_connection) },
+	{ GDBUS_METHOD("Release", NULL, NULL, profile_release) },
+	{ GDBUS_METHOD("Cancel", NULL, NULL, profile_cancel) },
+	{ GDBUS_METHOD("RequestDisconnection",
+				GDBUS_ARGS({"device", "o"}), NULL,
+				profile_disconnection) },
+	{ }
+};
+
 static void bluetooth_device_destroy(gpointer user_data)
 {
 	struct bluetooth_device *bt_device =3D user_data;
@@ -259,6 +313,15 @@ int __dundee_bluetooth_init(void)
 =

 	DBG("");
 =

+	if (!g_dbus_register_interface(conn, DUN_DT_PROFILE_PATH,
+					BLUEZ_PROFILE_INTERFACE,
+					profile_methods, NULL,
+					NULL, NULL, NULL)) {
+		ofono_error("Register Profile interface failed: %s",
+						DUN_DT_PROFILE_PATH);
+		return -EIO;
+	}
+
 	bluez =3D g_dbus_client_new(conn, BLUEZ_SERVICE, BLUEZ_MANAGER_PATH);
 	g_dbus_client_set_connect_watch(bluez, connect_handler, NULL);
 	g_dbus_client_set_proxy_handlers(bluez, proxy_added, proxy_removed,
@@ -272,8 +335,13 @@ int __dundee_bluetooth_init(void)
 =

 void __dundee_bluetooth_cleanup(void)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
 	DBG("");
 =

+	g_dbus_unregister_interface(conn, DUN_DT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
+
 	g_dbus_client_unref(bluez);
 	g_hash_table_destroy(registered_devices);
 }
-- =

1.7.9.5


--===============8606088175606711193==--

