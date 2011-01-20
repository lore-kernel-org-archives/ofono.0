Content-Type: multipart/mixed; boundary="===============3156456742575050077=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v4] bluetooth: Add reference count for bluetooth utils
Date: Thu, 20 Jan 2011 12:10:12 +0100
Message-ID: <1295521812-29426-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3156456742575050077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add bluetooth_ref()/bluetooth_unref() to support reference count in
bluetooth utils.
---
 plugins/bluetooth.c |   51 ++++++++++++++++++++++++++++++++---------------=
----
 1 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 602c6da..93dd7a1 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -40,6 +40,7 @@
 static DBusConnection *connection;
 static GHashTable *uuid_hash =3D NULL;
 static GHashTable *adapter_address_hash =3D NULL;
+static gint bluetooth_refcount;
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
@@ -504,12 +505,10 @@ static guint adapter_added_watch;
 static guint adapter_removed_watch;
 static guint property_watch;
 =

-int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+static void bluetooth_ref(void)
 {
-	int err;
-
-	if (uuid_hash)
-		goto done;
+	if (bluetooth_refcount > 0)
+		goto increment;
 =

 	connection =3D ofono_dbus_get_connection();
 =

@@ -533,7 +532,6 @@ int bluetooth_register_uuid(const char *uuid, struct bl=
uetooth_profile *profile)
 =

 	if (bluetooth_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
 			adapter_removed_watch =3D=3D 0 || property_watch =3D=3D 0) {
-		err =3D -EIO;
 		goto remove;
 	}
 =

@@ -543,28 +541,21 @@ int bluetooth_register_uuid(const char *uuid, struct =
bluetooth_profile *profile)
 	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, g_free);
 =

-done:
-	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
-
-	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
-				manager_properties_cb, NULL, NULL, -1,
-				DBUS_TYPE_INVALID);
+increment:
+	g_atomic_int_inc(&bluetooth_refcount);
 =

-	return 0;
+	return;
 =

 remove:
 	g_dbus_remove_watch(connection, bluetooth_watch);
 	g_dbus_remove_watch(connection, adapter_added_watch);
 	g_dbus_remove_watch(connection, adapter_removed_watch);
 	g_dbus_remove_watch(connection, property_watch);
-	return err;
 }
 =

-void bluetooth_unregister_uuid(const char *uuid)
+static void bluetooth_unref(void)
 {
-	g_hash_table_remove(uuid_hash, uuid);
-
-	if (g_hash_table_size(uuid_hash))
+	if (g_atomic_int_dec_and_test(&bluetooth_refcount) =3D=3D FALSE)
 		return;
 =

 	g_dbus_remove_watch(connection, bluetooth_watch);
@@ -574,7 +565,29 @@ void bluetooth_unregister_uuid(const char *uuid)
 =

 	g_hash_table_destroy(uuid_hash);
 	g_hash_table_destroy(adapter_address_hash);
-	uuid_hash =3D NULL;
+}
+
+int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+{
+	bluetooth_ref();
+
+	if (bluetooth_refcount =3D=3D 0)
+		return -EIO;
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


--===============3156456742575050077==--

