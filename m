Content-Type: multipart/mixed; boundary="===============7932760789651299868=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/16] stkutil: Add the Provide Local Info response builder.
Date: Sun, 23 May 2010 12:14:27 +0200
Message-ID: <1274609667-6274-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7932760789651299868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  436 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   53 +++++++
 2 files changed, 489 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 7b46c54..2b38c5c 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3128,6 +3128,119 @@ static gboolean build_dataobj_text(struct stk_tlv_b=
uilder *tlv,
 	return stk_tlv_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.19 */
+static gboolean build_dataobj_location_info(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_location_info *li =3D data;
+	guint8 mccmnc[3];
+
+	if (li->mcc[0] =3D=3D 0)
+		/*
+		 * "If no location information is available for an access
+		 * technology, the respective data object shall have
+		 * length zero."
+		 */
+		return stk_tlv_open_container(tlv, cr,
+				STK_DATA_OBJECT_TYPE_LOCATION_INFO, FALSE) &&
+			stk_tlv_close_container(tlv);
+
+	sim_encode_mcc_mnc(mccmnc, li->mcc, li->mnc);
+
+	return stk_tlv_open_container(tlv, cr,
+				STK_DATA_OBJECT_TYPE_LOCATION_INFO, FALSE) &&
+		stk_tlv_append_bytes(tlv, mccmnc, 3) &&
+		stk_tlv_append_short(tlv, li->lac_tac) &&
+		(li->has_ci =3D=3D FALSE ||
+		 stk_tlv_append_short(tlv, li->ci)) &&
+		(li->has_ext_ci =3D=3D FALSE ||
+		 stk_tlv_append_short(tlv, li->ext_ci)) &&
+		(li->has_eutran_ci =3D=3D FALSE ||
+		 (stk_tlv_append_short(tlv, li->eutran_ci >> 12) &&
+		  stk_tlv_append_short(tlv, (li->eutran_ci << 4) | 0xf))) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.20
+ *
+ * See format note in parse_dataobj_imei.
+ */
+static gboolean build_dataobj_imei(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	char byte0[3];
+	const char *imei =3D data;
+	unsigned char value[8];
+
+	if (imei =3D=3D NULL)
+		return TRUE;
+
+	if (strlen(imei) !=3D 15)
+		return FALSE;
+
+	byte0[0] =3D '*';
+	byte0[1] =3D imei[0];
+	byte0[2] =3D '\0';
+	encode_bcd_number(byte0, value);
+	encode_bcd_number(imei + 1, value + 1);
+
+	return stk_tlv_open_container(tlv, cr,
+					STK_DATA_OBJECT_TYPE_IMEI, FALSE) &&
+		stk_tlv_append_bytes(tlv, value, 8) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.22 */
+static gboolean build_dataobj_network_measurement_results(
+						struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_common_byte_array *nmr =3D data;
+
+	return stk_tlv_open_container(tlv, cr,
+			STK_DATA_OBJECT_TYPE_NETWORK_MEASUREMENT_RESULTS,
+			FALSE) &&
+		(nmr->len =3D=3D 0 ||
+		 stk_tlv_append_bytes(tlv, nmr->array, nmr->len)) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in 3GPP 31.111 Section 8.29 */
+static gboolean build_dataobj_bcch_channel_list(struct stk_tlv_builder *tl=
v,
+						const void *data, gboolean cr)
+{
+	const struct stk_bcch_ch_list *list =3D data;
+	int i, bytes, pos, shift;
+	unsigned char value;
+
+	/* To distinguish between no BCCH Channel List data object and
+	 * an empty object in a sequence of empty and non-empty objects,
+	 * .channels must be non-NULL in objects in sequences.  */
+	if (list->channels =3D=3D NULL)
+		return TRUE;
+
+	if (stk_tlv_open_container(tlv, cr,
+			STK_DATA_OBJECT_TYPE_BCCH_CHANNEL_LIST, TRUE) !=3D TRUE)
+		return FALSE;
+
+	bytes =3D (list->length * 10 + 7) / 8;
+	for (i =3D 0; i < bytes; i++) {
+		pos =3D (i * 8 + 7) / 10;
+		shift =3D pos * 10 + 10 - i * 8 - 8;
+
+		value =3D 0;
+		if (pos < list->length)
+			value |=3D list->channels[pos] >> shift;
+		if (shift > 2)
+			value |=3D list->channels[pos - 1] << (10 - shift);
+
+		if (stk_tlv_append_byte(tlv, value) !=3D TRUE)
+			return FALSE;
+	}
+
+	return stk_tlv_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.30 */
 static gboolean build_dataobj_cc_requested_action(struct stk_tlv_builder *=
tlv,
 						const void *data, gboolean cr)
@@ -3142,6 +3255,194 @@ static gboolean build_dataobj_cc_requested_action(s=
truct stk_tlv_builder *tlv,
 		 stk_tlv_close_container(tlv));
 }
 =

+/* Described in TS 102.223 Section 8.39 */
+static gboolean build_dataobj_datetime_timezone(struct stk_tlv_builder *tl=
v,
+						const void *data, gboolean cr)
+{
+	const struct sms_scts *scts =3D data;
+	struct sms_scts timestamp;
+	unsigned char value[7];
+	int offset =3D 0;
+
+	if (scts->month =3D=3D 0 && scts->day =3D=3D 0)
+		return TRUE;
+
+	/* Time zone information is optional */
+	if (scts->timezone =3D=3D (gint8) 0xff) {
+		memcpy(&timestamp, scts, sizeof(timestamp));
+		timestamp.timezone =3D 0;
+		if (sms_encode_scts(&timestamp, value, &offset) !=3D TRUE)
+			return FALSE;
+		value[6] =3D 0xff;
+	} else
+		if (sms_encode_scts(scts, value, &offset) !=3D TRUE)
+			return FALSE;
+
+	return stk_tlv_open_container(tlv, cr,
+			STK_DATA_OBJECT_TYPE_DATETIME_TIMEZONE, FALSE) &&
+		stk_tlv_append_bytes(tlv, value, 7) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.45 */
+static gboolean build_dataobj_language(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	if (data =3D=3D NULL)
+		return TRUE;
+
+	/*
+	 * Coded as two GSM 7-bit characters with eighth bit clear.  Since
+	 * ISO 639-2 codes use only english alphabet letters, no conversion
+	 * from UTF-8 to GSM is needed.
+	 */
+	return stk_tlv_open_container(tlv, cr,
+			STK_DATA_OBJECT_TYPE_LANGUAGE, FALSE) &&
+		stk_tlv_append_bytes(tlv, data, 2) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in 3GPP TS 31.111 Section 8.46 */
+static gboolean build_dataobj_timing_advance(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_timing_advance *tadv =3D data;
+
+	return stk_tlv_open_container(tlv, cr,
+			STK_DATA_OBJECT_TYPE_TIMING_ADVANCE, FALSE) &&
+		stk_tlv_append_byte(tlv, tadv->status) &&
+		stk_tlv_append_byte(tlv, tadv->advance) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.61 */
+static gboolean build_dataobj_access_technologies(struct stk_tlv_builder *=
tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_access_technologies *techs =3D data;
+	int i;
+
+	if (stk_tlv_open_container(tlv, cr,
+			STK_DATA_OBJECT_TYPE_ACCESS_TECHNOLOGY, FALSE) !=3D TRUE)
+		return FALSE;
+
+	for (i =3D 0; i < techs->length; i++)
+		if (stk_tlv_append_byte(tlv, techs->techs[i]) !=3D TRUE)
+			return FALSE;
+
+	return stk_tlv_close_container(tlv);
+}
+
+/* Shortcut for a single Access Technology */
+static gboolean build_dataobj_access_technology(struct stk_tlv_builder *tl=
v,
+						const void *data, gboolean cr)
+{
+	return build_dataobj_access_technologies(tlv,
+			&(const struct stk_access_technologies) {
+				.techs =3D data, .length =3D 1 }, cr);
+}
+
+/* Described in TS 102.223 Section 8.69 */
+static gboolean build_dataobj_esn(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const guint32 *esn =3D data;
+
+	return stk_tlv_open_container(tlv, cr,
+					STK_DATA_OBJECT_TYPE_ESN, FALSE) &&
+		stk_tlv_append_short(tlv, *esn >> 16) &&
+		stk_tlv_append_short(tlv, *esn >> 0) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.74
+ *
+ * See format note in parse_dataobj_imeisv.
+ */
+static gboolean build_dataobj_imeisv(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	char byte0[3];
+	const char *imeisv =3D data;
+	unsigned char value[9];
+
+	if (imeisv =3D=3D NULL)
+		return TRUE;
+
+	if (strlen(imeisv) !=3D 16)
+		return FALSE;
+
+	byte0[0] =3D '3';
+	byte0[1] =3D imeisv[0];
+	byte0[2] =3D '\0';
+	encode_bcd_number(byte0, value);
+	encode_bcd_number(imeisv + 1, value + 1);
+
+	return stk_tlv_open_container(tlv, cr,
+					STK_DATA_OBJECT_TYPE_IMEISV, FALSE) &&
+		stk_tlv_append_bytes(tlv, value, 9) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.75 */
+static gboolean build_dataobj_network_search_mode(struct stk_tlv_builder *=
tlv,
+						const void *data, gboolean cr)
+{
+	const enum stk_network_search_mode *mode =3D data;
+
+	return stk_tlv_open_container(tlv, cr,
+			STK_DATA_OBJECT_TYPE_NETWORK_SEARCH_MODE, FALSE) &&
+		stk_tlv_append_byte(tlv, *mode) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.76 */
+static gboolean build_dataobj_battery_state(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const enum stk_battery_state *state =3D data;
+
+	return stk_tlv_open_container(tlv, cr,
+				STK_DATA_OBJECT_TYPE_BATTERY_STATE, FALSE) &&
+		stk_tlv_append_byte(tlv, *state) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.81 */
+static gboolean build_dataobj_meid(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const char *meid =3D data;
+	unsigned char value[8];
+
+	if (meid =3D=3D NULL)
+		return TRUE;
+
+	if (strlen(meid) !=3D 16)
+		return FALSE;
+
+	encode_bcd_number(meid, value);
+
+	return stk_tlv_open_container(tlv, cr,
+					STK_DATA_OBJECT_TYPE_MEID, FALSE) &&
+		stk_tlv_append_bytes(tlv, value, 8) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.90 */
+static gboolean build_dataobj_broadcast_network_information(
+						struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_broadcast_network_information *bni =3D data;
+
+	return stk_tlv_open_container(tlv, cr,
+			STK_DATA_OBJECT_TYPE_BROADCAST_NETWORK_INFO, FALSE) &&
+		stk_tlv_append_byte(tlv, bni->tech) &&
+		stk_tlv_append_bytes(tlv, bni->loc_info, bni->len) &&
+		stk_tlv_close_container(tlv);
+}
+
 static gboolean build_dataobj(struct stk_tlv_builder *tlv, gboolean
 				(*builder_func)(struct stk_tlv_builder *,
 						const void *, gboolean), ...)
@@ -3166,6 +3467,138 @@ static gboolean build_dataobj(struct stk_tlv_builde=
r *tlv, gboolean
 	return TRUE;
 }
 =

+static gboolean build_local_info(struct stk_tlv_builder *builder,
+					const struct stk_response *response)
+{
+	const struct stk_response_local_info *info =3D
+		&response->provide_local_info;
+	int i;
+
+	switch (response->qualifier) {
+	case 0x00: /* Location Information according to current NAA */
+		return build_dataobj(builder,
+					build_dataobj_location_info,
+					DATAOBJ_FLAG_CR, &info->location,
+					NULL);
+
+	case 0x01: /* IMEI of the terminal */
+		return build_dataobj(builder,
+					build_dataobj_imei,
+					DATAOBJ_FLAG_CR, info->imei,
+					NULL);
+
+	case 0x02: /* Network Measurement results according to current NAA */
+		return build_dataobj(builder,
+				build_dataobj_network_measurement_results,
+				DATAOBJ_FLAG_CR, &info->nmr.nmr,
+				build_dataobj_bcch_channel_list,
+				DATAOBJ_FLAG_CR, &info->nmr.bcch_ch_list,
+				NULL);
+
+	case 0x03: /* Date, time and time zone */
+		return build_dataobj(builder,
+					build_dataobj_datetime_timezone,
+					DATAOBJ_FLAG_CR, &info->datetime,
+					NULL);
+
+	case 0x04: /* Language setting */
+		return build_dataobj(builder,
+					build_dataobj_language,
+					DATAOBJ_FLAG_CR, info->language,
+					NULL);
+
+	case 0x05: /* Timing Advance */
+		return build_dataobj(builder,
+					build_dataobj_timing_advance,
+					DATAOBJ_FLAG_CR, &info->tadv,
+					NULL);
+
+	case 0x06: /* Access Technology (single access technology) */
+		return build_dataobj(builder,
+					build_dataobj_access_technology,
+					0, &info->access_technology,
+					NULL);
+
+	case 0x07: /* ESN of the terminal */
+		return build_dataobj(builder,
+					build_dataobj_esn,
+					DATAOBJ_FLAG_CR, &info->esn,
+					NULL);
+
+	case 0x08: /* IMEISV of the terminal */
+		return build_dataobj(builder,
+					build_dataobj_imeisv,
+					DATAOBJ_FLAG_CR, info->imeisv,
+					NULL);
+
+	case 0x09: /* Search Mode */
+		return build_dataobj(builder,
+					build_dataobj_network_search_mode,
+					0, &info->search_mode,
+					NULL);
+
+	case 0x0a: /* Charge State of the Battery */
+		return build_dataobj(builder,
+					build_dataobj_battery_state,
+					DATAOBJ_FLAG_CR, &info->battery_charge,
+					NULL);
+
+	case 0x0b: /* MEID of the terminal */
+		return build_dataobj(builder,
+					build_dataobj_meid,
+					0, info->meid,
+					NULL);
+
+	case 0x0d: /* Broadcast Network Information according to current tech */
+		return build_dataobj(builder,
+				build_dataobj_broadcast_network_information,
+				0, &info->broadcast_network_info,
+				NULL);
+
+	case 0x0e: /* Multiple Access Technologies */
+		return build_dataobj(builder,
+					build_dataobj_access_technologies,
+					0, &info->access_technologies,
+					NULL);
+
+	case 0x0f: /* Location Information for multiple NAAs */
+		if (build_dataobj(builder,
+					build_dataobj_access_technologies,
+					0, &info->location_infos.access_techs,
+					NULL) !=3D TRUE)
+			return FALSE;
+
+		for (i =3D 0; i < info->location_infos.access_techs.length; i++)
+			if (build_dataobj(builder,
+					build_dataobj_location_info,
+					0, &info->location_infos.locations[i],
+					NULL) !=3D TRUE)
+				return FALSE;
+
+		return TRUE;
+
+	case 0x10: /* Network Measurement results for multiple NAAs */
+		if (build_dataobj(builder,
+					build_dataobj_access_technologies,
+					0, &info->nmrs.access_techs,
+					NULL) !=3D TRUE)
+			return FALSE;
+
+		for (i =3D 0; i < info->nmrs.access_techs.length; i++)
+			if (build_dataobj(builder,
+				build_dataobj_network_measurement_results,
+				0, &info->nmrs.nmrs[i].nmr,
+				build_dataobj_bcch_channel_list,
+				0, &info->nmrs.nmrs[i].bcch_ch_list,
+				NULL) !=3D TRUE)
+				return FALSE;
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 unsigned int stk_pdu_from_response(const struct stk_response *response,
 					unsigned char *pdu, unsigned int size)
 {
@@ -3265,6 +3698,9 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 		break;
 	case STK_COMMAND_TYPE_POLLING_OFF:
 		break;
+	case STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO:
+		ok =3D build_local_info(&builder, response);
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 9dd3b75..c377dce 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -110,6 +110,7 @@ enum stk_data_object_type {
 	STK_DATA_OBJECT_TYPE_CAUSE =3D				0x1A,
 	STK_DATA_OBJECT_TYPE_LOCATION_STATUS =3D			0x1B,
 	STK_DATA_OBJECT_TYPE_TRANSACTION_ID =3D			0x1C,
+	STK_DATA_OBJECT_TYPE_BCCH_CHANNEL_LIST =3D		0x1D,
 	STK_DATA_OBJECT_TYPE_ICON_ID =3D				0x1E,
 	STK_DATA_OBJECT_TYPE_ITEM_ICON_ID_LIST =3D		0x1F,
 	STK_DATA_OBJECT_TYPE_CARD_READER_STATUS =3D		0x20,
@@ -544,6 +545,8 @@ struct stk_location_info {
 	unsigned short ci;
 	ofono_bool_t has_ext_ci;
 	unsigned short ext_ci;
+	ofono_bool_t has_eutran_ci;
+	guint32 eutran_ci;
 };
 =

 /*
@@ -1030,6 +1033,55 @@ struct stk_response_set_up_call {
 	} modified_result;
 };
 =

+struct stk_response_local_info {
+	union {
+		struct stk_location_info location;
+		const char *imei;
+		struct stk_network_measurement_results {
+			struct stk_common_byte_array nmr;
+			struct stk_bcch_ch_list {
+				const short *channels;
+				int length;
+			} bcch_ch_list;
+		} nmr;
+		struct sms_scts datetime;
+		const char *language;
+		enum stk_battery_state battery_charge;
+		enum stk_access_technology_type access_technology;
+		struct stk_timing_advance {
+			enum {
+				STK_TIMING_ADVANCE_ME_IDLE =3D 0x00,
+				STK_TIMING_ADVANCE_ME_NOT_IDLE =3D 0x01,
+			} status;
+			/* Contains bit periods number according to 3GPP TS
+			 * 44.118 Section 9.3.106 / 3GPP TS 44.018 Section
+			 * 10.5.2.40.1, not microseconds */
+			int advance;
+		} tadv;
+		/* Bits[31:24]: manufacturer, bits[23:0]: serial number */
+		guint32 esn;
+		const char *imeisv;
+		enum stk_network_search_mode {
+			STK_NETWORK_SEARCH_MODE_MANUAL =3D 0x00,
+			STK_NETWORK_SEARCH_MODE_AUTOMATIC =3D 0x01,
+		} search_mode;
+		const char *meid;
+		struct stk_broadcast_network_information broadcast_network_info;
+		struct stk_access_technologies {
+			const enum stk_access_technology_type *techs;
+			int length;
+		} access_technologies;
+		struct {
+			struct stk_access_technologies access_techs;
+			struct stk_location_info *locations;
+		} location_infos;
+		struct {
+			struct stk_access_technologies access_techs;
+			struct stk_network_measurement_results *nmrs;
+		} nmrs;
+	};
+};
+
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1050,6 +1102,7 @@ struct stk_response {
 		struct stk_response_generic send_sms;
 		struct stk_response_set_up_call set_up_call;
 		struct stk_response_generic polling_off;
+		struct stk_response_local_info provide_local_info;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============7932760789651299868==--

