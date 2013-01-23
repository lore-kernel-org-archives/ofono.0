Content-Type: multipart/mixed; boundary="===============5226075628697012880=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v1 02/10] hfp_hf_bluez5: Add GDBusProxy for Bluetooth devices
Date: Wed, 23 Jan 2013 15:27:53 -0300
Message-ID: <1358965681-7420-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358965681-7420-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5226075628697012880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch tracks the GDBusProxy for Bluetooth devices in order to be
able to get its properties.
---
 plugins/bluez5.h        |  1 +
 plugins/hfp_hf_bluez5.c | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 893072f..65c0b00 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -22,6 +22,7 @@
 #define BLUEZ_SERVICE			"org.bluez"
 #define BLUEZ_MANAGER_PATH		"/"
 #define BLUEZ_PROFILE_INTERFACE		BLUEZ_SERVICE ".Profile1"
+#define BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device1"
 #define BLUEZ_ERROR_INTERFACE		BLUEZ_SERVICE ".Error"
 =

 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 61e6669..e0962a6 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -42,6 +42,7 @@
 =

 #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
 =

+static GHashTable *devices_proxies =3D NULL;
 static GDBusClient *bluez =3D NULL;
 =

 static int hfp_probe(struct ofono_modem *modem)
@@ -155,20 +156,31 @@ static void connect_handler(DBusConnection *conn, voi=
d *user_data)
 =

 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
-	const char *path;
+	const char *interface, *path;
 =

+	interface =3D g_dbus_proxy_get_interface(proxy);
 	path =3D g_dbus_proxy_get_path(proxy);
 =

+	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
+		return;
+
+	g_hash_table_insert(devices_proxies, g_strdup(path),
+						g_dbus_proxy_ref(proxy));
 	DBG("Device proxy: %s(%p)", path, proxy);
 }
 =

 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
-	const char *path;
+	const char *interface, *path;
 =

+	interface =3D g_dbus_proxy_get_interface(proxy);
 	path =3D g_dbus_proxy_get_path(proxy);
 =

-	DBG("Device proxy: %s(%p)", path, proxy);
+	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface)) {
+		g_hash_table_remove(devices_proxies, path);
+		DBG("Device proxy: %s(%p)", path, proxy);
+	}
+
 }
 =

 static void property_changed(GDBusProxy *proxy, const char *name,
@@ -215,6 +227,9 @@ static int hfp_init(void)
 		return -ENOMEM;
 	}
 =

+	devices_proxies =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+				g_free, (GDestroyNotify) g_dbus_proxy_unref);
+
 	g_dbus_client_set_connect_watch(bluez, connect_handler, NULL);
 	g_dbus_client_set_proxy_handlers(bluez, proxy_added, proxy_removed,
 						property_changed, NULL);
@@ -231,6 +246,8 @@ static void hfp_exit(void)
 						BLUEZ_PROFILE_INTERFACE);
 	ofono_modem_driver_unregister(&hfp_driver);
 	g_dbus_client_unref(bluez);
+
+	g_hash_table_destroy(devices_proxies);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", VERS=
ION,
-- =

1.8.1.1


--===============5226075628697012880==--

