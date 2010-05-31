Content-Type: multipart/mixed; boundary="===============7084196689235077394=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/11] stkutil: Add the Call Control envelope builder
Date: Mon, 31 May 2010 14:47:23 +0200
Message-ID: <1275310044-27469-10-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275310044-27469-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7084196689235077394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  175 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/stkutil.h |   31 ++++++++++
 2 files changed, 204 insertions(+), 2 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index e5ea65a..b4466c7 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -321,8 +321,6 @@ static gboolean parse_dataobj_subaddress(struct compreh=
ension_tlv_iter *iter,
 	unsigned int len;
 =

 	len =3D comprehension_tlv_iter_get_length(iter);
-	if (len < 1)
-		return FALSE;
 =

 	if (len > sizeof(subaddr->subaddr))
 		return FALSE;
@@ -331,6 +329,8 @@ static gboolean parse_dataobj_subaddress(struct compreh=
ension_tlv_iter *iter,
 	subaddr->len =3D len;
 	memcpy(subaddr->subaddr, data, len);
 =

+	subaddr->has_subaddr =3D TRUE;
+
 	return TRUE;
 }
 =

@@ -3331,6 +3331,9 @@ static gboolean build_dataobj_address(struct stk_tlv_=
builder *tlv,
 	unsigned int len =3D (strlen(addr->number) + 1) / 2;
 	unsigned char number[len];
 =

+	if (addr->number =3D=3D NULL)
+		return TRUE;
+
 	sim_encode_bcd_number(addr->number, number);
 =

 	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
@@ -3339,6 +3342,61 @@ static gboolean build_dataobj_address(struct stk_tlv=
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
+	if (sa->has_subaddr !=3D TRUE)
+		return FALSE;
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
@@ -3414,6 +3472,26 @@ static gboolean build_dataobj_gsm_sms_tpdu(struct st=
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
+	unsigned int len =3D (strlen(addr->number) + 1) / 2;
+	unsigned char number[len];
+
+	if (addr->number =3D=3D NULL)
+		return TRUE;
+
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
@@ -3451,6 +3529,22 @@ static gboolean build_dataobj_text(struct stk_tlv_bu=
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
@@ -3698,6 +3792,19 @@ static gboolean build_dataobj_at_response(struct stk=
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
+	return bcr->has_bc_repeat !=3D TRUE ||
+		(stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		 stk_tlv_builder_append_byte(tlv, bcr->value) &&
+		 stk_tlv_builder_close_container(tlv));
+}
+
 /* Described in TS 102.223 Section 8.45 */
 static gboolean build_dataobj_language(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -3773,6 +3880,23 @@ static gboolean build_dataobj_esn(struct stk_tlv_bui=
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
@@ -3861,6 +3985,23 @@ static gboolean build_dataobj_broadcast_network_info=
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
@@ -4222,6 +4363,36 @@ ofono_bool_t stk_pdu_from_envelope(const struct stk_=
envelope *envelope,
 					&envelope->menu_selection.help_request,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_CALL_CONTROL:
+		ok =3D build_dataobj(&builder,
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
 		return FALSE;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 0e00b7e..382f7ff 100644
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
+	gboolean has_subaddr;
 	unsigned char len;
 	unsigned char subaddr[23];
 };
@@ -1187,6 +1189,34 @@ struct stk_envelope_menu_selection {
 	gboolean help_request;
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
+		gboolean has_bc_repeat;
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


--===============7084196689235077394==--

