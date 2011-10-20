Content-Type: multipart/mixed; boundary="===============3828466062909831977=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 05/15] hfpmodem: Support for AT+BVRA
Date: Thu, 20 Oct 2011 18:38:10 +0200
Message-ID: <1319128700-15841-6-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319128700-15841-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3828466062909831977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/handsfree.c |   53 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index 54a5fba..2daff94 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -43,12 +43,25 @@
 #include "slc.h"
 =

 static const char *binp_prefix[] =3D { "+BINP:", NULL };
+static const char *bvra_prefix[] =3D { "+BVRA:", NULL };
 =

 struct hf_data {
 	GAtChat *chat;
 	unsigned int ag_features;
 };
 =

+static void hf_generic_set_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_handsfree_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
 static void bsir_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_handsfree *hf =3D user_data;
@@ -66,12 +79,30 @@ static void bsir_notify(GAtResult *result, gpointer use=
r_data)
 	ofono_handsfree_set_inband_ringing(hf, (ofono_bool_t) value);
 }
 =

+static void bvra_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_handsfree *hf =3D user_data;
+	GAtResultIter iter;
+	int value;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+BVRA:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	ofono_handsfree_set_voice_recognition(hf, (ofono_bool_t) value);
+}
+
 static gboolean hfp_handsfree_register(gpointer user_data)
 {
 	struct ofono_handsfree *hf =3D user_data;
 	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
 =

 	g_at_chat_register(hd->chat, "+BSIR:", bsir_notify, FALSE, hf, NULL);
+	g_at_chat_register(hd->chat, "+BVRA:", bvra_notify, FALSE, hf, NULL);
 =

 	if (hd->ag_features & HFP_AG_FEATURE_IN_BAND_RING_TONE)
 		ofono_handsfree_set_inband_ringing(hf, TRUE);
@@ -169,11 +200,33 @@ static void hfp_request_phone_number(struct ofono_han=
dsfree *hf,
 	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

+static void hfp_voice_recognition(struct ofono_handsfree *hf,
+					ofono_bool_t enabled,
+					ofono_handsfree_cb_t cb, void *data)
+{
+	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+
+	snprintf(buf, sizeof(buf), "AT+BVRA=3D%d",
+				(int)(enabled));
+
+	if (g_at_chat_send(hd->chat, buf, bvra_prefix,
+				hf_generic_set_cb,
+				cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static struct ofono_handsfree_driver driver =3D {
 	.name			=3D "hfpmodem",
 	.probe			=3D hfp_handsfree_probe,
 	.remove			=3D hfp_handsfree_remove,
 	.request_phone_number	=3D hfp_request_phone_number,
+	.voice_recognition	=3D hfp_voice_recognition,
 };
 =

 void hfp_handsfree_init(void)
-- =

1.7.6.4


--===============3828466062909831977==--

