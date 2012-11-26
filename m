Content-Type: multipart/mixed; boundary="===============6370395400355734684=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v1 09/15] bluetooth: Reuse D-Bus dictionary parser function
Date: Mon, 26 Nov 2012 10:27:03 -0300
Message-ID: <1353936429-9997-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353936429-9997-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6370395400355734684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changes the Bluetooth D-Bus property parser function to allow
reusing on other messages. The dictionary can be placed on any position
of the message, the current implementation assumes that the first
message parameter should be a dictionary.
---
 plugins/bluetooth.c | 27 ++++++++++++++++-----------
 plugins/bluetooth.h |  3 ++-
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 201c851..37738e7 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -195,11 +195,14 @@ static gint property_handler_compare(gconstpointer a,=
 gconstpointer b)
 	return strcmp(handler->property, property);
 }
 =

-void bluetooth_parse_properties(DBusMessage *reply, const char *property, =
...)
+void bluetooth_parse_properties(DBusMessageIter *array, const char *proper=
ty, ...)
 {
 	va_list args;
 	GSList *prop_handlers =3D NULL;
-	DBusMessageIter array, dict;
+	DBusMessageIter dict;
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		goto done;
 =

 	va_start(args, property);
 =

@@ -218,13 +221,7 @@ void bluetooth_parse_properties(DBusMessage *reply, co=
nst char *property, ...)
 =

 	va_end(args);
 =

-	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
-		goto done;
-
-	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
-		goto done;
-
-	dbus_message_iter_recurse(&array, &dict);
+	dbus_message_iter_recurse(array, &dict);
 =

 	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTRY)=
 {
 		DBusMessageIter entry, value;
@@ -324,6 +321,7 @@ static void device_properties_cb(DBusPendingCall *call,=
 gpointer user_data)
 	const char *adapter_addr =3D NULL;
 	const char *device_addr =3D NULL;
 	const char *alias =3D NULL;
+	DBusMessageIter iter;
 	struct DBusError derr;
 	GSList *uuids =3D NULL;
 =

@@ -341,7 +339,10 @@ static void device_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 =

 	DBG("");
 =

-	bluetooth_parse_properties(reply, "UUIDs", parse_uuids, &uuids,
+	if (dbus_message_iter_init(reply, &iter) =3D=3D FALSE)
+		goto done;
+
+	bluetooth_parse_properties(&iter, "UUIDs", parse_uuids, &uuids,
 				"Adapter", parse_string, &adapter,
 				"Address", parse_string, &device_addr,
 				"Alias", parse_string, &alias, NULL);
@@ -480,6 +481,7 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 {
 	const char *path =3D user_data;
 	DBusMessage *reply;
+	DBusMessageIter iter;
 	DBusError derr;
 	GSList *device_list =3D NULL;
 	GSList *l;
@@ -499,7 +501,10 @@ static void adapter_properties_cb(DBusPendingCall *cal=
l, gpointer user_data)
 =

 	DBG("");
 =

-	bluetooth_parse_properties(reply,
+	if (dbus_message_iter_init(reply, &iter) =3D=3D FALSE)
+		goto done;
+
+	bluetooth_parse_properties(&iter,
 					"Devices", parse_devices, &device_list,
 					"Address", parse_string, &addr,
 					NULL);
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index a9355f6..5b4d9d4 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -84,7 +84,8 @@ int bluetooth_send_with_reply(const char *path, const cha=
r *interface,
 				DBusPendingCallNotifyFunction cb,
 				void *user_data, DBusFreeFunction free_func,
 				int timeout, int type, ...);
-void bluetooth_parse_properties(DBusMessage *reply, const char *property, =
...);
+void bluetooth_parse_properties(DBusMessageIter *array,
+						const char *property, ...);
 =

 int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
 					struct ofono_modem *modem);
-- =

1.7.11.7


--===============6370395400355734684==--

