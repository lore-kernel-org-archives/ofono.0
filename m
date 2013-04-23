Content-Type: multipart/mixed; boundary="===============6838547246693319456=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 2/3] hfp: Add defines for HFP SDP feature bits
Date: Tue, 23 Apr 2013 18:21:51 -0300
Message-ID: <1366752112-8007-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366752112-8007-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6838547246693319456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hfp.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/hfp.h b/src/hfp.h
index b54de56..0d36ae5 100644
--- a/src/hfp.h
+++ b/src/hfp.h
@@ -45,6 +45,24 @@ enum hfp_hf_feature {
 	HFP_HF_FEATURE_CODEC_NEGOTIATION =3D	0x80,
 };
 =

+enum hfp_sdp_hf_features {
+	HFP_SDP_HF_FEATURE_ECNR =3D			0x1,
+	HFP_SDP_HF_FEATURE_3WAY =3D			0x2,
+	HFP_SDP_HF_FEATURE_CLIP =3D			0x4,
+	HFP_SDP_HF_FEATURE_VOICE_RECOGNITION =3D		0x8,
+	HFP_SDP_HF_FEATURE_REMOTE_VOLUME_CONTROL =3D	0x10,
+	HFP_SDP_HF_FEATURE_WIDEBAND_SPEECH =3D		0x20,
+};
+
+enum hfp_sdp_ag_features {
+	HFP_SDP_AG_FEATURE_3WAY =3D			0x1,
+	HFP_SDP_AG_FEATURE_ECNR =3D			0x2,
+	HFP_SDP_AG_FEATURE_VOICE_RECOG =3D		0x4,
+	HFP_SDP_AG_FEATURE_IN_BAND_RING_TONE =3D		0x8,
+	HFP_SDP_AG_FEATURE_ATTACH_VOICE_TAG =3D		0x10,
+	HFP_SDP_AG_FEATURE_WIDEBAND_SPEECH =3D		0x20,
+};
+
 /* Supported agent codecs */
 enum hfp_codec {
 	HFP_CODEC_CVSD =3D 0x01,
-- =

1.8.2.1


--===============6838547246693319456==--

