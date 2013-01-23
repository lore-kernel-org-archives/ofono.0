Content-Type: multipart/mixed; boundary="===============7247201208547437270=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v1 01/10] hfp_hf_bluez5: Initial GDBusClient for BlueZ
Date: Wed, 23 Jan 2013 15:27:52 -0300
Message-ID: <1358965681-7420-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358965681-7420-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7247201208547437270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the initial callbacks to track when BlueZ connects so we can
register our HFP external profile handler. And tracks the interfaces added =
or
removed.
---
 plugins/bluez5.h        |  3 ++-
 plugins/hfp_hf_bluez5.c | 51 +++++++++++++++++++++++++++++++++++++++++++++=
----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 01ecfe8..893072f 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -19,7 +19,8 @@
  *
  */
 =

-#define	BLUEZ_SERVICE "org.bluez"
+#define BLUEZ_SERVICE			"org.bluez"
+#define BLUEZ_MANAGER_PATH		"/"
 #define BLUEZ_PROFILE_INTERFACE		BLUEZ_SERVICE ".Profile1"
 #define BLUEZ_ERROR_INTERFACE		BLUEZ_SERVICE ".Error"
 =

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index e024838..61e6669 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -42,6 +42,8 @@
 =

 #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
 =

+static GDBusClient *bluez =3D NULL;
+
 static int hfp_probe(struct ofono_modem *modem)
 {
 	DBG("modem: %p", modem);
@@ -143,6 +145,43 @@ static const GDBusMethodTable profile_methods[] =3D {
 	{ }
 };
 =

+static void connect_handler(DBusConnection *conn, void *user_data)
+{
+	DBG("Registering External Profile handler ...");
+
+	bluetooth_register_profile(conn, HFP_HS_UUID, "hfp_hf",
+						HFP_EXT_PROFILE_PATH);
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *path;
+
+	path =3D g_dbus_proxy_get_path(proxy);
+
+	DBG("Device proxy: %s(%p)", path, proxy);
+}
+
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *path;
+
+	path =3D g_dbus_proxy_get_path(proxy);
+
+	DBG("Device proxy: %s(%p)", path, proxy);
+}
+
+static void property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *interface, *path;
+
+	interface =3D g_dbus_proxy_get_interface(proxy);
+	path =3D g_dbus_proxy_get_path(proxy);
+
+	DBG("path: %s interface: %s", path, interface);
+}
+
 static int hfp_init(void)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -168,15 +207,18 @@ static int hfp_init(void)
 		return err;
 	}
 =

-	err =3D bluetooth_register_profile(conn, HFP_HS_UUID, "hfp_hf",
-						HFP_EXT_PROFILE_PATH);
-	if (err < 0) {
+	bluez =3D g_dbus_client_new(conn, BLUEZ_SERVICE, BLUEZ_MANAGER_PATH);
+	if (bluez =3D=3D NULL) {
 		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 		ofono_modem_driver_unregister(&hfp_driver);
-		return err;
+		return -ENOMEM;
 	}
 =

+	g_dbus_client_set_connect_watch(bluez, connect_handler, NULL);
+	g_dbus_client_set_proxy_handlers(bluez, proxy_added, proxy_removed,
+						property_changed, NULL);
+
 	return 0;
 }
 =

@@ -188,6 +230,7 @@ static void hfp_exit(void)
 	g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 	ofono_modem_driver_unregister(&hfp_driver);
+	g_dbus_client_unref(bluez);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", VERS=
ION,
-- =

1.8.1.1


--===============7247201208547437270==--

