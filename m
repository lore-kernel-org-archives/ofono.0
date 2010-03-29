Content-Type: multipart/mixed; boundary="===============2498186201686401902=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 4/9] Add parser for cause objects
Date: Tue, 30 Mar 2010 00:24:39 +0800
Message-ID: <1269879884-12741-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269879884-12741-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2498186201686401902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index ecd5639..8f4ff39 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -687,6 +687,39 @@ static gboolean parse_dataobj_event_list(
 				STK_DATA_OBJECT_TYPE_EVENT_LIST);
 }
 =

+/* Defined in TS 102.223 Section 8.26 */
+static gboolean parse_dataobj_cause(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_common_byte_array *array =3D user;
+	const unsigned char *data;
+	unsigned int len;
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D STK_DATA_OBJECT_TYPE_CAUSE)
+		return FALSE;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+	if ((len =3D=3D 1) || (len > 30))
+		return FALSE;
+
+	if (len =3D=3D 0) {
+		array->len =3D 0;
+		array->array =3D NULL;
+		return TRUE;
+	}
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	array->len =3D len;
+
+	array->array =3D g_try_malloc(len);
+	if (array->array =3D=3D NULL)
+		return FALSE;
+
+	memcpy(array->array, data, len);
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -808,6 +841,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_items_next_action_indicator;
 	case STK_DATA_OBJECT_TYPE_EVENT_LIST:
 		return parse_dataobj_event_list;
+	case STK_DATA_OBJECT_TYPE_CAUSE:
+		return parse_dataobj_cause;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
-- =

1.6.3.3


--===============2498186201686401902==--

