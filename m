Content-Type: multipart/mixed; boundary="===============7468068060289202527=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 07/13] Add parser for multimedia message transfer status
 objects
Date: Thu, 22 Apr 2010 23:12:24 +0800
Message-ID: <1271949150-9085-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7468068060289202527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 45ff7e3..c2b3cd5 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1705,6 +1705,24 @@ static gboolean parse_dataobj_mms_id(struct comprehe=
nsion_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.84 */
+static gboolean parse_dataobj_mms_transfer_status(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_mms_transfer_status *mts =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	mts->len =3D len;
+	memcpy(mts->status, data, len);
+
+	return TRUE;
+}
+
 static dataobj_handler handler_for_type(enum stk_data_object_type type)
 {
 	switch (type) {
@@ -1860,6 +1878,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_mms_reference;
 	case STK_DATA_OBJECT_TYPE_MMS_ID:
 		return parse_dataobj_mms_id;
+	case STK_DATA_OBJECT_TYPE_MMS_TRANSFER_STATUS:
+		return parse_dataobj_mms_transfer_status;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index c4e2c91..937bbc6 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -739,6 +739,15 @@ struct stk_mms_id {
 	unsigned char len;
 };
 =

+/*
+ * According to 102.223 Section 8.84 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_mms_transfer_status {
+	unsigned char status[127];
+	unsigned char len;
+};
+
 struct stk_command_display_text {
 	char *text;
 	struct stk_icon_id icon_id;
-- =

1.7.0.4


--===============7468068060289202527==--

