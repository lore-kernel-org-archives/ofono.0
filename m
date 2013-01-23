Content-Type: multipart/mixed; boundary="===============0116744287247641206=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v1 06/10] hfpmodem: Add dynamic hfp_slc_info allocation
Date: Wed, 23 Jan 2013 15:27:57 -0300
Message-ID: <1358965681-7420-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358965681-7420-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0116744287247641206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It less error prone to have hfp_slc_info allocated dynamically than
having it allocated statically, as it makes the verification that it
was already de-allocated more direct.
---
 drivers/hfpmodem/slc.c  |  9 ++++++++-
 drivers/hfpmodem/slc.h  |  3 ++-
 plugins/hfp_hf_bluez4.c | 35 ++++++++++++++++++-----------------
 plugins/phonesim.c      |  4 ++--
 4 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 646befa..825b8a9 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -52,8 +52,13 @@ struct slc_establish_data {
 	gpointer userdata;
 };
 =

-void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version)
+struct hfp_slc_info *hfp_slc_info_init(GAtChat *chat, guint16 version)
 {
+	struct hfp_slc_info *info;
+
+	info =3D g_new0(struct hfp_slc_info, 1);
+	info->chat =3D g_at_chat_ref(chat);
+
 	info->ag_features =3D 0;
 	info->ag_mpty_features =3D 0;
 =

@@ -75,6 +80,8 @@ void hfp_slc_info_init(struct hfp_slc_info *info, guint16=
 version)
 done:
 	memset(info->cind_val, 0, sizeof(info->cind_val));
 	memset(info->cind_pos, 0, sizeof(info->cind_pos));
+
+	return info;
 }
 =

 static void slc_establish_data_unref(gpointer userdata)
diff --git a/drivers/hfpmodem/slc.h b/drivers/hfpmodem/slc.h
index b71ffe9..8ae8d2f 100644
--- a/drivers/hfpmodem/slc.h
+++ b/drivers/hfpmodem/slc.h
@@ -55,7 +55,8 @@ struct hfp_slc_info {
 	unsigned int cind_val[HFP_INDICATOR_LAST];
 };
 =

-void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version);
+struct hfp_slc_info *hfp_slc_info_init(GAtChat *chat, guint16 version);
+
 void hfp_slc_info_free(struct hfp_slc_info *info);
 =

 void hfp_slc_establish(struct hfp_slc_info *info, hfp_slc_cb_t connect_cb,
diff --git a/plugins/hfp_hf_bluez4.c b/plugins/hfp_hf_bluez4.c
index 450c183..b0aa1aa 100644
--- a/plugins/hfp_hf_bluez4.c
+++ b/plugins/hfp_hf_bluez4.c
@@ -62,7 +62,7 @@ static DBusConnection *connection;
 static GHashTable *modem_hash =3D NULL;
 =

 struct hfp_data {
-	struct hfp_slc_info info;
+	struct hfp_slc_info *info;
 	char *handsfree_path;
 	char *handsfree_address;
 	DBusMessage *slc_msg;
@@ -109,8 +109,8 @@ static void slc_failed(gpointer userdata)
 	ofono_error("Service level connection failed");
 	ofono_modem_set_powered(modem, FALSE);
 =

-	g_at_chat_unref(data->info.chat);
-	data->info.chat =3D NULL;
+	g_at_chat_unref(data->info->chat);
+	data->info->chat =3D NULL;
 }
 =

 static void hfp_disconnected_cb(gpointer user_data)
@@ -120,12 +120,13 @@ static void hfp_disconnected_cb(gpointer user_data)
 =

 	ofono_modem_set_powered(modem, FALSE);
 =

-	g_at_chat_unref(data->info.chat);
-	data->info.chat =3D NULL;
+	g_at_chat_unref(data->info->chat);
+	data->info->chat =3D NULL;
 }
 =

 /* either oFono or Phone could request SLC connection */
-static int service_level_connection(struct ofono_modem *modem, int fd)
+static int service_level_connection(struct ofono_modem *modem, int fd,
+							guint16 version)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 	GIOChannel *io;
@@ -152,8 +153,10 @@ static int service_level_connection(struct ofono_modem=
 *modem, int fd)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(chat, hfp_debug, "");
 =

-	data->info.chat =3D chat;
-	hfp_slc_establish(&data->info, slc_established, slc_failed, modem);
+	data->info =3D hfp_slc_info_init(chat, version);
+	g_at_chat_unref(chat);
+
+	hfp_slc_establish(data->info, slc_established, slc_failed, modem);
 =

 	return -EINPROGRESS;
 }
@@ -170,9 +173,7 @@ static DBusMessage *hfp_agent_new_connection(DBusConnec=
tion *conn,
 				DBUS_TYPE_UINT16, &version, DBUS_TYPE_INVALID))
 		return __ofono_error_invalid_args(msg);
 =

-	hfp_slc_info_init(&hfp_data->info, version);
-
-	err =3D service_level_connection(modem, fd);
+	err =3D service_level_connection(modem, fd, version);
 	if (err < 0 && err !=3D -EINPROGRESS)
 		return __ofono_error_failed(msg);
 =

@@ -462,8 +463,8 @@ static int hfp_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	g_at_chat_unref(data->info.chat);
-	data->info.chat =3D NULL;
+	g_at_chat_unref(data->info->chat);
+	data->info->chat =3D NULL;
 =

 	if (data->agent_registered) {
 		status =3D bluetooth_send_with_reply(data->handsfree_path,
@@ -486,10 +487,10 @@ static void hfp_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "hfpmodem", data->handsfree_address);
-	ofono_voicecall_create(modem, 0, "hfpmodem", &data->info);
-	ofono_netreg_create(modem, 0, "hfpmodem", &data->info);
-	ofono_call_volume_create(modem, 0, "hfpmodem", &data->info);
-	ofono_handsfree_create(modem, 0, "hfpmodem", &data->info);
+	ofono_voicecall_create(modem, 0, "hfpmodem", data->info);
+	ofono_netreg_create(modem, 0, "hfpmodem", data->info);
+	ofono_call_volume_create(modem, 0, "hfpmodem", data->info);
+	ofono_handsfree_create(modem, 0, "hfpmodem", data->info);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 26f96d0..9210e02 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -929,8 +929,8 @@ static int localhfp_enable(struct ofono_modem *modem)
 =

 	g_at_chat_set_disconnect_function(chat, slc_failed, modem);
 =

-	hfp_slc_info_init(info, HFP_VERSION_LATEST);
-	info->chat =3D chat;
+	info =3D hfp_slc_info_init(chat, HFP_VERSION_LATEST);
+	g_at_chat_unref(chat);
 	hfp_slc_establish(info, slc_established, slc_failed, modem);
 =

 	return -EINPROGRESS;
-- =

1.8.1.1


--===============0116744287247641206==--

