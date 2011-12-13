Content-Type: multipart/mixed; boundary="===============8210015205247986194=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 09/16] elect: Add BlueZ hooks to device
Date: Tue, 13 Dec 2011 16:00:03 +0100
Message-ID: <1323788410-9988-10-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8210015205247986194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am    |    4 +-
 elect/device.c |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index cdeab8d..a11176e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -651,8 +651,8 @@ if ELECT
 =

 sbin_PROGRAMS +=3D elect/electd
 =

-elect_electd_SOURCES =3D $(gdbus_sources) \
-			src/log.c src/dbus.c \
+elect_electd_SOURCES =3D $(gdbus_sources) $(btio_sources) \
+			src/log.c src/dbus.c plugins/bluetooth.c \
 			elect/main.c elect/dbus.c elect/manager.c elect/device.c
 =

 elect_electd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LI=
BS@ -ldl
diff --git a/elect/device.c b/elect/device.c
index 1198083..13999fd 100644
--- a/elect/device.c
+++ b/elect/device.c
@@ -31,16 +31,28 @@
 #include <glib.h>
 #include <gdbus.h>
 =

+#include "plugins/bluetooth.h"
+
 #include "elect.h"
 =

+static int next_device_id =3D 0;
 static GHashTable *device_hash;
 =

 struct elect_device {
+	/* The D-Bus path to this device */
+	char *elect_path;
+
+	/* BlueZ device information */
+	char *path;
+	char *address;
+	char *name;
+
+	DBusPendingCall *call;
 };
 =

 const char *__elect_device_get_path(struct elect_device *device)
 {
-	return "/";
+	return  device->elect_path;
 }
 =

 void __elect_device_append_properties(struct elect_device *device,
@@ -64,10 +76,129 @@ void __elect_device_foreach(elect_device_foreach_func =
func, void *userdata)
 	}
 }
 =

+static int bt_probe(const char *path, const char *dev_addr,
+				const char *adapter_addr, const char *alias)
+{
+	struct elect_device *device;
+	char buf[256];
+
+	DBG("");
+
+	/* We already have this device in our hash, ignore */
+	if (g_hash_table_lookup(device_hash, path) !=3D NULL)
+		return -EALREADY;
+
+	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
+			path, dev_addr, adapter_addr);
+
+	strcpy(buf, "dun/");
+	bluetooth_create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
+
+	device =3D g_try_new0(struct elect_device, 1);
+	if (device =3D=3D 0) {
+		DBG("Failed to create device data structure");
+		return -ENOMEM;
+	}
+
+	DBG("%p", device);
+
+	device->elect_path =3D g_strdup_printf("/device%d", next_device_id);
+	if (device->elect_path =3D=3D NULL)
+		goto free;
+
+	device->path =3D g_strdup(path);
+	if (device->path =3D=3D NULL)
+		goto free;
+
+	device->address =3D g_strdup(dev_addr);
+	if (device->address =3D=3D NULL)
+		goto free;
+
+	device->name =3D g_strdup(alias);
+	if (device->name =3D=3D NULL)
+		goto free;
+
+	g_hash_table_insert(device_hash, g_strdup(path), device);
+
+	next_device_id +=3D 1;
+
+	return 0;
+
+free:
+	g_free(device->path);
+	g_free(device->address);
+	g_free(device->name);
+	g_free(device->elect_path);
+	g_free(device);
+
+	return -ENOMEM;
+}
+
+static gboolean bt_remove_device(gpointer key, gpointer value,
+					gpointer user_data)
+{
+	struct elect_device *device =3D value;
+	const char *path =3D key;
+	const char *prefix =3D user_data;
+
+	DBG("%p", device);
+
+	if (device->call !=3D NULL)
+		dbus_pending_call_cancel(device->call);
+
+	if (prefix && g_str_has_prefix(path, prefix) =3D=3D FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static void bt_remove(const char *prefix)
+{
+	DBG("%s", prefix);
+
+	if (device_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach_remove(device_hash, bt_remove_device,
+							(gpointer) prefix);
+}
+
+static void bt_set_alias(const char *path, const char *alias)
+{
+	struct elect_device *device;
+
+	DBG("");
+
+	if (path =3D=3D NULL || alias =3D=3D NULL)
+		return;
+
+	device =3D g_hash_table_lookup(device_hash, path);
+	if (device =3D=3D NULL)
+		return;
+
+	g_free(device->name);
+	device->name =3D g_strdup(alias);
+}
+
+static struct bluetooth_profile dun_profile =3D {
+	.name		=3D "dun_dt",
+	.probe		=3D bt_probe,
+	.remove		=3D bt_remove,
+	.set_alias	=3D bt_set_alias,
+};
+
 static void destroy_device(gpointer user)
 {
 	struct elect_device *device =3D user;
 =

+	if (device->call)
+		dbus_pending_call_cancel(device->call);
+
+	g_free(device->elect_path);
+	g_free(device->path);
+	g_free(device->address);
+	g_free(device->name);
+
 	g_free(device);
 }
 =

@@ -84,8 +215,14 @@ void __elect_device_shutdown(void)
 =

 int __elect_device_init(void)
 {
+	int err;
+
 	DBG("");
 =

+	err =3D bluetooth_register_uuid(DUN_GW_UUID, &dun_profile);
+	if (err < 0)
+		return err;
+
 	device_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, destroy_device);
 =

@@ -96,5 +233,7 @@ void __elect_device_cleanup(void)
 {
 	DBG("");
 =

+	bluetooth_unregister_uuid(DUN_GW_UUID);
+
 	g_hash_table_destroy(device_hash);
 }
-- =

1.7.8.110.g4cb5d1


--===============8210015205247986194==--

