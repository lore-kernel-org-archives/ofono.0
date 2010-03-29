Content-Type: multipart/mixed; boundary="===============1372658201999965938=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 9/9] Add parser for item icon identifier list objects
Date: Mon, 29 Mar 2010 16:05:51 +0000
Message-ID: <1269878605-12223-9-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269878605-12223-8-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1372658201999965938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   31 +++++++++++++++++++++++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 6619bc3..71899b9 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -786,6 +786,35 @@ static gboolean parse_dataobj_icon_id(struct comprehen=
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
+
+	iiil->array =3D g_try_malloc(len - 1);
+	if (iiil->array =3D=3D NULL)
+		return FALSE;
+
+	memcpy(iiil->array, data + 1, iiil->len);
+
+	return TRUE;
+}
+
 /* Defined in 102.223 Section 8.43 */
 static gboolean parse_dataobj_imm_resp(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -895,6 +924,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
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
index 08a5355..a00bee3 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -356,6 +356,13 @@ struct stk_icon_identifier {
 	unsigned char id;
 };
 =

+/* Defined in TS 102.223 Section 8.32 */
+struct stk_item_icon_id_list {
+	unsigned char qualifier;
+	unsigned char len;
+	unsigned char *array;
+};
+
 /*
  * According to 102.223 Section 8.8 interval values of 0x00 are reserved.
  * We use this to denote empty duration objects.
-- =

1.6.3.3


--===============1372658201999965938==--

