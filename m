Content-Type: multipart/mixed; boundary="===============0349920973724309577=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/6] hfp_hf_bluez5: Add audio card .connect() for HFP 1.6
Date: Mon, 08 Apr 2013 19:40:58 -0300
Message-ID: <1365460863-14645-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0349920973724309577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index ac6189d..d4a9b23 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -324,11 +324,39 @@ static void hfp16_card_remove(struct ofono_handsfree_=
card *card)
 =

 }
 =

+static void bcc_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_handsfree_card_connect_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
 static void hfp16_card_connect(struct ofono_handsfree_card *card,
 					ofono_handsfree_card_connect_cb_t cb,
 					void *data)
 {
-	CALLBACK_WITH_FAILURE(cb, data);
+	struct hfp *hfp =3D ofono_handsfree_card_get_data(card);
+	struct hfp_slc_info *info =3D &hfp->info;
+
+	if ((info->hf_features & HFP_HF_FEATURE_CODEC_NEGOTIATION &&
+			info->ag_features & HFP_AG_FEATURE_CODEC_NEGOTIATION)) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+
+		g_at_chat_send(info->chat, "AT+BCC", NULL, bcc_cb, cbd, g_free);
+		return;
+	}
+
+	/*
+	 * If any side (remote or local) doesn't support codec negotiation,
+	 * fallback to direct SCO connection. Calling connect_sco()
+	 * hands the connection responsibility to the core, so no need
+	 * to call the callback
+	 */
+	ofono_handsfree_card_connect_sco(card);
 }
 =

 static struct ofono_handsfree_card_driver hfp16_hf_driver =3D {
-- =

1.8.2


--===============0349920973724309577==--

