Content-Type: multipart/mixed; boundary="===============2424544271377273126=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 12/13] Add parser for card reader identifier objects
Date: Tue, 06 Apr 2010 18:06:46 +0800
Message-ID: <1270548407-12042-12-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-11-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2424544271377273126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 01124a5..28a09d9 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1161,6 +1161,24 @@ static gboolean parse_dataobj_channel_status(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.57 */
+static gboolean parse_dataobj_card_reader_id(
+			struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_card_reader_id *cr_id =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	cr_id->len =3D len;
+	memcpy(cr_id->id, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static gboolean parse_dataobj_text_attr(struct comprehension_tlv_iter *ite=
r,
 					void *user)
@@ -1303,6 +1321,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_buffer_size;
 	case STK_DATA_OBJECT_TYPE_CHANNEL_STATUS:
 		return parse_dataobj_channel_status;
+	case STK_DATA_OBJECT_TYPE_CARD_READER_ID:
+		return parse_dataobj_card_reader_id;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
 		return parse_dataobj_text_attr;
 	case STK_DATA_OBJECT_TYPE_FRAME_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index c1b9af0..511b912 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -544,6 +544,15 @@ struct stk_bearer_description {
 };
 =

 /*
+ * According to 102.223 Section 8.57 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs.
+ */
+struct stk_card_reader_id {
+	unsigned char id[127];
+	unsigned char len;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.6.3.3


--===============2424544271377273126==--

