Content-Type: multipart/mixed; boundary="===============6944491615240689112=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 05/13] Add parser for multimedia message reference objects
Date: Thu, 22 Apr 2010 23:12:22 +0800
Message-ID: <1271949150-9085-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6944491615240689112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 3dca39c..a33c4e9 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1669,6 +1669,24 @@ static gboolean parse_dataobj_meid(struct comprehens=
ion_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.82 */
+static gboolean parse_dataobj_mms_reference(struct comprehension_tlv_iter =
*iter,
+						void *user)
+{
+	struct stk_mms_reference *mr =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	mr->len =3D len;
+	memcpy(mr->ref, data, len);
+
+	return TRUE;
+}
+
 static dataobj_handler handler_for_type(enum stk_data_object_type type)
 {
 	switch (type) {
@@ -1820,6 +1838,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_frame_id;
 	case STK_DATA_OBJECT_TYPE_MEID:
 		return parse_dataobj_meid;
+	case STK_DATA_OBJECT_TYPE_MMS_REFERENCE:
+		return parse_dataobj_mms_reference;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index c2579dc..b1e4c5e 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -721,6 +721,15 @@ struct stk_frames_info {
 	unsigned int len;
 };
 =

+/*
+ * According to 102.223 Section 8.82 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_mms_reference {
+	unsigned char ref[127];
+	unsigned char len;
+};
+
 struct stk_command_display_text {
 	char *text;
 	struct stk_icon_id icon_id;
-- =

1.7.0.4


--===============6944491615240689112==--

