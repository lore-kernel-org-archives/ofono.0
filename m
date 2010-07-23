Content-Type: multipart/mixed; boundary="===============6594552352695328352=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/5] bluetooth: Add reference count for bluetooth utils
Date: Fri, 23 Jul 2010 17:40:30 +0800
Message-ID: <1279878034-12971-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1279878034-12971-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6594552352695328352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add bluetooth_ref()/bluetooth_unref() to support reference count in
bluetooth utils.
---
 plugins/bluetooth.c |   62 +++++++++++++++++++++++++++++++++++++----------=
----
 1 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 5a85eaa..10cc49d 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -39,6 +39,7 @@
 static DBusConnection *connection;
 static GHashTable *uuid_hash =3D NULL;
 static GHashTable *adapter_address_hash =3D NULL;
+static gint ref_count;
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
@@ -503,13 +504,10 @@ static guint adapter_added_watch;
 static guint adapter_removed_watch;
 static guint property_watch;
 =

-int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+static int bluetooth_init()
 {
 	int err;
 =

-	if (uuid_hash)
-		goto done;
-
 	connection =3D ofono_dbus_get_connection();
 =

 	bluetooth_watch =3D g_dbus_add_service_watch(connection, BLUEZ_SERVICE,
@@ -542,13 +540,6 @@ int bluetooth_register_uuid(const char *uuid, struct b=
luetooth_profile *profile)
 	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, g_free);
 =

-done:
-	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
-
-	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
-				manager_properties_cb, NULL, NULL, -1,
-				DBUS_TYPE_INVALID);
-
 	return 0;
 =

 remove:
@@ -556,14 +547,27 @@ remove:
 	g_dbus_remove_watch(connection, adapter_added_watch);
 	g_dbus_remove_watch(connection, adapter_removed_watch);
 	g_dbus_remove_watch(connection, property_watch);
+
 	return err;
 }
 =

-void bluetooth_unregister_uuid(const char *uuid)
+static int bluetooth_ref()
 {
-	g_hash_table_remove(uuid_hash, uuid);
+	g_atomic_int_inc(&ref_count);
+
+	if (ref_count > 1)
+		return 0;
+
+	return bluetooth_init();
+}
+
+static void bluetooth_unref()
+{
+	gboolean is_zero;
+
+	is_zero =3D g_atomic_int_dec_and_test(&ref_count);
 =

-	if (g_hash_table_size(uuid_hash))
+	if (is_zero =3D=3D FALSE)
 		return;
 =

 	g_dbus_remove_watch(connection, bluetooth_watch);
@@ -571,9 +575,33 @@ void bluetooth_unregister_uuid(const char *uuid)
 	g_dbus_remove_watch(connection, adapter_removed_watch);
 	g_dbus_remove_watch(connection, property_watch);
 =

-	g_hash_table_destroy(uuid_hash);
-	g_hash_table_destroy(adapter_address_hash);
-	uuid_hash =3D NULL;
+	if (uuid_hash)
+		g_hash_table_destroy(uuid_hash);
+
+	if (adapter_address_hash)
+		g_hash_table_destroy(adapter_address_hash);
+}
+
+int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+{
+	int err =3D bluetooth_ref();
+
+	if (err !=3D 0)
+		return err;
+
+	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
+
+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
+				manager_properties_cb, NULL, NULL, -1,
+				DBUS_TYPE_INVALID);
+	return 0;
+}
+
+void bluetooth_unregister_uuid(const char *uuid)
+{
+	g_hash_table_remove(uuid_hash, uuid);
+
+	bluetooth_unref();
 }
 =

 OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
-- =

1.7.0.4


--===============6594552352695328352==--

