Content-Type: multipart/mixed; boundary="===============8071337382799353720=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 3/6] bluetooth: add watches for the bluetoothd service and
 adapters
Date: Sun, 20 Jun 2010 05:51:21 -0300
Message-ID: <1277023884-27143-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1277023884-27143-2-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8071337382799353720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Exactly the same code from hfp.c
---
 plugins/bluetooth.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index d635989..a398312 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -338,6 +338,34 @@ done:
 	dbus_message_unref(reply);
 }
 =

+static gboolean adapter_added(DBusConnection *connection, DBusMessage *mes=
sage,
+				void *user_data)
+{
+	const char *path;
+	int ret;
+
+	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+
+	ret =3D bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
+			"GetProperties", adapter_properties_cb, g_strdup(path),
+			g_free, -1, DBUS_TYPE_INVALID);
+
+	return TRUE;
+}
+
+static gboolean adapter_removed(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	const char *path;
+
+	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID) =3D=3D TRUE)
+		g_hash_table_remove(adapter_address_hash, path);
+
+	return TRUE;
+}
+
 static void parse_adapters(DBusMessageIter *array, gpointer user_data)
 {
 	DBusMessageIter value;
@@ -384,13 +412,53 @@ done:
 	dbus_message_unref(reply);
 }
 =

+static void bluetooth_remove_all_modem(gpointer key, gpointer value, gpoin=
ter user_data)
+{
+	struct bluetooth_profile *profile =3D value;
+
+	profile->remove_all();
+}
+
+static void bluetooth_disconnect(DBusConnection *connection, void *user_da=
ta)
+{
+	if (!uuid_hash)
+		return;
+
+	g_hash_table_foreach(uuid_hash, bluetooth_remove_all_modem, NULL);
+}
+
+static guint bluetooth_watch;
+static guint adapter_added_watch;
+static guint adapter_removed_watch;
+
 int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
 {
+	int err;
+
 	if (uuid_hash)
 		goto done;
 =

 	connection =3D ofono_dbus_get_connection();
 =

+	bluetooth_watch =3D g_dbus_add_service_watch(connection, BLUEZ_SERVICE,
+					NULL, bluetooth_disconnect, NULL, NULL);
+
+	adapter_added_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_MANAGER_INTERFACE,
+						"AdapterAdded",
+						adapter_added, NULL, NULL);
+
+	adapter_removed_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_MANAGER_INTERFACE,
+						"AdapterRemoved",
+						adapter_removed, NULL, NULL);
+
+	if (bluetooth_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
+			adapter_removed_watch =3D=3D 0) {
+		err =3D -EIO;
+		goto remove;
+	}
+
 	uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, NULL);
 =

@@ -405,6 +473,12 @@ done:
 				DBUS_TYPE_INVALID);
 =

 	return 0;
+
+remove:
+	g_dbus_remove_watch(connection, bluetooth_watch);
+	g_dbus_remove_watch(connection, adapter_added_watch);
+	g_dbus_remove_watch(connection, adapter_removed_watch);
+	return err;
 }
 =

 void bluetooth_unregister_uuid(const char *uuid)
@@ -414,6 +488,10 @@ void bluetooth_unregister_uuid(const char *uuid)
 	if (g_hash_table_size(uuid_hash))
 		return;
 =

+	g_dbus_remove_watch(connection, bluetooth_watch);
+	g_dbus_remove_watch(connection, adapter_added_watch);
+	g_dbus_remove_watch(connection, adapter_removed_watch);
+
 	g_hash_table_destroy(uuid_hash);
 	g_hash_table_destroy(adapter_address_hash);
 	uuid_hash =3D NULL;
-- =

1.7.1


--===============8071337382799353720==--

