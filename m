Content-Type: multipart/mixed; boundary="===============5426934026908337683=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 3/3 v2] bluetooth: fix not removing data when devices/adapters
 are removed
Date: Mon, 04 Jul 2011 10:32:16 +0300
Message-ID: <1309764736-26327-1-git-send-email-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5426934026908337683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If an adapter or device is removed any data associate should be removed,
otherwise the next time they appear/are created the drivers may not
asssociate again.
---
 plugins/bluetooth.c |   79 ++++++++++++++++++++++++++++++++++++-----------=
---
 plugins/bluetooth.h |    4 +-
 plugins/hfp_hf.c    |   30 ++++++++++++-------
 3 files changed, 78 insertions(+), 35 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 7e0705f..1fdb579 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -258,6 +258,28 @@ static void parse_string(DBusMessageIter *iter, gpoint=
er user_data)
 	dbus_message_iter_get_basic(iter, str);
 }
 =

+static void bluetooth_probe(GSList *uuids, const char *path,
+				const char *device, const char *adapter,
+				const char *alias)
+{
+	for (; uuids; uuids =3D uuids->next) {
+		struct bluetooth_profile *driver;
+		const char *uuid =3D uuids->data;
+		int err;
+
+		driver =3D g_hash_table_lookup(uuid_hash, uuid);
+		if (driver =3D=3D NULL)
+			continue;
+
+		err =3D driver->probe(path, device, adapter, alias);
+		if (err =3D=3D 0)
+			continue;
+
+		ofono_error("%s probe: %s (%d)", driver->name, strerror(-err),
+									-err);
+	}
+}
+
 static void device_properties_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusMessage *reply;
@@ -291,19 +313,10 @@ static void device_properties_cb(DBusPendingCall *cal=
l, gpointer user_data)
 		adapter_addr =3D g_hash_table_lookup(adapter_address_hash,
 							adapter);
 =

-	if (!device_addr && !adapter_addr)
+	if (!device_addr || !adapter_addr)
 		goto done;
 =

-	for (; uuids; uuids =3D uuids->next) {
-		struct bluetooth_profile *profile;
-		const char *uuid =3D uuids->data;
-
-		profile =3D g_hash_table_lookup(uuid_hash, uuid);
-		if (profile =3D=3D NULL || profile->create =3D=3D NULL)
-			continue;
-
-		profile->create(path, device_addr, adapter_addr, alias);
-	}
+	bluetooth_probe(uuids, path, device_addr, adapter_addr, alias);
 =

 done:
 	g_slist_free(uuids);
@@ -697,14 +710,38 @@ static gboolean adapter_added(DBusConnection *connect=
ion, DBusMessage *message,
 	return TRUE;
 }
 =

+static void bluetooth_remove(gpointer key, gpointer value, gpointer user_d=
ata)
+{
+	struct bluetooth_profile *profile =3D value;
+
+	profile->remove(user_data);
+}
+
 static gboolean adapter_removed(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
 	const char *path;
 =

 	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID) =3D=3D TRUE)
-		g_hash_table_remove(adapter_address_hash, path);
+				DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return FALSE;
+
+	g_hash_table_foreach(uuid_hash, bluetooth_remove, (gpointer) path);
+	g_hash_table_remove(adapter_address_hash, path);
+
+	return TRUE;
+}
+
+static gboolean device_removed(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	const char *path;
+
+	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return FALSE;
+
+	g_hash_table_foreach(uuid_hash, bluetooth_remove, (gpointer) path);
 =

 	return TRUE;
 }
@@ -761,14 +798,6 @@ done:
 	dbus_message_unref(reply);
 }
 =

-static void bluetooth_remove_all_modem(gpointer key, gpointer value,
-					gpointer user_data)
-{
-	struct bluetooth_profile *profile =3D value;
-
-	profile->remove_all();
-}
-
 static void bluetooth_connect(DBusConnection *connection, void *user_data)
 {
 	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
@@ -786,7 +815,7 @@ static void bluetooth_disconnect(DBusConnection *connec=
tion, void *user_data)
 	if (uuid_hash =3D=3D NULL)
 		return;
 =

-	g_hash_table_foreach(uuid_hash, bluetooth_remove_all_modem, NULL);
+	g_hash_table_foreach(uuid_hash, bluetooth_remove, NULL);
 =

 	g_slist_foreach(server_list, (GFunc) remove_service_handle, NULL);
 }
@@ -794,6 +823,7 @@ static void bluetooth_disconnect(DBusConnection *connec=
tion, void *user_data)
 static guint bluetooth_watch;
 static guint adapter_added_watch;
 static guint adapter_removed_watch;
+static guint device_removed_watch;
 static guint property_watch;
 =

 static void bluetooth_ref(void)
@@ -817,6 +847,11 @@ static void bluetooth_ref(void)
 						"AdapterRemoved",
 						adapter_removed, NULL, NULL);
 =

+	device_removed_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_ADAPTER_INTERFACE,
+						"DeviceRemoved",
+						device_removed, NULL, NULL);
+
 	property_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
 						BLUEZ_DEVICE_INTERFACE,
 						"PropertyChanged",
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index ff0ea52..7f9f810 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -32,9 +32,9 @@
 =

 struct bluetooth_profile {
 	const char *name;
-	int (*create)(const char *device, const char *dev_addr,
+	int (*probe)(const char *device, const char *dev_addr,
 			const char *adapter_addr, const char *alias);
-	void (*remove_all)(void);
+	void (*remove)(const char *prefix);
 	void (*set_alias)(const char *device, const char *);
 };
 =

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 8a76701..b0b1ccf 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -393,7 +393,7 @@ static GDBusMethodTable agent_methods[] =3D {
 	{ NULL, NULL, NULL, NULL }
 };
 =

-static int hfp_create_modem(const char *device, const char *dev_addr,
+static int hfp_hf_probe(const char *device, const char *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
 	struct ofono_modem *modem;
@@ -443,25 +443,33 @@ free:
 	return -ENOMEM;
 }
 =

-static gboolean hfp_remove_each_modem(gpointer key, gpointer value,
+static gboolean hfp_remove_modem(gpointer key, gpointer value,
 					gpointer user_data)
 {
 	struct ofono_modem *modem =3D value;
+	const char *device =3D key;
+	const char *prefix =3D user_data;
+
+	if (prefix && g_str_has_prefix(device, prefix) =3D=3D FALSE)
+		return FALSE;
 =

 	ofono_modem_remove(modem);
 =

 	return TRUE;
 }
 =

-static void hfp_remove_all_modem(void)
+static void hfp_hf_remove(const char *prefix)
 {
+	DBG("%s", prefix);
+
 	if (modem_hash =3D=3D NULL)
 		return;
 =

-	g_hash_table_foreach_remove(modem_hash, hfp_remove_each_modem, NULL);
+	g_hash_table_foreach_remove(modem_hash, hfp_remove_modem,
+							(gpointer) prefix);
 }
 =

-static void hfp_set_alias(const char *device, const char *alias)
+static void hfp_hf_set_alias(const char *device, const char *alias)
 {
 	struct ofono_modem *modem;
 =

@@ -675,11 +683,11 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

-static struct bluetooth_profile hfp_profile =3D {
-	.name		=3D "hfp",
-	.create		=3D hfp_create_modem,
-	.remove_all	=3D hfp_remove_all_modem,
-	.set_alias	=3D hfp_set_alias,
+static struct bluetooth_profile hfp_hf =3D {
+	.name		=3D "hfp_hf",
+	.probe		=3D hfp_hf_probe,
+	.remove		=3D hfp_hf_remove,
+	.set_alias	=3D hfp_hf_set_alias,
 };
 =

 static int hfp_init(void)
@@ -695,7 +703,7 @@ static int hfp_init(void)
 	if (err < 0)
 		return err;
 =

-	err =3D bluetooth_register_uuid(HFP_AG_UUID, &hfp_profile);
+	err =3D bluetooth_register_uuid(HFP_AG_UUID, &hfp_hf);
 	if (err < 0) {
 		ofono_modem_driver_unregister(&hfp_driver);
 		return err;
-- =

1.7.5.4


--===============5426934026908337683==--

