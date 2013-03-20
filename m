Content-Type: multipart/mixed; boundary="===============1884391339819127816=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 04/13] dundee: Initial GDBusClient for BlueZ 5
Date: Wed, 20 Mar 2013 19:26:33 -0300
Message-ID: <1363818402-17710-5-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363818402-17710-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1884391339819127816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds callbacks to track additions of BlueZ related
interfaces.
---
 dundee/bluez5.c |   36 ++++++++++++++++++++++++++++++++++++
 dundee/dundee.h |    2 ++
 2 files changed, 38 insertions(+)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index 6685b4c..4ab7904 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -22,16 +22,52 @@
 #include <config.h>
 #endif
 =

+#include <stdint.h>
+#include <sys/socket.h>
+#include <gdbus.h>
+
 #include "dundee.h"
+#include "plugins/bluez5.h"
+
+#define DUN_DT_PROFILE_PATH   "/bluetooth/profile/dun_dt"
+
+static GDBusClient *bluez;
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *path =3D g_dbus_proxy_get_path(proxy);
+	const char *interface =3D g_dbus_proxy_get_interface(proxy);
+
+	if (!g_str_equal(BLUEZ_DEVICE_INTERFACE, interface))
+		return;
+
+	DBG("%s %s", path, interface);
+}
+
+static void connect_handler(DBusConnection *conn, void *user_data)
+{
+	DBG("");
+
+	bt_register_profile_with_role(conn, DUN_UUID, DUN_VERSION_1_2,
+				"dun_dt", DUN_DT_PROFILE_PATH, "client");
+}
 =

 int __dundee_bluetooth_init(void)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
 	DBG("");
 =

+	bluez =3D g_dbus_client_new(conn, BLUEZ_SERVICE, BLUEZ_MANAGER_PATH);
+	g_dbus_client_set_connect_watch(bluez, connect_handler, NULL);
+	g_dbus_client_set_proxy_handlers(bluez, proxy_added, NULL, NULL, NULL);
+
 	return 0;
 }
 =

 void __dundee_bluetooth_cleanup(void)
 {
 	DBG("");
+
+	g_dbus_client_unref(bluez);
 }
diff --git a/dundee/dundee.h b/dundee/dundee.h
index db932b6..daf78a5 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -26,6 +26,8 @@
 =

 #include <ofono/types.h>
 =

+#define DUN_VERSION_1_2 0x0102
+
 void __dundee_exit(void);
 =

 enum dundee_error_type {
-- =

1.7.9.5


--===============1884391339819127816==--

