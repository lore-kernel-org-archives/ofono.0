Content-Type: multipart/mixed; boundary="===============4154683631132950538=="
MIME-Version: 1.0
From: Krzysztof Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 2/5] hfp: Define hfp_ag_chld_feature
Date: Mon, 17 Mar 2014 16:47:27 +0100
Message-ID: <1395071250-19440-3-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1395071250-19440-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4154683631132950538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Wilk <Krzysztofx.Wilk@intel.com>

---
 src/hfp.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/hfp.h b/src/hfp.h
index 0d36ae5..94ea4f7 100644
--- a/src/hfp.h
+++ b/src/hfp.h
@@ -45,6 +45,17 @@ enum hfp_hf_feature {
 	HFP_HF_FEATURE_CODEC_NEGOTIATION =3D	0x80,
 };
 =

+/* HFP AG supported call hold and multiparty services bitmap. Bluetooth HF=
P 1.6 spec page 76 */
+enum hfp_ag_chld_feature {
+	HFP_AG_CHLD_0 =3D		0x1,
+	HFP_AG_CHLD_1 =3D		0x2,
+	HFP_AG_CHLD_1x =3D	0x4,
+	HFP_AG_CHLD_2 =3D		0x8,
+	HFP_AG_CHLD_2x =3D	0x10,
+	HFP_AG_CHLD_3 =3D		0x20,
+	HFP_AG_CHLD_4 =3D		0x40,
+};
+
 enum hfp_sdp_hf_features {
 	HFP_SDP_HF_FEATURE_ECNR =3D			0x1,
 	HFP_SDP_HF_FEATURE_3WAY =3D			0x2,
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


--===============4154683631132950538==--

