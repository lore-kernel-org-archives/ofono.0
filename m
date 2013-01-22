Content-Type: multipart/mixed; boundary="===============3795638516676846874=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 02/10] hfp_hf_bluez5: Add GDBusProxy for Bluetooth devices
Date: Tue, 22 Jan 2013 18:43:17 -0300
Message-ID: <1358891005-24688-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358891005-24688-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3795638516676846874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch tracks the GDBusProxy for Bluetooth devices in order to be
able to get its properties.
---
 plugins/bluez5.h        |  2 ++
 plugins/hfp_hf_bluez5.c | 23 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 893072f..e232fee 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -22,6 +22,8 @@
 #define BLUEZ_SERVICE			"org.bluez"
 #define BLUEZ_MANAGER_PATH		"/"
 #define BLUEZ_PROFILE_INTERFACE		BLUEZ_SERVICE ".Profile1"
+#define BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE".Adapter1"
+#define BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE".Device1"
 #define BLUEZ_ERROR_INTERFACE		BLUEZ_SERVICE ".Error"
 =

 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index c5c5cd7..2daa4c9 100644
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
@@ -172,20 +173,31 @@ static void disconnect_handler(DBusConnection *conn, =
void *user_data)
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
@@ -230,6 +242,9 @@ static int hfp_init(void)
 		return err;
 	}
 =

+	devices_proxies =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+				g_free, (GDestroyNotify) g_dbus_proxy_unref);
+
 	return 0;
 }
 =

@@ -242,6 +257,8 @@ static void hfp_exit(void)
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


--===============3795638516676846874==--

