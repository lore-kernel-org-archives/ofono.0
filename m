Content-Type: multipart/mixed; boundary="===============5290208542922213141=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 07/11] Add parser for call control requested action objects
Date: Wed, 31 Mar 2010 17:16:59 +0800
Message-ID: <1270027023-21468-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270027023-21468-6-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5290208542922213141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   34 ++++++++++++++++++++++++++++++++++
 src/stkutil.h |    6 ++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 73dae2c..b60aa65 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -112,6 +112,29 @@ static gboolean parse_dataobj_common_byte(
 	return TRUE;
 }
 =

+/* For data object that only has a byte array with undetermined length */
+static gboolean parse_dataobj_common_byte_array(
+			struct comprehension_tlv_iter *iter,
+			struct stk_common_byte_array *array)
+{
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+
+	if (len < 1)
+		return FALSE;
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
 /* Defined in TS 102.223 Section 8.1 */
 static gboolean parse_dataobj_address(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -693,6 +716,15 @@ static gboolean parse_dataobj_transaction_id(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.30 */
+static gboolean parse_dataobj_call_control_requested_action(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_common_byte_array *array =3D user;
+
+	return parse_dataobj_common_byte_array(iter, array);
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -809,6 +841,8 @@ static dataobj_handler handler_for_type(enum stk_data_o=
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
index 419cda7..9ba8138 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -296,6 +296,12 @@ enum stk_service_state {
 	STK_NO_SERVICE =3D 	0x02
 };
 =

+/* For data object that only has a byte array with undetermined length */
+struct stk_common_byte_array {
+	unsigned char *array;
+	unsigned int len;
+};
+
 /* Defined in TS 102.223 Section 8.1 */
 struct stk_address {
 	unsigned char ton_npi;
-- =

1.6.3.3


--===============5290208542922213141==--

