Content-Type: multipart/mixed; boundary="===============0304502083763527554=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 3/5] bluetooth: change how we report DBus errors
Date: Thu, 17 Feb 2011 19:00:47 -0300
Message-ID: <1297980049-30760-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1297980049-30760-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0304502083763527554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 8ca9f5f..161ae4b 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -267,19 +267,16 @@ static void device_properties_cb(DBusPendingCall *cal=
l, gpointer user_data)
 	const char *device_addr =3D NULL;
 	const char *alias =3D NULL;
 	struct bluetooth_profile *profile;
+	struct DBusError derr;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

-	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
-		DBG("Bluetooth daemon is apparently not available.");
-		goto done;
-	}
-
-	if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR) {
-		if (!dbus_message_is_error(reply, DBUS_ERROR_UNKNOWN_METHOD))
-			ofono_info("Error from GetProperties reply: %s",
-					dbus_message_get_error_name(reply));
+	dbus_error_init(&derr);
 =

+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("Device.GetProperties replied an error: %s, %s",
+					derr.name, derr.message);
+		dbus_error_free(&derr);
 		goto done;
 	}
 =

@@ -397,14 +394,19 @@ static void adapter_properties_cb(DBusPendingCall *ca=
ll, gpointer user_data)
 {
 	const char *path =3D user_data;
 	DBusMessage *reply;
+	DBusError derr;
 	GSList *device_list =3D NULL;
 	GSList *l;
 	const char *addr;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

-	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
-		DBG("Bluetooth daemon is apparently not available.");
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("Adapter.GetProperties replied an error: %s, %s",
+					derr.name, derr.message);
+		dbus_error_free(&derr);
 		goto done;
 	}
 =

@@ -717,11 +719,16 @@ static void parse_adapters(DBusMessageIter *array, gp=
ointer user_data)
 static void manager_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
 {
 	DBusMessage *reply;
+	DBusError derr;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

-	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
-		DBG("Bluetooth daemon is apparently not available.");
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("Manager.GetProperties() replied an error: %s, %s",
+					derr.name, derr.message);
+		dbus_error_free(&derr);
 		goto done;
 	}
 =

-- =

1.7.4


--===============0304502083763527554==--

