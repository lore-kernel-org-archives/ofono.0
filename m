Content-Type: multipart/mixed; boundary="===============2898519326839412579=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 23/24] bluetooth: track DBus call pending
Date: Tue, 13 Sep 2011 15:58:31 -0300
Message-ID: <1315940312-1238-23-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-22-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2898519326839412579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/bluetooth.c |   42 +++++++++++++++++++++++-------------------
 plugins/bluetooth.h |    2 +-
 plugins/hfp_hf.c    |    4 ++--
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 73b8d59..573c7c8 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -89,13 +89,13 @@ void bluetooth_create_path(const char *dev_addr, const =
char *adapter_addr,
 }
 =

 int bluetooth_send_with_reply(const char *path, const char *interface,
-				const char *method,
+				const char *method, DBusPendingCall **call,
 				DBusPendingCallNotifyFunction cb,
 				void *user_data, DBusFreeFunction free_func,
 				int timeout, int type, ...)
 {
 	DBusMessage *msg;
-	DBusPendingCall *call;
+	DBusPendingCall *c;
 	va_list args;
 	int err;
 =

@@ -120,14 +120,18 @@ int bluetooth_send_with_reply(const char *path, const=
 char *interface,
 	if (timeout > 0)
 		timeout *=3D 1000;
 =

-	if (!dbus_connection_send_with_reply(connection, msg, &call, timeout)) {
+	if (!dbus_connection_send_with_reply(connection, msg, &c, timeout)) {
 		ofono_error("Sending %s failed", method);
 		err =3D -EIO;
 		goto fail;
 	}
 =

-	dbus_pending_call_set_notify(call, cb, user_data, free_func);
-	dbus_pending_call_unref(call);
+	if (call !=3D NULL)
+		*call =3D c;
+
+	dbus_pending_call_set_notify(c, cb, user_data, free_func);
+	dbus_pending_call_unref(c);
+
 	dbus_message_unref(msg);
 =

 	return 0;
@@ -379,9 +383,9 @@ static gboolean property_changed(DBusConnection *connec=
tion, DBusMessage *msg,
 		 */
 		if (uuids)
 			bluetooth_send_with_reply(path, BLUEZ_DEVICE_INTERFACE,
-					"GetProperties", device_properties_cb,
-					g_strdup(path), g_free, -1,
-					DBUS_TYPE_INVALID);
+					"GetProperties", NULL,
+					device_properties_cb, g_strdup(path),
+					g_free, -1, DBUS_TYPE_INVALID);
 	} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
 		const char *path =3D dbus_message_get_path(msg);
 		struct bluetooth_profile *profile;
@@ -446,9 +450,9 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 		const char *device =3D l->data;
 =

 		bluetooth_send_with_reply(device, BLUEZ_DEVICE_INTERFACE,
-					"GetProperties", device_properties_cb,
-					g_strdup(device), g_free, -1,
-					DBUS_TYPE_INVALID);
+					"GetProperties", NULL,
+					device_properties_cb, g_strdup(device),
+					g_free, -1, DBUS_TYPE_INVALID);
 	}
 =

 done:
@@ -460,7 +464,7 @@ static void get_adapter_properties(const char *path, co=
nst char *handle,
 						gpointer user_data)
 {
 	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-			"GetProperties", adapter_properties_cb,
+			"GetProperties", NULL, adapter_properties_cb,
 			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
 }
 =

@@ -607,7 +611,7 @@ static void new_connection(GIOChannel *io, gpointer use=
r_data)
 	addr =3D raddress;
 =

 	if (bluetooth_send_with_reply(path, BLUEZ_SERVICE_INTERFACE,
-					"RequestAuthorization",
+					"RequestAuthorization", NULL,
 					auth_cb, cbd, cb_data_destroy,
 					TIMEOUT, DBUS_TYPE_STRING, &addr,
 					DBUS_TYPE_UINT32, &server->handle,
@@ -663,7 +667,7 @@ static void add_record(gpointer data, gpointer user_dat=
a)
 =

 	bluetooth_send_with_reply(adapter_any_path,
 					BLUEZ_SERVICE_INTERFACE, "AddRecord",
-					add_record_cb, server, NULL, -1,
+					NULL, add_record_cb, server, NULL, -1,
 					DBUS_TYPE_STRING, &server->sdp_record,
 					DBUS_TYPE_INVALID);
 }
@@ -703,8 +707,8 @@ static gboolean adapter_added(DBusConnection *connectio=
n, DBusMessage *message,
 				DBUS_TYPE_INVALID);
 =

 	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-			"GetProperties", adapter_properties_cb, g_strdup(path),
-			g_free, -1, DBUS_TYPE_INVALID);
+			"GetProperties", NULL, adapter_properties_cb,
+			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
 =

 	return TRUE;
 }
@@ -765,7 +769,7 @@ static void parse_adapters(DBusMessageIter *array, gpoi=
nter user_data)
 		DBG("Calling GetProperties on %s", path);
 =

 		bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-				"GetProperties", adapter_properties_cb,
+				"GetProperties", NULL, adapter_properties_cb,
 				g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
 =

 		dbus_message_iter_next(&value);
@@ -800,11 +804,11 @@ done:
 static void bluetooth_connect(DBusConnection *connection, void *user_data)
 {
 	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
-				manager_properties_cb, NULL, NULL, -1,
+				NULL, manager_properties_cb, NULL, NULL, -1,
 				DBUS_TYPE_INVALID);
 =

 	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "FindAdapter",
-				find_adapter_cb, NULL, NULL, -1,
+				NULL, find_adapter_cb, NULL, NULL, -1,
 				DBUS_TYPE_STRING, &adapter_any_name,
 				DBUS_TYPE_INVALID);
 }
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index c26a969..c723b6e 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -75,7 +75,7 @@ void bluetooth_create_path(const char *dev_addr, const ch=
ar *adapter_addr,
 							char *buf, int size);
 =

 int bluetooth_send_with_reply(const char *path, const char *interface,
-				const char *method,
+				const char *method, DBusPendingCall **call,
 				DBusPendingCallNotifyFunction cb,
 				void *user_data, DBusFreeFunction free_func,
 				int timeout, int type, ...);
diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 717891b..3081d35 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -405,7 +405,7 @@ static int hfp_enable(struct ofono_modem *modem)
 =

 	status =3D bluetooth_send_with_reply(data->handsfree_path,
 					BLUEZ_GATEWAY_INTERFACE, "Connect",
-					hfp_connect_reply, modem, NULL,
+					NULL, hfp_connect_reply, modem, NULL,
 					DBUS_TIMEOUT, DBUS_TYPE_INVALID);
 =

 	if (status < 0)
@@ -448,7 +448,7 @@ static int hfp_disable(struct ofono_modem *modem)
 	if (data->agent_registered) {
 		status =3D bluetooth_send_with_reply(data->handsfree_path,
 					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-					hfp_power_down, modem, NULL,
+					NULL, hfp_power_down, modem, NULL,
 					DBUS_TIMEOUT, DBUS_TYPE_INVALID);
 =

 		if (status < 0)
-- =

1.7.6.2


--===============2898519326839412579==--

