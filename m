Content-Type: multipart/mixed; boundary="===============6779067874395010285=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 1/2] hfp_ag_bluez5: Add initial handsfree audio driver
Date: Fri, 09 Oct 2015 12:05:39 +0200
Message-ID: <1444385140-14777-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6779067874395010285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c | 105 ++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 101 insertions(+), 4 deletions(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index ef8a048..a80875f 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -49,11 +49,42 @@
 #define HFP_AG_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_ag"
 #define BT_ADDR_SIZE 18
 =

+#define HFP16_AG_DRIVER		"hfp16-ag-driver"
+
 static guint modemwatch_id;
 static GList *modems;
 static GHashTable *sim_hash =3D NULL;
 static GHashTable *connection_hash;
 =

+static int hfp16_card_probe(struct ofono_handsfree_card *card,
+					unsigned int vendor, void *data)
+{
+	return 0;
+}
+
+static void hfp16_card_remove(struct ofono_handsfree_card *card)
+{
+}
+
+static void hfp16_card_connect(struct ofono_handsfree_card *card,
+					ofono_handsfree_card_connect_cb_t cb,
+					void *data)
+{
+	ofono_handsfree_card_connect_sco(card);
+}
+
+static void hfp16_sco_connected_hint(struct ofono_handsfree_card *card)
+{
+}
+
+static struct ofono_handsfree_card_driver hfp16_ag_driver =3D {
+	.name			=3D HFP16_AG_DRIVER,
+	.probe			=3D hfp16_card_probe,
+	.remove			=3D hfp16_card_remove,
+	.connect		=3D hfp16_card_connect,
+	.sco_connected_hint	=3D hfp16_sco_connected_hint,
+};
+
 static void connection_destroy(gpointer data)
 {
 	int fd =3D GPOINTER_TO_INT(data);
@@ -74,11 +105,51 @@ static gboolean io_hup_cb(GIOChannel *io, GIOCondition=
 cond, gpointer data)
 	return FALSE;
 }
 =

+static int get_version(DBusMessageIter *iter, uint16_t *version)
+{
+	DBusMessageIter dict, entry, valiter;
+	const char *key;
+	uint16_t value;
+
+	/* Points to dict */
+	dbus_message_iter_recurse(iter, &dict);
+
+	/* For each entry in this dict */
+	while (dbus_message_iter_get_arg_type(&dict) !=3D DBUS_TYPE_INVALID) {
+		/* I want to access the entry's contents */
+		dbus_message_iter_recurse(&dict, &entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
+			return -EINVAL;
+
+		/* If the current key isn't "Version", keep looking */
+		dbus_message_iter_get_basic(&entry, &key);
+		if (!g_str_equal("Version", key)) {
+			dbus_message_iter_next(&dict);
+			continue;
+		}
+
+		dbus_message_iter_next(&entry);
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
+			return -EINVAL;
+
+		dbus_message_iter_recurse(&entry, &valiter);
+		dbus_message_iter_get_basic(&valiter, &value);
+
+		if (version)
+			*version =3D value;
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	DBusMessageIter entry;
-	const char *device;
+	const char *device, *driver;
 	GIOChannel *io;
 	int fd, fd_dup;
 	struct sockaddr_rc saddr;
@@ -87,6 +158,7 @@ static DBusMessage *profile_new_connection(DBusConnectio=
n *conn,
 	struct ofono_modem *modem;
 	char local[BT_ADDR_SIZE], remote[BT_ADDR_SIZE];
 	struct ofono_handsfree_card *card;
+	uint16_t version =3D HFP_VERSION_1_5;
 	int err;
 =

 	DBG("Profile handler NewConnection");
@@ -104,12 +176,22 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
 		goto invalid;
 =

 	dbus_message_iter_get_basic(&entry, &fd);
-	dbus_message_iter_next(&entry);
 =

 	if (fd < 0)
 		goto invalid;
 =

-	DBG("%s", device);
+	dbus_message_iter_next(&entry);
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_ARRAY) {
+		close(fd);
+		goto invalid;
+	}
+
+	if (get_version(&entry, &version) < 0) {
+		close(fd);
+		goto invalid;
+	}
+
+	DBG("version: %hd", version);
 =

 	/* Pick the first voicecall capable modem */
 	if (modems =3D=3D NULL) {
@@ -165,9 +247,14 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 						g_strdup(device), g_free);
 	g_io_channel_unref(io);
 =

+	driver =3D NULL;
+
+	if (version >=3D HFP_VERSION_1_6)
+		driver =3D HFP16_AG_DRIVER;
+
 	card =3D ofono_handsfree_card_create(0,
 					OFONO_HANDSFREE_CARD_TYPE_GATEWAY,
-					NULL, NULL);
+					driver, NULL);
 =

 	ofono_handsfree_card_set_local(card, local);
 	ofono_handsfree_card_set_remote(card, remote);
@@ -369,6 +456,7 @@ static void call_modemwatch(struct ofono_modem *modem, =
void *user)
 static int hfp_ag_init(void)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
+	int err;
 =

 	if (DBUS_TYPE_UNIX_FD < 0)
 		return -EBADF;
@@ -383,6 +471,13 @@ static int hfp_ag_init(void)
 		return -EIO;
 	}
 =

+	err =3D ofono_handsfree_card_driver_register(&hfp16_ag_driver);
+	if (err < 0) {
+		g_dbus_unregister_interface(conn, HFP_AG_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
+		return err;
+	}
+
 	sim_hash =3D g_hash_table_new(g_direct_hash, g_direct_equal);
 =

 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
@@ -404,6 +499,8 @@ static void hfp_ag_exit(void)
 	g_dbus_unregister_interface(conn, HFP_AG_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 =

+	ofono_handsfree_card_driver_unregister(&hfp16_ag_driver);
+
 	g_hash_table_destroy(connection_hash);
 =

 	g_list_free(modems);
-- =

2.5.0


--===============6779067874395010285==--

