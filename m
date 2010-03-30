Content-Type: multipart/mixed; boundary="===============1314637776866156559=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2 01/10] Add parser for items next action indicator objects
Date: Tue, 30 Mar 2010 15:57:28 +0800
Message-ID: <1269935857-4234-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1314637776866156559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   36 ++++++++++++++++++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c5e0369..3f7183f 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -67,6 +67,29 @@ static gboolean parse_dataobj_common_bool(struct compreh=
ension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* For data object that only has a byte array with variable length */
+static gboolean parse_dataobj_common_byte_array(
+			struct comprehension_tlv_iter *iter,
+			enum stk_data_object_type type,
+			unsigned char *array, unsigned int *array_len)
+{
+	const unsigned char *data;
+	unsigned int len;
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D type)
+		return FALSE;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	*array_len =3D len;
+	memcpy(array, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.1 */
 static gboolean parse_dataobj_address(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -643,6 +666,17 @@ static gboolean parse_dataobj_network_measurement_resu=
lts(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.24 */
+static gboolean parse_dataobj_items_next_action_indicator(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_items_next_action_indicator *inai =3D user;
+
+	return parse_dataobj_common_byte_array(iter,
+			STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR,
+			inai->list, &inai->len);
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -760,6 +794,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_help_request;
 	case STK_DATA_OBJECT_TYPE_NETWORK_MEASUREMENT_RESULTS:
 		return parse_dataobj_network_measurement_results;
+	case STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR:
+		return parse_dataobj_items_next_action_indicator;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index a9495de..c4b8970 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -370,6 +370,15 @@ struct stk_file {
 };
 =

 /*
+ * According to 102.223 Section 8.24 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_items_next_action_indicator {
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


--===============1314637776866156559==--

