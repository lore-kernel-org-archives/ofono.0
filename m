Content-Type: multipart/mixed; boundary="===============3924563362401654678=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 09/15] hfpmodem: Report features supported by AG
Date: Thu, 20 Oct 2011 18:38:14 +0200
Message-ID: <1319128700-15841-10-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319128700-15841-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3924563362401654678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/handsfree.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index 2daff94..7526b40 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -107,6 +107,7 @@ static gboolean hfp_handsfree_register(gpointer user_da=
ta)
 	if (hd->ag_features & HFP_AG_FEATURE_IN_BAND_RING_TONE)
 		ofono_handsfree_set_inband_ringing(hf, TRUE);
 =

+	ofono_handsfree_set_ag_features(hf, hd->ag_features);
 	ofono_handsfree_register(hf);
 =

 	return FALSE;
-- =

1.7.6.4


--===============3924563362401654678==--

