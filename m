Content-Type: multipart/mixed; boundary="===============4400970881348769121=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/6] bluetooth: Add register service for bluetooth
Date: Mon, 05 Jul 2010 13:45:05 +0800
Message-ID: <1278308709-13908-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278308709-13908-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4400970881348769121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add bluetooth_register_service() and bluetooth_unregister_service()
where bluetooth profiles plugins like DUN GW can register themselves per
adapter. It shares existing bluetooth framework to listen bluetooth
events (new adapters, bluetoothd shutdown, etc..)
---
 plugins/bluetooth.c |  125 ++++++++++++++++++++++++++++++++++++++++++-----=
----
 plugins/bluetooth.h |    8 +++
 2 files changed, 112 insertions(+), 21 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 5a85eaa..3a3b5e6 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -38,8 +38,19 @@
 =

 static DBusConnection *connection;
 static GHashTable *uuid_hash =3D NULL;
+static GHashTable *service_hash =3D NULL;
 static GHashTable *adapter_address_hash =3D NULL;
 =

+static char *bluetooth_service_type_to_str(enum bluetooth_service_type typ=
e)
+{
+	switch (type) {
+	case DUN_GATEWAY:
+		return "DUN";
+	default:
+		return "";
+	}
+}
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
 {
@@ -376,6 +387,9 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 	GSList *device_list =3D NULL;
 	GSList *l;
 	const char *addr;
+	GHashTableIter hash_iter;
+	gpointer key, value;
+	struct bluetooth_profile *profile;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

@@ -393,6 +407,12 @@ static void adapter_properties_cb(DBusPendingCall *cal=
l, gpointer user_data)
 	g_hash_table_insert(adapter_address_hash,
 				g_strdup(path), g_strdup(addr));
 =

+	g_hash_table_iter_init(&hash_iter, service_hash);
+	while (g_hash_table_iter_next(&hash_iter, &key, &value)) {
+		profile =3D value;
+		profile->create(path, NULL, addr, NULL);
+	}
+
 	for (l =3D device_list; l; l =3D l->next) {
 		const char *device =3D l->data;
 =

@@ -492,10 +512,13 @@ static void bluetooth_remove_all_modem(gpointer key, =
gpointer value,
 =

 static void bluetooth_disconnect(DBusConnection *connection, void *user_da=
ta)
 {
-	if (!uuid_hash)
-		return;
+	if (uuid_hash)
+		g_hash_table_foreach(uuid_hash, bluetooth_remove_all_modem,
+					NULL);
 =

-	g_hash_table_foreach(uuid_hash, bluetooth_remove_all_modem, NULL);
+	if (service_hash)
+		g_hash_table_foreach(service_hash, bluetooth_remove_all_modem,
+					NULL);
 }
 =

 static guint bluetooth_watch;
@@ -503,12 +526,12 @@ static guint adapter_added_watch;
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
+	if (adapter_address_hash)
+		return 0;
 =

 	connection =3D ofono_dbus_get_connection();
 =

@@ -536,19 +559,9 @@ int bluetooth_register_uuid(const char *uuid, struct b=
luetooth_profile *profile)
 		goto remove;
 	}
 =

-	uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
-						g_free, NULL);
-
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
@@ -556,14 +569,13 @@ remove:
 	g_dbus_remove_watch(connection, adapter_added_watch);
 	g_dbus_remove_watch(connection, adapter_removed_watch);
 	g_dbus_remove_watch(connection, property_watch);
+
 	return err;
 }
 =

-void bluetooth_unregister_uuid(const char *uuid)
+static void bluetooth_exit()
 {
-	g_hash_table_remove(uuid_hash, uuid);
-
-	if (g_hash_table_size(uuid_hash))
+	if (uuid_hash !=3D NULL || service_hash !=3D NULL)
 		return;
 =

 	g_dbus_remove_watch(connection, bluetooth_watch);
@@ -571,9 +583,80 @@ void bluetooth_unregister_uuid(const char *uuid)
 	g_dbus_remove_watch(connection, adapter_removed_watch);
 	g_dbus_remove_watch(connection, property_watch);
 =

-	g_hash_table_destroy(uuid_hash);
 	g_hash_table_destroy(adapter_address_hash);
+}
+
+
+int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+{
+	int err;
+
+	err =3D bluetooth_init();
+	if (err)
+		return err;
+
+	if (!uuid_hash)
+		uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+							g_free, NULL);
+
+	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
+
+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
+				manager_properties_cb, NULL, NULL, -1,
+				DBUS_TYPE_INVALID);
+
+	return 0;
+}
+
+void bluetooth_unregister_uuid(const char *uuid)
+{
+	g_hash_table_remove(uuid_hash, uuid);
+
+	if (g_hash_table_size(uuid_hash) > 0)
+		return;
+
+	g_hash_table_destroy(uuid_hash);
 	uuid_hash =3D NULL;
+	bluetooth_exit();
+}
+
+int bluetooth_register_service(enum bluetooth_service_type type,
+					struct bluetooth_profile *profile)
+{
+	int err;
+	char *type_str;
+
+	err =3D bluetooth_init();
+	if (err)
+		return err;
+
+	type_str =3D bluetooth_service_type_to_str(type);
+
+	if (!service_hash)
+		service_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+							g_free, NULL);
+
+	g_hash_table_insert(service_hash, g_strdup(type_str), profile);
+
+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
+				manager_properties_cb, NULL, NULL, -1,
+				DBUS_TYPE_INVALID);
+
+	return 0;
+}
+
+void bluetooth_unregister_service(enum bluetooth_service_type type)
+{
+	char *type_str =3D bluetooth_service_type_to_str(type);
+
+	g_hash_table_remove(service_hash, type_str);
+
+	if (g_hash_table_size(service_hash) > 0)
+		return;
+
+	g_hash_table_destroy(service_hash);
+	service_hash =3D NULL;
+	bluetooth_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index fb0d841..84707a9 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -28,6 +28,10 @@
 /* Profiles bitfield */
 #define HFP_AG 0x01
 =

+enum bluetooth_service_type {
+	DUN_GATEWAY,
+};
+
 struct bluetooth_profile {
 	const char *name;
 	int (*create)(const char *device, const char *dev_addr,
@@ -40,6 +44,10 @@ int bluetooth_register_uuid(const char *uuid,
 				struct bluetooth_profile *profile);
 void bluetooth_unregister_uuid(const char *uuid);
 =

+int bluetooth_register_service(enum bluetooth_service_type type,
+					struct bluetooth_profile *profile);
+void bluetooth_unregister_service(enum bluetooth_service_type type);
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 							char *buf, int size);
 =

-- =

1.6.3.3


--===============4400970881348769121==--

