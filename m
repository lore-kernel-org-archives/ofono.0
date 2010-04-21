Content-Type: multipart/mixed; boundary="===============5635723101907065957=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 13/15] Add parser for imeisv objects
Date: Wed, 21 Apr 2010 12:55:57 +0800
Message-ID: <1271825759-8898-13-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271825759-8898-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5635723101907065957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 4d6722d..8582b9f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1502,6 +1502,49 @@ static gboolean parse_dataobj_item_text_attribute_li=
st(
 	return TRUE;
 }
 =

+/*
+ * Defined in TS 102.223 Section 8.74.
+ *
+ * According to 3GPP TS 24.008, Section 10.5.1.4, IMEISV is composed of
+ * 16 digits and totally 9 bytes are used to represent it.
+ *
+ * Bits 1-3 of first byte represent the type of identity, and they
+ * are 0 1 1 separately for IMEISV. Bit 4 of first byte is the odd/even
+ * indication, and it's 0 to indicate IMEISV has odd number of digits (16).
+ * The rest bytes are coded using BCD coding.
+ *
+ * For example, if the IMEISV is "1234567890123456", then it's coded as
+ * "13 32 54 76 98 10 32 54 F6".
+ */
+static gboolean parse_dataobj_imeisv(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	char **imeisv =3D user;
+	const unsigned char *data;
+	unsigned int len;
+	static const char digit_lut[] =3D "0123456789*#abc\0";
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if (len !=3D 9)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	if ((data[0] & 0x0f) !=3D 0x03)
+		return FALSE;
+
+	if (data[8] >> 4 !=3D 0x0f)
+		return FALSE;
+
+	/* Assume imeisv is at least 17 bytes long (16 for imeisv + null) */
+	(*imeisv)[0] =3D digit_lut[data[0] >> 4];
+	extract_bcd_number(data + 1, 7, *imeisv + 1);
+	(*imeisv)[15] =3D digit_lut[data[8] & 0x0f];
+	(*imeisv)[16] =3D '\0';
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.80 */
 static gboolean parse_dataobj_frame_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1657,6 +1700,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_ITEM_TEXT_ATTRIBUTE_LIST:
 		return parse_dataobj_item_text_attribute_list;
+	case STK_DATA_OBJECT_TYPE_IMEISV:
+		return parse_dataobj_imeisv;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
 		return parse_dataobj_frame_id;
 	default:
-- =

1.7.0.4


--===============5635723101907065957==--

