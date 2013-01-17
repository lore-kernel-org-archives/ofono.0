Content-Type: multipart/mixed; boundary="===============1078446915332669115=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 3/8] hfpmodem: Add support for sending the supported codecs
Date: Thu, 17 Jan 2013 12:13:06 -0300
Message-ID: <1358435591-14757-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358435591-14757-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1078446915332669115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Right now, only the mandatory CVSD codec is supported. The mSBC
mandatory codec is "temporarily" not supported.

The spec alows this, HFP 1.6 Spec Section 4.34.1 page 92: "If wide band
speech is supported then the mandatory codec (mSBC) shall be included
unless it is temporarily unavailable."
---
 drivers/hfpmodem/slc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 4028479..646befa 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -67,6 +67,11 @@ void hfp_slc_info_init(struct hfp_slc_info *info, guint1=
6 version)
 	info->hf_features |=3D HFP_HF_FEATURE_ENHANCED_CALL_STATUS;
 	info->hf_features |=3D HFP_HF_FEATURE_ENHANCED_CALL_CONTROL;
 =

+	if (version < HFP_VERSION_1_6)
+		goto done;
+
+	info->hf_features |=3D HFP_HF_FEATURE_CODEC_NEGOTIATION;
+
 done:
 	memset(info->cind_val, 0, sizeof(info->cind_val));
 	memset(info->cind_pos, 0, sizeof(info->cind_pos));
@@ -266,6 +271,21 @@ error:
 	slc_failed(sed);
 }
 =

+static void bac_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct slc_establish_data *sed =3D user_data;
+	struct hfp_slc_info *info =3D sed->info;
+
+	if (!ok) {
+		slc_failed(sed);
+		return;
+	}
+
+	slc_establish_data_ref(sed);
+	g_at_chat_send(info->chat, "AT+CIND=3D?", cind_prefix,
+				cind_cb, sed, slc_establish_data_unref);
+}
+
 static void brsf_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct slc_establish_data *sed =3D user_data;
@@ -282,6 +302,15 @@ static void brsf_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 =

 	g_at_result_iter_next_number(&iter, (gint *)&info->ag_features);
 =

+	if (info->ag_features & HFP_AG_FEATURE_CODEC_NEGOTIATION &&
+			info->hf_features & HFP_HF_FEATURE_CODEC_NEGOTIATION) {
+
+		slc_establish_data_ref(sed);
+		g_at_chat_send(info->chat, "AT+BAC=3D1", NULL, bac_cb, sed,
+						slc_establish_data_unref);
+		return;
+	}
+
 	slc_establish_data_ref(sed);
 	g_at_chat_send(info->chat, "AT+CIND=3D?", cind_prefix,
 				cind_cb, sed, slc_establish_data_unref);
-- =

1.7.11.7


--===============1078446915332669115==--

