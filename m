Content-Type: multipart/mixed; boundary="===============7854465111408810312=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 05/13] dundee: Add mechanism to store bluetooth devices
Date: Thu, 14 Mar 2013 10:32:46 -0300
Message-ID: <1363267974-13518-6-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363267974-13518-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7854465111408810312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a hash that will store every known bluetooth
device that implements DUN service.
---
 dundee/bluez5.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index 1b2c8e1..f2c9fed 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -32,6 +32,25 @@
 #define DUN_DT_PROFILE_PATH   "/bluetooth/profile/dun_dt"
 =

 static GDBusClient *bluez;
+static GHashTable *registered_devices;
+
+struct bluetooth_device {
+	char *path;
+	char *address;
+	char *name;
+};
+
+static void bluetooth_device_destroy(gpointer user_data)
+{
+	struct bluetooth_device *bt_device =3D user_data;
+
+	DBG("%s", bt_device->path);
+
+	g_free(bt_device->path);
+	g_free(bt_device->address);
+	g_free(bt_device->name);
+	g_free(bt_device);
+}
 =

 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
@@ -86,6 +105,9 @@ int __dundee_bluetooth_init(void)
 	g_dbus_client_set_proxy_handlers(bluez, proxy_added, proxy_removed,
 						property_changed, NULL);
 =

+	registered_devices =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+					g_free, bluetooth_device_destroy);
+
 	return 0;
 }
 =

@@ -94,4 +116,5 @@ void __dundee_bluetooth_cleanup(void)
 	DBG("");
 =

 	g_dbus_client_unref(bluez);
+	g_hash_table_destroy(registered_devices);
 }
-- =

1.7.9.5


--===============7854465111408810312==--

