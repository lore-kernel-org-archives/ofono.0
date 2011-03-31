Content-Type: multipart/mixed; boundary="===============5161063323388727158=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 1/2] stkutil: Complete the TLV parsing/builder to support
 BIP commands
Date: Thu, 31 Mar 2011 18:25:13 +0200
Message-ID: <1301588714-5879-1-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5161063323388727158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  278 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 src/stkutil.h |  131 ++++++++++++++++++++++-----
 2 files changed, 370 insertions(+), 39 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 3418b4b..89721e7 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1264,8 +1264,20 @@ static gboolean parse_dataobj_bearer_description(
 =

 	data =3D comprehension_tlv_iter_get_data(iter);
 	bd->type =3D data[0];
-	bd->len =3D len - 1;
-	memcpy(bd->pars, data + 1, bd->len);
+
+	/* Parse only the packet data service bearer parameters */
+	if (bd->type !=3D STK_BEARER_TYPE_GPRS_UTRAN)
+		return FALSE;
+
+	if (len < 7)
+		return FALSE;
+
+	bd->gprs.precedence =3D data[1];
+	bd->gprs.delay =3D data[2];
+	bd->gprs.reliability =3D data[3];
+	bd->gprs.peak =3D data[4];
+	bd->gprs.mean =3D data[5];
+	bd->gprs.pdp_type =3D data[6];
 =

 	return TRUE;
 }
@@ -1355,8 +1367,16 @@ static gboolean parse_dataobj_other_address(
 		return FALSE;
 =

 	data =3D comprehension_tlv_iter_get_data(iter);
+
+	if (data[0] !=3D STK_ADDRESS_IPV4 && data[0] !=3D STK_ADDRESS_IPV6)
+		return FALSE;
+
 	oa->type =3D data[0];
-	memcpy(&oa->addr, data + 1, len - 1);
+
+	if (oa->type =3D=3D STK_ADDRESS_IPV4)
+		memcpy(&oa->addr.ipv4, data + 1, 4);
+	else
+		memcpy(&oa->addr.ipv6, data + 1, 16);
 =

 	return TRUE;
 }
@@ -1604,16 +1624,42 @@ static gboolean parse_dataobj_esn(struct comprehens=
ion_tlv_iter *iter,
 static gboolean parse_dataobj_network_access_name(
 		struct comprehension_tlv_iter *iter, void *user)
 {
-	struct stk_network_access_name *nan =3D user;
+	char **apn =3D user;
 	const unsigned char *data;
 	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+	unsigned char label_size;
+	unsigned char offset =3D 0;
+	char decoded_apn[100];
 =

-	if (len =3D=3D 0)
+	if (len =3D=3D 0 || len > 100)
 		return FALSE;
 =

 	data =3D comprehension_tlv_iter_get_data(iter);
-	nan->len =3D len;
-	memcpy(nan->name, data, len);
+	/*
+	 * As specified in TS 23 003 Section 9
+	 * The APN consists of one or more labels. Each label is coded as
+	 * a one octet length field followed by that number of octets coded
+	 * as 8 bit ASCII characters
+	 */
+
+	while (len) {
+		label_size =3D *data;
+
+		if (label_size > (len-1))
+			return FALSE;
+
+		memcpy(decoded_apn + offset, data + 1, label_size);
+
+		data +=3D label_size + 1;
+		offset +=3D label_size;
+		len -=3D label_size + 1;
+
+		if (len)
+			decoded_apn[offset++] =3D '.';
+	}
+
+	decoded_apn[offset] =3D '\0';
+	*apn =3D g_strdup(decoded_apn);
 =

 	return TRUE;
 }
@@ -3274,7 +3320,69 @@ static enum stk_command_parse_result parse_launch_br=
owser(
 				STK_DATA_OBJECT_TYPE_INVALID);
 }
 =

-/* TODO: parse_open_channel */
+static void destroy_open_channel(struct stk_command *command)
+{
+	g_free(command->open_channel.alpha_id);
+	g_free(command->open_channel.apn);
+	g_free(command->open_channel.text_usr);
+	g_free(command->open_channel.text_passwd);
+}
+
+static enum stk_command_parse_result parse_open_channel(
+					struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_open_channel *obj =3D &command->open_channel;
+	enum stk_command_parse_result status;
+
+	if (command->qualifier >=3D 0x08)
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
+	command->destructor =3D destroy_open_channel;
+
+	/*
+	 * parse the Open Channel data objects related to packet data service
+	 * bearer
+	 */
+	status =3D parse_dataobj(iter,
+				STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+				&obj->alpha_id,
+				STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+				&obj->icon_id,
+				STK_DATA_OBJECT_TYPE_BEARER_DESCRIPTION,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->bearer_desc,
+				STK_DATA_OBJECT_TYPE_BUFFER_SIZE,
+				DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+				&obj->buf_size,
+				STK_DATA_OBJECT_TYPE_NETWORK_ACCESS_NAME, 0,
+				&obj->apn,
+				STK_DATA_OBJECT_TYPE_OTHER_ADDRESS, 0,
+				&obj->local_addr,
+				STK_DATA_OBJECT_TYPE_TEXT, 0,
+				&obj->text_usr,
+				STK_DATA_OBJECT_TYPE_TEXT, 0,
+				&obj->text_passwd,
+				STK_DATA_OBJECT_TYPE_UICC_TE_INTERFACE, 0,
+				&obj->uti,
+				STK_DATA_OBJECT_TYPE_OTHER_ADDRESS, 0,
+				&obj->data_dest_addr,
+				STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+				&obj->text_attr,
+				STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+				&obj->frame_id,
+				STK_DATA_OBJECT_TYPE_INVALID);
+
+	CHECK_TEXT_AND_ICON(obj->alpha_id, obj->icon_id.id);
+
+	return status;
+}
 =

 static void destroy_close_channel(struct stk_command *command)
 {
@@ -3291,7 +3399,8 @@ static enum stk_command_parse_result parse_close_chan=
nel(
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

-	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+	if ((command->dst < STK_DEVICE_IDENTITY_TYPE_CHANNEL_1) ||
+			(command->dst > STK_DEVICE_IDENTITY_TYPE_CHANNEL_7))
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	command->destructor =3D destroy_close_channel;
@@ -3363,6 +3472,9 @@ static enum stk_command_parse_result parse_send_data(
 	struct stk_command_send_data *obj =3D &command->send_data;
 	enum stk_command_parse_result status;
 =

+	if (command->qualifier > STK_SEND_DATA_IMMEDIATELY)
+		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
+
 	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

@@ -3737,6 +3849,8 @@ static enum stk_command_parse_result parse_command_bo=
dy(
 		return parse_language_notification(command, iter);
 	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
 		return parse_launch_browser(command, iter);
+	case STK_COMMAND_TYPE_OPEN_CHANNEL:
+		return parse_open_channel(command, iter);
 	case STK_COMMAND_TYPE_CLOSE_CHANNEL:
 		return parse_close_channel(command, iter);
 	case STK_COMMAND_TYPE_RECEIVE_DATA:
@@ -4752,12 +4866,35 @@ static gboolean build_dataobj_bearer_description(st=
ruct stk_tlv_builder *tlv,
 	const struct stk_bearer_description *bd =3D data;
 	unsigned char tag =3D STK_DATA_OBJECT_TYPE_BEARER_DESCRIPTION;
 =

-	if (bd->type =3D=3D 0x00)
+	if (bd->type !=3D STK_BEARER_TYPE_GPRS_UTRAN)
 		return TRUE;
 =

 	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
 		stk_tlv_builder_append_byte(tlv, bd->type) &&
-		stk_tlv_builder_append_bytes(tlv, bd->pars, bd->len) &&
+		stk_tlv_builder_append_byte(tlv,
+			bd->gprs.precedence) &&
+		stk_tlv_builder_append_byte(tlv,
+			bd->gprs.delay) &&
+		stk_tlv_builder_append_byte(tlv,
+			bd->gprs.reliability) &&
+		stk_tlv_builder_append_byte(tlv,
+			bd->gprs.peak) &&
+		stk_tlv_builder_append_byte(tlv,
+			bd->gprs.mean) &&
+		stk_tlv_builder_append_byte(tlv,
+			bd->gprs.pdp_type) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.53 */
+static gboolean build_dataobj_channel_data(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_common_byte_array *cd =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CHANNEL_DATA;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_bytes(tlv, cd->array, cd->len) &&
 		stk_tlv_builder_close_container(tlv);
 }
 =

@@ -4766,7 +4903,7 @@ static gboolean build_dataobj_channel_data_length(
 						struct stk_tlv_builder *tlv,
 						const void *data, gboolean cr)
 {
-	const unsigned int *length =3D data;
+	const unsigned short *length =3D data;
 	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CHANNEL_DATA_LENGTH;
 =

 	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
@@ -4774,15 +4911,50 @@ static gboolean build_dataobj_channel_data_length(
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.55 */
+static gboolean build_dataobj_buffer_size(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const unsigned short *buf_size =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_BUFFER_SIZE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_short(tlv, *buf_size) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.56 */
 static gboolean build_dataobj_channel_status(struct stk_tlv_builder *tlv,
 						const void *data, gboolean cr)
 {
+	const struct stk_channel *channel =3D data;
 	unsigned char tag =3D STK_DATA_OBJECT_TYPE_CHANNEL_STATUS;
+	unsigned char byte[2];
+
+	switch (channel->status) {
+	case STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED:
+	case STK_CHANNEL_TCP_IN_CLOSED_STATE:
+		byte[0] =3D channel->id;
+		byte[1] =3D 0x00;
+		break;
+	case STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED:
+	case STK_CHANNEL_TCP_IN_ESTABLISHED_STATE:
+		byte[0] =3D channel->id | 0x80;
+		byte[1] =3D 0x00;
+		break;
+	case STK_CHANNEL_TCP_IN_LISTEN_STATE:
+		byte[0] =3D channel->id | 0x40;
+		byte[1] =3D 0x00;
+		break;
+	case STK_CHANNEL_LINK_DROPPED:
+		byte[0] =3D channel->id;
+		byte[1] =3D 0x05;
+		break;
+	}
 =

 	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
-		stk_tlv_builder_append_bytes(tlv, data, 2) &&
-		stk_tlv_builder_close_container(tlv);
+			stk_tlv_builder_append_bytes(tlv, byte, 2) &&
+			stk_tlv_builder_close_container(tlv);
 }
 =

 /* Described in TS 102.223 Section 8.58 */
@@ -5454,6 +5626,63 @@ static gboolean build_local_info(struct stk_tlv_buil=
der *builder,
 	return FALSE;
 }
 =

+static gboolean build_open_channel(struct stk_tlv_builder *builder,
+					const struct stk_response *response)
+{
+	const struct stk_response_open_channel *open_channel =3D
+		&response->open_channel;
+
+	/* insert channel identifier only in case of success */
+	if (response->result.type =3D=3D STK_RESULT_TYPE_SUCCESS) {
+		if (build_dataobj(builder, build_dataobj_channel_status,
+						0, &open_channel->channel,
+						NULL) !=3D TRUE)
+			return FALSE;
+	}
+
+	return build_dataobj(builder,
+				build_dataobj_bearer_description,
+				0, &open_channel->bearer_desc,
+				build_dataobj_buffer_size,
+				0, &open_channel->buf_size,
+				NULL);
+}
+
+static gboolean build_receive_data(struct stk_tlv_builder *builder,
+					const struct stk_response *response)
+{
+	const struct stk_response_receive_data *receive_data =3D
+		&response->receive_data;
+
+	if (response->result.type !=3D STK_RESULT_TYPE_SUCCESS)
+		return TRUE;
+
+ 	if (receive_data->rx_data.len) {
+		if (build_dataobj(builder, build_dataobj_channel_data,
+					DATAOBJ_FLAG_CR,
+					&response->receive_data.rx_data,
+					NULL) !=3D TRUE)
+		return FALSE;
+	}
+
+	return build_dataobj(builder, build_dataobj_channel_data_length,
+				DATAOBJ_FLAG_CR,
+				&response->receive_data.rx_remaining,
+				NULL);
+}
+
+static gboolean build_send_data(struct stk_tlv_builder *builder,
+					const struct stk_response *response)
+{
+	if (response->result.type !=3D STK_RESULT_TYPE_SUCCESS) =

+		return TRUE;
+
+	return build_dataobj(builder, build_dataobj_channel_data_length,
+				DATAOBJ_FLAG_CR,
+				&response->send_data.tx_avail,
+				NULL);
+}
+
 const unsigned char *stk_pdu_from_response(const struct stk_response *resp=
onse,
 						unsigned int *out_length)
 {
@@ -5582,6 +5811,7 @@ const unsigned char *stk_pdu_from_response(const stru=
ct stk_response *response,
 	case STK_COMMAND_TYPE_SEND_DTMF:
 	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
 	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
+	case STK_COMMAND_TYPE_CLOSE_CHANNEL:
 		break;
 	case STK_COMMAND_TYPE_SEND_USSD:
 		ok =3D build_dataobj(&builder,
@@ -5590,6 +5820,22 @@ const unsigned char *stk_pdu_from_response(const str=
uct stk_response *response,
 					&response->send_ussd.text,
 					NULL);
 		break;
+	case STK_COMMAND_TYPE_OPEN_CHANNEL:
+		ok =3D build_open_channel(&builder, response);
+		break;
+	case STK_COMMAND_TYPE_RECEIVE_DATA:
+		ok =3D build_receive_data(&builder, response);
+		break;
+	case STK_COMMAND_TYPE_SEND_DATA:
+		ok =3D build_send_data(&builder, response);
+		break;
+	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_channel_status,
+					DATAOBJ_FLAG_CR,
+					&response->channel_status.channel,
+					NULL);
+		break;
 	default:
 		return NULL;
 	};
@@ -5738,7 +5984,7 @@ static gboolean build_envelope_event_download(struct =
stk_tlv_builder *builder,
 		return build_dataobj(builder,
 					build_dataobj_channel_status,
 					DATAOBJ_FLAG_CR,
-					&evt->data_available.channel_status,
+					&evt->data_available.channel,
 					build_dataobj_channel_data_length,
 					DATAOBJ_FLAG_CR,
 					&evt->data_available.channel_data_len,
@@ -5747,7 +5993,7 @@ static gboolean build_envelope_event_download(struct =
stk_tlv_builder *builder,
 		return build_dataobj(builder,
 					build_dataobj_channel_status,
 					DATAOBJ_FLAG_CR,
-					&evt->channel_status.status,
+					&evt->channel_status.channel,
 					build_dataobj_bearer_description,
 					DATAOBJ_FLAG_CR,
 					&evt->channel_status.bearer_desc,
diff --git a/src/stkutil.h b/src/stkutil.h
index 1b38dec..dd45bc2 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -425,14 +425,19 @@ enum stk_browser_termination_cause {
 	STK_BROWSER_ERROR_TERMINATION =3D		0x01
 };
 =

+/* Defined in TS 31.111 Section 8.52 */
 enum stk_bearer_type {
+	STK_BEARER_TYPE_CS =3D			0x01,
+	STK_BEARER_TYPE_GPRS_UTRAN =3D		0x02,
 	STK_BEARER_TYPE_DEFAULT =3D		0x03,
 	STK_BEARER_TYPE_INDEPENDENT =3D		0x04,
 	STK_BEARER_TYPE_BLUETOOTH =3D		0x05,
 	STK_BEARER_TYPE_IRDA =3D			0x06,
 	STK_BEARER_TYPE_RS232 =3D			0x07,
-	STK_BEARER_TYPE_PACKET_DATA_SERVICE =3D	0x08,
-	STK_BEARER_TYPE_I_WLAN =3D		0x0a,
+	STK_BEARER_TYPE_TIA_EIA_IS_820 =3D	0x08,
+	STK_BEARER_TYPE_UTRAN_WITH_EXT_PARAMS =3D 0x09,
+	STK_BEARER_TYPE_I_WLAN =3D		0x0A,
+	STK_BEARER_TYPE_EUTRAN_MAPPED_UTRAN =3D	0x0B,
 	STK_BEARER_TYPE_USB =3D			0x10
 };
 =

@@ -587,6 +592,39 @@ enum stk_img_scheme {
 	STK_IMG_SCHEME_TRANSPARENCY =3D	0x22,
 };
 =

+/* Defined in TS 102.223 Section 8.6 */
+enum stk_qualifier_open_channel {
+	STK_OPEN_CHANNEL_FLAG_IMMEDIATE =3D		0x01,
+	STK_OPEN_CHANNEL_FLAG_AUTO_RECONNECT =3D		0x02,
+	STK_OPEN_CHANNEL_FLAG_BACKGROUND =3D		0x04,
+};
+
+/* Defined in TS 102.223 Section 8.6 */
+enum stk_qualifier_send_data {
+	STK_SEND_DATA_STORE_DATA =3D	0x00,
+	STK_SEND_DATA_IMMEDIATELY =3D	0x01,
+};
+
+/* Defined in TS 102.223 Section 8.56 */
+enum stk_channel_status {
+	STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED =3D 0x00,
+	STK_CHANNEL_PACKET_DATA_SERVICE_ACTIVATED =3D	0x01,
+	STK_CHANNEL_TCP_IN_CLOSED_STATE =3D		0x02,
+	STK_CHANNEL_TCP_IN_LISTEN_STATE =3D		0x03,
+	STK_CHANNEL_TCP_IN_ESTABLISHED_STATE =3D		0x04,
+	STK_CHANNEL_LINK_DROPPED =3D			0x05,
+};
+
+/* Defined in TS 102.223 Section 8.59 */
+enum stk_transport_protocol_type {
+	STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE =3D	0x01,
+	STK_TRANSPORT_PROTOCOL_TCP_CLIENT_REMOTE =3D	0x02,
+	STK_TRANSPORT_PROTOCOL_TCP_SERVER =3D		0x03,
+	STK_TRANSPORT_PROTOCOL_UDP_CLIENT_LOCAL =3D	0x04,
+	STK_TRANSPORT_PROTOCOL_TCP_CLIENT_LOCAL =3D	0x05,
+	STK_TRANSPORT_PROTOCOL_DIRECT =3D			0x06,
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
@@ -849,16 +887,20 @@ struct stk_timing_advance {
 	unsigned char advance;
 };
 =

-/*
- * According to 102.223 Section 8.52 the length of CTLV is 1 byte. This me=
ans
- * that the maximum size is 127 according to the rules of CTLVs. This size=
 also
- * includes bearer type for 1 byte, so the maxmimum size of bearer paramet=
ers
- * is 126.
- */
+/* Bearer parameters for GPRS/UTRAN Packet Service/E-UTRAN */
+struct stk_gprs_bearer_parameters {
+	unsigned char precedence;
+	unsigned char delay;
+	unsigned char reliability;
+	unsigned char peak;
+	unsigned char mean;
+	unsigned char pdp_type;
+};
+
+/* Defined in TS 31.111 Section 8.52 */
 struct stk_bearer_description {
-	unsigned char type;
-	unsigned char pars[126];
-	unsigned int len;
+	enum stk_bearer_type type;
+	struct stk_gprs_bearer_parameters gprs;
 };
 =

 /*
@@ -885,7 +927,7 @@ struct stk_other_address {
 =

 /* Defined in TS 102.223 Section 8.59 */
 struct stk_uicc_te_interface {
-	unsigned char protocol;
+	enum stk_transport_protocol_type protocol;
 	unsigned short port;
 };
 =

@@ -950,15 +992,6 @@ struct stk_remote_entity_address {
 };
 =

 /*
- * According to 102.223 Section 8.70 the length of CTLV is 1 byte. This me=
ans
- * that the maximum size is 127 according to the rules of CTLVs.
- */
-struct stk_network_access_name {
-	unsigned char name[127];
-	unsigned char len;
-};
-
-/*
  * According to 102.223 Section 8.72 the length of text attribute CTLV is 1
  * byte.  This means that the maximum size is 127 according to the rules
  * of CTLVs.  Empty attribute options will have len of 0.
@@ -1250,6 +1283,21 @@ struct stk_command_launch_browser {
 	char *text_passwd;
 };
 =

+struct stk_command_open_channel {
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_bearer_description bearer_desc;
+	unsigned short buf_size;
+	char *apn;
+	struct stk_other_address local_addr;
+	char *text_usr;
+	char *text_passwd;
+	struct stk_uicc_te_interface uti;
+	struct stk_other_address data_dest_addr;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command_close_channel {
 	char *alpha_id;
 	struct stk_icon_id icon_id;
@@ -1368,6 +1416,7 @@ struct stk_command {
 		struct stk_command_send_dtmf send_dtmf;
 		struct stk_command_language_notification language_notification;
 		struct stk_command_launch_browser launch_browser;
+		struct stk_command_open_channel open_channel;
 		struct stk_command_close_channel close_channel;
 		struct stk_command_receive_data receive_data;
 		struct stk_command_send_data send_data;
@@ -1406,6 +1455,19 @@ struct stk_ussd_text {
 	int len;
 };
 =

+struct stk_channel {
+	unsigned char id;
+	enum stk_channel_status status;
+};
+
+struct stk_channel_data {
+	struct stk_common_byte_array data;
+	union {
+		unsigned short rx_remaining;
+		unsigned short tx_avail;
+	};
+};
+
 struct stk_response_get_inkey {
 	struct stk_answer_text text;
 	struct stk_duration duration;
@@ -1481,6 +1543,25 @@ struct stk_response_send_ussd {
 	struct stk_ussd_text text;
 };
 =

+struct stk_response_open_channel {
+	struct stk_channel channel;
+	struct stk_bearer_description bearer_desc;
+	unsigned short buf_size;
+};
+
+struct stk_response_receive_data {
+	struct stk_common_byte_array rx_data;
+	unsigned short rx_remaining;
+};
+
+struct stk_response_send_data {
+	unsigned short tx_avail;
+};
+
+struct stk_response_channel_status {
+	struct stk_channel channel;
+};
+
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1511,6 +1592,10 @@ struct stk_response {
 		struct stk_response_generic language_notification;
 		struct stk_response_generic launch_browser;
 		struct stk_response_send_ussd send_ussd;
+		struct stk_response_open_channel open_channel;
+		struct stk_response_receive_data receive_data;
+		struct stk_response_send_data send_data;
+		struct stk_response_channel_status channel_status;
 	};
 =

 	void (*destructor)(struct stk_response *response);
@@ -1596,11 +1681,11 @@ struct stk_envelope_event_download {
 			enum stk_browser_termination_cause cause;
 		} browser_termination;
 		struct {
-			unsigned char channel_status[2];
+			struct stk_channel channel;
 			unsigned int channel_data_len;
 		} data_available;
 		struct {
-			unsigned char status[2];
+			struct stk_channel channel;
 			struct stk_bearer_description bearer_desc;
 			struct stk_other_address address;
 		} channel_status;
-- =

1.7.1


--===============5161063323388727158==--

