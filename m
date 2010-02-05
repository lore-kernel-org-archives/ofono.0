Content-Type: multipart/mixed; boundary="===============8929172153376033553=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/3] hfp: create modem for new devices paired on runtime
Date: Fri, 05 Feb 2010 18:47:05 +0000
Message-ID: <1326571257-7566-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8929172153376033553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It listens the Paired property to create a modem to the recently paired
devices. It also renames added_watch to adapter_watch, a more proper
name.
---
 plugins/hfp.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++-=
---
 1 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 981b05b..3e41342 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -66,6 +66,7 @@ static const char *cmer_prefix[] =3D { "+CMER:", NULL };
 static const char *chld_prefix[] =3D { "+CHLD:", NULL };
 =

 static DBusConnection *connection;
+static GHashTable *uuid_hash =3D NULL;
 =

 static void hfp_debug(const char *str, void *user_data)
 {
@@ -427,6 +428,7 @@ static int hfp_create_modem(const char *device)
 {
 	struct ofono_modem *modem;
 	struct hfp_data *data;
+	const char *path;
 =

 	ofono_info("Using device: %s", device);
 =

@@ -451,6 +453,9 @@ static int hfp_create_modem(const char *device)
 	ofono_modem_set_data(modem, data);
 	ofono_modem_register(modem);
 =

+	path =3D ofono_modem_get_path(modem);
+	g_hash_table_insert(uuid_hash, g_strdup(device), g_strdup(path));
+
 	return 0;
 =

 free:
@@ -465,6 +470,9 @@ static void parse_uuids(DBusMessageIter *i, const char =
*device)
 	DBusMessageIter variant, ai;
 	const char *value;
 =

+	if (g_hash_table_lookup(uuid_hash, device))
+		return;
+
 	dbus_message_iter_recurse(i, &variant);
 	dbus_message_iter_recurse(&variant, &ai);
 =

@@ -624,6 +632,33 @@ static gboolean adapter_added(DBusConnection *connecti=
on, DBusMessage *message,
 	return TRUE;
 }
 =

+static gboolean uuid_emitted(DBusConnection *connection, DBusMessage *mess=
age,
+				void *user_data)
+{
+	const char *device, *property;
+	DBusMessageIter iter;
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
+	if (!dbus_message_iter_next(&iter))
+		return FALSE;
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return FALSE;
+
+	device =3D dbus_message_get_path(message);
+	parse_uuids(&iter, device);
+
+	return TRUE;
+}
+
 static void list_adapters_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusError err;
@@ -725,6 +760,8 @@ static void hfp_remove(struct ofono_modem *modem)
 =

 	hfp_unregister_ofono_handsfree(modem);
 =

+	g_hash_table_remove(uuid_hash, data->handsfree_path);
+
 	g_free(data->handsfree_path);
 	g_free(data);
 =

@@ -798,7 +835,8 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

-static guint added_watch;
+static guint adapter_watch;
+static guint uuid_watch;
 =

 static int hfp_init(void)
 {
@@ -809,12 +847,21 @@ static int hfp_init(void)
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
+	uuid_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_DEVICE_INTERFACE,
+						"PropertyChanged",
+						uuid_emitted, NULL, NULL);
+
+
+	uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+			g_free, g_free);
+
+	if (adapter_watch =3D=3D 0 || uuid_watch =3D=3D 0) {
 		err =3D -EIO;
 		goto remove;
 	}
@@ -828,7 +875,9 @@ static int hfp_init(void)
 	return 0;
 =

 remove:
-	g_dbus_remove_watch(connection, added_watch);
+	g_dbus_remove_watch(connection, adapter_watch);
+	g_dbus_remove_watch(connection, uuid_watch);
+	g_hash_table_destroy(uuid_hash);
 =

 	dbus_connection_unref(connection);
 =

@@ -837,9 +886,12 @@ remove:
 =

 static void hfp_exit(void)
 {
-	g_dbus_remove_watch(connection, added_watch);
+	g_dbus_remove_watch(connection, adapter_watch);
+	g_dbus_remove_watch(connection, uuid_watch);
 =

 	ofono_modem_driver_unregister(&hfp_driver);
+
+	g_hash_table_destroy(uuid_hash);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp, "Hands-Free Profile Plugins", VERSION,
-- =

1.6.4.4


--===============8929172153376033553==--

