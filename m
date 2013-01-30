Content-Type: multipart/mixed; boundary="===============5508271892757002724=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 2/2] hfp_hf_bluez5: Only register modems for Paired devices
Date: Wed, 30 Jan 2013 13:24:16 -0300
Message-ID: <1359563056-24294-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359563056-24294-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5508271892757002724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

When there are many devices around that support the HFP AG profile,
we may have a lot of modems that the user will never use.
---
 plugins/hfp_hf_bluez5.c | 61 +++++++++++++++++++++++++++++++++------------=
----
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 653829b..8cac945 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -479,20 +479,18 @@ static gboolean has_hfp_ag_uuid(DBusMessageIter *arra=
y)
 	return FALSE;
 }
 =

-static void proxy_added(GDBusProxy *proxy, void *user_data)
+static void modem_register_from_proxy(GDBusProxy *proxy, const char *path)
 {
-	const char *interface, *path, *alias, *address;
+	const char *alias, *remote;
 	DBusMessageIter iter;
+	dbus_bool_t paired;
 =

-	interface =3D g_dbus_proxy_get_interface(proxy);
-	path =3D g_dbus_proxy_get_path(proxy);
-
-	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
+	if (g_dbus_proxy_get_property(proxy, "Paired", &iter) =3D=3D FALSE)
 		return;
 =

-	g_hash_table_insert(devices_proxies, g_strdup(path),
-						g_dbus_proxy_ref(proxy));
-	DBG("Device proxy: %s(%p)", path, proxy);
+	dbus_message_iter_get_basic(&iter, &paired);
+	if (paired =3D=3D FALSE)
+		return;
 =

 	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE)
 		return;
@@ -509,9 +507,26 @@ static void proxy_added(GDBusProxy *proxy, void *user_=
data)
 	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
 		return;
 =

-	dbus_message_iter_get_basic(&iter, &address);
+	dbus_message_iter_get_basic(&iter, &remote);
+
+	modem_register(path, remote, alias);
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface, *path;
+
+	interface =3D g_dbus_proxy_get_interface(proxy);
+	path =3D g_dbus_proxy_get_path(proxy);
 =

-	modem_register(path, address, alias);
+	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
+		return;
+
+	g_hash_table_insert(devices_proxies, g_strdup(path),
+						g_dbus_proxy_ref(proxy));
+	DBG("Device proxy: %s(%p)", path, proxy);
+
+	modem_register_from_proxy(proxy, path);
 }
 =

 static void proxy_removed(GDBusProxy *proxy, void *user_data)
@@ -538,27 +553,33 @@ static void proxy_removed(GDBusProxy *proxy, void *us=
er_data)
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
-	const char *interface, *path, *alias;
+	const char *interface, *path;
 	struct ofono_modem *modem;
 =

 	interface =3D g_dbus_proxy_get_interface(proxy);
 	path =3D g_dbus_proxy_get_path(proxy);
 =

-	DBG("path: %s interface: %s", path, interface);
-
 	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
 		return;
 =

-	if (g_str_equal("Alias", name) =3D=3D FALSE)
+	if (g_str_equal("Paired", name) =3D=3D TRUE) {
+		modem_register_from_proxy(proxy, path);
 		return;
+	}
 =

-	dbus_message_iter_get_basic(iter, &alias);
+	if (g_str_equal("Alias", name) =3D=3D TRUE) {
+		const char *alias;
 =

-	modem =3D g_hash_table_lookup(modem_hash, path);
-	if (modem =3D=3D NULL)
-		return;
+		dbus_message_iter_get_basic(iter, &alias);
 =

-	ofono_modem_set_name(modem, alias);
+		modem =3D g_hash_table_lookup(modem_hash, path);
+		if (modem =3D=3D NULL)
+			return;
+
+		DBG("path: %s Alias: %s", path, alias);
+
+		ofono_modem_set_name(modem, alias);
+	}
 }
 =

 static int hfp_init(void)
-- =

1.7.11.7


--===============5508271892757002724==--

