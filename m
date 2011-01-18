Content-Type: multipart/mixed; boundary="===============6543562097545330152=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH 1/2] simutil: M9, M11, Minor style fixes and indentation
Date: Tue, 18 Jan 2011 13:32:10 +0100
Message-ID: <1295353930-25914-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6543562097545330152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.h |   68 ++++++++++++++++++++++++++++-------------------------=
---
 1 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index ad84907..cda9d55 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -19,36 +19,39 @@
  *
  */
 =

+#define SIM_EFSPN_DC_HOME_PLMN_BIT 0x1
+#define SIM_EFSPN_DC_ROAMING_SPN_BIT 0x2
+
 enum sim_fileid {
-	SIM_EFPL_FILEID =3D 0x2f05,
-	SIM_EF_ICCID_FILEID =3D 0x2fe2,
-	SIM_EFIMG_FILEID =3D 0x4F20,
-	SIM_EFLI_FILEID =3D 0x6f05,
-	SIM_EF_CPHS_MWIS_FILEID =3D 0x6f11,
-	SIM_EF_CPHS_CFF_FILEID =3D 0x6f13,
-	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
-	SIM_EF_CPHS_MBDN_FILEID =3D 0x6f17,
-	SIM_EFUST_FILEID =3D 0x6f38,
-	SIM_EFSST_FILEID =3D 0x6f38, /* same as EFust */
-	SIM_EFMSISDN_FILEID =3D 0x6f40,
-	SIM_EFSPN_FILEID =3D 0x6f46,
-	SIM_EFSDN_FILEID =3D 0x6f49,
-	SIM_EFBDN_FILEID =3D 0x6f4d,
-	SIM_EFADN_FILEID =3D 0x6f3a,
-	SIM_EFEST_FILEID =3D 0x6f56,
-	SIM_EFAD_FILEID =3D 0x6fad,
-	SIM_EFPHASE_FILEID =3D 0x6fae,
-	SIM_EFPNN_FILEID =3D 0x6fc5,
-	SIM_EFOPL_FILEID =3D 0x6fc6,
-	SIM_EFMBDN_FILEID =3D 0x6fc7,
-	SIM_EFMBI_FILEID =3D 0x6fc9,
-	SIM_EFMWIS_FILEID =3D 0x6fca,
-	SIM_EFCFIS_FILEID =3D 0x6fcb,
-	SIM_EFSPDI_FILEID =3D 0x6fcd,
-	SIM_EFECC_FILEID =3D 0x6fb7,
-	SIM_EFCBMIR_FILEID =3D 0x6f50,
-	SIM_EFCBMI_FILEID =3D 0x6f45,
-	SIM_EFCBMID_FILEID =3D 0x6f48,
+	SIM_EFPL_FILEID =3D			0x2f05,
+	SIM_EF_ICCID_FILEID =3D			0x2fe2,
+	SIM_EFIMG_FILEID =3D			0x4f20,
+	SIM_EFLI_FILEID =3D			0x6f05,
+	SIM_EF_CPHS_MWIS_FILEID =3D		0x6f11,
+	SIM_EF_CPHS_CFF_FILEID =3D		0x6f13,
+	SIM_EF_CPHS_INFORMATION_FILEID =3D	0x6f16,
+	SIM_EF_CPHS_MBDN_FILEID =3D		0x6f17,
+	SIM_EFUST_FILEID =3D			0x6f38,
+	SIM_EFSST_FILEID =3D			0x6f38, /* same as EFust */
+	SIM_EFMSISDN_FILEID =3D			0x6f40,
+	SIM_EFSPN_FILEID =3D			0x6f46,
+	SIM_EFSDN_FILEID =3D			0x6f49,
+	SIM_EFBDN_FILEID =3D			0x6f4d,
+	SIM_EFADN_FILEID =3D			0x6f3a,
+	SIM_EFEST_FILEID =3D			0x6f56,
+	SIM_EFAD_FILEID =3D			0x6fad,
+	SIM_EFPHASE_FILEID =3D			0x6fae,
+	SIM_EFPNN_FILEID =3D			0x6fc5,
+	SIM_EFOPL_FILEID =3D			0x6fc6,
+	SIM_EFMBDN_FILEID =3D			0x6fc7,
+	SIM_EFMBI_FILEID =3D			0x6fc9,
+	SIM_EFMWIS_FILEID =3D			0x6fca,
+	SIM_EFCFIS_FILEID =3D			0x6fcb,
+	SIM_EFSPDI_FILEID =3D			0x6fcd,
+	SIM_EFECC_FILEID =3D			0x6fb7,
+	SIM_EFCBMIR_FILEID =3D			0x6f50,
+	SIM_EFCBMI_FILEID =3D			0x6f45,
+	SIM_EFCBMID_FILEID =3D			0x6f48,
 };
 =

 /* 51.011 Section 9.3 */
@@ -223,9 +226,6 @@ enum sim_sst_service {
 	SIM_SST_SERVICE_PROVIDER_DISPLAY_INFO =3D		55
 };
 =

-#define SIM_EFSPN_DC_HOME_PLMN_BIT 0x1
-#define SIM_EFSPN_DC_ROAMING_SPN_BIT 0x2
-
 enum ber_tlv_data_type {
 	BER_TLV_DATA_TYPE_UNIVERSAL =3D		0,
 	BER_TLV_DATA_TYPE_APPLICATION =3D		1,
@@ -347,8 +347,8 @@ void ber_tlv_iter_init(struct ber_tlv_iter *iter, const=
 unsigned char *pdu,
 unsigned int ber_tlv_iter_get_tag(struct ber_tlv_iter *iter);
 =

 enum ber_tlv_data_type ber_tlv_iter_get_class(struct ber_tlv_iter *iter);
-enum ber_tlv_data_encoding_type
-	ber_tlv_iter_get_encoding(struct ber_tlv_iter *iter);
+enum ber_tlv_data_encoding_type ber_tlv_iter_get_encoding(
+						struct ber_tlv_iter *iter);
 =

 /*
  * This will return the short tag along with class and encoding informatio=
n.
-- =

1.7.3.2


--===============6543562097545330152==--

