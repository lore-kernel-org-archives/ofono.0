Content-Type: multipart/mixed; boundary="===============6560552875506562644=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 02/17] Add parser for aid objects
Date: Tue, 20 Apr 2010 14:14:57 +0800
Message-ID: <1271744112-32285-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271744112-32285-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6560552875506562644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |   23 +++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 5b97aeb..0d4be68 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1225,6 +1225,24 @@ static gboolean parse_dataobj_uicc_te_interface(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.60 */
+static gboolean parse_dataobj_aid(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	struct stk_aid *aid =3D user;
+	const unsigned char *data;
+	unsigned char len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len > 16) || (len < 12))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	aid->len =3D len;
+	memcpy(aid->aid, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1373,6 +1391,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_other_address;
 	case STK_DATA_OBJECT_TYPE_UICC_TE_INTERFACE:
 		return parse_dataobj_uicc_te_interface;
+	case STK_DATA_OBJECT_TYPE_AID:
+		return parse_dataobj_aid;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index 1c7c970..67e7ef7 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -337,6 +337,18 @@ enum stk_address_type {
 	STK_ADDRESS_IPV6 =3D 	0x57
 };
 =

+enum stk_access_technology_type {
+	STK_ACCESS_TECHNOLOGY_GSM =3D 		0x00,
+	STK_ACCESS_TECHNOLOGY_TIA_EIA_553 =3D	0x01,
+	STK_ACCESS_TECHNOLOGY_TIA_EIA_136_C =3D	0x02,
+	STK_ACCESS_TECHNOLOGY_UTRAN =3D 		0x03,
+	STK_ACCESS_TECHNOLOGY_TETRA =3D 		0x04,
+	STK_ACCESS_TECHNOLOGY_TIA_EIA_95 =3D 	0x05,
+	STK_ACCESS_TECHNOLOGY_CDMA2000_1X =3D	0x06,
+	STK_ACCESS_TECHNOLOGY_CDMA2000_HRPD =3D 	0x07,
+	STK_ACCESS_TECHNOLOGY_EUTRAN =3D 		0x08
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -577,6 +589,17 @@ struct stk_uicc_te_interface {
 };
 =

 /*
+ * Defined in TS 102.223 Section 8.60.
+ * According to 101.220, Section 4, aid contains two fields RID and PIX.
+ * RID has 5 bytes, while PIX contains information between 7 to 11 bytes.
+ * So the maximum size of aid is 16 bytes.
+ */
+struct stk_aid {
+	unsigned char aid[16];
+	unsigned int len;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.7.0.4


--===============6560552875506562644==--

