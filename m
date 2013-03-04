Content-Type: multipart/mixed; boundary="===============9050649493875024581=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 09/13] dundee: Register/unregister dundee device
Date: Mon, 04 Mar 2013 16:33:10 -0300
Message-ID: <1362425590-26075-10-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1362425590-26075-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9050649493875024581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the dundee device struct to the our Bluetooth
device representation.
---
 dundee/bluez5.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index 19111e7..12f0cf0 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -35,6 +35,8 @@ static GDBusClient *bluez;
 static GHashTable *registered_devices;
 =

 struct bluetooth_device {
+	struct dundee_device *device;
+
 	char *path;
 	char *address;
 	char *name;
@@ -46,6 +48,9 @@ static void bluetooth_device_destroy(gpointer user_data)
 =

 	DBG("%s", bt_device->path);
 =

+	if (bt_device->device !=3D NULL)
+		dundee_device_unregister(bt_device->device);
+
 	g_free(bt_device->path);
 	g_free(bt_device->address);
 	g_free(bt_device->name);
@@ -93,6 +98,7 @@ static void bluetooth_device_register(GDBusProxy *proxy)
 	const char *path =3D g_dbus_proxy_get_path(proxy);
 	const char *alias, *address;
 	struct bluetooth_device *bt_device;
+	struct dundee_device *device;
 	DBusMessageIter iter;
 =

 	DBG("%s", path);
@@ -116,7 +122,26 @@ static void bluetooth_device_register(GDBusProxy *prox=
y)
 		return;
 	}
 =

+	device =3D dundee_device_create(&bluetooth_driver);
+	if (device =3D=3D NULL)
+		goto free;
+
+	dundee_device_set_data(device, bt_device);
+	dundee_device_set_name(device, bt_device->name);
+
+	if (dundee_device_register(device) < 0) {
+		g_free(device);
+		goto free;
+	}
+
+	bt_device->device =3D device;
 	g_hash_table_insert(registered_devices, g_strdup(path), bt_device);
+
+	return;
+
+free:
+	bluetooth_device_destroy(bt_device);
+	return;
 }
 =

 static void bluetooth_device_unregister(const char *path)
-- =

1.7.9.5


--===============9050649493875024581==--

