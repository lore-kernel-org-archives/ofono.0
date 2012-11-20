Content-Type: multipart/mixed; boundary="===============4424708448185272705=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 3/4] bluetooth: Fix read device properties
Date: Tue, 20 Nov 2012 09:12:18 -0300
Message-ID: <1353413539-19693-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353413539-19693-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4424708448185272705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch replaces GetProperties method by the GetAll method of the
object manager to read the device properties.
---
 plugins/bluetooth.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 1ab3214..675e53d 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -299,7 +299,8 @@ static void device_properties_cb(DBusPendingCall *call,=
 gpointer user_data)
 	dbus_error_init(&derr);
 =

 	if (dbus_set_error_from_message(&derr, reply)) {
-		ofono_error("Device.GetProperties replied an error: %s, %s",
+		ofono_error("%s GetAll(\"%s\") replied an error: %s, %s",
+					path, FREEDESKTOP_PROPERTIES_INTERFACE,
 					derr.name, derr.message);
 		dbus_error_free(&derr);
 		goto done;
@@ -350,6 +351,19 @@ static void parse_devices(DBusMessageIter *array, gpoi=
nter user_data)
 	}
 }
 =

+static void get_device_properties(const char *path)
+{
+	const char *interface =3D BLUEZ_DEVICE_INTERFACE;
+
+	DBG("Calling %s GetAll(%s)", path, interface);
+
+	bluetooth_send_with_reply(path, FREEDESKTOP_PROPERTIES_INTERFACE,
+				"GetAll", NULL, device_properties_cb,
+				g_strdup(path), g_free, -1,
+				DBUS_TYPE_STRING, &interface,
+				DBUS_TYPE_INVALID);
+}
+
 static gboolean property_changed(DBusConnection *conn, DBusMessage *msg,
 				void *user_data)
 {
@@ -382,10 +396,7 @@ static gboolean property_changed(DBusConnection *conn,=
 DBusMessage *msg,
 		 * refetch everything again
 		 */
 		if (uuids)
-			bluetooth_send_with_reply(path, BLUEZ_DEVICE_INTERFACE,
-					"GetProperties", NULL,
-					device_properties_cb, g_strdup(path),
-					g_free, -1, DBUS_TYPE_INVALID);
+			get_device_properties(path);
 	} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
 		const char *path =3D dbus_message_get_path(msg);
 		struct bluetooth_profile *profile;
@@ -450,10 +461,7 @@ static void adapter_properties_cb(DBusPendingCall *cal=
l, gpointer user_data)
 	for (l =3D device_list; l; l =3D l->next) {
 		const char *device =3D l->data;
 =

-		bluetooth_send_with_reply(device, BLUEZ_DEVICE_INTERFACE,
-					"GetProperties", NULL,
-					device_properties_cb, g_strdup(device),
-					g_free, -1, DBUS_TYPE_INVALID);
+		get_device_properties(device);
 	}
 =

 done:
-- =

1.7.11.7


--===============4424708448185272705==--

