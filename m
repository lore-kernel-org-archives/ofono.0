Content-Type: multipart/mixed; boundary="===============8714151535749392044=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 2/2] hfp_hf_bluez5: Remove BlueZ devices proxies hash
Date: Thu, 31 Jan 2013 16:01:54 -0300
Message-ID: <1359658914-24892-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359658914-24892-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8714151535749392044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hash table to track the devices is not necessary anymore since
dynamic modem registration on NewConnection was removed.
---
 plugins/hfp_hf_bluez5.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index d2f3abb..2f4a89e 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -64,7 +64,6 @@ struct hfp {
 };
 =

 static GHashTable *modem_hash =3D NULL;
-static GHashTable *devices_proxies =3D NULL;
 static GDBusClient *bluez =3D NULL;
 static guint sco_watch =3D 0;
 =

@@ -500,10 +499,6 @@ static void proxy_added(GDBusProxy *proxy, void *user_=
data)
 	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
 		return;
 =

-	g_hash_table_insert(devices_proxies, g_strdup(path),
-						g_dbus_proxy_ref(proxy));
-	DBG("Device proxy: %s(%p)", path, proxy);
-
 	modem_register_from_proxy(proxy, path);
 }
 =

@@ -515,10 +510,8 @@ static void proxy_removed(GDBusProxy *proxy, void *use=
r_data)
 	interface =3D g_dbus_proxy_get_interface(proxy);
 	path =3D g_dbus_proxy_get_path(proxy);
 =

-	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface)) {
-		g_hash_table_remove(devices_proxies, path);
-		DBG("Device proxy: %s(%p)", path, proxy);
-	}
+	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
+		return;
 =

 	modem =3D g_hash_table_lookup(modem_hash, path);
 	if (modem =3D=3D NULL)
@@ -602,9 +595,6 @@ static int hfp_init(void)
 	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
 								NULL);
 =

-	devices_proxies =3D g_hash_table_new_full(g_str_hash, g_str_equal,
-				g_free, (GDestroyNotify) g_dbus_proxy_unref);
-
 	g_dbus_client_set_connect_watch(bluez, connect_handler, NULL);
 	g_dbus_client_set_proxy_handlers(bluez, proxy_added, proxy_removed,
 						property_changed, NULL);
@@ -623,7 +613,6 @@ static void hfp_exit(void)
 	g_dbus_client_unref(bluez);
 =

 	g_hash_table_destroy(modem_hash);
-	g_hash_table_destroy(devices_proxies);
 =

 	if (sco_watch > 0)
 		g_source_remove(sco_watch);
-- =

1.7.11.7


--===============8714151535749392044==--

