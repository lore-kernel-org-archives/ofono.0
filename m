Content-Type: multipart/mixed; boundary="===============0714547304733526676=="
MIME-Version: 1.0
From: Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH 1/2] dundee: export Bluetooth address in as D-Bus property
Date: Mon, 24 Jun 2013 17:14:01 +0100
Message-ID: <1372090442-15152-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0714547304733526676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 dundee/bluez4.c |  1 +
 dundee/bluez5.c |  1 +
 dundee/device.c | 24 ++++++++++++++++++++++++
 dundee/dundee.h |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/dundee/bluez4.c b/dundee/bluez4.c
index 58355d3..c9fbee8 100644
--- a/dundee/bluez4.c
+++ b/dundee/bluez4.c
@@ -183,6 +183,7 @@ static int bt_probe(const char *path, const char *dev_a=
ddr,
 		goto free;
 =

 	dundee_device_set_name(device, bt->name);
+	dundee_device_set_address(device, bt->address);
 =

 	if (dundee_device_register(device) < 0) {
 		g_free(device);
diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index 79b5ade..0608e40 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -282,6 +282,7 @@ static struct bluetooth_device *bluetooth_device_regist=
er(GDBusProxy *proxy)
 =

 	dundee_device_set_data(device, bt_device);
 	dundee_device_set_name(device, bt_device->name);
+	dundee_device_set_address(device, bt_device->address);
 =

 	if (dundee_device_register(device) < 0) {
 		g_free(device);
diff --git a/dundee/device.c b/dundee/device.c
index 2d84aaa..76fb692 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -57,6 +57,7 @@ struct dundee_device {
 	GAtChat *chat;
 =

 	char *name;
+	char *address;
 	gboolean active;
 	struct ipv4_settings settings;
 =

@@ -137,6 +138,9 @@ void __dundee_device_append_properties(struct dundee_de=
vice *device,
 	ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING,
 				&device->name);
 =

+	ofono_dbus_dict_append(dict, "Address", DBUS_TYPE_STRING,
+				&device->address);
+
 	ofono_dbus_dict_append(dict, "Active", DBUS_TYPE_BOOLEAN,
 				&device->active);
 }
@@ -586,6 +590,7 @@ static void destroy_device(gpointer user)
 =

 	g_free(device->path);
 	g_free(device->name);
+	g_free(device->address);
 =

 	g_free(device);
 }
@@ -666,6 +671,25 @@ int dundee_device_set_name(struct dundee_device *devic=
e, const char *name)
 	return 0;
 }
 =

+int dundee_device_set_address(struct dundee_device *device, const char *ad=
dress)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	DBG("%p address %s", device, address);
+
+	g_free(device->address);
+	device->address =3D g_strdup(address);
+
+	if (device->registered =3D=3D FALSE)
+		return 0;
+
+	ofono_dbus_signal_property_changed(conn, device->path,
+					DUNDEE_DEVICE_INTERFACE, "Address",
+					DBUS_TYPE_STRING, &device->address);
+
+	return 0;
+}
+
 static void device_shutdown(gpointer key, gpointer value, gpointer user_da=
ta)
 {
 	struct dundee_device *device =3D value;
diff --git a/dundee/dundee.h b/dundee/dundee.h
index 1889d84..56c6913 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -137,6 +137,8 @@ void dundee_device_set_data(struct dundee_device *devic=
e, void *data);
 void *dundee_device_get_data(struct dundee_device *device);
 =

 int dundee_device_set_name(struct dundee_device *device, const char *name);
+int dundee_device_set_address(struct dundee_device *device,
+							const char *address);
 =

 typedef void (*dundee_device_foreach_func)(struct dundee_device *device,
 						void *data);
-- =

1.8.1.4


--===============0714547304733526676==--

