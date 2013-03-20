Content-Type: multipart/mixed; boundary="===============1082526913162571133=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 06/13] dundee: Add tracking of bluetooth devices
Date: Wed, 20 Mar 2013 19:26:35 -0300
Message-ID: <1363818402-17710-7-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363818402-17710-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1082526913162571133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch tracks the GDBusProxy for Bluetooth devices in order to
be able to get their properties.
---
 dundee/bluez5.c |  102 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 102 insertions(+)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index 7a9e0fe..3688753 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -52,15 +52,117 @@ static void bluetooth_device_destroy(gpointer user_dat=
a)
 	g_free(bt_device);
 }
 =

+static struct bluetooth_device *bluetooth_device_create(const char *path,
+					const char *address, const char *alias)
+{
+	struct bluetooth_device *bt_device;
+
+	DBG("%s %s %s", path, address, alias);
+
+	bt_device =3D g_try_new0(struct bluetooth_device, 1);
+	if (bt_device =3D=3D NULL)
+		return NULL;
+
+	bt_device->path =3D g_strdup(path);
+	bt_device->address =3D g_strdup(address);
+	bt_device->name =3D g_strdup(alias);
+
+	return bt_device;
+}
+
+static struct bluetooth_device *bluetooth_device_register(GDBusProxy *prox=
y)
+{
+	const char *path =3D g_dbus_proxy_get_path(proxy);
+	const char *alias, *address;
+	struct bluetooth_device *bt_device;
+	DBusMessageIter iter;
+
+	DBG("%s", path);
+
+	if (g_hash_table_lookup(registered_devices, path) !=3D NULL)
+		return NULL;
+
+	if (!g_dbus_proxy_get_property(proxy, "Address", &iter))
+		return NULL;
+
+	dbus_message_iter_get_basic(&iter, &address);
+
+	if (!g_dbus_proxy_get_property(proxy, "Alias", &iter))
+		return NULL;
+
+	dbus_message_iter_get_basic(&iter, &alias);
+
+	bt_device =3D bluetooth_device_create(path, address, alias);
+	if (bt_device =3D=3D NULL) {
+		ofono_error("Register bluetooth device failed");
+		return NULL;
+	}
+
+	g_hash_table_insert(registered_devices, g_strdup(path), bt_device);
+
+	return bt_device;
+}
+
+static void bluetooth_device_unregister(const char *path)
+{
+	DBG("");
+
+	g_hash_table_remove(registered_devices, path);
+}
+
+static gboolean has_dun_uuid(DBusMessageIter *array)
+{
+	DBusMessageIter value;
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		return FALSE;
+
+	dbus_message_iter_recurse(array, &value);
+
+	while (dbus_message_iter_get_arg_type(&value) =3D=3D DBUS_TYPE_STRING) {
+		const char *uuid;
+
+		dbus_message_iter_get_basic(&value, &uuid);
+
+		if (g_str_equal(uuid, DUN_UUID))
+			return TRUE;
+
+		dbus_message_iter_next(&value);
+	}
+
+	return FALSE;
+}
+
+static void bluetooth_device_removed(GDBusProxy *proxy, void *user_data)
+{
+	struct bluetooth_device *bt_device =3D user_data;
+
+	DBG("%s", bt_device->path);
+
+	bluetooth_device_unregister(bt_device->path);
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *path =3D g_dbus_proxy_get_path(proxy);
 	const char *interface =3D g_dbus_proxy_get_interface(proxy);
+	struct bluetooth_device *bt_device;
+	DBusMessageIter iter;
 =

 	if (!g_str_equal(BLUEZ_DEVICE_INTERFACE, interface))
 		return;
 =

+	if (!g_dbus_proxy_get_property(proxy, "UUIDs", &iter))
+		return;
+
 	DBG("%s %s", path, interface);
+
+	if (!has_dun_uuid(&iter))
+		return;
+
+	bt_device =3D bluetooth_device_register(proxy);
+	g_dbus_proxy_set_removed_watch(proxy, bluetooth_device_removed,
+								bt_device);
 }
 =

 static void connect_handler(DBusConnection *conn, void *user_data)
-- =

1.7.9.5


--===============1082526913162571133==--

