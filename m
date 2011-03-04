Content-Type: multipart/mixed; boundary="===============6368380284030919784=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 5/5] isimodem: implement SSN handling
Date: Fri, 04 Mar 2011 19:12:56 +0200
Message-ID: <3daa52fd9f1088cea73092d5df1dfbb4338d4808.1299258404.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1299258404.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6368380284030919784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/voicecall.c |  359 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 359 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 9507255..165f3b4 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -739,6 +739,362 @@ static void isi_call_terminated_ind_cb(const GIsiMess=
age *msg, void *data)
 	isi_call_notify(ovc, call);
 }
 =

+static gboolean decode_notify(GIsiSubBlockIter *iter)
+{
+	uint8_t byte;
+
+	if (!g_isi_sb_iter_get_byte(iter, &byte, 2))
+		return FALSE;
+
+	switch (byte) {
+	case CALL_NOTIFY_USER_SUSPENDED:
+		DBG("CALL_NOTIFY_USER_SUSPENDED");
+		break;
+
+	case CALL_NOTIFY_USER_RESUMED:
+		DBG("CALL_NOTIFY_USER_RESUMED");
+		break;
+
+	case CALL_NOTIFY_BEARER_CHANGE:
+		DBG("CALL_NOTIFY_BEARER_CHANGE");
+		break;
+
+	default:
+		DBG("Unknown notification: 0x%02X", byte);
+	}
+
+	return TRUE;
+}
+
+static gboolean decode_ss_code(GIsiSubBlockIter *iter, int *cssi, int *css=
u)
+{
+	uint16_t word;
+
+	if (!g_isi_sb_iter_get_word(iter, &word, 2))
+		return FALSE;
+
+	switch (word) {
+	case CALL_SSC_ALL_FWDS:
+		DBG("Call forwarding is active");
+		break;
+
+	case CALL_SSC_ALL_COND_FWD:
+		*cssi =3D SS_MO_CONDITIONAL_FORWARDING;
+		DBG("Some of conditional call forwardings active");
+		break;
+
+	case CALL_SSC_CFU:
+		*cssi =3D SS_MO_UNCONDITIONAL_FORWARDING;
+		DBG("Unconditional call forwarding is active");
+		break;
+
+	case CALL_SSC_OUTGOING_BARR_SERV:
+		*cssi =3D SS_MO_OUTGOING_BARRING;
+		DBG("Outgoing calls are barred");
+		break;
+
+	case CALL_SSC_INCOMING_BARR_SERV:
+		*cssi =3D SS_MO_INCOMING_BARRING;
+		DBG("Incoming calls are barred");
+		break;
+
+	case CALL_SSC_CALL_WAITING:
+		DBG("Incoming calls are barred");
+		break;
+
+	case CALL_SSC_CLIR:
+		DBG("CLIR connected unknown indication.");
+		break;
+
+	case CALL_SSC_MPTY:
+		*cssu =3D SS_MT_MULTIPARTY_VOICECALL;
+		DBG("Multiparty call entered.");
+		break;
+
+	case CALL_SSC_CALL_HOLD:
+		*cssu =3D SS_MT_VOICECALL_HOLD_RELEASED;
+		DBG("Call on hold has been released.");
+		break;
+
+	default:
+		DBG("Unknown/unhandled notification: 0x%02X", word);
+		break;
+	}
+
+	return TRUE;
+}
+
+static gboolean decode_ss_status(GIsiSubBlockIter *iter)
+{
+	uint8_t byte;
+
+	if (!g_isi_sb_iter_get_byte(iter, &byte, 2))
+		return FALSE;
+
+	if (byte & CALL_SS_STATUS_ACTIVE)
+		DBG("CALL_SS_STATUS_ACTIVE");
+
+	if (byte & CALL_SS_STATUS_REGISTERED)
+		DBG("CALL_SS_STATUS_REGISTERED");
+
+	if (byte & CALL_SS_STATUS_PROVISIONED)
+		DBG("CALL_SS_STATUS_PROVISIONED");
+
+	if (byte & CALL_SS_STATUS_QUIESCENT)
+		DBG("CALL_SS_STATUS_QUIESCENT");
+
+	return TRUE;
+}
+
+static gboolean decode_ss_notify(GIsiSubBlockIter *iter, int *cssi, int *c=
ssu)
+{
+	uint8_t byte;
+
+	if (!g_isi_sb_iter_get_byte(iter, &byte, 2))
+		return FALSE;
+
+	if (byte & CALL_SSN_INCOMING_IS_FWD) {
+		*cssu =3D SS_MT_CALL_FORWARDED;
+		DBG("This is a forwarded call #1.");
+	}
+
+	if (byte & CALL_SSN_INCOMING_FWD)
+		DBG("This is a forwarded call #2.");
+
+	if (byte & CALL_SSN_OUTGOING_FWD) {
+		*cssi =3D SS_MO_CALL_FORWARDED;
+		DBG("Call has been forwarded.");
+	}
+
+	return TRUE;
+}
+
+static gboolean decode_ss_notify_indicator(GIsiSubBlockIter *iter, int *cs=
si)
+{
+	uint8_t byte;
+
+	if (!g_isi_sb_iter_get_byte(iter, &byte, 2))
+		return FALSE;
+
+	if (byte & CALL_SSI_CALL_IS_WAITING) {
+		*cssi =3D SS_MO_CALL_WAITING;
+		DBG("Call is waiting.");
+	}
+
+	if (byte & CALL_SSI_MPTY)
+		DBG("Multiparty call");
+
+	if (byte & CALL_SSI_CLIR_SUPPR_REJ) {
+		*cssi =3D SS_MO_CLIR_SUPPRESSION_REJECTED;
+		DBG("CLIR suppression rejected");
+	}
+
+	return TRUE;
+}
+
+static gboolean decode_ss_hold_indicator(GIsiSubBlockIter *iter, int *cssu)
+{
+	uint8_t byte;
+
+	if (!g_isi_sb_iter_get_byte(iter, &byte, 2))
+		return FALSE;
+
+	if (byte =3D=3D CALL_HOLD_IND_RETRIEVED) {
+		*cssu =3D SS_MT_VOICECALL_RETRIEVED;
+		DBG("Call has been retrieved");
+	} else if (byte & CALL_HOLD_IND_ON_HOLD) {
+		*cssu =3D SS_MT_VOICECALL_ON_HOLD;
+		DBG("Call has been put on hold");
+	} else {
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static gboolean decode_ss_ect_indicator(GIsiSubBlockIter *iter, int *cssu)
+{
+	uint8_t byte;
+
+	if (!g_isi_sb_iter_get_byte(iter, &byte, 2))
+		return FALSE;
+
+	if (byte & CALL_ECT_CALL_STATE_ALERT) {
+		*cssu =3D SS_MT_VOICECALL_IN_TRANSFER;
+		DBG("Call is being connected with the remote party in "
+			"alerting state");
+	}
+
+	if (byte & CALL_ECT_CALL_STATE_ACTIVE) {
+		*cssu =3D SS_MT_VOICECALL_TRANSFERRED;
+		DBG("Call has been connected with the other remote "
+			"party in explicit call transfer operation.");
+	}
+
+	return TRUE;
+}
+
+static gboolean decode_remote_address(GIsiSubBlockIter *iter,
+					struct ofono_phone_number *number,
+					int *index)
+{
+	uint8_t type, len;
+	char *addr;
+
+	if (!g_isi_sb_iter_get_byte(iter, &type, 2))
+		return FALSE;
+
+	if (!g_isi_sb_iter_get_byte(iter, &len, 5))
+		return FALSE;
+
+	if (len > OFONO_MAX_PHONE_NUMBER_LENGTH)
+		return FALSE;
+
+	if (!g_isi_sb_iter_get_alpha_tag(iter, &addr, 2 * len, 6))
+		return FALSE;
+
+	strncpy(number->number, addr, len);
+	number->number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+	number->type =3D type;
+
+	g_free(addr);
+
+	return TRUE;
+}
+
+static gboolean decode_cug_info(GIsiSubBlockIter *iter, int *index, int *c=
ssu)
+{
+	uint8_t pref;
+	uint8_t access;
+	uint16_t word;
+
+	if (!g_isi_sb_iter_get_byte(iter, &pref, 2))
+		return FALSE;
+
+	if (!g_isi_sb_iter_get_byte(iter, &access, 3))
+		return FALSE;
+
+	if (!g_isi_sb_iter_get_word(iter, &word, 4))
+		return FALSE;
+
+	DBG("Preferential CUG: 0x%02X", pref);
+	DBG("CUG output access: 0x%02X", access);
+
+	*index =3D word;
+	*cssu =3D SS_MO_CUG_CALL;
+
+	return TRUE;
+}
+
+static void notification_ind_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_voicecall *ovc =3D data;
+	GIsiSubBlockIter iter;
+
+	struct ofono_phone_number number;
+	int index =3D 0;
+	int cssi =3D -1;
+	int cssu =3D -1;
+	uint8_t call_id;
+
+	if (ovc =3D=3D NULL || g_isi_msg_id(msg) !=3D CALL_GSM_NOTIFICATION_IND ||
+			!g_isi_msg_data_get_byte(msg, 0, &call_id) ||
+			(call_id & 7) =3D=3D 0)
+		return;
+
+	DBG("Received CallServer notification for call: 0x%02X", call_id);
+
+	for (g_isi_sb_iter_init(&iter, msg, 2);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+
+		switch (g_isi_sb_iter_get_id(&iter)) {
+		case CALL_GSM_NOTIFY:
+
+			if (!decode_notify(&iter))
+				return;
+
+			break;
+
+		case CALL_GSM_SS_CODE:
+
+			if (!decode_ss_code(&iter, &cssi, &cssu))
+				return;
+
+			break;
+
+		case CALL_GSM_SS_STATUS:
+
+			if (!decode_ss_status(&iter))
+				return;
+
+			break;
+
+		case CALL_GSM_SS_NOTIFY:
+
+			if (!decode_ss_notify(&iter, &cssi, &cssu))
+				return;
+
+			break;
+
+		case CALL_GSM_SS_NOTIFY_INDICATOR:
+
+			if (!decode_ss_notify_indicator(&iter, &cssi))
+				return;
+
+			break;
+
+		case CALL_GSM_SS_HOLD_INDICATOR:
+
+
+			if (!decode_ss_hold_indicator(&iter, &cssu))
+				return;
+
+			break;
+
+		case CALL_GSM_SS_ECT_INDICATOR:
+
+			if (!decode_ss_ect_indicator(&iter, &cssu))
+				return;
+
+			break;
+
+		case CALL_GSM_REMOTE_ADDRESS:
+
+			if (!decode_remote_address(&iter, &number, &index))
+				return;
+
+			break;
+
+		case CALL_GSM_REMOTE_SUBADDRESS:
+			break;
+
+		case CALL_GSM_CUG_INFO:
+
+			if (!decode_cug_info(&iter, &index, &cssu))
+				return;
+
+			break;
+
+		case CALL_ORIGIN_INFO:
+			break;
+
+		case CALL_GSM_ALERTING_PATTERN:
+			break;
+
+		case CALL_ALERTING_INFO:
+			break;
+		}
+	}
+
+	if (cssi !=3D -1)
+		ofono_voicecall_ssn_mo_notify(ovc, call_id & 7, cssi, index);
+
+	if (cssu !=3D -1)
+		ofono_voicecall_ssn_mt_notify(ovc, call_id & 7, cssu, index,
+						&number);
+}
+
 static void isi_call_answer_resp(const GIsiMessage *msg, void *data)
 {
 	struct isi_call_req_ctx *irc =3D data;
@@ -1436,6 +1792,9 @@ static void call_verify_cb(const GIsiMessage *msg, vo=
id *data)
 		DBG("Failed to request call status");
 =

 	ofono_voicecall_register(ovc);
+
+	g_isi_client_ind_subscribe(ivc->client, CALL_GSM_NOTIFICATION_IND,
+					notification_ind_cb, ovc);
 }
 =

 static int probe_by_resource(struct ofono_voicecall *ovc, uint8_t resource,
-- =

1.7.0.4


--===============6368380284030919784==--

