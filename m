Content-Type: multipart/mixed; boundary="===============3874185532928355819=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 6/6] hfp_hf: Add BlueZ Profile handler
Date: Tue, 15 Jan 2013 15:24:48 -0300
Message-ID: <1358274288-24857-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358274288-24857-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3874185532928355819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch declares the external HFP Profile handler. It contains the
initial implementation of the D-Bus Profile1 interface and methods
responsible for handling Bluetooth connections.
---
 plugins/bluez5.h        |  2 ++
 plugins/hfp_hf_bluez5.c | 74 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 99bf896..01ecfe8 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -20,6 +20,8 @@
  */
 =

 #define	BLUEZ_SERVICE "org.bluez"
+#define BLUEZ_PROFILE_INTERFACE		BLUEZ_SERVICE ".Profile1"
+#define BLUEZ_ERROR_INTERFACE		BLUEZ_SERVICE ".Error"
 =

 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 =

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 0cd0d23..e024838 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -26,6 +26,8 @@
 #include <errno.h>
 #include <glib.h>
 =

+#include <gdbus.h>
+
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/modem.h>
 #include <ofono/dbus.h>
@@ -88,6 +90,59 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

+static DBusMessage *profile_new_connection(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("Profile handler NewConnection");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".NotImplemented",
+					"Implementation not provided");
+}
+
+static DBusMessage *profile_release(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("Profile handler Release");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".NotImplemented",
+						"Implementation not provided");
+}
+
+static DBusMessage *profile_cancel(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("Profile handler Cancel");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".NotImplemented",
+					"Implementation not provided");
+}
+
+static DBusMessage *profile_disconnection(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("Profile handler RequestDisconnection");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".NotImplemented",
+					"Implementation not provided");
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
 static int hfp_init(void)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -96,13 +151,28 @@ static int hfp_init(void)
 	if (DBUS_TYPE_UNIX_FD < 0)
 		return -EBADF;
 =

+	/* Registers External Profile handler */
+	if (!g_dbus_register_interface(conn, HFP_EXT_PROFILE_PATH,
+					BLUEZ_PROFILE_INTERFACE,
+					profile_methods, NULL,
+					NULL, NULL, NULL)) {
+		ofono_error("Register Profile interface failed: %s",
+						HFP_EXT_PROFILE_PATH);
+		return -EIO;
+	}
+
 	err =3D ofono_modem_driver_register(&hfp_driver);
-	if (err < 0)
+	if (err < 0) {
+		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
 		return err;
+	}
 =

 	err =3D bluetooth_register_profile(conn, HFP_HS_UUID, "hfp_hf",
 						HFP_EXT_PROFILE_PATH);
 	if (err < 0) {
+		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
 		ofono_modem_driver_unregister(&hfp_driver);
 		return err;
 	}
@@ -115,6 +185,8 @@ static void hfp_exit(void)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 =

 	bluetooth_unregister_profile(conn, HFP_EXT_PROFILE_PATH);
+	g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
 	ofono_modem_driver_unregister(&hfp_driver);
 }
 =

-- =

1.7.11.7


--===============3874185532928355819==--

