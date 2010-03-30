Content-Type: multipart/mixed; boundary="===============2378986514033595787=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH v2 07/10] Add parser for call control requested action objects
Date: Tue, 30 Mar 2010 15:57:34 +0800
Message-ID: <1269935857-4234-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269935857-4234-6-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2378986514033595787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   20 ++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 189d831..c901213 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -753,6 +753,24 @@ static gboolean parse_dataobj_transaction_id(
 		STK_DATA_OBJECT_TYPE_TRANSACTION_ID, ti->list, &ti->len);
 }
 =

+/* Defined in TS 102.223 Section 8.30 */
+static gboolean parse_dataobj_call_control_requested_action(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_call_control_requested_action *action =3D user;
+	unsigned int len;
+
+	len =3D comprehension_tlv_iter_get_length(iter);
+
+	action->action =3D g_try_malloc(len);
+	if (action->action =3D=3D NULL)
+		return FALSE;
+
+	return parse_dataobj_common_byte_array(iter,
+			STK_DATA_OBJECT_TYPE_CALL_CONTROL_REQUESTED_ACTION,
+			action->action, &action->len);
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -880,6 +898,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
bject_type type)
 		return parse_dataobj_location_status;
 	case STK_DATA_OBJECT_TYPE_TRANSACTION_ID:
 		return parse_dataobj_transaction_id;
+	case STK_DATA_OBJECT_TYPE_CALL_CONTROL_REQUESTED_ACTION:
+		return parse_dataobj_call_control_requested_action;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
 		return parse_dataobj_icon_id;
 	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
diff --git a/src/stkutil.h b/src/stkutil.h
index 4c2f195..1eae1cd 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -435,6 +435,12 @@ struct stk_transaction_id {
 	unsigned int len;
 };
 =

+/* Defined in TS 102.223 Section 8.30 */
+struct stk_call_control_requested_action {
+	unsigned char *action;
+	unsigned int len;
+};
+
 /*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
-- =

1.6.3.3


--===============2378986514033595787==--

