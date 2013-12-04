Content-Type: multipart/mixed; boundary="===============5122328581403203368=="
MIME-Version: 1.0
From: Andrew Earl <andrewx.earl@intel.com>
Subject: [PATCH] hfp: Add Voice Recognition flag to BRSF for HF role
Date: Wed, 04 Dec 2013 15:36:13 +0100
Message-ID: <1386167773-6375-2-git-send-email-andrewx.earl@intel.com>
In-Reply-To: <1386167773-6375-1-git-send-email-andrewx.earl@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5122328581403203368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/slc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 38a9b2e..3a28a26 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -63,6 +63,7 @@ void hfp_slc_info_init(struct hfp_slc_info *info, guint16=
 version)
 	info->hf_features |=3D HFP_HF_FEATURE_3WAY;
 	info->hf_features |=3D HFP_HF_FEATURE_CLIP;
 	info->hf_features |=3D HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL;
+        info->hf_features |=3D HFP_HF_FEATURE_VOICE_RECOGNITION;
 =

 	if (version < HFP_VERSION_1_5)
 		goto done;
-- =

1.7.11.7

Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052


--===============5122328581403203368==--

