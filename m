Content-Type: multipart/mixed; boundary="===============8162032087205710887=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 1/6] bluetooth: Move functions from hfp.c to bluetooth.c
Date: Sun, 20 Jun 2010 05:51:19 -0300
Message-ID: <1277023884-27143-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8162032087205710887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The part that call device_properties_cb is commented to permit this patch
compile.
device_properties_cb() will be changed, so it will have separated patch.
---
 plugins/bluetooth.c |  122 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 0b1b560..e27982b 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -199,6 +199,124 @@ done:
 	g_slist_free(prop_handlers);
 }
 =

+static void parse_string(DBusMessageIter *iter, gpointer user_data)
+{
+	char **str =3D user_data;
+	int arg_type =3D dbus_message_iter_get_arg_type(iter);
+
+	if (arg_type !=3D DBUS_TYPE_OBJECT_PATH && arg_type !=3D DBUS_TYPE_STRING)
+		return;
+
+	dbus_message_iter_get_basic(iter, str);
+}
+
+static void parse_devices(DBusMessageIter *array, gpointer user_data)
+{
+	DBusMessageIter value;
+	GSList **device_list =3D user_data;
+
+	DBG("");
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		return;
+
+	dbus_message_iter_recurse(array, &value);
+
+	while (dbus_message_iter_get_arg_type(&value)
+			=3D=3D DBUS_TYPE_OBJECT_PATH) {
+		const char *path;
+
+		dbus_message_iter_get_basic(&value, &path);
+
+		*device_list =3D g_slist_prepend(*device_list, (gpointer) path);
+
+		dbus_message_iter_next(&value);
+	}
+}
+
+static void adapter_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
+{
+	const char *path =3D user_data;
+	DBusMessage *reply;
+	GSList *device_list =3D NULL;
+	GSList *l;
+	const char *addr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		DBG("Bluetooth daemon is apparently not available.");
+		goto done;
+	}
+
+	bluetooth_parse_properties(reply, "Devices", parse_devices, &device_list,
+				"Address", parse_string, &addr, NULL);
+
+	DBG("Adapter Address: %s, Path: %s", addr, path);
+	g_hash_table_insert(adapter_address_hash,
+				g_strdup(path), g_strdup(addr));
+
+	for (l =3D device_list; l; l =3D l->next) {
+		/*
+		const char *device =3D l->data;
+
+		bluetooth_send_with_reply(device, BLUEZ_DEVICE_INTERFACE,
+				"GetProperties", device_properties_cb,
+				g_strdup(device), g_free, -1, DBUS_TYPE_INVALID);
+		*/
+	}
+
+done:
+	g_slist_free(device_list);
+	dbus_message_unref(reply);
+}
+
+static void parse_adapters(DBusMessageIter *array, gpointer user_data)
+{
+	DBusMessageIter value;
+
+	DBG("");
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		return;
+
+	dbus_message_iter_recurse(array, &value);
+
+	while (dbus_message_iter_get_arg_type(&value)
+			=3D=3D DBUS_TYPE_OBJECT_PATH) {
+		const char *path;
+
+		dbus_message_iter_get_basic(&value, &path);
+
+		DBG("Calling GetProperties on %s", path);
+
+		bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
+				"GetProperties", adapter_properties_cb,
+				g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+
+		dbus_message_iter_next(&value);
+	}
+}
+
+static void manager_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
+{
+	DBusMessage *reply;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		DBG("Bluetooth daemon is apparently not available.");
+		goto done;
+	}
+
+	DBG("");
+
+	bluetooth_parse_properties(reply, "Adapters", parse_adapters, NULL, NULL);
+
+done:
+	dbus_message_unref(reply);
+}
+
 int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
 {
 	if (uuid_hash)
@@ -215,6 +333,10 @@ int bluetooth_register_uuid(const char *uuid, struct b=
luetooth_profile *profile)
 done:
 	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
 =

+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
+				manager_properties_cb, NULL, NULL, -1,
+				DBUS_TYPE_INVALID);
+
 	return 0;
 }
 =

-- =

1.7.1


--===============8162032087205710887==--

