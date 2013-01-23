Content-Type: multipart/mixed; boundary="===============3685683872414315049=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v1 03/10] hfp_hf_bluez5: Register modem for HFP AG capable
 devices
Date: Wed, 23 Jan 2013 15:27:54 -0300
Message-ID: <1358965681-7420-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358965681-7420-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3685683872414315049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that we are able to keep track of devices appearing and
disappearing from BlueZ, we are able to register the modem when a
device that supports the HFP AG UUID appears.
---
 plugins/bluez5.h        |  1 +
 plugins/hfp_hf_bluez5.c | 78 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 65c0b00..3aa8ffe 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -26,6 +26,7 @@
 #define BLUEZ_ERROR_INTERFACE		BLUEZ_SERVICE ".Error"
 =

 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
+#define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 =

 int bluetooth_register_profile(DBusConnection *conn, const char *uuid,
 					const char *name, const char *object);
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index e0962a6..fbb1be3 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -42,9 +42,37 @@
 =

 #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
 =

+static GHashTable *modem_hash =3D NULL;
 static GHashTable *devices_proxies =3D NULL;
 static GDBusClient *bluez =3D NULL;
 =

+static struct ofono_modem *modem_register(const char *device,
+						const char *alias)
+{
+	struct ofono_modem *modem;
+	char *path;
+
+	modem =3D g_hash_table_lookup(modem_hash, device);
+	if (modem !=3D NULL)
+		return modem;
+
+	path =3D g_strconcat("hfp", device, NULL);
+
+	modem =3D ofono_modem_create(path, "hfp");
+
+	g_free(path);
+
+	if (modem =3D=3D NULL)
+		return NULL;
+
+	ofono_modem_set_name(modem, alias);
+	ofono_modem_register(modem);
+
+	g_hash_table_insert(modem_hash, g_strdup(device), modem);
+
+	return modem;
+}
+
 static int hfp_probe(struct ofono_modem *modem)
 {
 	DBG("modem: %p", modem);
@@ -154,9 +182,33 @@ static void connect_handler(DBusConnection *conn, void=
 *user_data)
 						HFP_EXT_PROFILE_PATH);
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
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
-	const char *interface, *path;
+	const char *interface, *path, *alias;
+	DBusMessageIter iter;
 =

 	interface =3D g_dbus_proxy_get_interface(proxy);
 	path =3D g_dbus_proxy_get_path(proxy);
@@ -167,11 +219,25 @@ static void proxy_added(GDBusProxy *proxy, void *user=
_data)
 	g_hash_table_insert(devices_proxies, g_strdup(path),
 						g_dbus_proxy_ref(proxy));
 	DBG("Device proxy: %s(%p)", path, proxy);
+
+	if (g_dbus_proxy_get_property(proxy, "UUIDs", &iter) =3D=3D FALSE)
+		return;
+
+	if (has_hfp_ag_uuid(&iter) =3D=3D FALSE)
+		return;
+
+	if (g_dbus_proxy_get_property(proxy, "Alias", &iter) =3D=3D FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &alias);
+
+	modem_register(path, alias);
 }
 =

 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface, *path;
+	struct ofono_modem *modem;
 =

 	interface =3D g_dbus_proxy_get_interface(proxy);
 	path =3D g_dbus_proxy_get_path(proxy);
@@ -181,6 +247,12 @@ static void proxy_removed(GDBusProxy *proxy, void *use=
r_data)
 		DBG("Device proxy: %s(%p)", path, proxy);
 	}
 =

+	modem =3D g_hash_table_lookup(modem_hash, path);
+	if (modem =3D=3D NULL)
+		return;
+
+	g_hash_table_remove(modem_hash, path);
+	ofono_modem_remove(modem);
 }
 =

 static void property_changed(GDBusProxy *proxy, const char *name,
@@ -227,6 +299,9 @@ static int hfp_init(void)
 		return -ENOMEM;
 	}
 =

+	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
+								NULL);
+
 	devices_proxies =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 				g_free, (GDestroyNotify) g_dbus_proxy_unref);
 =

@@ -247,6 +322,7 @@ static void hfp_exit(void)
 	ofono_modem_driver_unregister(&hfp_driver);
 	g_dbus_client_unref(bluez);
 =

+	g_hash_table_destroy(modem_hash);
 	g_hash_table_destroy(devices_proxies);
 }
 =

-- =

1.8.1.1


--===============3685683872414315049==--

