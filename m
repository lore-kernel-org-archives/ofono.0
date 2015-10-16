Content-Type: multipart/mixed; boundary="===============4769952674267811306=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 1/3 v2] hfp_ag_bluez5: Add initial handsfree audio driver
Date: Fri, 16 Oct 2015 07:59:58 +0200
Message-ID: <1444975200-19682-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4769952674267811306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c | 55 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index ef8a048..3aca792 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -49,11 +49,47 @@
 #define HFP_AG_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_ag"
 #define BT_ADDR_SIZE 18
 =

+#define HFP_AG_DRIVER		"hfp-ag-driver"
+
 static guint modemwatch_id;
 static GList *modems;
 static GHashTable *sim_hash =3D NULL;
 static GHashTable *connection_hash;
 =

+static int hfp_card_probe(struct ofono_handsfree_card *card,
+					unsigned int vendor, void *data)
+{
+	DBG("");
+
+	return 0;
+}
+
+static void hfp_card_remove(struct ofono_handsfree_card *card)
+{
+	DBG("");
+}
+
+static void hfp_card_connect(struct ofono_handsfree_card *card,
+					ofono_handsfree_card_connect_cb_t cb,
+					void *data)
+{
+	DBG("");
+	ofono_handsfree_card_connect_sco(card);
+}
+
+static void hfp_sco_connected_hint(struct ofono_handsfree_card *card)
+{
+	DBG("");
+}
+
+static struct ofono_handsfree_card_driver hfp_ag_driver =3D {
+	.name			=3D HFP_AG_DRIVER,
+	.probe			=3D hfp_card_probe,
+	.remove			=3D hfp_card_remove,
+	.connect		=3D hfp_card_connect,
+	.sco_connected_hint	=3D hfp_sco_connected_hint,
+};
+
 static void connection_destroy(gpointer data)
 {
 	int fd =3D GPOINTER_TO_INT(data);
@@ -104,12 +140,15 @@ static DBusMessage *profile_new_connection(DBusConnec=
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
 =

 	/* Pick the first voicecall capable modem */
 	if (modems =3D=3D NULL) {
@@ -167,7 +206,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 =

 	card =3D ofono_handsfree_card_create(0,
 					OFONO_HANDSFREE_CARD_TYPE_GATEWAY,
-					NULL, NULL);
+					HFP_AG_DRIVER, em);
 =

 	ofono_handsfree_card_set_local(card, local);
 	ofono_handsfree_card_set_remote(card, remote);
@@ -369,6 +408,7 @@ static void call_modemwatch(struct ofono_modem *modem, =
void *user)
 static int hfp_ag_init(void)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
+	int err;
 =

 	if (DBUS_TYPE_UNIX_FD < 0)
 		return -EBADF;
@@ -383,6 +423,13 @@ static int hfp_ag_init(void)
 		return -EIO;
 	}
 =

+	err =3D ofono_handsfree_card_driver_register(&hfp_ag_driver);
+	if (err < 0) {
+		g_dbus_unregister_interface(conn, HFP_AG_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
+		return err;
+	}
+
 	sim_hash =3D g_hash_table_new(g_direct_hash, g_direct_equal);
 =

 	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
@@ -404,6 +451,8 @@ static void hfp_ag_exit(void)
 	g_dbus_unregister_interface(conn, HFP_AG_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 =

+	ofono_handsfree_card_driver_unregister(&hfp_ag_driver);
+
 	g_hash_table_destroy(connection_hash);
 =

 	g_list_free(modems);
-- =

2.5.0


--===============4769952674267811306==--

