Content-Type: multipart/mixed; boundary="===============4133343750381184216=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 06/13] Add parser for multimedia message identifier objects
Date: Thu, 22 Apr 2010 23:12:23 +0800
Message-ID: <1271949150-9085-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4133343750381184216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a33c4e9..45ff7e3 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1687,6 +1687,24 @@ static gboolean parse_dataobj_mms_reference(struct c=
omprehension_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.83 */
+static gboolean parse_dataobj_mms_id(struct comprehension_tlv_iter *iter,
+					void *user)
+{
+	struct stk_mms_id *mi =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	mi->len =3D len;
+	memcpy(mi->id, data, len);
+
+	return TRUE;
+}
+
 static dataobj_handler handler_for_type(enum stk_data_object_type type)
 {
 	switch (type) {
@@ -1840,6 +1858,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_meid;
 	case STK_DATA_OBJECT_TYPE_MMS_REFERENCE:
 		return parse_dataobj_mms_reference;
+	case STK_DATA_OBJECT_TYPE_MMS_ID:
+		return parse_dataobj_mms_id;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index b1e4c5e..c4e2c91 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -730,6 +730,15 @@ struct stk_mms_reference {
 	unsigned char len;
 };
 =

+/*
+ * According to 102.223 Section 8.83 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_mms_id {
+	unsigned char id[127];
+	unsigned char len;
+};
+
 struct stk_command_display_text {
 	char *text;
 	struct stk_icon_id icon_id;
-- =

1.7.0.4


--===============4133343750381184216==--

