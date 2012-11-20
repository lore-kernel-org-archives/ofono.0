Content-Type: multipart/mixed; boundary="===============4346130504668693070=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 2/4] bluetooth: Fix reading adapter properties
Date: Tue, 20 Nov 2012 09:12:17 -0300
Message-ID: <1353413539-19693-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353413539-19693-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4346130504668693070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch replaces GetProperties method by the GetAll method of the
object manager to read the adapter properties.
---
 plugins/bluetooth.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index f35c755..1ab3214 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -429,7 +429,8 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 	dbus_error_init(&derr);
 =

 	if (dbus_set_error_from_message(&derr, reply)) {
-		ofono_error("Adapter.GetProperties replied an error: %s, %s",
+		ofono_error("%s GetAll(\"%s\") replied an error: %s, %s",
+					path, FREEDESKTOP_PROPERTIES_INTERFACE,
 					derr.name, derr.message);
 		dbus_error_free(&derr);
 		goto done;
@@ -463,9 +464,15 @@ done:
 static void get_adapter_properties(const char *path, const char *handle,
 						gpointer user_data)
 {
-	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-			"GetProperties", NULL, adapter_properties_cb,
-			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+	const char *interface =3D BLUEZ_ADAPTER_INTERFACE;
+
+	DBG("Calling %s GetAll(%s)", path, interface);
+
+	bluetooth_send_with_reply(path, FREEDESKTOP_PROPERTIES_INTERFACE,
+				"GetAll", NULL, adapter_properties_cb,
+				g_strdup(path), g_free, -1,
+				DBUS_TYPE_STRING, &interface,
+				DBUS_TYPE_INVALID);
 }
 =

 static void remove_record(struct server *server)
@@ -706,9 +713,7 @@ static gboolean adapter_added(DBusConnection *conn, DBu=
sMessage *message,
 	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
 =

-	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-			"GetProperties", NULL, adapter_properties_cb,
-			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+	get_adapter_properties(path, NULL, NULL);
 =

 	return TRUE;
 }
@@ -766,11 +771,7 @@ static void parse_adapters(DBusMessageIter *array)
 =

 		dbus_message_iter_get_basic(&value, &path);
 =

-		DBG("Calling GetProperties on %s", path);
-
-		bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-				"GetProperties", NULL, adapter_properties_cb,
-				g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+		get_adapter_properties(path, NULL, NULL);
 =

 		dbus_message_iter_next(&value);
 	}
-- =

1.7.11.7


--===============4346130504668693070==--

