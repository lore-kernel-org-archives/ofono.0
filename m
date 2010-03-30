Content-Type: multipart/mixed; boundary="===============3620254129476859421=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2 06/10] Add parser for transaction identifier objects
Date: Tue, 30 Mar 2010 15:57:33 +0800
Message-ID: <1269935857-4234-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269935857-4234-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3620254129476859421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   12 ++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 37cb81e..189d831 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -743,6 +743,16 @@ static gboolean parse_dataobj_location_status(
 					STK_DATA_OBJECT_TYPE_LOCATION_STATUS);
 }
 =

+/* Defined in TS 102.223 Section 8.28 */
+static gboolean parse_dataobj_transaction_id(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_transaction_id *ti =3D user;
+
+	return parse_dataobj_common_byte_array(iter,
+		STK_DATA_OBJECT_TYPE_TRANSACTION_ID, ti->list, &ti->len);
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -868,6 +878,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_cause;
 	case STK_DATA_OBJECT_TYPE_LOCATION_STATUS:
 		return parse_dataobj_location_status;
+	case STK_DATA_OBJECT_TYPE_TRANSACTION_ID:
+		return parse_dataobj_transaction_id;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index 00e351b..4c2f195 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -427,6 +427,15 @@ struct stk_cause {
 };
 =

 /*
+ * According to 102.223 Section 8.28 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_transaction_id {
+	unsigned char list[127];
+	unsigned int len;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.6.3.3


--===============3620254129476859421==--

