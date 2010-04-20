Content-Type: multipart/mixed; boundary="===============8451448053885042161=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 14/17] Add parser for item text attribute list objects
Date: Tue, 20 Apr 2010 14:15:09 +0800
Message-ID: <1271744112-32285-14-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271744112-32285-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8451448053885042161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   21 +++++++++++++++++++++
 src/stkutil.h |   11 +++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index e6d69ef..0f373f9 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1480,6 +1480,25 @@ static gboolean parse_dataobj_text_attr(struct compr=
ehension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.73 */
+static gboolean parse_dataobj_item_text_attribute_list(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_item_text_attribute_list *ital =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len > sizeof(ital->list)) || (len % 4 !=3D 0))
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	memcpy(ital->list, data, len);
+	ital->len =3D len;
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.80 */
 static gboolean parse_dataobj_frame_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1633,6 +1652,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_cdma_sms_tpdu;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
+	case STK_DATA_OBJECT_TYPE_ITEM_TEXT_ATTRIBUTE_LIST:
+		return parse_dataobj_item_text_attribute_list;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
 		return parse_dataobj_frame_id;
 	default:
diff --git a/src/stkutil.h b/src/stkutil.h
index 01597b3..f9cf34b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -681,6 +681,17 @@ struct stk_text_attribute {
 	unsigned char len;
 };
 =

+/*
+ * According to 102.223 Section 8.73 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs. In additi=
on,
+ * the length should be also the number multiplied by 4, so the maximum nu=
mber
+ * is 124.
+ */
+struct stk_item_text_attribute_list {
+	unsigned char list[124];
+	unsigned char len;
+};
+
 struct stk_command_display_text {
 	char *text;
 	struct stk_icon_id icon_id;
-- =

1.7.0.4


--===============8451448053885042161==--

