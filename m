Content-Type: multipart/mixed; boundary="===============2619185184785021493=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 09/11] Add parser for item icon identifier list objects
Date: Wed, 31 Mar 2010 17:17:01 +0800
Message-ID: <1270027023-21468-9-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270027023-21468-8-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2619185184785021493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   21 +++++++++++++++++++++
 src/stkutil.h |   12 ++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b60aa65..4c9cb6a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -743,6 +743,25 @@ static gboolean parse_dataobj_icon_id(struct comprehen=
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
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if ((len < 2) || (len > 127))
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
@@ -845,6 +864,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
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
index 5619211..3f2802e 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -448,6 +448,18 @@ struct stk_icon_identifier {
 };
 =

 /*
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
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.6.3.3


--===============2619185184785021493==--

