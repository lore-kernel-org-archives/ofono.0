Content-Type: multipart/mixed; boundary="===============6582531278054214625=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 18/19] hfpmodem: Report features supported by AG
Date: Wed, 12 Oct 2011 14:35:39 +0200
Message-ID: <1318422940-14955-19-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6582531278054214625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/handsfree.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index 5fe41c0..835dcfc 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -98,6 +98,7 @@ static gboolean hfp_handsfree_register(gpointer user_data)
 	g_at_chat_register(hd->chat, "+BVRA:", bvra_notify, FALSE, hf, NULL);
 =

 	ofono_handsfree_register(hf);
+	ofono_handsfree_set_ag_features(hf, hd->ag_features);
 =

 	if (hd->ag_features & HFP_AG_FEATURE_IN_BAND_RING_TONE)
 		ofono_handsfree_set_inband_ringing(hf, TRUE);
-- =

1.7.6.4


--===============6582531278054214625==--

