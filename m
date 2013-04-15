Content-Type: multipart/mixed; boundary="===============7028021010493307210=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 3/6] hfp_hf_bluez5: Watch for changes in the selected codec
Date: Mon, 15 Apr 2013 10:54:50 -0300
Message-ID: <1366034093-24084-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366034093-24084-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7028021010493307210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a function to monitor when the AG sends a new codec
before establishing the SCO connection.
---
 plugins/hfp_hf_bluez5.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index c63b1a2..2c67a21 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -314,9 +314,49 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

+static void bcs_notify(GAtResult *result, gpointer user_data)
+{
+	struct hfp *hfp =3D user_data;
+	struct hfp_slc_info *info =3D &hfp->info;
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
+	if (ofono_handsfree_card_set_codec(hfp->card, value) =3D=3D FALSE) {
+		/* Unsupported codec, re-send our codecs */
+		if (ofono_handsfree_audio_has_wideband())
+			sprintf(str, "AT+BAC=3D%d,%d", HFP_CODEC_CVSD,
+							HFP_CODEC_MSBC);
+		else
+			sprintf(str, "AT+BAC=3D%d", HFP_CODEC_CVSD);
+
+		goto done;
+	}
+
+	/* Confirm the codec */
+	sprintf(str, "AT+BCS=3D%d", value);
+
+done:
+	g_at_chat_send(info->chat, str, NULL, NULL, NULL, NULL);
+}
+
 static int hfp16_card_probe(struct ofono_handsfree_card *card,
 					unsigned int vendor, void *data)
 {
+	struct hfp *hfp =3D data;
+	struct hfp_slc_info *info =3D &hfp->info;
+
+	g_at_chat_register(info->chat, "+BCS:", bcs_notify, FALSE,
+								hfp, NULL);
+
 	return 0;
 }
 =

-- =

1.8.2


--===============7028021010493307210==--

