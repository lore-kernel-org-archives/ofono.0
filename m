Content-Type: multipart/mixed; boundary="===============6225907459176146259=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v6 1/3] hfp_hf_bluez5: Rework code handling device changes
Date: Thu, 04 May 2017 11:22:34 +0300
Message-ID: <20170504082236.9977-1-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6225907459176146259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This splits the handling of device changes and modem registration so
they can be uses separately.
---
v6: Now properly rebased

 plugins/hfp_hf_bluez5.c | 104 +++++++++++++++++++++++++-------------------=
----
 1 file changed, 55 insertions(+), 49 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index f7d2450..bdeb3ca 100644
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

@@ -522,30 +556,15 @@ static gboolean has_hfp_ag_uuid(DBusMessageIter *arra=
y)
 	return FALSE;
 }
 =

-static void modem_removed(GDBusProxy *proxy, void *user_data)
+static void modem_unregister(struct ofono_modem *modem, GDBusProxy *proxy)
 {
-	struct ofono_modem *modem =3D user_data;
-
 	ofono_modem_remove(modem);
+	g_dbus_proxy_set_removed_watch(proxy, NULL, NULL);
+	g_dbus_proxy_set_property_watch(proxy, NULL, NULL);
 }
 =

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
-static struct ofono_modem *modem_register_from_proxy(GDBusProxy *proxy,
-							const char *path)
+static void *device_changed(GDBusProxy *proxy, const char *path)
 {
-	const char *alias, *remote;
 	DBusMessageIter iter;
 	dbus_bool_t paired;
 	struct ofono_modem *modem;
@@ -558,36 +577,23 @@ static struct ofono_modem *modem_register_from_proxy(=
GDBusProxy *proxy,
 	modem =3D ofono_modem_find(device_path_compare, (void *) path);
 =

 	if (paired =3D=3D FALSE) {
-		if (modem !=3D NULL) {
-			ofono_modem_remove(modem);
-			g_dbus_proxy_set_removed_watch(proxy, NULL, NULL);
-			g_dbus_proxy_set_property_watch(proxy, NULL, NULL);
-		}
+		if (modem !=3D NULL)
+			modem_unregister(modem, proxy);
 		return NULL;
 	}
 =

-	if (modem)
-		return modem;
-
-	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE)
-		return NULL;
-
-	if (has_hfp_ag_uuid(&iter) =3D=3D FALSE)
-		return NULL;
-
-	if (g_dbus_proxy_get_property(proxy, "Alias", &iter) =3D=3D FALSE)
-		return NULL;
-
-	dbus_message_iter_get_basic(&iter, &alias);
-
-	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
+	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE ||
+					has_hfp_ag_uuid(&iter) =3D=3D FALSE) {
+		if (modem !=3D NULL)
+			modem_unregister(modem, proxy);
 		return NULL;
+	}
 =

-	dbus_message_iter_get_basic(&iter, &remote);
+	/* Skip if modem already registered */
+	if (modem)
+		return modem;
 =

-	modem =3D modem_register(path, remote, alias);
-	g_dbus_proxy_set_property_watch(proxy, alias_changed, modem);
-	g_dbus_proxy_set_removed_watch(proxy, modem_removed, modem);
+	modem =3D modem_register(path, proxy);
 =

 	return modem;
 }
@@ -637,7 +643,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 		GDBusProxy *proxy;
 =

 		proxy =3D g_dbus_proxy_new(bluez, device, BLUEZ_DEVICE_INTERFACE);
-		modem =3D modem_register_from_proxy(proxy, device);
+		modem =3D modem_register(device, proxy);
 		g_dbus_proxy_unref(proxy);
 =

 		if (!modem) {
@@ -797,7 +803,7 @@ static void proxy_added(GDBusProxy *proxy, void *user_d=
ata)
 	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
 		return;
 =

-	modem_register_from_proxy(proxy, path);
+	device_changed(proxy, path);
 }
 =

 static void property_changed(GDBusProxy *proxy, const char *name,
@@ -815,7 +821,7 @@ static void property_changed(GDBusProxy *proxy, const c=
har *name,
 			g_str_equal("ServicesResolved", name) !=3D TRUE)
 		return;
 =

-	modem_register_from_proxy(proxy, path);
+	device_changed(proxy, path);
 }
 =

 static int hfp_init(void)
-- =

2.9.3


--===============6225907459176146259==--

