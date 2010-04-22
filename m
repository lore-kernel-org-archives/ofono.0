Content-Type: multipart/mixed; boundary="===============8984545560789158615=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 02/13] Add parser for frame layout objects
Date: Thu, 22 Apr 2010 23:12:19 +0800
Message-ID: <1271949150-9085-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8984545560789158615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   26 ++++++++++++++++++++++++++
 src/stkutil.h |   16 ++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b855b0f..fab60a9 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1578,6 +1578,30 @@ static gboolean parse_dataobj_browsing_status(
 	return parse_dataobj_common_byte_array(iter, array);
 }
 =

+/* Defined in TS 102.223 Section 8.78 */
+static gboolean parse_dataobj_frame_layout(struct comprehension_tlv_iter *=
iter,
+						void *user)
+{
+	struct stk_frame_layout *fl =3D user;
+	const unsigned char *data;
+	unsigned char len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 2)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	if (data[0] !=3D STK_LAYOUT_HORIZONTAL &&
+			data[0] !=3D STK_LAYOUT_VERTICAL)
+		return FALSE;
+
+	fl->layout =3D data[0];
+	fl->len =3D len - 1;
+	memcpy(fl->size, data + 1, fl->len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.80 */
 static gboolean parse_dataobj_frame_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1741,6 +1765,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_battery_state;
 	case STK_DATA_OBJECT_TYPE_BROWSING_STATUS:
 		return parse_dataobj_browsing_status;
+	case STK_DATA_OBJECT_TYPE_FRAME_LAYOUT:
+		return parse_dataobj_frame_layout;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
 		return parse_dataobj_frame_id;
 	default:
diff --git a/src/stkutil.h b/src/stkutil.h
index 98da709..52b62af 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -365,6 +365,11 @@ enum stk_battery_state {
 	STK_BATTERY_FULL =3D 	0x04
 };
 =

+enum stk_frame_layout_type {
+	STK_LAYOUT_HORIZONTAL =3D 	0x01,
+	STK_LAYOUT_VERTICAL =3D 		0x02
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -693,6 +698,17 @@ struct stk_item_text_attribute_list {
 	unsigned char len;
 };
 =

+/*
+ * According to 102.223 Section 8.78 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum length is 127 bytes for the total length of layout and
+ * relative-sized frame. Thus the maximum length of relative size is 126 b=
ytes.
+ */
+struct stk_frame_layout {
+	unsigned char layout;
+	unsigned char size[126];
+	unsigned int len;
+};
+
 struct stk_command_display_text {
 	char *text;
 	struct stk_icon_id icon_id;
-- =

1.7.0.4


--===============8984545560789158615==--

