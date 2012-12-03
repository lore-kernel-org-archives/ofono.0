Content-Type: multipart/mixed; boundary="===============4664310125956295677=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 02/14] hfp_hf: Add BlueZ Profile handler
Date: Mon, 03 Dec 2012 10:11:43 -0300
Message-ID: <1354540315-27731-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1354540315-27731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4664310125956295677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch declares the external HFP Profile handler. It contains the
initial implementation of the D-Bus Profile1 interface and methods
responsible for handling Bluetooth connections.
---
 plugins/bluetooth.h |  2 ++
 plugins/hfp_hf.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index ffaf9e3..a9355f6 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -24,7 +24,9 @@
 =

 #define	BLUEZ_SERVICE "org.bluez"
 #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
+#define	BLUEZ_ERROR_INTERFACE		BLUEZ_SERVICE ".Error"
 #define BLUEZ_PROFILE_MGMT_INTERFACE   BLUEZ_SERVICE ".ProfileManager1"
+#define	BLUEZ_PROFILE_INTERFACE		BLUEZ_SERVICE ".Profile1"
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
 #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
 #define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 1e0064c..6836c45 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -339,6 +339,55 @@ static int hfp_unregister_ofono_handsfree(struct ofono=
_modem *modem)
 	return 0;
 }
 =

+static DBusMessage *profile_new_connection(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBG("Profile handler NewConnection");
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".NotImplemented",
+					"Implementation not provided");
+}
+
+static DBusMessage *profile_release(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBG("Profile handler Release");
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".NotImplemented",
+					"Implementation not provided");
+}
+
+static DBusMessage *profile_cancel(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBG("Profile handler Cancel");
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".NotImplemented",
+					"Implementation not provided");
+}
+
+static DBusMessage *profile_disconnection(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBG("Profile handler RequestDisconnection");
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
 static int hfp_probe(struct ofono_modem *modem)
 {
 	const char *obj_path =3D ofono_modem_get_path(modem);
@@ -526,12 +575,24 @@ static int hfp_init(void)
 =

 	connection =3D ofono_dbus_get_connection();
 =

+	/* Registers External Profile handler */
+	if (!g_dbus_register_interface(connection, HFP_EXT_PROFILE_PATH,
+					BLUEZ_PROFILE_INTERFACE,
+					profile_methods, NULL,
+					NULL, NULL, NULL)) {
+		ofono_error("Register Profile interface failed: %s",
+							HFP_EXT_PROFILE_PATH);
+		return -EIO;
+	}
+
 	err =3D ofono_modem_driver_register(&hfp_driver);
 	if (err < 0)
 		return err;
 =

 	err =3D bluetooth_register_uuid(HFP_AG_UUID, &hfp_hf);
 	if (err < 0) {
+		g_dbus_unregister_interface(connection, HFP_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
 		ofono_modem_driver_unregister(&hfp_driver);
 		return err;
 	}
@@ -539,6 +600,8 @@ static int hfp_init(void)
 	err =3D bluetooth_register_profile(HFP_HS_UUID, "hfp_hf",
 						HFP_EXT_PROFILE_PATH);
 	if (err < 0) {
+		g_dbus_unregister_interface(connection, HFP_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
 		bluetooth_unregister_uuid(HFP_AG_UUID);
 		ofono_modem_driver_unregister(&hfp_driver);
 		return err;
@@ -552,7 +615,8 @@ static int hfp_init(void)
 =

 static void hfp_exit(void)
 {
-
+	g_dbus_unregister_interface(connection, HFP_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
 	bluetooth_unregister_profile(HFP_EXT_PROFILE_PATH);
 	bluetooth_unregister_uuid(HFP_AG_UUID);
 	ofono_modem_driver_unregister(&hfp_driver);
-- =

1.7.11.7


--===============4664310125956295677==--

