Content-Type: multipart/mixed; boundary="===============4947161685813274186=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 01/15] hfpmodem: Support for +BSIR unsol. result codes
Date: Thu, 20 Oct 2011 18:38:06 +0200
Message-ID: <1319128700-15841-2-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319128700-15841-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4947161685813274186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/handsfree.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index 05bf2c8..54a5fba 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -49,11 +49,30 @@ struct hf_data {
 	unsigned int ag_features;
 };
 =

+static void bsir_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_handsfree *hf =3D user_data;
+	GAtResultIter iter;
+	int value;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+BSIR:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	ofono_handsfree_set_inband_ringing(hf, (ofono_bool_t) value);
+}
+
 static gboolean hfp_handsfree_register(gpointer user_data)
 {
 	struct ofono_handsfree *hf =3D user_data;
 	struct hf_data *hd =3D ofono_handsfree_get_data(hf);
 =

+	g_at_chat_register(hd->chat, "+BSIR:", bsir_notify, FALSE, hf, NULL);
+
 	if (hd->ag_features & HFP_AG_FEATURE_IN_BAND_RING_TONE)
 		ofono_handsfree_set_inband_ringing(hf, TRUE);
 =

-- =

1.7.6.4


--===============4947161685813274186==--

