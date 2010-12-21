Content-Type: multipart/mixed; boundary="===============7888510425912756484=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH 1/2] simutil: Minor style fixes and indentation
Date: Tue, 21 Dec 2010 10:34:22 +0100
Message-ID: <1292924062-16665-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7888510425912756484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.h |  110 ++++++++++++++++++++++++++++-------------------------=
---
 1 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index ad84907..fd703d1 100644
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
@@ -77,7 +80,7 @@ enum sim_ust_service {
 	SIM_UST_SERVICE_BDN =3D				5,
 	SIM_UST_SERVICE_EXT_4 =3D				6,
 	SIM_UST_SERVICE_OCI_OCT =3D			7,
-	SIM_UST_SERVICE_ICI_ICT =3D			8,
+	SIM_UST_SERVICE_ICI_ICT	=3D			8,
 	SIM_UST_SERVICE_SMS =3D				9,
 	SIM_UST_SERVICE_SMSR =3D				10,
 	SIM_UST_SERVICE_SMSP =3D				11,
@@ -212,7 +215,7 @@ enum sim_sst_service {
 	SIM_SST_SERVICE_HPLMN =3D				44,
 	SIM_SST_SERVICE_CPBCCH =3D			45,
 	SIM_SST_SERVICE_INVESTIGATION_SCAN =3D		46,
-	SIM_SST_SERVICE_EXT_CCP =3D			47,
+	SIM_SST_SERVICE_EXT_CCP	=3D			47,
 	SIM_SST_SERVICE_MEXE =3D				48,
 	SIM_SST_SERVICE_RPLMN =3D				49,
 	SIM_SST_SERVICE_PLMN_NETWORK_NAME =3D		50,
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
@@ -319,24 +319,24 @@ gboolean comprehension_tlv_iter_next(struct comprehen=
sion_tlv_iter *iter);
 unsigned short comprehension_tlv_iter_get_tag(struct comprehension_tlv_ite=
r *i);
 gboolean comprehension_tlv_get_cr(struct comprehension_tlv_iter *iter);
 unsigned int comprehension_tlv_iter_get_length(
-					struct comprehension_tlv_iter *iter);
+	struct comprehension_tlv_iter *iter);
 const unsigned char *comprehension_tlv_iter_get_data(
-					struct comprehension_tlv_iter *iter);
+	struct comprehension_tlv_iter *iter);
 =

 void comprehension_tlv_iter_copy(struct comprehension_tlv_iter *from,
 					struct comprehension_tlv_iter *to);
 =

 gboolean comprehension_tlv_builder_init(
-				struct comprehension_tlv_builder *builder,
-				unsigned char *pdu, unsigned int size);
+	struct comprehension_tlv_builder *builder,
+	unsigned char *pdu, unsigned int size);
 gboolean comprehension_tlv_builder_next(
-				struct comprehension_tlv_builder *builder,
-				gboolean cr, unsigned short tag);
+	struct comprehension_tlv_builder *builder,
+	gboolean cr, unsigned short tag);
 gboolean comprehension_tlv_builder_set_length(
-				struct comprehension_tlv_builder *builder,
-				unsigned int len);
+	struct comprehension_tlv_builder *builder,
+	unsigned int len);
 unsigned char *comprehension_tlv_builder_get_data(
-				struct comprehension_tlv_builder *builder);
+	struct comprehension_tlv_builder *builder);
 =

 void ber_tlv_iter_init(struct ber_tlv_iter *iter, const unsigned char *pdu,
 			unsigned int len);
@@ -348,7 +348,7 @@ unsigned int ber_tlv_iter_get_tag(struct ber_tlv_iter *=
iter);
 =

 enum ber_tlv_data_type ber_tlv_iter_get_class(struct ber_tlv_iter *iter);
 enum ber_tlv_data_encoding_type
-	ber_tlv_iter_get_encoding(struct ber_tlv_iter *iter);
+ber_tlv_iter_get_encoding(struct ber_tlv_iter *iter);
 =

 /*
  * This will return the short tag along with class and encoding informatio=
n.
@@ -382,7 +382,7 @@ unsigned char *ber_tlv_builder_get_data(struct ber_tlv_=
builder *builder);
 gboolean ber_tlv_builder_recurse(struct ber_tlv_builder *builder,
 					struct ber_tlv_builder *recurse);
 gboolean ber_tlv_builder_recurse_comprehension(struct ber_tlv_builder *bui=
lder,
-				struct comprehension_tlv_builder *recurse);
+						struct comprehension_tlv_builder *recurse);
 void ber_tlv_builder_optimize(struct ber_tlv_builder *builder,
 				unsigned char **pdu, unsigned int *len);
 =

@@ -394,13 +394,13 @@ void sim_eons_add_opl_record(struct sim_eons *eons,
 				const guint8 *contents, int length);
 void sim_eons_optimize(struct sim_eons *eons);
 const struct sim_eons_operator_info *sim_eons_lookup_with_lac(
-						struct sim_eons *eons,
-						const char *mcc,
-						const char *mnc,
-						guint16 lac);
+	struct sim_eons *eons,
+	const char *mcc,
+	const char *mnc,
+	guint16 lac);
 const struct sim_eons_operator_info *sim_eons_lookup(struct sim_eons *eons,
-						const char *mcc,
-						const char *mnc);
+							const char *mcc,
+							const char *mnc);
 void sim_eons_free(struct sim_eons *eons);
 =

 void sim_parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc);
@@ -439,10 +439,10 @@ gboolean sim_parse_2g_get_response(const unsigned cha=
r *response, int len,
 					unsigned char *file_status);
 =

 gboolean sim_ust_is_available(unsigned char *service_ust, unsigned char le=
n,
-						enum sim_ust_service index);
+				enum sim_ust_service index);
 gboolean sim_est_is_active(unsigned char *service_est, unsigned char len,
-						enum sim_est_service index);
+				enum sim_est_service index);
 gboolean sim_sst_is_available(unsigned char *service_sst, unsigned char le=
n,
-						enum sim_sst_service index);
+				enum sim_sst_service index);
 gboolean sim_sst_is_active(unsigned char *service_sst, unsigned char len,
-						enum sim_sst_service index);
+				enum sim_sst_service index);
-- =

1.7.3.2


--===============7888510425912756484==--

