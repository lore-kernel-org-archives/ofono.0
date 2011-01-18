Content-Type: multipart/mixed; boundary="===============7118600476420871314=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2] bluetooth: Add reference count for bluetooth utils
Date: Tue, 18 Jan 2011 18:05:03 +0100
Message-ID: <1295370303-8976-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7118600476420871314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add bluetooth_ref()/bluetooth_unref() to support reference count in
bluetooth utils.
---
 plugins/bluetooth.c |   60 ++++++++++++++++++++++++++++++++++++++---------=
---
 1 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 602c6da..d641d18 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -40,6 +40,7 @@
 static DBusConnection *connection;
 static GHashTable *uuid_hash =3D NULL;
 static GHashTable *adapter_address_hash =3D NULL;
+static gint ref_count;
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
@@ -504,12 +505,12 @@ static guint adapter_added_watch;
 static guint adapter_removed_watch;
 static guint property_watch;
 =

-int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+static int bluetooth_ref(void)
 {
 	int err;
 =

-	if (uuid_hash)
-		goto done;
+	if (ref_count > 0)
+		return 0;
 =

 	connection =3D ofono_dbus_get_connection();
 =

@@ -543,12 +544,7 @@ int bluetooth_register_uuid(const char *uuid, struct b=
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
+	g_atomic_int_inc(&ref_count);
 =

 	return 0;
 =

@@ -557,14 +553,17 @@ remove:
 	g_dbus_remove_watch(connection, adapter_added_watch);
 	g_dbus_remove_watch(connection, adapter_removed_watch);
 	g_dbus_remove_watch(connection, property_watch);
+
 	return err;
 }
 =

-void bluetooth_unregister_uuid(const char *uuid)
+static void bluetooth_unref(void)
 {
-	g_hash_table_remove(uuid_hash, uuid);
+	gboolean is_zero;
+
+	is_zero =3D g_atomic_int_dec_and_test(&ref_count);
 =

-	if (g_hash_table_size(uuid_hash))
+	if (is_zero =3D=3D FALSE)
 		return;
 =

 	g_dbus_remove_watch(connection, bluetooth_watch);
@@ -572,9 +571,40 @@ void bluetooth_unregister_uuid(const char *uuid)
 	g_dbus_remove_watch(connection, adapter_removed_watch);
 	g_dbus_remove_watch(connection, property_watch);
 =

-	g_hash_table_destroy(uuid_hash);
-	g_hash_table_destroy(adapter_address_hash);
-	uuid_hash =3D NULL;
+	if (uuid_hash) {
+		g_hash_table_destroy(uuid_hash);
+		uuid_hash =3D NULL;
+	}
+
+	if (adapter_address_hash) {
+		g_hash_table_destroy(adapter_address_hash);
+		adapter_address_hash =3D NULL;
+	}
+}
+
+int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+{
+	int err;
+
+	err =3D bluetooth_ref();
+
+	if (err !=3D 0)
+		return err;
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
+	bluetooth_unref();
 }
 =

 OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
-- =

1.7.1


--===============7118600476420871314==--

