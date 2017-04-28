Content-Type: multipart/mixed; boundary="===============7537291252426091523=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 1/3] hfp_hf: Fix not creating modem during NewConnection
Date: Fri, 28 Apr 2017 10:40:03 +0300
Message-ID: <20170428074005.22543-1-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7537291252426091523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case the UUIDs are not updated, as they are still being resolved, when
Paired property changes a modem will never be registered.

In order to fix this problem allow modems to be registered directly
during NewConnection.
---
 plugins/hfp_hf_bluez5.c | 193 +++++++++++++++++++++++++-------------------=
----
 1 file changed, 102 insertions(+), 91 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 6ae98b3..fb7cc3f 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -499,6 +499,96 @@ static int get_version(DBusMessageIter *iter, uint16_t=
 *version)
 	return -ENOENT;
 }
 =

+static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
+{
+	DBusMessageIter value;
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		return FALSE;
+
+	dbus_message_iter_recurse(array, &value);
+
+	while (dbus_message_iter_get_arg_type(&value) =3D=3D DBUS_TYPE_STRING) {
+		const char *uuid;
+
+		dbus_message_iter_get_basic(&value, &uuid);
+
+		if (g_str_equal(uuid, HFP_AG_UUID) =3D=3D TRUE)
+			return TRUE;
+
+		dbus_message_iter_next(&value);
+	}
+
+	return FALSE;
+}
+
+static void modem_removed(GDBusProxy *proxy, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	ofono_modem_remove(modem);
+}
+
+static void alias_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *alias;
+	struct ofono_modem *modem =3D user_data;
+
+	if (g_str_equal("Alias", name) =3D=3D FALSE)
+		return;
+
+	dbus_message_iter_get_basic(iter, &alias);
+	ofono_modem_set_name(modem, alias);
+}
+
+static struct ofono_modem *modem_register_from_proxy(GDBusProxy *proxy,
+							const char *path)
+{
+	const char *alias, *remote;
+	DBusMessageIter iter;
+	dbus_bool_t paired;
+	struct ofono_modem *modem;
+
+	if (g_dbus_proxy_get_property(proxy, "Paired", &iter) =3D=3D FALSE)
+		return NULL;
+
+	dbus_message_iter_get_basic(&iter, &paired);
+
+	if (paired =3D=3D FALSE) {
+		modem =3D ofono_modem_find(device_path_compare, (void *) path);
+
+		if (modem !=3D NULL) {
+			ofono_modem_remove(modem);
+			g_dbus_proxy_set_removed_watch(proxy, NULL, NULL);
+			g_dbus_proxy_set_property_watch(proxy, NULL, NULL);
+		}
+		return NULL;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE)
+		return NULL;
+
+	if (has_hfp_ag_uuid(&iter) =3D=3D FALSE)
+		return NULL;
+
+	if (g_dbus_proxy_get_property(proxy, "Alias", &iter) =3D=3D FALSE)
+		return NULL;
+
+	dbus_message_iter_get_basic(&iter, &alias);
+
+	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
+		return NULL;
+
+	dbus_message_iter_get_basic(&iter, &remote);
+
+	modem =3D modem_register(path, remote, alias);
+	g_dbus_proxy_set_property_watch(proxy, alias_changed, modem);
+	g_dbus_proxy_set_removed_watch(proxy, modem_removed, modem);
+
+	return modem;
+}
+
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -541,10 +631,18 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
 =

 	modem =3D ofono_modem_find(device_path_compare, (void *) device);
 	if (modem =3D=3D NULL) {
-		close(fd);
-		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-					".Rejected",
-					"Unknown Bluetooth device");
+		GDBusProxy *proxy;
+
+		proxy =3D g_dbus_proxy_new(bluez, device, BLUEZ_DEVICE_INTERFACE);
+		modem =3D modem_register_from_proxy(proxy, device);
+		g_dbus_proxy_unref(proxy);
+
+		if (!modem) {
+			close(fd);
+			return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".Rejected",
+						"Unknown Bluetooth device");
+		}
 	}
 =

 	err =3D service_level_connection(modem, fd, version);
@@ -686,93 +784,6 @@ static void connect_handler(DBusConnection *conn, void=
 *user_data)
 					HFP_EXT_PROFILE_PATH, NULL, features);
 }
 =

-static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
-{
-	DBusMessageIter value;
-
-	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
-		return FALSE;
-
-	dbus_message_iter_recurse(array, &value);
-
-	while (dbus_message_iter_get_arg_type(&value) =3D=3D DBUS_TYPE_STRING) {
-		const char *uuid;
-
-		dbus_message_iter_get_basic(&value, &uuid);
-
-		if (g_str_equal(uuid, HFP_AG_UUID) =3D=3D TRUE)
-			return TRUE;
-
-		dbus_message_iter_next(&value);
-	}
-
-	return FALSE;
-}
-
-static void modem_removed(GDBusProxy *proxy, void *user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-
-	ofono_modem_remove(modem);
-}
-
-static void alias_changed(GDBusProxy *proxy, const char *name,
-					DBusMessageIter *iter, void *user_data)
-{
-	const char *alias;
-	struct ofono_modem *modem =3D user_data;
-
-	if (g_str_equal("Alias", name) =3D=3D FALSE)
-		return;
-
-	dbus_message_iter_get_basic(iter, &alias);
-	ofono_modem_set_name(modem, alias);
-}
-
-static void modem_register_from_proxy(GDBusProxy *proxy, const char *path)
-{
-	const char *alias, *remote;
-	DBusMessageIter iter;
-	dbus_bool_t paired;
-	struct ofono_modem *modem;
-
-	if (g_dbus_proxy_get_property(proxy, "Paired", &iter) =3D=3D FALSE)
-		return;
-
-	dbus_message_iter_get_basic(&iter, &paired);
-
-	if (paired =3D=3D FALSE) {
-		modem =3D ofono_modem_find(device_path_compare, (void *) path);
-
-		if (modem !=3D NULL) {
-			ofono_modem_remove(modem);
-			g_dbus_proxy_set_removed_watch(proxy, NULL, NULL);
-			g_dbus_proxy_set_property_watch(proxy, NULL, NULL);
-		}
-		return;
-	}
-
-	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE)
-		return;
-
-	if (has_hfp_ag_uuid(&iter) =3D=3D FALSE)
-		return;
-
-	if (g_dbus_proxy_get_property(proxy, "Alias", &iter) =3D=3D FALSE)
-		return;
-
-	dbus_message_iter_get_basic(&iter, &alias);
-
-	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
-		return;
-
-	dbus_message_iter_get_basic(&iter, &remote);
-
-	modem =3D modem_register(path, remote, alias);
-	g_dbus_proxy_set_property_watch(proxy, alias_changed, modem);
-	g_dbus_proxy_set_removed_watch(proxy, modem_removed, modem);
-}
-
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface, *path;
-- =

2.9.3


--===============7537291252426091523==--

