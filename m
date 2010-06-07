Content-Type: multipart/mixed; boundary="===============1912026563647158241=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 17/20] stkutil: Add the Event Download envelope builder
Date: Mon, 07 Jun 2010 12:08:39 +0200
Message-ID: <1275905322-14768-17-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1912026563647158241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  556 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/stkutil.h |  196 ++++++++++++++++++++-
 2 files changed, 746 insertions(+), 6 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index f8e7568..26af066 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1208,8 +1208,10 @@ static gboolean parse_dataobj_other_address(
 	const unsigned char *data;
 	unsigned char len =3D comprehension_tlv_iter_get_length(iter);
 =

-	if (len =3D=3D 0)
+	if (len =3D=3D 0) {
+		oa->type =3D STK_ADDRESS_AUTO;
 		return TRUE;
+	}
 =

 	if ((len !=3D 5) && (len !=3D 17))
 		return FALSE;
@@ -1434,6 +1436,7 @@ static gboolean parse_dataobj_remote_entity_address(
 		return FALSE;
 	}
 =

+	rea->has_address =3D TRUE;
 	rea->coding_type =3D data[0];
 	memcpy(&rea->addr, data + 1, len - 1);
 =

@@ -1623,6 +1626,7 @@ static gboolean parse_dataobj_frames_info(struct comp=
rehension_tlv_iter *iter,
 	struct stk_frames_info *fi =3D user;
 	const unsigned char *data;
 	unsigned char len =3D comprehension_tlv_iter_get_length(iter);
+	unsigned int i;
 =

 	if (len < 1)
 		return FALSE;
@@ -1635,12 +1639,18 @@ static gboolean parse_dataobj_frames_info(struct co=
mprehension_tlv_iter *iter,
 	if ((len =3D=3D 1 && data[0] !=3D 0) || (len > 1 && data[0] =3D=3D 0))
 		return FALSE;
 =

+	if (len % 2 =3D=3D 0)
+		return FALSE;
+
 	if (len =3D=3D 1)
 		return TRUE;
 =

 	fi->id =3D data[0];
-	fi->len =3D len - 1;
-	memcpy(fi->list, data + 1, fi->len);
+	fi->len =3D (len - 1) / 2;
+	for (i =3D 0; i < len; i++) {
+		fi->list[i].height =3D data[i * 2 + 1] & 0x1f;
+		fi->list[i].width =3D data[i * 2 + 2] & 0x7f;
+	}
 =

 	return TRUE;
 }
@@ -3688,6 +3698,81 @@ static gboolean build_dataobj_network_measurement_re=
sults(
 	return stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.25 */
+static gboolean build_dataobj_event_list(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_event_list *list =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_EVENT_LIST;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, list->list, list->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Shortcut for a single Event type */
+static gboolean build_dataobj_event_type(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_event_list list =3D {
+		.list =3D { *(unsigned char *) data },
+		.len =3D 1,
+	};
+
+	return build_dataobj_event_list(tlv, &list, cr);
+}
+
+/* Described in TS 102.223 Section 8.26 */
+static gboolean build_dataobj_cause(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_cause *cause =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CAUSE;
+
+	if (cause->has_cause =3D=3D FALSE)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, cause->cause, cause->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.27 */
+static gboolean build_dataobj_location_status(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const enum stk_service_state *state =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_LOCATION_STATUS;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, *state) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 131.111 Section 8.28 */
+static gboolean build_dataobj_transaction_ids(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_transaction_id *id =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_TRANSACTION_ID;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, id->list, id->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Shortcut for a single Transaction ID */
+static gboolean build_dataobj_transaction_id(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_transaction_id ids =3D {
+		.list =3D { *(unsigned char *) data },
+		.len =3D 1,
+	};
+
+	return build_dataobj_transaction_ids(tlv, &ids, cr);
+}
+
 /* Described in 3GPP 31.111 Section 8.29 */
 static gboolean build_dataobj_bcch_channel_list(struct stk_tlv_builder *tl=
v,
 						const void *data, gboolean cr)
@@ -3739,6 +3824,26 @@ static gboolean build_dataobj_cc_requested_action(st=
ruct stk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.33 */
+static gboolean build_dataobj_card_reader_status(struct stk_tlv_builder *t=
lv,
+						const void *data, gboolean cr)
+{
+	const struct stk_reader_status *status =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CARD_READER_STATUS;
+	unsigned char byte;
+
+	byte =3D status->id |
+		(status->removable << 3) |
+		(status->present << 4) |
+		(status->id1_size << 5) |
+		(status->card_present << 6) |
+		(status->card_powered << 7);
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, byte) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.37 */
 static gboolean build_dataobj_timer_id(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -3873,6 +3978,112 @@ static gboolean build_dataobj_timing_advance(struct=
 stk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.51 */
+static gboolean build_dataobj_browser_termination_cause(
+						struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const enum stk_browser_termination_cause *cause =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_BROWSER_TERMINATION_CAUSE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, *cause) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.52 */
+static gboolean build_dataobj_bearer_description(struct stk_tlv_builder *t=
lv,
+						const void *data, gboolean cr)
+{
+	const struct stk_bearer_description *bd =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_BEARER_DESCRIPTION;
+
+	if (bd->type =3D=3D 0x00)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, bd->type) &&
+		stk_tlv_builder_append_bytes(tlv, bd->pars, bd->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.54 */
+static gboolean build_dataobj_channel_data_length(
+						struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const unsigned int *length =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CHANNEL_DATA_LENGTH;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, MIN(*length, 255)) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.56 */
+static gboolean build_dataobj_channel_status(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CHANNEL_STATUS;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, data, 2) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.58 */
+static gboolean build_dataobj_other_address(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_other_address *addr =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_OTHER_ADDRESS;
+	gboolean ok =3D FALSE;
+
+	if (!addr->type)
+		return TRUE;
+
+	if (stk_tlv_builder_open_container(tlv, cr, tag, FALSE) =3D=3D FALSE)
+		return FALSE;
+
+	switch (addr->type) {
+	case STK_ADDRESS_AUTO:
+		ok =3D TRUE;
+		break;
+	case STK_ADDRESS_IPV4:
+		ok =3D
+			stk_tlv_builder_append_byte(tlv, addr->type) &&
+			stk_tlv_builder_append_bytes(tlv,
+					(const guint8 *) &addr->addr.ipv4, 4);
+		break;
+	case STK_ADDRESS_IPV6:
+		ok =3D
+			stk_tlv_builder_append_byte(tlv, addr->type) &&
+			stk_tlv_builder_append_bytes(tlv, addr->addr.ipv6, 16);
+		break;
+	}
+
+	if (!ok)
+		return FALSE;
+
+	return stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.59 */
+static gboolean build_dataobj_uicc_te_interface(struct stk_tlv_builder *tl=
v,
+						const void *data, gboolean cr)
+{
+	const struct stk_uicc_te_interface *iface =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_UICC_TE_INTERFACE;
+
+	if (iface->protocol =3D=3D 0 && iface->port =3D=3D 0)
+		return TRUE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, iface->protocol) &&
+		stk_tlv_builder_append_short(tlv, iface->port) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.61 */
 static gboolean build_dataobj_access_technologies(struct stk_tlv_builder *=
tlv,
 						const void *data, gboolean cr)
@@ -3903,6 +4114,66 @@ static gboolean build_dataobj_access_technology(stru=
ct stk_tlv_builder *tlv,
 	return build_dataobj_access_technologies(tlv, &techs, cr);
 }
 =

+/* Described in TS 102.223 Section 8.62 */
+static gboolean build_dataobj_display_parameters(struct stk_tlv_builder *t=
lv,
+						const void *data, gboolean cr)
+{
+	const struct stk_display_parameters *params =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_DISPLAY_PARAMETERS;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, params->height) &&
+		stk_tlv_builder_append_byte(tlv, params->width) &&
+		stk_tlv_builder_append_byte(tlv, params->effects) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.63 */
+static gboolean build_dataobj_service_record(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_service_record *rec =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_SERVICE_RECORD;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_byte(tlv, rec->tech_id) &&
+		stk_tlv_builder_append_byte(tlv, rec->serv_id) &&
+		stk_tlv_builder_append_bytes(tlv, rec->serv_rec, rec->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.68 */
+static gboolean build_dataobj_remote_entity_address(struct stk_tlv_builder=
 *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_remote_entity_address *addr =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_REMOTE_ENTITY_ADDRESS;
+	gboolean ok =3D FALSE;
+
+	if (addr->has_address !=3D TRUE)
+		return TRUE;
+
+	if (stk_tlv_builder_open_container(tlv, cr, tag, TRUE) !=3D TRUE)
+		return FALSE;
+
+	if (stk_tlv_builder_append_byte(tlv, addr->coding_type) !=3D TRUE)
+		return FALSE;
+
+	switch (addr->coding_type) {
+	case 0x00:
+		ok =3D stk_tlv_builder_append_bytes(tlv, addr->addr.ieee802, 6);
+		break;
+	case 0x01:
+		ok =3D stk_tlv_builder_append_bytes(tlv, addr->addr.irda, 4);
+		break;
+	}
+
+	if (!ok)
+		return FALSE;
+
+	return stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.69 */
 static gboolean build_dataobj_esn(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -3986,6 +4257,44 @@ static gboolean build_dataobj_battery_state(struct s=
tk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.77 */
+static gboolean build_dataobj_browsing_status(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_common_byte_array *bs =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_BROWSING_STATUS;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_bytes(tlv, bs->array, bs->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.79 */
+static gboolean build_dataobj_frames_information(struct stk_tlv_builder *t=
lv,
+						const void *data, gboolean cr)
+{
+	const struct stk_frames_info *info =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_FRAMES_INFO;
+	unsigned int i;
+
+	if (stk_tlv_builder_open_container(tlv, cr, tag, FALSE) !=3D TRUE)
+		return FALSE;
+
+	if (stk_tlv_builder_append_byte(tlv, info->id) !=3D TRUE)
+		return FALSE;
+
+	for (i =3D 0; i < info->len; i++) {
+		if (stk_tlv_builder_append_byte(tlv,
+						info->list[i].height) !=3D TRUE)
+			return FALSE;
+		if (stk_tlv_builder_append_byte(tlv,
+						info->list[i].width) !=3D TRUE)
+			return FALSE;
+	}
+
+	return stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.81 */
 static gboolean build_dataobj_meid(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -4007,6 +4316,18 @@ static gboolean build_dataobj_meid(struct stk_tlv_bu=
ilder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.84 */
+static gboolean build_dataobj_i_wlan_access_status(struct stk_tlv_builder =
*tlv,
+						const void *data, gboolean cr)
+{
+	const enum stk_i_wlan_access_status *status =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_I_WLAN_ACCESS_STATUS;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, *status) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.90 */
 static gboolean build_dataobj_broadcast_network_information(
 						struct stk_tlv_builder *tlv,
@@ -4021,6 +4342,50 @@ static gboolean build_dataobj_broadcast_network_info=
rmation(
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.91 / 3GPP 24.008 Section 10.5.5.15 */
+static gboolean build_dataobj_routing_area_id(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_routing_area_info *rai =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_ROUTING_AREA_INFO;
+	guint8 mccmnc[3];
+
+	if (rai->mcc[0] =3D=3D 0)
+		return TRUE;
+
+	sim_encode_mcc_mnc(mccmnc, rai->mcc, rai->mnc);
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, mccmnc, 3) &&
+		stk_tlv_builder_append_short(tlv, rai->lac) &&
+		stk_tlv_builder_append_byte(tlv, rai->rac) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 131.111 Section 8.92 */
+static gboolean build_dataobj_update_attach_type(struct stk_tlv_builder *t=
lv,
+						const void *data, gboolean cr)
+{
+	const enum stk_update_attach_type *type =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_UPDATE_ATTACH_TYPE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, *type) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 131.111 Section 8.93 */
+static gboolean build_dataobj_rejection_cause_code(struct stk_tlv_builder =
*tlv,
+						const void *data, gboolean cr)
+{
+	const enum stk_rejection_cause_code *cause =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_REJECTION_CAUSE_CODE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, *cause) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 131.111 Section 8.98, 3GPP 24.301 Section 6.5.1 */
 static gboolean build_dataobj_eps_pdn_conn_params(struct stk_tlv_builder *=
tlv,
 						const void *data, gboolean cr)
@@ -4038,6 +4403,25 @@ static gboolean build_dataobj_eps_pdn_conn_params(st=
ruct stk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.99 / 3GPP 24.301 Section 9.9.3.32 */
+static gboolean build_dataobj_tracking_area_id(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_tracking_area_id *tai =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_TRACKING_AREA_ID;
+	guint8 mccmnc[3];
+
+	if (tai->mcc[0] =3D=3D 0)
+		return TRUE;
+
+	sim_encode_mcc_mnc(mccmnc, tai->mcc, tai->mnc);
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_bytes(tlv, mccmnc, 3) &&
+		stk_tlv_builder_append_short(tlv, tai->tac) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 static gboolean build_dataobj(struct stk_tlv_builder *tlv,
 				dataobj_writer builder_func, ...)
 {
@@ -4372,6 +4756,169 @@ static gboolean build_envelope_dataobj_device_ids(s=
truct stk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+static gboolean build_envelope_event_download(struct stk_tlv_builder *buil=
der,
+					const struct stk_envelope *envelope)
+{
+	const struct stk_envelope_event_download *evt =3D
+		&envelope->event_download;
+
+	if (build_dataobj(builder,
+				build_dataobj_event_type, DATAOBJ_FLAG_CR,
+				&evt->type,
+				build_envelope_dataobj_device_ids,
+				DATAOBJ_FLAG_CR,
+				envelope,
+				NULL) =3D=3D FALSE)
+		return FALSE;
+
+	switch (evt->type) {
+	case STK_EVENT_TYPE_MT_CALL:
+		return build_dataobj(builder,
+					build_dataobj_transaction_id,
+					DATAOBJ_FLAG_CR,
+					&evt->mt_call.transaction_id,
+					build_dataobj_address, 0,
+					&evt->mt_call.caller_address,
+					build_dataobj_subaddress, 0,
+					&evt->mt_call.caller_subaddress,
+					NULL);
+	case STK_EVENT_TYPE_CALL_CONNECTED:
+		return build_dataobj(builder,
+					build_dataobj_transaction_id,
+					DATAOBJ_FLAG_CR,
+					&evt->call_connected.transaction_id,
+					NULL);
+	case STK_EVENT_TYPE_CALL_DISCONNECTED:
+		return build_dataobj(builder,
+					build_dataobj_transaction_ids,
+					DATAOBJ_FLAG_CR,
+					&evt->call_disconnected.transaction_ids,
+					build_dataobj_cause, 0,
+					&evt->call_disconnected.cause,
+					NULL);
+	case STK_EVENT_TYPE_LOCATION_STATUS:
+		return build_dataobj(builder,
+					build_dataobj_location_status,
+					DATAOBJ_FLAG_CR,
+					&evt->location_status.state,
+					build_dataobj_location_info, 0,
+					&evt->location_status.info,
+					NULL);
+	case STK_EVENT_TYPE_USER_ACTIVITY:
+	case STK_EVENT_TYPE_IDLE_SCREEN_AVAILABLE:
+		return TRUE;
+	case STK_EVENT_TYPE_CARD_READER_STATUS:
+		return build_dataobj(builder,
+					build_dataobj_card_reader_status,
+					DATAOBJ_FLAG_CR,
+					&evt->card_reader_status,
+					NULL);
+	case STK_EVENT_TYPE_LANGUAGE_SELECTION:
+		return build_dataobj(builder,
+					build_dataobj_language, DATAOBJ_FLAG_CR,
+					evt->language_selection,
+					NULL);
+	case STK_EVENT_TYPE_BROWSER_TERMINATION:
+		return build_dataobj(builder,
+					build_dataobj_browser_termination_cause,
+					DATAOBJ_FLAG_CR,
+					&evt->browser_termination.cause,
+					NULL);
+	case STK_EVENT_TYPE_DATA_AVAILABLE:
+		return build_dataobj(builder,
+					build_dataobj_channel_status,
+					DATAOBJ_FLAG_CR,
+					&evt->data_available.channel_status,
+					build_dataobj_channel_data_length,
+					DATAOBJ_FLAG_CR,
+					&evt->data_available.channel_data_len,
+					NULL);
+	case STK_EVENT_TYPE_CHANNEL_STATUS:
+		return build_dataobj(builder,
+					build_dataobj_channel_status,
+					DATAOBJ_FLAG_CR,
+					&evt->channel_status.status,
+					build_dataobj_bearer_description,
+					DATAOBJ_FLAG_CR,
+					&evt->channel_status.bearer_desc,
+					build_dataobj_other_address,
+					DATAOBJ_FLAG_CR,
+					&evt->channel_status.address,
+					NULL);
+	case STK_EVENT_TYPE_SINGLE_ACCESS_TECHNOLOGY_CHANGE:
+		return build_dataobj(builder,
+					build_dataobj_access_technology,
+					DATAOBJ_FLAG_CR,
+					&evt->access_technology_change,
+					NULL);
+	case STK_EVENT_TYPE_DISPLAY_PARAMETERS_CHANGED:
+		return build_dataobj(builder,
+					build_dataobj_display_parameters,
+					DATAOBJ_FLAG_CR,
+					&evt->display_params_changed,
+					NULL);
+	case STK_EVENT_TYPE_LOCAL_CONNECTION:
+		return build_dataobj(builder,
+					build_dataobj_service_record,
+					DATAOBJ_FLAG_CR,
+					&evt->local_connection.service_record,
+					build_dataobj_remote_entity_address, 0,
+					&evt->local_connection.remote_addr,
+					build_dataobj_uicc_te_interface, 0,
+					&evt->local_connection.transport_level,
+					build_dataobj_other_address,
+					0,
+					&evt->local_connection.transport_addr,
+					NULL);
+	case STK_EVENT_TYPE_NETWORK_SEARCH_MODE_CHANGE:
+		return build_dataobj(builder,
+					build_dataobj_network_search_mode,
+					DATAOBJ_FLAG_CR,
+					&evt->network_search_mode_change,
+					NULL);
+	case STK_EVENT_TYPE_BROWSING_STATUS:
+		return build_dataobj(builder,
+					build_dataobj_browsing_status,
+					DATAOBJ_FLAG_CR,
+					&evt->browsing_status,
+					NULL);
+	case STK_EVENT_TYPE_FRAMES_INFORMATION_CHANGE:
+		return build_dataobj(builder,
+					build_dataobj_frames_information,
+					DATAOBJ_FLAG_CR,
+					&evt->frames_information_change,
+					NULL);
+	case STK_EVENT_TYPE_I_WLAN_ACCESS_STATUS:
+		return build_dataobj(builder,
+					build_dataobj_i_wlan_access_status,
+					DATAOBJ_FLAG_CR,
+					&evt->i_wlan_access_status,
+					NULL);
+	case STK_EVENT_TYPE_NETWORK_REJECTION:
+		return build_dataobj(builder,
+					build_dataobj_location_info, 0,
+					&evt->network_rejection.location,
+					build_dataobj_routing_area_id, 0,
+					&evt->network_rejection.rai,
+					build_dataobj_tracking_area_id, 0,
+					&evt->network_rejection.tai,
+					build_dataobj_access_technology,
+					DATAOBJ_FLAG_CR,
+					&evt->network_rejection.access_tech,
+					build_dataobj_update_attach_type,
+					DATAOBJ_FLAG_CR,
+					&evt->network_rejection.update_attach,
+					build_dataobj_rejection_cause_code,
+					DATAOBJ_FLAG_CR,
+					&evt->network_rejection.cause,
+					NULL);
+	case STK_EVENT_TYPE_HCI_CONNECTIVITY_EVENT:
+		return TRUE;
+	default:
+		return FALSE;
+	}
+}
+
 const unsigned char *stk_pdu_from_envelope(const struct stk_envelope *enve=
lope,
 						unsigned int *out_length)
 {
@@ -4470,6 +5017,9 @@ const unsigned char *stk_pdu_from_envelope(const stru=
ct stk_envelope *envelope,
 					&envelope->sms_mo_control.location,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_EVENT_DOWNLOAD:
+		ok =3D build_envelope_event_download(&builder, envelope);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index a57af48..a24ace7 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -154,6 +154,8 @@ enum stk_data_object_type {
 	STK_DATA_OBJECT_TYPE_NETWORK_ACCESS_NAME =3D		0x47,
 	STK_DATA_OBJECT_TYPE_CDMA_SMS_TPDU =3D 			0x48,
 	STK_DATA_OBJECT_TYPE_REMOTE_ENTITY_ADDRESS =3D		0x49,
+	STK_DATA_OBJECT_TYPE_I_WLAN_ID_TAG =3D			0x4A,
+	STK_DATA_OBJECT_TYPE_I_WLAN_ACCESS_STATUS =3D		0x4B,
 	STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE =3D			0x50,
 	STK_DATA_OBJECT_TYPE_ITEM_TEXT_ATTRIBUTE_LIST =3D		0x51,
 	STK_DATA_OBJECT_TYPE_PDP_ACTIVATION_PARAMETER =3D		0x52,
@@ -174,11 +176,13 @@ enum stk_data_object_type {
 	STK_DATA_OBJECT_TYPE_REGISTRY_APPLICATION_DATA =3D	0x71,
 	STK_DATA_OBJECT_TYPE_ROUTING_AREA_INFO =3D		0x73,
 	STK_DATA_OBJECT_TYPE_UPDATE_ATTACH_TYPE =3D		0x74,
+	STK_DATA_OBJECT_TYPE_REJECTION_CAUSE_CODE =3D		0x75,
 	STK_DATA_OBJECT_TYPE_NMEA_SENTENCE =3D			0x78,
 	STK_DATA_OBJECT_TYPE_PLMN_LIST =3D			0x79,
 	STK_DATA_OBJECT_TYPE_BROADCAST_NETWORK_INFO =3D		0x7A,
 	STK_DATA_OBJECT_TYPE_ACTIVATE_DESCRIPTOR =3D		0x7B,
 	STK_DATA_OBJECT_TYPE_EPS_PDN_CONN_ACTIVATION_REQ =3D	0x7C,
+	STK_DATA_OBJECT_TYPE_TRACKING_AREA_ID =3D			0x7D,
 };
 =

 enum stk_device_identity_type {
@@ -404,6 +408,7 @@ enum stk_bearer_type {
 };
 =

 enum stk_address_type {
+	STK_ADDRESS_AUTO =3D 	-1,
 	STK_ADDRESS_IPV4 =3D 	0x21,
 	STK_ADDRESS_IPV6 =3D 	0x57
 };
@@ -448,6 +453,100 @@ enum stk_broadcast_network_technology {
 	STK_BROADCAST_NETWORK_T_DMB =3D 0x03
 };
 =

+enum stk_i_wlan_access_status {
+	STK_I_WLAN_STATUS_NO_COVERAGE		=3D 0x00,
+	STK_I_WLAN_STATUS_NOT_CONNECTED		=3D 0x01,
+	STK_I_WLAN_STATUS_CONNECTED		=3D 0x02,
+};
+
+enum stk_update_attach_type {
+	STK_UPDATE_ATTACH_NORMAL_LOCATION_UPDATING	=3D 0x00,
+	STK_UPDATE_ATTACH_PERIODIC_UPDATING		=3D 0x01,
+	STK_UPDATE_ATTACH_IMSI_ATTACH			=3D 0x02,
+	STK_UPDATE_ATTACH_GPRS_ATTACH			=3D 0x03,
+	STK_UPDATE_ATTACH_GPRS_IMSI_ATTACH		=3D 0x04,
+	STK_UPDATE_ATTACH_RA_UPDATING			=3D 0x05,
+	STK_UPDATE_ATTACH_RA_LA_UPDATING		=3D 0x06,
+	STK_UPDATE_ATTACH_RA_LA_UPDATING_IMSI_ATTACH	=3D 0x07,
+	STK_UPDATE_ATTACH_PERIODIC_RA_UPDATING		=3D 0x08,
+	STK_UPDATE_ATTACH_EPS_ATTACH			=3D 0x09,
+	STK_UPDATE_ATTACH_EPS_IMSI_ATTACH		=3D 0x0a,
+	STK_UPDATE_ATTACH_TA_UPDATING			=3D 0x0b,
+	STK_UPDATE_ATTACH_TA_LA_UPDATING		=3D 0x0c,
+	STK_UPDATE_ATTACH_TA_LA_UPDATING_IMSI_ATTACH	=3D 0x0d,
+	STK_UPDATE_ATTACH_PERIDIC_TA_UPDATING		=3D 0x0e,
+};
+
+enum stk_rejection_cause_code {
+	/* MM and GMM codes (GERAN/UTRAN) */
+	STK_CAUSE_GMM_IMSI_UNKNOWN_IN_HLR		=3D 0x02,
+	STK_CAUSE_GMM_ILLEGAL_MS			=3D 0x03,
+	STK_CAUSE_GMM_IMSI_UNKNOWN_IN_VLR		=3D 0x04,
+	STK_CAUSE_GMM_IMEI_NOT_ACCEPTED			=3D 0x05,
+	STK_CAUSE_GMM_ILLEGAL_ME			=3D 0x06,
+	STK_CAUSE_GMM_GPRS_NOT_ALLOWED			=3D 0x07,
+	STK_CAUSE_GMM_GPRS_AND_NON_GPRS_NOT_ALLOWED	=3D 0x08,
+	STK_CAUSE_GMM_IMEI_NOT_DERIVED_BY_NETWORK	=3D 0x09,
+	STK_CAUSE_GMM_IMPLICITLY_DETACHED		=3D 0x0a,
+	STK_CAUSE_GMM_PLMN_NOT_ALLOWED			=3D 0x0b,
+	STK_CAUSE_GMM_LAC_NOT_ALLOWED			=3D 0x0c,
+	STK_CAUSE_GMM_ROAMING_NOT_ALLOWED		=3D 0x0d,
+	STK_CAUSE_GMM_GPRS_NOT_ALLOWED_IN_PLMN		=3D 0x0e,
+	STK_CAUSE_GMM_NO_SUITABLE_CELLS			=3D 0x0f,
+	STK_CAUSE_GMM_MSC_TEMPORARILY_UNREACHABLE	=3D 0x10,
+	STK_CAUSE_GMM_NETWORK_FAILURE			=3D 0x11,
+	STK_CAUSE_GMM_MAC_FAILURE			=3D 0x14,
+	STK_CAUSE_GMM_SYNCH_FAILURE			=3D 0x15,
+	STK_CAUSE_GMM_CONGESTION			=3D 0x16,
+	STK_CAUSE_GMM_GSM_AUTHENTICATION_UNACCEPTABLE	=3D 0x17,
+	STK_CAUSE_GMM_NOT_AUTHORISED_FOR_CSG		=3D 0x19,
+	STK_CAUSE_GMM_SERVICE_OPTION_NOT_SUPPORTED	=3D 0x20,
+	STK_CAUSE_GMM_SERVICE_OPTION_NOT_SUBSCRIBED	=3D 0x21,
+	STK_CAUSE_GMM_SERVICE_OPTION_TEMPORARY_DEFUNC	=3D 0x22,
+	STK_CAUSE_GMM_CALL_NOT_IDENTIFIED		=3D 0x26,
+	STK_CAUSE_GMM_NO_PDP_CONTEXT_ACTIVATED		=3D 0x28,
+	STK_CAUSE_GMM_RETRY_ON_NEW_CELL			=3D 0x30, /* to 0x3f */
+	STK_CAUSE_GMM_SEMANTICALLY_INCORRECT_MESSAGE	=3D 0x5f,
+	STK_CAUSE_GMM_INVALID_MANDATORY_INFO		=3D 0x60,
+	STK_CAUSE_GMM_MESSAGE_TYPE_UNKNOWN		=3D 0x61,
+	STK_CAUSE_GMM_MESSAGE_TYPE_INCOMPATIBLE_STATE	=3D 0x62,
+	STK_CAUSE_GMM_IE_UNKNOWN			=3D 0x63,
+	STK_CAUSE_GMM_CONDITIONAL_IE_ERROR		=3D 0x64,
+	STK_CAUSE_GMM_MESSAGE_INCOMPATIBLE_WITH_STATE	=3D 0x65,
+	STK_CAUSE_GMM_PROTOCOL_ERROR			=3D 0x6f,
+	/* EMM codes (E-UTRAN) */
+	STK_CAUSE_EMM_IMSI_UNKNOWN_IN_HSS		=3D 0x02,
+	STK_CAUSE_EMM_ILLEGAL_UE			=3D 0x03,
+	STK_CAUSE_EMM_ILLEGAL_ME			=3D 0x06,
+	STK_CAUSE_EMM_EPS_NOT_ALLOWED			=3D 0x07,
+	STK_CAUSE_EMM_EPS_AND_NON_EPS_NOT_ALLOWED	=3D 0x08,
+	STK_CAUSE_EMM_IMEI_NOT_DERIVED_BY_NETWORK	=3D 0x09,
+	STK_CAUSE_EMM_IMPLICITLY_DETACHED		=3D 0x0a,
+	STK_CAUSE_EMM_PLMN_NOT_ALLOWED			=3D 0x0b,
+	STK_CAUSE_EMM_TAC_NOT_ALLOWED			=3D 0x0c,
+	STK_CAUSE_EMM_ROAMING_NOT_ALLOWED		=3D 0x0d,
+	STK_CAUSE_EMM_EPS_NOT_ALLOWED_IN_PLMN		=3D 0x0e,
+	STK_CAUSE_EMM_NO_SUITABLE_CELLS			=3D 0x0f,
+	STK_CAUSE_EMM_MSC_TEMPORARILY_UNREACHABLE	=3D 0x10,
+	STK_CAUSE_EMM_NETWORK_FAILURE			=3D 0x11,
+	STK_CAUSE_EMM_MAC_FAILURE			=3D 0x14,
+	STK_CAUSE_EMM_SYNCH_FAILURE			=3D 0x15,
+	STK_CAUSE_EMM_CONGESTION			=3D 0x16,
+	STK_CAUSE_EMM_SECURITY_MODE_REJECTED		=3D 0x18,
+	STK_CAUSE_EMM_NOT_AUTHORISED_FOR_CSG		=3D 0x19,
+	STK_CAUSE_EMM_CS_FALLBACK_NOT_ALLOWED		=3D 0x26,
+	STK_CAUSE_EMM_CS_DOMAIN_TEMPORARY_UNAVAILABLE	=3D 0x27,
+	STK_CAUSE_EMM_NO_EPS_BEARER_CONTEXT_ACTIVATED	=3D 0x28,
+	STK_CAUSE_EMM_SEMANTICALLY_INCORRECT_MESSAGE	=3D 0x5f,
+	STK_CAUSE_EMM_INVALID_MANDATORY_INFO		=3D 0x60,
+	STK_CAUSE_EMM_MESSAGE_TYPE_UNKNOWN		=3D 0x61,
+	STK_CAUSE_EMM_MESSAGE_TYPE_INCOMPATIBLE_STATE	=3D 0x62,
+	STK_CAUSE_EMM_IE_UNKNOWN			=3D 0x63,
+	STK_CAUSE_EMM_CONDITIONAL_IE_ERROR		=3D 0x64,
+	STK_CAUSE_EMM_MESSAGE_INCOMPATIBLE_WITH_STATE	=3D 0x65,
+	STK_CAUSE_EMM_PROTOCOL_ERROR			=3D 0x6f,
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -609,6 +708,16 @@ struct stk_item_icon_id_list {
 	unsigned int len;
 };
 =

+/* Defined in TS 102.223 Section 8.33 */
+struct stk_reader_status {
+	int id;
+	ofono_bool_t removable;
+	ofono_bool_t present;
+	ofono_bool_t id1_size;
+	ofono_bool_t card_present;
+	ofono_bool_t card_powered;
+};
+
 /*
  * According to 102.223 Section 8.34 the length of CTLV is 1 byte. This me=
ans
  * that the maximum size is 127 according to the rules of CTLVs.
@@ -679,10 +788,10 @@ struct stk_card_reader_id {
 struct stk_other_address {
 	union {
 		/* Network Byte Order */
-		unsigned int ipv4;
+		guint32 ipv4;
 		unsigned char ipv6[16];
 	} addr;
-	unsigned char type;
+	enum stk_address_type type;
 };
 =

 /* Defined in TS 102.223 Section 8.59 */
@@ -744,6 +853,7 @@ struct stk_attribute_info {
  */
 struct stk_remote_entity_address {
 	unsigned char coding_type;
+	ofono_bool_t has_address;
 	union {
 		unsigned char ieee802[6];
 		unsigned char irda[4];
@@ -799,7 +909,9 @@ struct stk_frame_layout {
  */
 struct stk_frames_info {
 	unsigned char id;
-	unsigned char list[126];
+	struct {
+		unsigned int width, height;
+	} list[66];
 	unsigned int len;
 };
 =

@@ -864,6 +976,21 @@ struct stk_broadcast_network_information {
 	unsigned int len;
 };
 =

+/* Defined in TS 131.111 Section 8.91 */
+struct stk_routing_area_info {
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	unsigned short lac;
+	unsigned char rac;
+};
+
+/* Defined in TS 131.111 Section 8.99 */
+struct stk_tracking_area_id {
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	unsigned short tac;
+};
+
 struct stk_command_display_text {
 	char *text;
 	struct stk_icon_id icon_id;
@@ -1223,6 +1350,68 @@ struct stk_envelope_sms_mo_control {
 	struct stk_location_info location;
 };
 =

+struct stk_envelope_event_download {
+	enum stk_event_type type;
+	union {
+		struct {
+			unsigned char transaction_id;
+			struct stk_address caller_address;
+			struct stk_subaddress caller_subaddress;
+		} mt_call;
+		struct {
+			unsigned char transaction_id;
+		} call_connected;
+		struct {
+			struct stk_transaction_id transaction_ids;
+			struct stk_cause cause;
+		} call_disconnected;
+		struct {
+			enum stk_service_state state;
+			/* Present when state indicated Normal Service */
+			struct stk_location_info info;
+		} location_status;
+		struct stk_reader_status card_reader_status;
+		const char *language_selection;
+		struct {
+			enum stk_browser_termination_cause cause;
+		} browser_termination;
+		struct {
+			unsigned char channel_status[2];
+			unsigned int channel_data_len;
+		} data_available;
+		struct {
+			unsigned char status[2];
+			struct stk_bearer_description bearer_desc;
+			struct stk_other_address address;
+		} channel_status;
+		struct stk_access_technologies access_technology_change;
+		struct stk_display_parameters display_params_changed;
+		struct {
+			/*
+			 * Note the service record subfield is not required,
+			 * only the Technology id and Service id.
+			 */
+			struct stk_service_record service_record;
+			struct stk_remote_entity_address remote_addr;
+			struct stk_uicc_te_interface transport_level;
+			/* Only present if transport_level present */
+			struct stk_other_address transport_addr;
+		} local_connection;
+		enum stk_network_search_mode network_search_mode_change;
+		struct stk_common_byte_array browsing_status;
+		struct stk_frames_info frames_information_change;
+		enum stk_i_wlan_access_status i_wlan_access_status;
+		struct {
+			struct stk_location_info location;
+			struct stk_routing_area_info rai;
+			struct stk_tracking_area_id tai;
+			enum stk_access_technology_type access_tech;
+			enum stk_update_attach_type update_attach;
+			enum stk_rejection_cause_code cause;
+		} network_rejection;
+	};
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1233,6 +1422,7 @@ struct stk_envelope {
 		struct stk_envelope_menu_selection menu_selection;
 		struct stk_envelope_call_control call_control;
 		struct stk_envelope_sms_mo_control sms_mo_control;
+		struct stk_envelope_event_download event_download;
 	};
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============1912026563647158241==--

