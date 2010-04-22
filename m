Content-Type: multipart/mixed; boundary="===============2034354127694039741=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 08/13] Add parser for mm content identifier objects
Date: Thu, 22 Apr 2010 23:12:25 +0800
Message-ID: <1271949150-9085-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2034354127694039741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c2b3cd5..b4702b2 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1723,6 +1723,24 @@ static gboolean parse_dataobj_mms_transfer_status(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.85 */
+static gboolean parse_dataobj_mms_content_id(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_mms_content_id *mci =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	mci->len =3D len;
+	memcpy(mci->id, data, len);
+
+	return TRUE;
+}
+
 static dataobj_handler handler_for_type(enum stk_data_object_type type)
 {
 	switch (type) {
@@ -1880,6 +1898,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_mms_id;
 	case STK_DATA_OBJECT_TYPE_MMS_TRANSFER_STATUS:
 		return parse_dataobj_mms_transfer_status;
+	case STK_DATA_OBJECT_TYPE_MMS_CONTENT_ID:
+		return parse_dataobj_mms_content_id;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 937bbc6..267e296 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -748,6 +748,15 @@ struct stk_mms_transfer_status {
 	unsigned char len;
 };
 =

+/*
+ * According to 102.223 Section 8.85 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_mms_content_id {
+	unsigned char id[127];
+	unsigned char len;
+};
+
 struct stk_command_display_text {
 	char *text;
 	struct stk_icon_id icon_id;
-- =

1.7.0.4


--===============2034354127694039741==--

