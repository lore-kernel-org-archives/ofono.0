Content-Type: multipart/mixed; boundary="===============7386410315582234151=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/20] stkutil: Add Set Up Call response builder
Date: Thu, 27 May 2010 06:59:40 +0200
Message-ID: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7386410315582234151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   37 +++++++++++++++++++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2ca5c6a..c9b9511 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3383,6 +3383,20 @@ static gboolean build_dataobj_text(struct stk_tlv_bu=
ilder *tlv,
 	return stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.30 */
+static gboolean build_dataobj_cc_requested_action(struct stk_tlv_builder *=
tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_common_byte_array *action =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CALL_CONTROL_REQUESTED_ACTION;
+
+	return action->array =3D=3D NULL ||
+		(stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		 stk_tlv_builder_append_bytes(tlv,
+						action->array, action->len) &&
+		 stk_tlv_builder_close_container(tlv));
+}
+
 static gboolean build_dataobj(struct stk_tlv_builder *tlv,
 				dataobj_writer builder_func, ...)
 {
@@ -3404,6 +3418,26 @@ static gboolean build_dataobj(struct stk_tlv_builder=
 *tlv,
 	return TRUE;
 }
 =

+static gboolean build_set_up_call(struct stk_tlv_builder *builder,
+					const struct stk_response *response)
+{
+	if (response->set_up_call.modified_result.cc_modified)
+		return build_dataobj(builder,
+				build_dataobj_cc_requested_action,
+				DATAOBJ_FLAG_CR,
+				&response->set_up_call.cc_requested_action,
+				build_dataobj_result,
+				DATAOBJ_FLAG_CR,
+				&response->set_up_call.modified_result.result,
+				NULL);
+	else
+		return build_dataobj(builder,
+				build_dataobj_cc_requested_action,
+				DATAOBJ_FLAG_CR,
+				&response->set_up_call.cc_requested_action,
+				NULL);
+}
+
 unsigned int stk_pdu_from_response(const struct stk_response *response,
 					unsigned char *pdu, unsigned int size)
 {
@@ -3495,6 +3529,9 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					&response->select_item.item_id,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_SETUP_CALL:
+		ok =3D build_set_up_call(&builder, response);
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index b04078f..3245a90 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1069,6 +1069,14 @@ struct stk_response_select_item {
 	unsigned char item_id;
 };
 =

+struct stk_response_set_up_call {
+	struct stk_common_byte_array cc_requested_action;
+	struct {
+		ofono_bool_t cc_modified;
+		struct stk_result result;
+	} modified_result;
+};
+
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1087,6 +1095,7 @@ struct stk_response {
 		struct stk_response_generic set_up_menu;
 		struct stk_response_select_item select_item;
 		struct stk_response_generic send_sms;
+		struct stk_response_set_up_call set_up_call;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============7386410315582234151==--

