Content-Type: multipart/mixed; boundary="===============3122794773116613254=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 11/20] hfpmodem: Add codec watcher register
Date: Tue, 12 Mar 2013 11:21:35 -0300
Message-ID: <1363098104-16467-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3122794773116613254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This patch adds a function to monitor when the AG sends a new codec
before establishing the SCO connection.
---
 drivers/hfpmodem/slc.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/hfpmodem/slc.h |  4 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index b9b687b..905be68 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -53,6 +53,12 @@ struct slc_establish_data {
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
@@ -355,3 +361,65 @@ void hfp_slc_establish(struct hfp_slc_info *info, hfp_=
slc_cb_t connect_cb,
 	g_at_chat_send(info->chat, buf, brsf_prefix,
 				brsf_cb, sed, slc_establish_data_unref);
 }
+
+static void bcs_notify(GAtResult *result, gpointer user_data)
+{
+	struct codec_watch *watch =3D user_data;
+	struct hfp_slc_info *info =3D watch->slc;
+	unsigned char codecs[8];
+	GAtResultIter iter;
+	GString *str;
+	int i, value, len;
+
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+BCS:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	/* If some codec matches, we confirm it */
+
+	len =3D ofono_handsfree_get_codecs(codecs, sizeof(codecs));
+	if (len < 0)
+		return;
+
+	for (i =3D 0; i < len; i++) {
+		if (codecs[i] =3D=3D value) {
+
+			DBG("Negotiated HFP codec: %d", value);
+			watch->cb(value, watch->user_data);
+
+			str =3D g_string_new("AT+BCS=3D");
+			g_string_append_printf(str, "%d", value);
+			goto done;
+		}
+	}
+
+	/* If none matches, we send our supported codecs again */
+	str =3D g_string_new("AT+BAC=3D");
+
+	for (i =3D 0; i < (len - 1); i++)
+		g_string_append_printf(str, "%d,", codecs[i]);
+
+	g_string_append_printf(str, "%d", codecs[i]);
+
+done:
+	g_at_chat_send(info->chat, str->str, NULL, NULL, NULL, NULL);
+	g_string_free(str, TRUE);
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

1.7.11.7


--===============3122794773116613254==--

