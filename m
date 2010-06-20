Content-Type: multipart/mixed; boundary="===============8296024543811077694=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 2/6] bluetooth: add device_properties_cb() and has_uuid()
Date: Sun, 20 Jun 2010 05:51:20 -0300
Message-ID: <1277023884-27143-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1277023884-27143-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8296024543811077694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index e27982b..d635989 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -199,6 +199,28 @@ done:
 	g_slist_free(prop_handlers);
 }
 =

+static void has_uuid(DBusMessageIter *array, gpointer user_data)
+{
+	gboolean *profiles =3D user_data;
+	DBusMessageIter value;
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		return;
+
+	dbus_message_iter_recurse(array, &value);
+
+	while (dbus_message_iter_get_arg_type(&value) =3D=3D DBUS_TYPE_STRING) {
+		const char *uuid;
+
+		dbus_message_iter_get_basic(&value, &uuid);
+
+		if (!strcasecmp(uuid, HFP_AG_UUID))
+			*profiles |=3D HFP_AG;
+
+		dbus_message_iter_next(&value);
+	}
+}
+
 static void parse_string(DBusMessageIter *iter, gpointer user_data)
 {
 	char **str =3D user_data;
@@ -210,6 +232,53 @@ static void parse_string(DBusMessageIter *iter, gpoint=
er user_data)
 	dbus_message_iter_get_basic(iter, str);
 }
 =

+static void device_properties_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusMessage *reply;
+	int have_uuid =3D 0;
+	const char *path =3D user_data;
+	const char *adapter =3D NULL;
+	const char *adapter_addr =3D NULL;
+	const char *device_addr =3D NULL;
+	const char *alias =3D NULL;
+	struct bluetooth_profile *profile;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		DBG("Bluetooth daemon is apparently not available.");
+		goto done;
+	}
+
+	if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR) {
+		if (!dbus_message_is_error(reply, DBUS_ERROR_UNKNOWN_METHOD))
+			ofono_info("Error from GetProperties reply: %s",
+					dbus_message_get_error_name(reply));
+
+		goto done;
+	}
+
+	bluetooth_parse_properties(reply, "UUIDs", has_uuid, &have_uuid,
+				"Adapter", parse_string, &adapter,
+				"Address", parse_string, &device_addr,
+				"Alias", parse_string, &alias, NULL);
+
+	if (adapter)
+		adapter_addr =3D g_hash_table_lookup(adapter_address_hash,
+							adapter);
+
+	if ((have_uuid & HFP_AG) && device_addr && adapter_addr) {
+		profile =3D g_hash_table_lookup(uuid_hash, HFP_AG_UUID);
+		if (!profile || !profile->create)
+			goto done;
+
+		profile->create(path, device_addr, adapter_addr, alias);
+	}
+
+done:
+	dbus_message_unref(reply);
+}
+
 static void parse_devices(DBusMessageIter *array, gpointer user_data)
 {
 	DBusMessageIter value;
@@ -257,13 +326,11 @@ static void adapter_properties_cb(DBusPendingCall *ca=
ll, gpointer user_data)
 				g_strdup(path), g_strdup(addr));
 =

 	for (l =3D device_list; l; l =3D l->next) {
-		/*
 		const char *device =3D l->data;
 =

 		bluetooth_send_with_reply(device, BLUEZ_DEVICE_INTERFACE,
 				"GetProperties", device_properties_cb,
 				g_strdup(device), g_free, -1, DBUS_TYPE_INVALID);
-		*/
 	}
 =

 done:
-- =

1.7.1


--===============8296024543811077694==--

