Content-Type: multipart/mixed; boundary="===============1670024132425173513=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 22/27] stkutil: Add Set Up Call response builder.
Date: Sun, 16 May 2010 16:07:38 +0200
Message-ID: <1274018858-6968-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1670024132425173513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   33 +++++++++++++++++++++++++++++++++
 src/stkutil.h |    9 +++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index cf22361..4e813ec 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3129,6 +3129,20 @@ static gboolean build_dataobj_text(struct stk_tlv_bu=
ilder *tlv,
 	return stk_tlv_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.30 */
+static gboolean build_dataobj_cc_requested_action(struct stk_tlv_builder *=
tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_common_byte_array *action =3D data;
+
+	return action->array =3D=3D NULL ||
+		(stk_tlv_open_container(tlv, cr,
+			STK_DATA_OBJECT_TYPE_CALL_CONTROL_REQUESTED_ACTION,
+			FALSE) &&
+		 stk_tlv_append_bytes(tlv, action->array, action->len) &&
+		 stk_tlv_close_container(tlv));
+}
+
 static gboolean build_dataobj(struct stk_tlv_builder *tlv, gboolean
 				(*builder_func)(struct stk_tlv_builder *,
 						const void *, gboolean), ...)
@@ -3231,6 +3245,25 @@ unsigned int stk_pdu_from_response(const struct stk_=
response *response,
 					&response->select_item.item_id,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_SETUP_CALL:
+		if (response->set_up_call.modified_result.cc_modified)
+			ok =3D build_dataobj(&builder,
+					build_dataobj_cc_requested_action,
+					DATAOBJ_FLAG_CR,
+					&response->set_up_call.
+					 cc_requested_action,
+					build_dataobj_result, DATAOBJ_FLAG_CR,
+					&response->set_up_call.modified_result.
+					 result,
+					NULL);
+		else
+			ok =3D build_dataobj(&builder,
+					build_dataobj_cc_requested_action,
+					DATAOBJ_FLAG_CR,
+					&response->set_up_call.
+					 cc_requested_action,
+					NULL);
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 1810b8e..9674f8b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1022,6 +1022,14 @@ struct stk_response_select_item {
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
@@ -1040,6 +1048,7 @@ struct stk_response {
 		struct stk_response_generic set_up_menu;
 		struct stk_response_select_item select_item;
 		struct stk_response_generic send_sms;
+		struct stk_response_set_up_call set_up_call;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============1670024132425173513==--

