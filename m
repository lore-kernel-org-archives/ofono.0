Content-Type: multipart/mixed; boundary="===============4916881540791245744=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2 04/10] Add parser for cause objects
Date: Tue, 30 Mar 2010 15:57:31 +0800
Message-ID: <1269935857-4234-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269935857-4234-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4916881540791245744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   30 ++++++++++++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index aa57543..14d3999 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -687,6 +687,34 @@ static gboolean parse_dataobj_event_list(
 			STK_DATA_OBJECT_TYPE_EVENT_LIST, el->list, &el->len);
 }
 =

+/* Defined in TS 102.223 Section 8.26 */
+static gboolean parse_dataobj_cause(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_cause *cause =3D user;
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
+		cause->has_cause =3D TRUE;
+		return TRUE;
+	}
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+	cause->len =3D len;
+	memcpy(cause->cause, data, len);
+	cause->has_cause =3D TRUE;
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -808,6 +836,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_items_next_action_indicator;
 	case STK_DATA_OBJECT_TYPE_EVENT_LIST:
 		return parse_dataobj_event_list;
+	case STK_DATA_OBJECT_TYPE_CAUSE:
+		return parse_dataobj_cause;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index 12428ca..e719403 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -412,6 +412,15 @@ struct stk_event_list {
 };
 =

 /*
+ * According to 102.223 Section 8.26, the maximum length of cause is 30.
+ */
+struct stk_cause {
+	unsigned char cause[30];
+	unsigned int len;
+	ofono_bool_t has_cause;
+};
+
+/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
-- =

1.6.3.3


--===============4916881540791245744==--

