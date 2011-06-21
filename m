Content-Type: multipart/mixed; boundary="===============7954012262613864607=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 1/4] include: add HFP features types for HF and AG
Date: Tue, 21 Jun 2011 14:49:46 +0200
Message-ID: <1308660589-2187-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7954012262613864607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/types.h b/include/types.h
index d25f409..536dac7 100644
--- a/include/types.h
+++ b/include/types.h
@@ -115,6 +115,30 @@ struct ofono_uuid {
 	unsigned char uuid[OFONO_SHA1_UUID_LEN];
 };
 =

+/* HFP AG supported features bitmap. Bluetooth HFP 1.5 spec page 77 */
+enum hfp_ag_feature {
+	HFP_AG_FEATURE_3WAY =3D			0x1,
+	HFP_AG_FEATURE_ECNR =3D			0x2,
+	HFP_AG_FEATURE_VOICE_RECOG =3D		0x4,
+	HFP_AG_FEATURE_IN_BAND_RING_TONE =3D	0x8,
+	HFP_AG_FEATURE_ATTACH_VOICE_TAG =3D	0x10,
+	HFP_AG_FEATURE_REJECT_CALL =3D		0x20,
+	HFP_AG_FEATURE_ENHANCED_CALL_STATUS =3D	0x40,
+	HFP_AG_FEATURE_ENHANCED_CALL_CONTROL =3D	0x80,
+	HFP_AG_FEATURE_EXTENDED_RES_CODE =3D	0x100
+};
+
+/* HFP HF supported features bitmap. Bluetooth HFP 1.5 spec page 77 */
+enum hfp_hf_feature {
+	HFP_HF_FEATURE_ECNR =3D			0x1,
+	HFP_HF_FEATURE_3WAY =3D			0x2,
+	HFP_HF_FEATURE_CLIP =3D			0x4,
+	HFP_HF_FEATURE_VOICE_RECOGNITION =3D	0x8,
+	HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL =3D	0x10,
+	HFP_HF_FEATURE_ENHANCED_CALL_STATUS =3D	0x20,
+	HFP_HF_FEATURE_ENHANCED_CALL_CONTROL =3D	0x40
+};
+
 const char *ofono_uuid_to_str(const struct ofono_uuid *uuid);
 void ofono_call_init(struct ofono_call *call);
 =

-- =

1.7.1


--===============7954012262613864607==--

