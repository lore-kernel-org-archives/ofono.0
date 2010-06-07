Content-Type: multipart/mixed; boundary="===============6282450656045975031=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 12/20] stkutil: Add the Call Control envelope builder
Date: Mon, 07 Jun 2010 12:08:34 +0200
Message-ID: <1275905322-14768-12-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6282450656045975031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  178 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/stkutil.h |   31 ++++++++++
 2 files changed, 207 insertions(+), 2 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 83ff5c7..b9a152a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -319,8 +319,6 @@ static gboolean parse_dataobj_subaddress(struct compreh=
ension_tlv_iter *iter,
 	unsigned int len;
 =

 	len =3D comprehension_tlv_iter_get_length(iter);
-	if (len < 1)
-		return FALSE;
 =

 	if (len > sizeof(subaddr->subaddr))
 		return FALSE;
@@ -329,6 +327,8 @@ static gboolean parse_dataobj_subaddress(struct compreh=
ension_tlv_iter *iter,
 	subaddr->len =3D len;
 	memcpy(subaddr->subaddr, data, len);
 =

+	subaddr->has_subaddr =3D TRUE;
+
 	return TRUE;
 }
 =

@@ -3357,6 +3357,61 @@ static gboolean build_dataobj_address(struct stk_tlv=
_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.2 */
+static gboolean build_dataobj_alpha_id(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_ALPHA_ID;
+	int len;
+	unsigned char *string;
+
+	if (data =3D=3D NULL)
+		return TRUE;
+
+	if (strlen(data) =3D=3D 0)
+		return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+			stk_tlv_builder_close_container(tlv);
+
+	string =3D utf8_to_sim_string(data, -1, &len);
+	if (string =3D=3D NULL)
+		return FALSE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_bytes(tlv, string, len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.3 */
+static gboolean build_dataobj_subaddress(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_subaddress *sa =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_SUBADDRESS;
+
+	if (sa->has_subaddr =3D=3D FALSE)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, sa->subaddr, sa->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 131.111 Section 8.4 */
+static gboolean build_dataobj_ccp(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_ccp *ccp =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CCP;
+
+	if (ccp->len =3D=3D 0)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, ccp->len) &&
+		stk_tlv_builder_append_bytes(tlv, ccp->ccp, ccp->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 131.111 Section 8.5 */
 static gboolean build_dataobj_cbs_page(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -3447,6 +3502,27 @@ static gboolean build_dataobj_gsm_sms_tpdu(struct st=
k_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.14 */
+static gboolean build_dataobj_ss_string(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_address *addr =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_SS_STRING;
+	unsigned int len;
+	unsigned char number[128];
+
+	if (addr->number =3D=3D NULL)
+		return TRUE;
+
+	len =3D (strlen(addr->number) + 1) / 2;
+	sim_encode_bcd_number(addr->number, number);
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, addr->ton_npi) &&
+		stk_tlv_builder_append_bytes(tlv, number, len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Defined in TS 102.223 Section 8.15 */
 static gboolean build_dataobj_text(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -3484,6 +3560,22 @@ static gboolean build_dataobj_text(struct stk_tlv_bu=
ilder *tlv,
 	return stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.17 */
+static gboolean build_dataobj_ussd_string(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_ussd_string *ussd =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_USSD_STRING;
+
+	if (ussd->string =3D=3D NULL)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, ussd->dcs) &&
+		stk_tlv_builder_append_bytes(tlv, ussd->string, ussd->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.19 */
 static gboolean build_dataobj_location_info(struct stk_tlv_builder *tlv,
 						const void *data, gboolean cr)
@@ -3731,6 +3823,21 @@ static gboolean build_dataobj_at_response(struct stk=
_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.42 */
+static gboolean build_dataobj_bc_repeat(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_BC_REPEAT_INDICATOR;
+	const struct stk_bc_repeat *bcr =3D data;
+
+	if (bcr->has_bc_repeat =3D=3D FALSE)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_byte(tlv, bcr->value) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.45 */
 static gboolean build_dataobj_language(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -3806,6 +3913,23 @@ static gboolean build_dataobj_esn(struct stk_tlv_bui=
lder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.72, 3GPP 24.008 Section 9.5.7 */
+static gboolean build_dataobj_pdp_context_params(struct stk_tlv_builder *t=
lv,
+						const void *data, gboolean cr)
+{
+	const struct stk_common_byte_array *params =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_PDP_ACTIVATION_PARAMETER;
+
+	if (params->len < 1)
+		return TRUE;
+	if (params->len > 0x7f)
+		return FALSE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, params->array, params->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.74
  *
  * See format note in parse_dataobj_imeisv.
@@ -3894,6 +4018,23 @@ static gboolean build_dataobj_broadcast_network_info=
rmation(
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.98, 3GPP 24.301 Section 6.5.1 */
+static gboolean build_dataobj_eps_pdn_conn_params(struct stk_tlv_builder *=
tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_common_byte_array *params =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_EPS_PDN_CONN_ACTIVATION_REQ;
+
+	if (params->len < 1)
+		return TRUE;
+	if (params->len > 0x7f)
+		return FALSE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, params->array, params->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 static gboolean build_dataobj(struct stk_tlv_builder *tlv,
 				dataobj_writer builder_func, ...)
 {
@@ -4267,6 +4408,39 @@ const unsigned char *stk_pdu_from_envelope(const str=
uct stk_envelope *envelope,
 					&envelope->menu_selection.help_request,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_CALL_CONTROL:
+		ok =3D build_dataobj(&builder,
+					build_envelope_dataobj_device_ids,
+					DATAOBJ_FLAG_CR,
+					envelope,
+					build_dataobj_address, DATAOBJ_FLAG_CR,
+					&envelope->call_control.address,
+					build_dataobj_ss_string,
+					DATAOBJ_FLAG_CR,
+					&envelope->call_control.ss_string,
+					build_dataobj_ussd_string,
+					DATAOBJ_FLAG_CR,
+					&envelope->call_control.ussd_string,
+					build_dataobj_pdp_context_params,
+					DATAOBJ_FLAG_CR,
+					&envelope->call_control.pdp_ctx_params,
+					build_dataobj_eps_pdn_conn_params,
+					DATAOBJ_FLAG_CR,
+					&envelope->call_control.eps_pdn_params,
+					build_dataobj_ccp, 0,
+					&envelope->call_control.ccp1,
+					build_dataobj_subaddress, 0,
+					&envelope->call_control.subaddress,
+					build_dataobj_location_info, 0,
+					&envelope->call_control.location,
+					build_dataobj_ccp, 0,
+					&envelope->call_control.ccp2,
+					build_dataobj_alpha_id, 0,
+					envelope->call_control.alpha_id,
+					build_dataobj_bc_repeat, 0,
+					&envelope->call_control.bc_repeat,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index d4b5b23..33a0f91 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -178,6 +178,7 @@ enum stk_data_object_type {
 	STK_DATA_OBJECT_TYPE_PLMN_LIST =3D			0x79,
 	STK_DATA_OBJECT_TYPE_BROADCAST_NETWORK_INFO =3D		0x7A,
 	STK_DATA_OBJECT_TYPE_ACTIVATE_DESCRIPTOR =3D		0x7B,
+	STK_DATA_OBJECT_TYPE_EPS_PDN_CONN_ACTIVATION_REQ =3D	0x7C,
 };
 =

 enum stk_device_identity_type {
@@ -474,6 +475,7 @@ struct stk_address {
  * bytes."
  */
 struct stk_subaddress {
+	ofono_bool_t has_subaddr;
 	unsigned char len;
 	unsigned char subaddr[23];
 };
@@ -1187,6 +1189,34 @@ struct stk_envelope_menu_selection {
 	ofono_bool_t help_request;
 };
 =

+/* Used both in the ENVELOPE message to UICC and response from UICC */
+struct stk_envelope_call_control {
+	/* Exactly one of the following 5 fields must be present */
+	struct stk_address address;
+	struct stk_address ss_string;
+	struct stk_ussd_string {
+		unsigned char dcs;
+		const unsigned char *string;
+		int len;
+	} ussd_string;
+	struct stk_common_byte_array pdp_ctx_params;
+	struct stk_common_byte_array eps_pdn_params;
+	/* At least one of the following two fields must be present in a
+	 * response indicating modification of the call.
+	 * In an EVELOPE message, only allowed for a call setup. */
+	struct stk_ccp ccp1;
+	struct stk_subaddress subaddress;
+	struct stk_location_info location;
+	/* Only allowed when ccp1 is present */
+	struct stk_ccp ccp2;
+	char *alpha_id;
+	/* Only allowed when both ccp1 and ccp2 are present */
+	struct stk_bc_repeat {
+		ofono_bool_t has_bc_repeat;
+		unsigned char value;
+	} bc_repeat;
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1195,6 +1225,7 @@ struct stk_envelope {
 		struct stk_envelope_sms_pp_download sms_pp_download;
 		struct stk_envelope_cbs_pp_download cbs_pp_download;
 		struct stk_envelope_menu_selection menu_selection;
+		struct stk_envelope_call_control call_control;
 	};
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============6282450656045975031==--

