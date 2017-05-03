Content-Type: multipart/mixed; boundary="===============8372336597646972110=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v4 1/5] hfp_hf_bluez5: Rework code handling device changes
Date: Wed, 03 May 2017 16:10:51 +0300
Message-ID: <20170503131055.9652-1-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8372336597646972110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This splits the handling of device changes and modem registration so
they can be uses separately.
---
 plugins/hfp_hf_bluez5.c | 150 ++++++++++++++++++++++++++------------------=
----
 1 file changed, 80 insertions(+), 70 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 6ae98b3..5f23b7f 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -176,11 +176,42 @@ static int service_level_connection(struct ofono_mode=
m *modem,
 	return -EINPROGRESS;
 }
 =

-static struct ofono_modem *modem_register(const char *device,
-				const char *device_address, const char *alias)
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
+static struct ofono_modem *modem_register(const char *device, GDBusProxy *=
proxy)
 {
 	struct ofono_modem *modem;
 	char *path;
+	DBusMessageIter iter;
+	const char *alias, *remote;
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
 =

 	path =3D g_strconcat("hfp", device, NULL);
 =

@@ -191,12 +222,15 @@ static struct ofono_modem *modem_register(const char =
*device,
 	if (modem =3D=3D NULL)
 		return NULL;
 =

-	ofono_modem_set_string(modem, "Remote", device_address);
+	ofono_modem_set_string(modem, "Remote", remote);
 	ofono_modem_set_string(modem, "DevicePath", device);
 =

 	ofono_modem_set_name(modem, alias);
 	ofono_modem_register(modem);
 =

+	g_dbus_proxy_set_property_watch(proxy, alias_changed, modem);
+	g_dbus_proxy_set_removed_watch(proxy, modem_removed, modem);
+
 	return modem;
 }
 =

@@ -499,6 +533,29 @@ static int get_version(DBusMessageIter *iter, uint16_t=
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
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -543,8 +600,8 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	if (modem =3D=3D NULL) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-					".Rejected",
-					"Unknown Bluetooth device");
+						".Rejected",
+						"Unknown Bluetooth device");
 	}
 =

 	err =3D service_level_connection(modem, fd, version);
@@ -686,52 +743,15 @@ static void connect_handler(DBusConnection *conn, voi=
d *user_data)
 					HFP_EXT_PROFILE_PATH, NULL, features);
 }
 =

-static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
+static void modem_unregister(struct ofono_modem *modem, GDBusProxy *proxy)
 {
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
 	ofono_modem_remove(modem);
+	g_dbus_proxy_set_removed_watch(proxy, NULL, NULL);
+	g_dbus_proxy_set_property_watch(proxy, NULL, NULL);
 }
 =

-static void alias_changed(GDBusProxy *proxy, const char *name,
-					DBusMessageIter *iter, void *user_data)
+static void device_changed(GDBusProxy *proxy, const char *path)
 {
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
 	DBusMessageIter iter;
 	dbus_bool_t paired;
 	struct ofono_modem *modem;
@@ -741,36 +761,26 @@ static void modem_register_from_proxy(GDBusProxy *pro=
xy, const char *path)
 =

 	dbus_message_iter_get_basic(&iter, &paired);
 =

-	if (paired =3D=3D FALSE) {
-		modem =3D ofono_modem_find(device_path_compare, (void *) path);
+	modem =3D ofono_modem_find(device_path_compare, (void *) path);
 =

-		if (modem !=3D NULL) {
-			ofono_modem_remove(modem);
-			g_dbus_proxy_set_removed_watch(proxy, NULL, NULL);
-			g_dbus_proxy_set_property_watch(proxy, NULL, NULL);
-		}
+	if (paired =3D=3D FALSE) {
+		if (modem !=3D NULL)
+			modem_unregister(modem, proxy);
 		return;
 	}
 =

-	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE)
-		return;
-
-	if (has_hfp_ag_uuid(&iter) =3D=3D FALSE)
+	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE ||
+				has_hfp_ag_uuid(&iter) =3D=3D FALSE) {
+		if (modem !=3D NULL)
+			modem_unregister(modem, proxy);
 		return;
+	}
 =

-	if (g_dbus_proxy_get_property(proxy, "Alias", &iter) =3D=3D FALSE)
-		return;
-
-	dbus_message_iter_get_basic(&iter, &alias);
-
-	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
+	/* Skip if modem already registered */
+	if (modem !=3D NULL)
 		return;
 =

-	dbus_message_iter_get_basic(&iter, &remote);
-
-	modem =3D modem_register(path, remote, alias);
-	g_dbus_proxy_set_property_watch(proxy, alias_changed, modem);
-	g_dbus_proxy_set_removed_watch(proxy, modem_removed, modem);
+	modem_register(path, proxy);
 }
 =

 static void proxy_added(GDBusProxy *proxy, void *user_data)
@@ -783,7 +793,7 @@ static void proxy_added(GDBusProxy *proxy, void *user_d=
ata)
 	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
 		return;
 =

-	modem_register_from_proxy(proxy, path);
+	device_changed(proxy, path);
 }
 =

 static void property_changed(GDBusProxy *proxy, const char *name,
@@ -800,7 +810,7 @@ static void property_changed(GDBusProxy *proxy, const c=
har *name,
 	if (g_str_equal("Paired", name) !=3D TRUE)
 		return;
 =

-	modem_register_from_proxy(proxy, path);
+	device_changed(proxy, path);
 }
 =

 static int hfp_init(void)
-- =

2.9.3


--===============8372336597646972110==--

