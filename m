Content-Type: multipart/mixed; boundary="===============2111135633252040691=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/8] hfpmodem: Add codec watcher register
Date: Tue, 09 Apr 2013 17:45:36 -0300
Message-ID: <1365540343-8394-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365540343-8394-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2111135633252040691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a function to monitor when the AG sends a new codec
before establishing the SCO connection.
---
 drivers/hfpmodem/slc.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/hfpmodem/slc.h |  4 ++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 40b22a1..51c1373 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -54,6 +54,12 @@ struct slc_establish_data {
 	gpointer userdata;
 };
 =

+struct codec_watch {
+	struct hfp_slc_info *slc;
+	hfp_slc_codec_watch_cb_t cb;
+	gpointer user_data;
+};
+
 void hfp_slc_info_init(struct hfp_slc_info *info, guint16 version)
 {
 	info->ag_features =3D 0;
@@ -347,3 +353,59 @@ void hfp_slc_establish(struct hfp_slc_info *info, hfp_=
slc_cb_t connect_cb,
 	g_at_chat_send(info->chat, buf, brsf_prefix,
 				brsf_cb, sed, slc_establish_data_unref);
 }
+
+static void bcs_notify(GAtResult *result, gpointer user_data)
+{
+	struct codec_watch *watch =3D user_data;
+	struct hfp_slc_info *info =3D watch->slc;
+	GAtResultIter iter;
+	char str[32];
+	int value;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+BCS:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	memset(str, 0, sizeof(str));
+
+	switch (value) {
+	case HFP_CODEC_MSBC:
+		if (!ofono_handsfree_audio_has_wideband()) {
+			sprintf(str, "AT+BAC=3D%d", HFP_CODEC_CVSD);
+			break;
+		}
+
+		/* fallthrough */
+
+	case HFP_CODEC_CVSD:
+		sprintf(str, "AT+BCS=3D%d", value);
+		watch->cb(value, watch->user_data);
+		break;
+
+	default:
+		if (ofono_handsfree_audio_has_wideband())
+			sprintf(str, "AT+BAC=3D%d,%d", HFP_CODEC_CVSD,
+							HFP_CODEC_MSBC);
+		else
+			sprintf(str, "AT+BAC=3D%d", HFP_CODEC_CVSD);
+	}
+
+	g_at_chat_send(info->chat, str, NULL, NULL, NULL, NULL);
+}
+
+guint hfp_slc_codec_watch_register(struct hfp_slc_info *info,
+				hfp_slc_codec_watch_cb_t cb, void *user_data)
+{
+	struct codec_watch *watch =3D g_new0(struct codec_watch, 1);
+
+	watch->slc =3D info;
+	watch->cb =3D cb;
+	watch->user_data =3D user_data;
+
+	return g_at_chat_register(info->chat, "+BCS:", bcs_notify, FALSE,
+								watch, g_free);
+}
diff --git a/drivers/hfpmodem/slc.h b/drivers/hfpmodem/slc.h
index b71ffe9..95539c8 100644
--- a/drivers/hfpmodem/slc.h
+++ b/drivers/hfpmodem/slc.h
@@ -45,6 +45,7 @@ enum hfp_indicator {
 };
 =

 typedef void (*hfp_slc_cb_t)(void *userdata);
+typedef void (*hfp_slc_codec_watch_cb_t)(unsigned char codec, void *userda=
ta);
 =

 struct hfp_slc_info {
 	GAtChat *chat;
@@ -60,3 +61,6 @@ void hfp_slc_info_free(struct hfp_slc_info *info);
 =

 void hfp_slc_establish(struct hfp_slc_info *info, hfp_slc_cb_t connect_cb,
 				hfp_slc_cb_t failed_cb, void *userdata);
+
+guint hfp_slc_codec_watch_register(struct hfp_slc_info *info,
+				hfp_slc_codec_watch_cb_t cb, void *user_data);
-- =

1.8.2


--===============2111135633252040691==--

