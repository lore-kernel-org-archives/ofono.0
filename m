Content-Type: multipart/mixed; boundary="===============2357450511549494472=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v1 07/15] hfp_hf: Register HFP modem dynamically
Date: Mon, 26 Nov 2012 10:27:01 -0300
Message-ID: <1353936429-9997-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353936429-9997-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2357450511549494472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch moves the modem creation from the Bluetooth profile probe
to the NewConnection method call. HFP modem are now registered when
the Bluetooth link is established.
---
 plugins/hfp_hf.c | 109 +++++++++++++++++++++++++++++++++++++--------------=
----
 1 file changed, 73 insertions(+), 36 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index dc00227..b3ea13f 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -57,13 +57,28 @@
 =

 static DBusConnection *connection;
 static GHashTable *modem_hash =3D NULL;
+static GHashTable *hfp_hash =3D NULL;
 =

 struct hfp_data {
 	struct hfp_slc_info info;
-	char *handsfree_address;
+	gchar *device_address;
+	gchar *adapter_address;
+	gchar *device_alias;
+	gchar *device_path;
 	DBusMessage *slc_msg;
 };
 =

+static void hfp_data_free(gpointer user_data)
+{
+	struct hfp_data *hfp_data =3D user_data;
+
+	g_free(hfp_data->device_address);
+	g_free(hfp_data->adapter_address);
+	g_free(hfp_data->device_alias);
+	g_free(hfp_data->device_path);
+	g_free(hfp_data);
+}
+
 static void hfp_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -117,6 +132,10 @@ static void hfp_disconnected_cb(gpointer user_data)
 =

 	g_at_chat_unref(data->info.chat);
 	data->info.chat =3D NULL;
+
+	g_hash_table_remove(modem_hash, data->device_path);
+
+	ofono_modem_remove(modem);
 }
 =

 /* either oFono or Phone could request SLC connection */
@@ -153,46 +172,72 @@ static int service_level_connection(struct ofono_mode=
m *modem, int fd)
 	return -EINPROGRESS;
 }
 =

-static int hfp_hf_probe(const char *device, const char *dev_addr,
-				const char *adapter_addr, const char *alias)
+static int modem_register(const char *device, struct hfp_data *hfp_data, i=
nt fd)
 {
 	struct ofono_modem *modem;
-	struct hfp_data *data;
 	char buf[256];
+	guint16 version =3D 0x0105;
 =

 	/* We already have this device in our hash, ignore */
 	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
 		return -EALREADY;
 =

-	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
-			device, dev_addr, adapter_addr);
-
 	strcpy(buf, "hfp/");
-	bluetooth_create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
+	bluetooth_create_path(hfp_data->device_address,
+			hfp_data->adapter_address, buf + 4, sizeof(buf) - 4);
 =

 	modem =3D ofono_modem_create(buf, "hfp");
 	if (modem =3D=3D NULL)
 		return -ENOMEM;
 =

-	data =3D g_try_new0(struct hfp_data, 1);
-	if (data =3D=3D NULL)
+	ofono_modem_set_data(modem, hfp_data);
+	ofono_modem_set_name(modem, hfp_data->device_alias);
+	ofono_modem_register(modem);
+
+	g_hash_table_insert(modem_hash, g_strdup(device), modem);
+
+	hfp_slc_info_init(&hfp_data->info, version);
+
+	return service_level_connection(modem, fd);
+}
+
+static int hfp_hf_probe(const char *device, const char *dev_addr,
+				const char *adapter_addr, const char *alias)
+{
+	struct hfp_data *hfp_data;
+
+	if (g_hash_table_lookup(hfp_hash, device) !=3D NULL)
+		return -EALREADY;
+
+	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
+					device, dev_addr, adapter_addr);
+
+	hfp_data =3D g_try_new0(struct hfp_data, 1);
+	if (hfp_data =3D=3D NULL)
 		goto free;
 =

-	data->handsfree_address =3D g_strdup(dev_addr);
-	if (data->handsfree_address =3D=3D NULL)
+	hfp_data->adapter_address =3D g_strdup(adapter_addr);
+	if (hfp_data->adapter_address =3D=3D NULL)
 		goto free;
 =

-	ofono_modem_set_data(modem, data);
-	ofono_modem_set_name(modem, alias);
-	ofono_modem_register(modem);
+	hfp_data->device_address =3D g_strdup(dev_addr);
+	if (hfp_data->device_address =3D=3D NULL)
+		goto free;
 =

-	g_hash_table_insert(modem_hash, g_strdup(device), modem);
+	hfp_data->device_path =3D g_strdup(device);
+	if (hfp_data->device_path =3D=3D NULL)
+		goto free;
+
+	hfp_data->device_alias =3D g_strdup(alias);
+	if (hfp_data->device_alias =3D=3D NULL)
+		goto free;
+
+	g_hash_table_insert(hfp_hash, g_strdup(device), hfp_data);
 =

 	return 0;
 =

 free:
-	g_free(data);
-	ofono_modem_remove(modem);
+	hfp_data_free(hfp_data);
 =

 	return -ENOMEM;
 }
@@ -240,12 +285,10 @@ static void hfp_hf_set_alias(const char *device, cons=
t char *alias)
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	struct ofono_modem *modem;
 	struct hfp_data *hfp_data;
 	const char *device;
 	DBusMessageIter entry;
 	int fd, err;
-	guint16 version =3D 0x0105;
 =

 	DBG("Profile handler NewConnection");
 =

@@ -256,9 +299,9 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 		goto error;
 =

 	dbus_message_iter_get_basic(&entry, &device);
-	modem =3D g_hash_table_lookup(modem_hash, device);
-	if (modem =3D=3D NULL) {
-		DBG("%s: modem not found", device);
+	hfp_data =3D g_hash_table_lookup(hfp_hash, device);
+	if (hfp_data =3D=3D NULL) {
+		DBG("%s: doesn't support HFP", device);
 		goto error;
 	}
 =

@@ -270,12 +313,9 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	if (fd < 0)
 		goto error;
 =

-	hfp_data =3D ofono_modem_get_data(modem);
-	DBG("modem %p, hfp_data: %p SLC FD: %d", modem, hfp_data, fd);
-
-	hfp_slc_info_init(&hfp_data->info, version);
+	DBG("hfp_data: %p SLC FD: %d", hfp_data, fd);
 =

-	err =3D service_level_connection(modem, fd);
+	err =3D modem_register(device, hfp_data, fd);
 	if (err < 0 && err !=3D -EINPROGRESS)
 		return __ofono_error_failed(msg);
 =

@@ -337,14 +377,7 @@ static int hfp_probe(struct ofono_modem *modem)
 =

 static void hfp_remove(struct ofono_modem *modem)
 {
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-
 	DBG("modem: %p", modem);
-
-	g_free(data->handsfree_address);
-	g_free(data);
-
-	ofono_modem_set_data(modem, NULL);
 }
 =

 /* power up hardware */
@@ -378,7 +411,7 @@ static void hfp_pre_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	ofono_devinfo_create(modem, 0, "hfpmodem", data->handsfree_address);
+	ofono_devinfo_create(modem, 0, "hfpmodem", data->device_address);
 	ofono_voicecall_create(modem, 0, "hfpmodem", &data->info);
 	ofono_netreg_create(modem, 0, "hfpmodem", &data->info);
 	ofono_call_volume_create(modem, 0, "hfpmodem", &data->info);
@@ -452,6 +485,9 @@ static int hfp_init(void)
 	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, NULL);
 =

+	hfp_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
+								hfp_data_free);
+
 	return 0;
 }
 =

@@ -464,6 +500,7 @@ static void hfp_exit(void)
 	ofono_modem_driver_unregister(&hfp_driver);
 =

 	g_hash_table_destroy(modem_hash);
+	g_hash_table_destroy(hfp_hash);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp, "Hands-Free Profile Plugins", VERSION,
-- =

1.7.11.7


--===============2357450511549494472==--

