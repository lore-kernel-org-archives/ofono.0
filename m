Content-Type: multipart/mixed; boundary="===============5984286933241532913=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/15] stkutil: Add the Call Control envelope builder
Date: Fri, 11 Jun 2010 12:39:46 +0200
Message-ID: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5984286933241532913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  195 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   47 ++++++++++++++
 2 files changed, 242 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 8ac1dba..da7cd78 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -329,6 +329,8 @@ static gboolean parse_dataobj_subaddress(struct compreh=
ension_tlv_iter *iter,
 	subaddr->len =3D len;
 	memcpy(subaddr->subaddr, data, len);
 =

+	subaddr->has_subaddr =3D TRUE;
+
 	return TRUE;
 }
 =

@@ -3357,6 +3359,61 @@ static gboolean build_dataobj_address(struct stk_tlv=
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
@@ -3447,6 +3504,27 @@ static gboolean build_dataobj_gsm_sms_tpdu(struct st=
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
@@ -3484,6 +3562,22 @@ static gboolean build_dataobj_text(struct stk_tlv_bu=
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
@@ -3734,6 +3828,21 @@ static gboolean build_dataobj_at_response(struct stk=
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
@@ -3809,6 +3918,23 @@ static gboolean build_dataobj_esn(struct stk_tlv_bui=
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
@@ -3897,6 +4023,23 @@ static gboolean build_dataobj_broadcast_network_info=
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
@@ -4231,6 +4374,55 @@ static gboolean build_envelope_dataobj_device_ids(st=
ruct stk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+static gboolean build_envelope_call_control(
+					struct stk_tlv_builder *builder,
+					const struct stk_envelope *envelope)
+{
+	const struct stk_envelope_call_control *cc =3D &envelope->call_control;
+	gboolean ok =3D FALSE;
+
+	if (build_dataobj(builder, build_envelope_dataobj_device_ids,
+				DATAOBJ_FLAG_CR, envelope, NULL) !=3D TRUE)
+		return FALSE;
+
+	switch (cc->type) {
+	case STK_CC_TYPE_CALL_SETUP:
+		ok =3D build_dataobj(builder, build_dataobj_address,
+					DATAOBJ_FLAG_CR, &cc->address, NULL);
+		break;
+	case STK_CC_TYPE_SUPPLEMENTARY_SERVICE:
+		ok =3D build_dataobj(builder, build_dataobj_ss_string,
+					DATAOBJ_FLAG_CR, &cc->ss_string, NULL);
+		break;
+	case STK_CC_TYPE_USSD_OP:
+		ok =3D build_dataobj(builder, build_dataobj_ussd_string,
+					DATAOBJ_FLAG_CR, &cc->ussd_string,
+					NULL);
+		break;
+	case STK_CC_TYPE_PDP_CTX_ACTIVATION:
+		ok =3D build_dataobj(builder, build_dataobj_pdp_context_params,
+					DATAOBJ_FLAG_CR, &cc->pdp_ctx_params,
+					NULL);
+		break;
+	case STK_CC_TYPE_EPS_PDN_CONNECTION_ACTIVATION:
+		ok =3D build_dataobj(builder, build_dataobj_eps_pdn_conn_params,
+					DATAOBJ_FLAG_CR, &cc->eps_pdn_params,
+					NULL);
+		break;
+	}
+	if (ok !=3D TRUE)
+		return FALSE;
+
+	return build_dataobj(builder,
+				build_dataobj_ccp, 0, &cc->ccp1,
+				build_dataobj_subaddress, 0, &cc->subaddress,
+				build_dataobj_location_info, 0, &cc->location,
+				build_dataobj_ccp, 0, &cc->ccp2,
+				build_dataobj_alpha_id, 0, cc->alpha_id,
+				build_dataobj_bc_repeat, 0, &cc->bc_repeat,
+				NULL);
+}
+
 const unsigned char *stk_pdu_from_envelope(const struct stk_envelope *enve=
lope,
 						unsigned int *out_length)
 {
@@ -4280,6 +4472,9 @@ const unsigned char *stk_pdu_from_envelope(const stru=
ct stk_envelope *envelope,
 					&envelope->menu_selection.help_request,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_CALL_CONTROL:
+		ok =3D build_envelope_call_control(&builder, envelope);
+		break;
 	case STK_ENVELOPE_TYPE_MO_SMS_CONTROL:
 		/*
 		 * Comprehension Required according to the specs but not
diff --git a/src/stkutil.h b/src/stkutil.h
index 2da787d..86c0e20 100644
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
@@ -525,6 +527,13 @@ struct stk_result {
 	unsigned char *additional;
 };
 =

+/* Defined in TS 131.111 Section 8.17.  Length limit of 160 chars in 23.02=
8 */
+struct stk_ussd_string {
+	unsigned char dcs;
+	unsigned char string[160];
+	int len;
+};
+
 /* Define the struct of single file in TS102.223 Section 8.18.
  * According to TS 11.11 Section 6.2, each file id has two bytes, and the
  * maximum Dedicated File level is 2. So the maximum size of file is 8, wh=
ich
@@ -649,6 +658,12 @@ struct stk_timer_value {
 	unsigned char second;
 };
 =

+/* Defined in TS 102.223 Section 8.42 */
+struct stk_bc_repeat {
+	ofono_bool_t has_bc_repeat;
+	unsigned char value;
+};
+
 /*
  * According to 102.223 Section 8.52 the length of CTLV is 1 byte. This me=
ans
  * that the maximum size is 127 according to the rules of CTLVs. This size=
 also
@@ -1193,6 +1208,37 @@ struct stk_envelope_sms_mo_control {
 	struct stk_location_info location;
 };
 =

+enum stk_call_control_type {
+	STK_CC_TYPE_CALL_SETUP,
+	STK_CC_TYPE_SUPPLEMENTARY_SERVICE,
+	STK_CC_TYPE_USSD_OP,
+	STK_CC_TYPE_PDP_CTX_ACTIVATION,
+	STK_CC_TYPE_EPS_PDN_CONNECTION_ACTIVATION,
+};
+
+/* Used both in the ENVELOPE message to UICC and response from UICC */
+struct stk_envelope_call_control {
+	enum stk_call_control_type type;
+	union {
+		struct stk_address address;
+		struct stk_address ss_string;
+		struct stk_ussd_string ussd_string;
+		struct stk_common_byte_array pdp_ctx_params;
+		struct stk_common_byte_array eps_pdn_params;
+	};
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
+	struct stk_bc_repeat bc_repeat;
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1201,6 +1247,7 @@ struct stk_envelope {
 		struct stk_envelope_sms_pp_download sms_pp_download;
 		struct stk_envelope_cbs_pp_download cbs_pp_download;
 		struct stk_envelope_menu_selection menu_selection;
+		struct stk_envelope_call_control call_control;
 		struct stk_envelope_sms_mo_control sms_mo_control;
 	};
 };
-- =

1.7.1.86.g0e460.dirty


--===============5984286933241532913==--

