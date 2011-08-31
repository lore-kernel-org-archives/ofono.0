Content-Type: multipart/mixed; boundary="===============0415371637233966906=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/4] include: update HFP features types to version 1.6
Date: Wed, 31 Aug 2011 17:21:31 +0200
Message-ID: <1314804093-12504-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1314804093-12504-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0415371637233966906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/types.h b/include/types.h
index 536dac7..0a3b72c 100644
--- a/include/types.h
+++ b/include/types.h
@@ -115,7 +115,7 @@ struct ofono_uuid {
 	unsigned char uuid[OFONO_SHA1_UUID_LEN];
 };
 =

-/* HFP AG supported features bitmap. Bluetooth HFP 1.5 spec page 77 */
+/* HFP AG supported features bitmap. Bluetooth HFP 1.6 spec page 88 */
 enum hfp_ag_feature {
 	HFP_AG_FEATURE_3WAY =3D			0x1,
 	HFP_AG_FEATURE_ECNR =3D			0x2,
@@ -125,10 +125,11 @@ enum hfp_ag_feature {
 	HFP_AG_FEATURE_REJECT_CALL =3D		0x20,
 	HFP_AG_FEATURE_ENHANCED_CALL_STATUS =3D	0x40,
 	HFP_AG_FEATURE_ENHANCED_CALL_CONTROL =3D	0x80,
-	HFP_AG_FEATURE_EXTENDED_RES_CODE =3D	0x100
+	HFP_AG_FEATURE_EXTENDED_RES_CODE =3D	0x100,
+	HFP_AG_FEATURE_CODEC_NEGOTIATION =3D	0x200
 };
 =

-/* HFP HF supported features bitmap. Bluetooth HFP 1.5 spec page 77 */
+/* HFP HF supported features bitmap. Bluetooth HFP 1.6 spec page 88 */
 enum hfp_hf_feature {
 	HFP_HF_FEATURE_ECNR =3D			0x1,
 	HFP_HF_FEATURE_3WAY =3D			0x2,
@@ -136,7 +137,8 @@ enum hfp_hf_feature {
 	HFP_HF_FEATURE_VOICE_RECOGNITION =3D	0x8,
 	HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL =3D	0x10,
 	HFP_HF_FEATURE_ENHANCED_CALL_STATUS =3D	0x20,
-	HFP_HF_FEATURE_ENHANCED_CALL_CONTROL =3D	0x40
+	HFP_HF_FEATURE_ENHANCED_CALL_CONTROL =3D	0x40,
+	HFP_HF_FEATURE_CODEC_NEGOTIATION =3D	0x80
 };
 =

 const char *ofono_uuid_to_str(const struct ofono_uuid *uuid);
-- =

1.7.1


--===============0415371637233966906==--

