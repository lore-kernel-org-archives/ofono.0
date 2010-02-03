Content-Type: multipart/mixed; boundary="===============3678328335276941481=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] hfp: create modem for new devices paired on runtime
Date: Wed, 03 Feb 2010 20:18:50 -0200
Message-ID: <1265235530-23421-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3678328335276941481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It listens the Paired property to create a modem to the recently paired
devices. It also renames added_watch to adapter_watch, a more proper
name.
---
 plugins/hfp.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 0e2e359..c32a18f 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -65,6 +65,7 @@ static const char *cmer_prefix[] =3D { "+CMER:", NULL };
 static const char *chld_prefix[] =3D { "+CHLD:", NULL };
 =

 static DBusConnection *connection;
+static GHashTable *uuid_watches =3D NULL;
 =

 static int hfp_disable(struct ofono_modem *modem);
 static void hfp_remove(struct ofono_modem *modem);
@@ -594,6 +595,79 @@ static gboolean adapter_added(DBusConnection *connecti=
on, DBusMessage *message,
 	return TRUE;
 }
 =

+static void uuid_watch_remove(gpointer data)
+{
+	guint id;
+
+	g_dbus_remove_watch(connection, id);
+}
+
+static gboolean uuid_emitted(DBusConnection *connection, DBusMessage *mess=
age,
+				void *user_data)
+{
+	const char *device, *property;
+	const char *path =3D user_data;
+	DBusMessageIter iter;
+
+	device =3D dbus_message_get_path(message);
+
+	if (!g_str_equal(path, device))
+		return TRUE;
+
+	dbus_message_iter_init(message, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &property);
+	if (g_str_equal(property, "UUIDs") =3D=3D FALSE)
+		return TRUE;
+
+	g_hash_table_remove(uuid_watches, path);
+
+	if (!dbus_message_iter_next(&iter))
+		return FALSE;
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return FALSE;
+
+	parse_uuids(&iter, device);
+
+	return TRUE;
+}
+
+static gboolean device_created(DBusConnection *connection, DBusMessage *me=
ssage,
+				void *user_data)
+{
+	const char *path;
+	guint uuid_watch;
+
+	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+
+	uuid_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_DEVICE_INTERFACE,
+						"PropertyChanged", uuid_emitted,
+						(void *)path, NULL);
+
+	g_hash_table_insert(uuid_watches, g_strdup(path), &uuid_watch);
+
+	return TRUE;
+}
+
+static gboolean device_removed(DBusConnection *connection, DBusMessage *me=
ssage,
+				void *user_data)
+{
+	const char *path;
+
+	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+
+	g_hash_table_remove(uuid_watches, path);
+
+	return TRUE;
+}
+
 static void list_adapters_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusError err;
@@ -801,7 +875,9 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

-static guint added_watch;
+static guint adapter_watch;
+static guint device_watch;
+static guint removed_watch;
 =

 static int hfp_init(void)
 {
@@ -812,12 +888,26 @@ static int hfp_init(void)
 =

 	connection =3D ofono_dbus_get_connection();
 =

-	added_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+	adapter_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
 						BLUEZ_MANAGER_INTERFACE,
 						"AdapterAdded",
 						adapter_added, NULL, NULL);
 =

-	if (added_watch =3D=3D 0) {
+	device_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_ADAPTER_INTERFACE,
+						"DeviceCreated",
+						device_created, NULL, NULL);
+
+	removed_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_ADAPTER_INTERFACE,
+						"DeviceRemoved",
+						device_removed, NULL, NULL);
+
+
+	uuid_watches =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+			g_free, uuid_watch_remove);
+
+	if (adapter_watch =3D=3D 0 || device_watch =3D=3D 0 || removed_watch =3D=
=3D 0) {
 		err =3D -EIO;
 		goto remove;
 	}
@@ -831,7 +921,10 @@ static int hfp_init(void)
 	return 0;
 =

 remove:
-	g_dbus_remove_watch(connection, added_watch);
+	g_dbus_remove_watch(connection, adapter_watch);
+	g_dbus_remove_watch(connection, device_watch);
+	g_dbus_remove_watch(connection, removed_watch);
+	g_hash_table_destroy(uuid_watches);
 =

 	dbus_connection_unref(connection);
 =

@@ -840,7 +933,10 @@ remove:
 =

 static void hfp_exit(void)
 {
-	g_dbus_remove_watch(connection, added_watch);
+	g_dbus_remove_watch(connection, adapter_watch);
+	g_dbus_remove_watch(connection, device_watch);
+	g_dbus_remove_watch(connection, removed_watch);
+	g_hash_table_destroy(uuid_watches);
 =

 	ofono_modem_driver_unregister(&hfp_driver);
 }
-- =

1.6.4.4


--===============3678328335276941481==--

