Content-Type: multipart/mixed; boundary="===============4480285243013024591=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2 10/10] Add parser for item icon identifier list objects
Date: Tue, 30 Mar 2010 15:57:37 +0800
Message-ID: <1269935857-4234-10-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269935857-4234-9-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4480285243013024591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   26 ++++++++++++++++++++++++++
 src/stkutil.h |   12 ++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c901213..5b95cba 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -793,6 +793,30 @@ static gboolean parse_dataobj_icon_id(struct comprehen=
sion_tlv_iter *iter,
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.32 */
+static gboolean parse_dataobj_item_icon_id_list(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_item_icon_id_list *iiil =3D user;
+	const unsigned char *data;
+	unsigned int len;
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D
+			STK_DATA_OBJECT_TYPE_ITEM_ICON_ID_LIST)
+		return FALSE;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if (len < 2)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	iiil->qualifier =3D data[0];
+	iiil->len =3D len - 1;
+	memcpy(iiil->list, data + 1, iiil->len);
+
+	return TRUE;
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -902,6 +926,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_call_control_requested_action;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
+	case STK_DATA_OBJECT_TYPE_ITEM_ICON_ID_LIST:
+		return parse_dataobj_item_icon_id_list;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
 		return parse_dataobj_imm_resp;
 	case STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE:
diff --git a/src/stkutil.h b/src/stkutil.h
index a3674e4..5cb50f1 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -447,6 +447,18 @@ struct stk_icon_identifier {
 	unsigned char id;
 };
 =

+/*
+ * According to 102.223 Section 8.32 the length of CTLV is 1 byte. This me=
ans
+ * that the maximum size is 127 according to the rules of CTLVs. This size=
 also
+ * includes icon list qualifier for 1 byte, so the maxmimum size of icon
+ * identifier list is 126.
+ */
+struct stk_item_icon_id_list {
+	unsigned char qualifier;
+	unsigned char list[126];
+	unsigned int len;
+};
+
 /* =

  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.6.3.3


--===============4480285243013024591==--

