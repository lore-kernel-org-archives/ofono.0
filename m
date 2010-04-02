Content-Type: multipart/mixed; boundary="===============0642807079339535762=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 02/15] Add parser for card atr objects
Date: Fri, 02 Apr 2010 14:20:27 +0800
Message-ID: <1270189240-11650-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270189240-11650-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0642807079339535762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 5b258ab..a96132c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -771,6 +771,24 @@ static gboolean parse_dataobj_card_reader_status(
 	return parse_dataobj_common_byte(iter, byte);
 }
 =

+/* Defined in TS 102.223 Section 8.34 */
+static gboolean parse_dataobj_card_atr(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_card_atr *ca =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len < 1) || (len > sizeof(ca->atr)))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	ca->len =3D len;
+	memcpy(ca->atr, data, len);
+
+	return TRUE;
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -877,6 +895,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_item_icon_id_list;
 	case STK_DATA_OBJECT_TYPE_CARD_READER_STATUS:
 		return parse_dataobj_card_reader_status;
+	case STK_DATA_OBJECT_TYPE_CARD_ATR:
+		return parse_dataobj_card_atr;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
diff --git a/src/stkutil.h b/src/stkutil.h
index 4ff8c4b..8047ed1 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -460,6 +460,15 @@ struct stk_item_icon_id_list {
 };
 =

 /*
+ * According to 102.223 Section 8.34 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_card_atr {
+	unsigned char atr[127];
+	unsigned int len;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.6.3.3


--===============0642807079339535762==--

