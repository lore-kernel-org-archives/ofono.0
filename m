Content-Type: multipart/mixed; boundary="===============0161219830315632400=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/5] hfp_hf_bluez5: Add audio card .connect() for HFP 1.6
Date: Wed, 03 Apr 2013 20:24:38 -0300
Message-ID: <1365031481-10467-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365031481-10467-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0161219830315632400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index a6cc156..4c8f412 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -67,6 +67,8 @@ struct hfp {
 	struct hfp_slc_info info;
 	DBusMessage *msg;
 	struct ofono_handsfree_card *card;
+	ofono_handsfree_card_connect_cb_t cb;
+	void *user_data;
 };
 =

 static GDBusClient *bluez =3D NULL;
@@ -324,11 +326,48 @@ static void hfp16_card_remove(struct ofono_handsfree_=
card *card)
 =

 }
 =

+static void bcc_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct hfp *hfp =3D user_data;
+	struct hfp_slc_info *info =3D &hfp->info;
+
+	if (ok)
+		CALLBACK_WITH_SUCCESS(hfp->cb, hfp->user_data);
+	else
+		CALLBACK_WITH_FAILURE(hfp->cb, hfp->user_data);
+
+	g_at_chat_unref(info->chat);
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
+	if (info->chat =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	if (!(info->hf_features & HFP_HF_FEATURE_CODEC_NEGOTIATION &&
+			info->ag_features & HFP_AG_FEATURE_CODEC_NEGOTIATION)) {
+		/*
+		 * If both sides don't support codec negotiation,
+		 * fallback to direct SCO connection. Calling
+		 * connect_sco() hands the connection responsability
+		 * to the core, so no need to call the callback
+		 */
+		ofono_handsfree_card_connect_sco(card);
+		return;
+	}
+
+	info->chat =3D g_at_chat_ref(info->chat);
+	hfp->cb =3D cb;
+	hfp->user_data =3D data;
+
+	g_at_chat_send(info->chat, "AT+BCC", NULL, bcc_cb, hfp, NULL);
 }
 =

 static struct ofono_handsfree_card_driver hfp16_hf_driver =3D {
-- =

1.8.2


--===============0161219830315632400==--

