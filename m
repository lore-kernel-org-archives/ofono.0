Content-Type: multipart/mixed; boundary="===============0990944498528230353=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 03/13] Add parser for frames information objects
Date: Thu, 22 Apr 2010 23:12:20 +0800
Message-ID: <1271949150-9085-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0990944498528230353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   31 +++++++++++++++++++++++++++++++
 src/stkutil.h |   12 ++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index fab60a9..f2b4fba 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1602,6 +1602,35 @@ static gboolean parse_dataobj_frame_layout(struct co=
mprehension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.79 */
+static gboolean parse_dataobj_frames_info(struct comprehension_tlv_iter *i=
ter,
+						void *user)
+{
+	struct stk_frames_info *fi =3D user;
+	const unsigned char *data;
+	unsigned char len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	if (data[0] > 0x0f)
+		return FALSE;
+
+	if ((len =3D=3D 1 && data[0] !=3D 0) || (len > 1 && data[0] =3D=3D 0))
+		return FALSE;
+
+	if (len =3D=3D 1)
+		return TRUE;
+
+	fi->id =3D data[0];
+	fi->len =3D len - 1;
+	memcpy(fi->list, data + 1, fi->len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.80 */
 static gboolean parse_dataobj_frame_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -1767,6 +1796,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_browsing_status;
 	case STK_DATA_OBJECT_TYPE_FRAME_LAYOUT:
 		return parse_dataobj_frame_layout;
+	case STK_DATA_OBJECT_TYPE_FRAMES_INFO:
+		return parse_dataobj_frames_info;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
 		return parse_dataobj_frame_id;
 	default:
diff --git a/src/stkutil.h b/src/stkutil.h
index 52b62af..c2579dc 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -709,6 +709,18 @@ struct stk_frame_layout {
 	unsigned int len;
 };
 =

+/*
+ * According to 102.223 Section 8.79 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum length is 127 bytes for the total length of default fr=
ame
+ * id and frame information list. Thus the maximum length of frame informa=
tion
+ * list is 126 bytes.
+ */
+struct stk_frames_info {
+	unsigned char id;
+	unsigned char list[126];
+	unsigned int len;
+};
+
 struct stk_command_display_text {
 	char *text;
 	struct stk_icon_id icon_id;
-- =

1.7.0.4


--===============0990944498528230353==--

