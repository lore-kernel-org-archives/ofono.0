Content-Type: multipart/mixed; boundary="===============2034428657210750109=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 10/18] isimodem: wgmodem2.5 added to voicecall
Date: Tue, 15 Feb 2011 13:31:04 +0100
Message-ID: <3684af0e38dc8d466a8ad38d34e4b0b9d282c984.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2034428657210750109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/call.h      |   82 ++++++++++++++++-
 drivers/isimodem/voicecall.c |  218 +++++++++++++++++++++++++++++++++-----=
----
 2 files changed, 253 insertions(+), 47 deletions(-)

diff --git a/drivers/isimodem/call.h b/drivers/isimodem/call.h
index 84f4e04..9c854a4 100644
--- a/drivers/isimodem/call.h
+++ b/drivers/isimodem/call.h
@@ -27,6 +27,8 @@ extern "C" {
 #endif
 =

 #define PN_CALL					0x01
+#define PN_MODEM_CALL				0xC9
+#define CALL_MODEM_PROP_PRESENT_DEFAULT		0x00
 =

 enum call_message_id {
 	CALL_CREATE_REQ =3D			0x01,
@@ -333,6 +335,7 @@ enum call_subblock {
 	CALL_MODE_CHANGE_INFO =3D			0x36,
 	CALL_ADDITIONAL_PARAMS =3D		0x37,
 	CALL_DSAC_INFO =3D			0x38,
+	CALL_LINE_ID =3D				0x47,
 };
 =

 enum call_id {
@@ -351,6 +354,10 @@ enum call_id {
 	CALL_ID_ALL =3D				0xF0,
 };
 =

+enum call_dtmf_pause_values {
+	CALL_DTMF_PAUSE_1S =3D 0x01
+};
+
 enum call_mode {
 	CALL_MODE_EMERGENCY =3D			0x00,
 	CALL_MODE_SPEECH =3D			0x01,
@@ -369,6 +376,12 @@ enum {
 	CALL_GSM_PRESENTATION_DEFAULT =3D		0x07,
 };
 =

+enum call_modem_line_id {
+	CALL_MODEM_PRESENT_DEFAULT =3D		0x00,
+	CALL_MODEM_PRESENT_ALLOWED =3D		0x01,
+	CALL_MODEM_PRESENT_RESTRICTED =3D		0x02
+};
+
 enum call_operation {
 	CALL_OP_HOLD =3D				0x01,
 	CALL_OP_RETRIEVE =3D			0x02,
@@ -402,9 +415,76 @@ enum {
 	CALL_DTMF_DISABLE_TONE_IND_SEND =3D	0x02,
 };
 =

+enum call_notification_indicator {
+	CALL_NOTIFY_USER_SUSPENDED =3D		0x00,
+	CALL_NOTIFY_USER_RESUMED =3D		0x01,
+	CALL_NOTIFY_BEARER_CHANGE =3D		0x02
+};
+
+enum call_mmi_ss_codes {
+	CALL_SSC_ALL_FWDS =3D			0x0002,
+	CALL_SSC_ALL_COND_FWD =3D			0x0004,
+	CALL_SSC_CFU =3D				0x0015,
+	CALL_SSC_CFB =3D				0x0043,
+	CALL_SSC_CFNRY =3D			0x003D,
+	CALL_SSC_CFGNC =3D			0x003E,
+	CALL_SSC_OUTGOING_BARR_SERV =3D		0x014D,
+	CALL_SSC_INCOMING_BARR_SERV =3D		0x0161,
+	CALL_SSC_CALL_WAITING =3D			0x002B,
+	CALL_SSC_CLIR =3D				0x001F,
+	CALL_SSC_ETC =3D				0x0060,
+	CALL_SSC_MPTY =3D				0xFFFE,
+	CALL_SSC_CALL_HOLD =3D			0xFFFF
+};
+
+enum call_ss_status {
+	CALL_SS_STATUS_ACTIVE =3D			0x01,
+	CALL_SS_STATUS_REGISTERED =3D		0x02,
+	CALL_SS_STATUS_PROVISIONED =3D		0x04,
+	CALL_SS_STATUS_QUIESCENT =3D		0x08
+};
+
+enum call_ss_notification {
+	CALL_SSN_INCOMING_IS_FWD =3D		0x01,
+	CALL_SSN_INCOMING_FWD =3D			0x02,
+	CALL_SSN_OUTGOING_FWD =3D			0x04
+};
+
+enum call_ss_indicator {
+	CALL_SSI_CALL_IS_WAITING =3D		0x01,
+	CALL_SSI_MPTY =3D				0x02,
+	CALL_SSI_CLIR_SUPPR_REJ =3D		0x04
+};
+
+enum call_ss_hold_indicator {
+	CALL_HOLD_IND_RETRIEVED =3D 0x00,
+	CALL_HOLD_IND_ON_HOLD =3D 0x01
+};
+
+enum call_ss_ect_indicator {
+	CALL_ECT_CALL_STATE_ALERT =3D		0x00,
+	CALL_ECT_CALL_STATE_ACTIVE =3D		0x01
+};
+
+enum call_notification_sb_values {
+	CALL_SB_NOTIFY =3D			0xB1,
+	CALL_SB_SS_NOTIFY =3D			0xB2,
+	CALL_SB_SS_CODE =3D			0xB3,
+	CALL_SB_SS_STATUS =3D			0xB4,
+	CALL_SB_SS_NOTIFY_INDICATOR =3D		0xB5,
+	CALL_SB_SS_HOLD_INDICATOR =3D		0xB6,
+	CALL_SB_SS_ECT_INDICATOR =3D		0xB7,
+	CALL_SB_REMOTE_ADDRESS =3D		0xA6,
+	CALL_SB_REMOTE_SUBADDRESS =3D		0xA7,
+	CALL_SB_CUG_INFO =3D			0xA0,
+	CALL_SB_ORIGIN_INFO =3D			0x0E,
+	CALL_SB_ALERTING_PATTERN =3D		0xA1,
+	CALL_SB_ALERTING_INFO =3D			0x0C
+};
+
 /* 27.007 Section 7.7 */
 enum clir_status {
-	CLIR_STATUS_NOT_PROVISIONED =3D 0,
+	CLIR_STATUS_NOT_PROVISIONED =3D		0,
 	CLIR_STATUS_PROVISIONED_PERMANENT,
 	CLIR_STATUS_UNKNOWN,
 	CLIR_STATUS_TEMPORARY_RESTRICTED,
diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 0a32f27..750707d 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -57,7 +57,7 @@ struct isi_call {
 	uint8_t addr_type;
 	uint8_t presentation;
 	uint8_t reason;
-	char address[20];
+	char address[30];
 	char addr_pad[4];
 };
 =

@@ -82,10 +82,12 @@ struct call_info {
 =

 struct isi_voicecall {
 	GIsiClient *client;
-
+	GIsiClient *primary;
+	GIsiClient *secondary;
 	struct isi_call_req_ctx *queue;
-
 	struct isi_call calls[8];
+	void *control_req_irc;
+
 };
 =

 typedef void isi_call_req_step(struct isi_call_req_ctx *ctx, int reason);
@@ -395,7 +397,7 @@ static struct ofono_call isi_call_as_ofono_call(const s=
truct isi_call *call)
 	ocall.direction =3D call->mode_info & CALL_MODE_ORIGINATOR;
 	ocall.status =3D isi_call_status_to_clcc(call);
 =

-	memcpy(number->number, call->address, sizeof(number->number));
+	memmove(number->number, call->address, sizeof(number->number));
 =

 	number->type =3D 0x80 | call->addr_type;
 	ocall.clip_validity =3D call->presentation & 3;
@@ -546,26 +548,66 @@ static struct isi_call_req_ctx *isi_call_create_req(s=
truct ofono_voicecall *ovc,
 							ofono_voicecall_cb_t cb,
 							void *data)
 {
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
 	size_t addr_len =3D strlen(address);
 	size_t sub_len =3D (6 + 2 * addr_len + 3) & ~3;
-	size_t i, offset =3D 3 + 4 + 8 + 6;
-	uint8_t req[3 + 4 + 8 + 6 + 40] =3D {
-		CALL_CREATE_REQ,
-		0,		/* No id */
-		3,		/* Mode, Clir, Number */
+	size_t origin_size =3D (g_isi_client_resource(ivc->client) =3D=3D
+				PN_MODEM_CALL) ? 4 : 8;
+	size_t i, offset =3D 3 + 4 + origin_size + 6;
+	size_t rlen =3D 3 + 4 + origin_size + sub_len;
+	uint8_t req[3 + 4 + origin_size + 6 + 40];
+
+	memset(req, 0, 3 + 4 + origin_size + 6 + 40);
+
+	if (g_isi_client_resource(ivc->client) =3D=3D PN_MODEM_CALL) {
+		req[0] =3D CALL_CREATE_REQ;
+		req[1] =3D 0; /* No id */
+		req[2] =3D 3; /* Mode, Clir, Number */
 		/* MODE SB */
-		CALL_MODE, 4, CALL_MODE_SPEECH, CALL_MODE_INFO_NONE,
+		req[3] =3D CALL_MODE;
+		req[4] =3D 4;
+		req[5] =3D CALL_MODE_SPEECH;
+		req[6] =3D 0;
 		/* ORIGIN_INFO SB */
-		CALL_ORIGIN_INFO, 8, presentation, 0, 0, 0, 0, 0,
+		req[7] =3D CALL_LINE_ID;
+		req[8] =3D origin_size;
+		req[9] =3D presentation;
+		req[10] =3D 0;
 		/* DESTINATION_ADDRESS SB */
-		CALL_DESTINATION_ADDRESS,
-		sub_len,
-		addr_type & 0x7F,
-		0, 0,
-		addr_len,
+		req[11] =3D CALL_DESTINATION_ADDRESS;
+		req[12] =3D sub_len;
+		req[13] =3D addr_type & 0x7F;
+		req[14] =3D 0;
+		req[15] =3D 0;
+		req[16] =3D addr_len;
 		/* uint16_t addr[20] */
-	};
-	size_t rlen =3D 3 + 4 + 8 + sub_len;
+	} else {
+		req[0] =3D CALL_CREATE_REQ;
+		req[1] =3D 0; /* No id */
+		req[2] =3D 3; /* Mode, Clir, Number */
+		/* MODE SB */
+		req[3] =3D CALL_MODE;
+		req[4] =3D 4;
+		req[5] =3D CALL_MODE_SPEECH;
+		req[6] =3D CALL_MODE_INFO_NONE;
+		/* ORIGIN_INFO SB */
+		req[7] =3D CALL_ORIGIN_INFO;
+		req[8] =3D origin_size;
+		req[9] =3D presentation;
+		req[10] =3D 0;
+		req[11] =3D 0;
+		req[12] =3D 0;
+		req[13] =3D 0;
+		req[14] =3D 0;
+		/* DESTINATION_ADDRESS SB */
+		req[15] =3D CALL_DESTINATION_ADDRESS;
+		req[16] =3D sub_len;
+		req[17] =3D addr_type & 0x7F;
+		req[18] =3D 0;
+		req[19] =3D 0;
+		req[20] =3D addr_len;
+		/* uint16_t addr[20] */
+	}
 =

 	if (addr_len > 20) {
 		CALLBACK_WITH_FAILURE(cb, data);
@@ -726,7 +768,8 @@ error:
 	isi_ctx_return_failure(irc);
 }
 =

-static struct isi_call_req_ctx *isi_call_release_req(struct ofono_voicecal=
l *ovc,
+static struct isi_call_req_ctx *isi_call_release_req(
+						struct ofono_voicecall *ovc,
 						uint8_t call_id,
 						enum call_cause_type cause_type,
 						uint8_t cause,
@@ -770,7 +813,8 @@ static void isi_call_status_resp(const GIsiMessage *msg=
, void *data)
 			break;
 =

 		case CALL_ADDR_AND_STATUS_INFO:
-			call =3D isi_call_addr_and_status_info_sb_proc(ivc, &iter);
+			call =3D isi_call_addr_and_status_info_sb_proc(ivc,
+									&iter);
 			if (call)
 				isi_call_notify(ovc, call);
 			break;
@@ -836,12 +880,13 @@ error:
 	isi_ctx_return_failure(irc);
 }
 =

-static struct isi_call_req_ctx *isi_call_control_req(struct ofono_voicecal=
l *ovc,
-							uint8_t call_id,
-							enum call_operation op,
-							uint8_t info,
-							ofono_voicecall_cb_t cb,
-							void *data)
+static struct isi_call_req_ctx *isi_call_control_req(
+						struct ofono_voicecall *ovc,
+						uint8_t call_id,
+						enum call_operation op,
+						uint8_t info,
+						ofono_voicecall_cb_t cb,
+						void *data)
 {
 	const uint8_t req[] =3D {
 		CALL_CONTROL_REQ,
@@ -856,12 +901,13 @@ static struct isi_call_req_ctx *isi_call_control_req(=
struct ofono_voicecall *ovc
 				cb, data);
 }
 =

-static struct isi_call_req_ctx *isi_call_deflect_req(struct ofono_voicecal=
l *ovc,
-							uint8_t call_id,
-							uint8_t address_type,
-							const char address[21],
-							ofono_voicecall_cb_t cb,
-							void *data)
+static struct isi_call_req_ctx *isi_call_deflect_req(
+						struct ofono_voicecall *ovc,
+						uint8_t call_id,
+						uint8_t address_type,
+						const char address[21],
+						ofono_voicecall_cb_t cb,
+						void *data)
 {
 	size_t addr_len =3D strlen(address);
 	size_t sub_len =3D (6 + 2 * addr_len + 3) & ~3;
@@ -893,6 +939,37 @@ static struct isi_call_req_ctx *isi_call_deflect_req(s=
truct ofono_voicecall *ovc
 	return isi_call_req(ovc, req, rlen, isi_call_control_resp, cb, data);
 }
 =

+static void isi_call_control_ind_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_voicecall *ovc =3D data;
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+	GIsiSubBlockIter iter;
+	uint8_t cause_type =3D 0, cause =3D 0;
+
+	if (ivc =3D=3D NULL || g_isi_msg_id(msg) !=3D CALL_CONTROL_IND)
+		return;
+
+	for (g_isi_sb_iter_init(&iter, msg, 2);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+
+		if (g_isi_sb_iter_get_id(&iter) !=3D CALL_CAUSE)
+			continue;
+		if (!g_isi_sb_iter_get_byte(&iter, &cause_type, 2) ||
+				!g_isi_sb_iter_get_byte(&iter, &cause, 3))
+			return;
+	}
+
+	if (ivc->control_req_irc) {
+		if (!cause)
+			isi_ctx_return_success(ivc->control_req_irc);
+		else
+			isi_ctx_return_failure(ivc->control_req_irc);
+
+		ivc->control_req_irc =3D NULL;
+	}
+}
+
 static void isi_call_dtmf_send_resp(const GIsiMessage *msg, void *data)
 {
 	struct isi_call_req_ctx *irc =3D data;
@@ -924,11 +1001,12 @@ error:
 	isi_ctx_return_failure(irc);
 }
 =

-static struct isi_call_req_ctx *isi_call_dtmf_send_req(struct ofono_voicec=
all *ovc,
-							uint8_t call_id,
-							const char *string,
-							ofono_voicecall_cb_t cb,
-							void *data)
+static struct isi_call_req_ctx *isi_call_dtmf_send_req(
+						struct ofono_voicecall *ovc,
+						uint8_t call_id,
+						const char *string,
+						ofono_voicecall_cb_t cb,
+						void *data)
 {
 	size_t str_len =3D strlen(string);
 	size_t sub_len =3D 4 + ((2 * str_len + 3) & ~3);
@@ -963,18 +1041,23 @@ static void isi_dial(struct ofono_voicecall *ovc,
 			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
 			void *data)
 {
-	unsigned char presentation =3D CALL_GSM_PRESENTATION_DEFAULT;
+	unsigned char presentation;
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
 =

 	switch (clir) {
-	case OFONO_CLIR_OPTION_DEFAULT:
-		presentation =3D CALL_GSM_PRESENTATION_DEFAULT;
-		break;
 	case OFONO_CLIR_OPTION_INVOCATION:
 		presentation =3D CALL_PRESENTATION_RESTRICTED;
 		break;
 	case OFONO_CLIR_OPTION_SUPPRESSION:
 		presentation =3D CALL_PRESENTATION_ALLOWED;
 		break;
+	case OFONO_CLIR_OPTION_DEFAULT:
+	default:
+		presentation =3D (g_isi_client_resource(ivc->client) =3D=3D
+				PN_MODEM_CALL) ?
+					CALL_MODEM_PROP_PRESENT_DEFAULT :
+					CALL_GSM_PRESENTATION_DEFAULT;
+		break;
 	}
 =

 	isi_call_create_req(ovc, presentation, number->type, number->number,
@@ -1275,7 +1358,7 @@ static void isi_send_tones(struct ofono_voicecall *ov=
c, const char *tones,
 	isi_call_dtmf_send_req(ovc, CALL_ID_ALL, tones, cb, data);;
 }
 =

-static void isi_call_verify_cb(const GIsiMessage *msg, void *data)
+static void isi_primary_call_verify_cb(const GIsiMessage *msg, void *data)
 {
 	struct ofono_voicecall *ovc =3D data;
 	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
@@ -1285,8 +1368,42 @@ static void isi_call_verify_cb(const GIsiMessage *ms=
g, void *data)
 =

 	ISI_VERSION_DBG(msg);
 =

+	ivc->client =3D ivc->primary;
+	g_isi_client_destroy(ivc->secondary);
+
 	g_isi_client_ind_subscribe(ivc->client, CALL_STATUS_IND,
-					isi_call_status_ind_cb, ovc);
+			isi_call_status_ind_cb, ovc);
+	g_isi_client_ind_subscribe(ivc->client, CALL_CONTROL_IND,
+			isi_call_control_ind_cb, ovc);
+
+	g_isi_client_ind_subscribe(ivc->client, CALL_TERMINATED_IND,
+					isi_call_terminated_ind_cb, ovc);
+
+	if (!isi_call_status_req(ovc, CALL_ID_ALL,
+					CALL_STATUS_MODE_ADDR_AND_ORIGIN,
+					NULL, NULL))
+		DBG("Failed to request call status");
+
+	ofono_voicecall_register(ovc);
+}
+
+static void isi_secondary_call_verify_cb(const GIsiMessage *msg, void *dat=
a)
+{
+	struct ofono_voicecall *ovc =3D data;
+	struct isi_voicecall *ivc =3D ofono_voicecall_get_data(ovc);
+
+	if (g_isi_msg_error(msg) < 0)
+		return;
+
+	ISI_VERSION_DBG(msg);
+
+	ivc->client =3D ivc->secondary;
+	g_isi_client_destroy(ivc->primary);
+
+	g_isi_client_ind_subscribe(ivc->client, CALL_STATUS_IND,
+			isi_call_status_ind_cb, ovc);
+	g_isi_client_ind_subscribe(ivc->client, CALL_CONTROL_IND,
+			isi_call_control_ind_cb, ovc);
 =

 	g_isi_client_ind_subscribe(ivc->client, CALL_TERMINATED_IND,
 					isi_call_terminated_ind_cb, ovc);
@@ -1313,15 +1430,24 @@ static int isi_voicecall_probe(struct ofono_voiceca=
ll *ovc,
 	for (id =3D 0; id <=3D 7; id++)
 		ivc->calls[id].id =3D id;
 =

-	ivc->client =3D g_isi_client_create(modem, PN_CALL);
-	if (ivc->client =3D=3D NULL) {
+	ivc->primary =3D g_isi_client_create(modem, PN_MODEM_CALL);
+	if (ivc->primary =3D=3D NULL) {
+		g_free(ivc);
+		return -ENOMEM;
+	}
+	ivc->secondary =3D g_isi_client_create(modem, PN_CALL);
+	if (ivc->secondary =3D=3D NULL) {
 		g_free(ivc);
+		g_isi_client_destroy(ivc->primary);
 		return -ENOMEM;
 	}
 =

 	ofono_voicecall_set_data(ovc, ivc);
 =

-	g_isi_client_verify(ivc->client, isi_call_verify_cb, ovc, NULL);
+	g_isi_client_verify(ivc->primary, isi_primary_call_verify_cb, ovc,
+				NULL);
+	g_isi_client_verify(ivc->secondary, isi_secondary_call_verify_cb, ovc,
+				NULL);
 =

 	return 0;
 }
-- =

1.7.3.5


--===============2034428657210750109==--

