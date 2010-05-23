Content-Type: multipart/mixed; boundary="===============3228120344779713903=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/16] stkutil: Add the Timer Management response builder.
Date: Sun, 23 May 2010 12:15:12 +0200
Message-ID: <1274609712-6570-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3228120344779713903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   41 +++++++++++++++++++++++++++++++++++++++++
 src/stkutil.h |    7 +++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 406f5d2..8dfea49 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -933,6 +933,7 @@ static gboolean parse_dataobj_timer_value(struct compre=
hension_tlv_iter *iter,
 	tv->hour =3D sms_decode_semi_octet(data[0]);
 	tv->minute =3D sms_decode_semi_octet(data[1]);
 	tv->second =3D sms_decode_semi_octet(data[2]);
+	tv->has_value =3D TRUE;
 =

 	return TRUE;
 }
@@ -3255,6 +3256,36 @@ static gboolean build_dataobj_cc_requested_action(st=
ruct stk_tlv_builder *tlv,
 		 stk_tlv_close_container(tlv));
 }
 =

+/* Described in TS 102.223 Section 8.37 */
+static gboolean build_dataobj_timer_id(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const unsigned char *id =3D data;
+
+	return *id =3D=3D 0 ||
+		(stk_tlv_open_container(tlv, cr,
+				STK_DATA_OBJECT_TYPE_TIMER_ID, FALSE) &&
+		 stk_tlv_append_byte(tlv, *id) &&
+		 stk_tlv_close_container(tlv));
+}
+
+/* Described in TS 102.223 Section 8.38 */
+static gboolean build_dataobj_timer_value(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_timer_value *value =3D data;
+
+	return value->has_value =3D=3D FALSE ||
+		(stk_tlv_open_container(tlv, cr,
+				STK_DATA_OBJECT_TYPE_TIMER_VALUE, FALSE) &&
+#define TO_BCD(bin) ((((bin) / 10) & 0xf) | (((bin) % 10) << 4))
+		 stk_tlv_append_byte(tlv, TO_BCD(value->hour)) &&
+		 stk_tlv_append_byte(tlv, TO_BCD(value->minute)) &&
+		 stk_tlv_append_byte(tlv, TO_BCD(value->second)) &&
+#undef TO_BCD
+		 stk_tlv_close_container(tlv));
+}
+
 /* Described in TS 102.223 Section 8.39 */
 static gboolean build_dataobj_datetime_timezone(struct stk_tlv_builder *tl=
v,
 						const void *data, gboolean cr)
@@ -3703,6 +3734,16 @@ unsigned int stk_pdu_from_response(const struct stk_=
response *response,
 		break;
 	case STK_COMMAND_TYPE_SETUP_EVENT_LIST:
 		break;
+	case STK_COMMAND_TYPE_TIMER_MANAGEMENT:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_timer_id,
+					DATAOBJ_FLAG_CR,
+					&response->timer_mgmt.id,
+					build_dataobj_timer_value,
+					DATAOBJ_FLAG_CR,
+					&response->timer_mgmt.value,
+					NULL);
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 566ae79..2288216 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -643,6 +643,7 @@ struct stk_r_apdu {
 =

 /* Defined in TS 102.223 Section 8.38 */
 struct stk_timer_value {
+	ofono_bool_t has_value;
 	unsigned char hour;
 	unsigned char minute;
 	unsigned char second;
@@ -1082,6 +1083,11 @@ struct stk_response_local_info {
 	};
 };
 =

+struct stk_response_timer_mgmt {
+	unsigned char id;
+	struct stk_timer_value value;
+};
+
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1104,6 +1110,7 @@ struct stk_response {
 		struct stk_response_generic polling_off;
 		struct stk_response_local_info provide_local_info;
 		struct stk_response_generic set_up_event_list;
+		struct stk_response_timer_mgmt timer_mgmt;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============3228120344779713903==--

