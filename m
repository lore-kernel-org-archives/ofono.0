Content-Type: multipart/mixed; boundary="===============2112080266747393055=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH] Fix: simplify isimodem call-barring driver.
Date: Mon, 29 Mar 2010 21:17:51 +0300
Message-ID: <1269886671-18397-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2112080266747393055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Add support for lock codes AG and AC (MMI codes 333 and 353,
respectively). Use decimal MMI codes in <ss.h>.
---
 drivers/isimodem/call-barring.c |  153 ++++++++++++-----------------------=
----
 drivers/isimodem/ss.h           |  142 ++++++++++++++++++------------------
 2 files changed, 120 insertions(+), 175 deletions(-)

diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index 6487ae8..b8b175d 100644
--- a/drivers/isimodem/call-barring.c
+++ b/drivers/isimodem/call-barring.c
@@ -48,6 +48,28 @@ struct barr_data {
 	GIsiClient *client;
 };
 =

+static int lock_code_to_mmi(char const *lock)
+{
+	if (strcmp(lock, "AO") =3D=3D 0)
+		return SS_GSM_BARR_ALL_OUT;
+	else if (strcmp(lock, "OI") =3D=3D 0)
+		return SS_GSM_BARR_OUT_INTER;
+	else if (strcmp(lock, "OX") =3D=3D 0)
+		return SS_GSM_BARR_OUT_INTER_EXC_HOME;
+	else if (strcmp(lock, "AI") =3D=3D 0)
+		return SS_GSM_BARR_ALL_IN;
+	else if (strcmp(lock, "IR") =3D=3D 0)
+		return SS_GSM_BARR_ALL_IN_ROAM;
+	else if (strcmp(lock, "AB") =3D=3D 0)
+		return SS_GSM_ALL_BARRINGS;
+	else if (strcmp(lock, "AG") =3D=3D 0)
+		return SS_GSM_OUTGOING_BARR_SERV;
+	else if (strcmp(lock, "AC") =3D=3D 0)
+		return SS_GSM_INCOMING_BARR_SERV;
+	else
+		return 0;
+}
+
 static bool set_resp_cb(GIsiClient *client, const void *restrict data,
 				size_t len, uint16_t object, void *opaque)
 {
@@ -84,19 +106,19 @@ static void isi_set(struct ofono_call_barring *barr, c=
onst char *lock,
 {
 	struct barr_data *bd =3D ofono_call_barring_get_data(barr);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(barr, cb, data);
-	int ss_code;
-	char *ucs2 =3D NULL;
+	int ss_code =3D lock_code_to_mmi(lock);
 =

 	unsigned char msg[] =3D {
 		SS_SERVICE_REQ,
 		enable ? SS_ACTIVATION : SS_DEACTIVATION,
 		SS_ALL_TELE_AND_BEARER,
-		0, 0,				/* Supplementary services code */
-		SS_SEND_ADDITIONAL_INFO,
+		ss_code >> 8, ss_code & 0xFF,	/* Supplementary services code */
+		SS_SEND_ADDITIONAL_INFO,	/* ? */
 		1,				/* Subblock count */
 		SS_GSM_PASSWORD,
 		28,				/* Subblock length */
-		0, 0, 0, 0, 0, 0, 0, 0,		/* Password */
+		0, passwd[0], 0, passwd[1],	/* Password */
+		0, passwd[2], 0, passwd[3],
 		0, 0, 0, 0, 0, 0, 0, 0,		/* Filler */
 		0, 0, 0, 0, 0, 0, 0, 0,		/* Filler */
 		0, 0				/* Filler */
@@ -105,43 +127,10 @@ static void isi_set(struct ofono_call_barring *barr, =
const char *lock,
 	DBG("lock code %s enable %d class %d password %s\n",
 		lock, enable, cls, passwd);
 =

-	if (!cbd || !passwd || strlen(passwd) > 4 || cls !=3D 7)
-		goto error;
-
-	if (strcmp(lock, "AO") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_ALL_OUT;
-	else if (strcmp(lock, "OI") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_OUT_INTER;
-	else if (strcmp(lock, "OX") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_OUT_INTER_EXC_HOME;
-	else if (strcmp(lock, "AI") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_ALL_IN;
-	else if (strcmp(lock, "IR") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_ALL_IN_ROAM;
-	else if (strcmp(lock, "AB") =3D=3D 0)
-		ss_code =3D SS_GSM_ALL_BARRINGS;
-	else if (strcmp(lock, "AG") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_ALL_OUT;
-	else if (strcmp(lock, "AC") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_ALL_IN;
-	else
-		goto error;
-
-	msg[3] =3D ss_code >> 8;
-	msg[4] =3D ss_code & 0xFF;
-
-	ucs2 =3D g_convert(passwd, 4, "UCS-2BE", "UTF-8//TRANSLIT",
-				NULL, NULL, NULL);
-	if (ucs2 =3D=3D NULL)
-		goto error;
-
-	memcpy((char *)msg + 9, ucs2, 8);
-	g_free(ucs2);
-
-	if (g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
-				set_resp_cb, cbd))
+	if (cbd && g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
+					set_resp_cb, cbd))
 		return;
-error:
+
 	CALLBACK_WITH_FAILURE(cb, data);
 	g_free(cbd);
 }
@@ -267,43 +256,23 @@ static void isi_query(struct ofono_call_barring *barr=
, const char *lock, int cls
 {
 	struct barr_data *bd =3D ofono_call_barring_get_data(barr);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(barr, cb, data);
-	int ss_code;
+	int ss_code =3D lock_code_to_mmi(lock);
 =

 	unsigned char msg[] =3D {
 		SS_SERVICE_REQ,
 		SS_INTERROGATION,
 		SS_ALL_TELE_AND_BEARER,
-		0, 0,				/* Supplementary services code */
-		SS_SEND_ADDITIONAL_INFO,
+		ss_code >> 8, ss_code & 0xFF,	/* Supplementary services code */
+		SS_SEND_ADDITIONAL_INFO,	/* Get BER-encoded result, too */
 		0				/* Subblock count */
 	};
 =

-	DBG("barring query lock code %s class %d\n", lock, cls);
-
-	if (!cbd || cls !=3D 7)
-		goto error;
-
-	if (strcmp(lock, "AO") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_ALL_OUT;
-	else if (strcmp(lock, "OI") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_OUT_INTER;
-	else if (strcmp(lock, "OX") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_OUT_INTER_EXC_HOME;
-	else if (strcmp(lock, "AI") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_ALL_IN;
-	else if (strcmp(lock, "IR") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_ALL_IN_ROAM;
-	else
-		goto error;
-
-	msg[3] =3D ss_code >> 8;
-	msg[4] =3D ss_code & 0xFF;
+	DBG("barring query lock code %s\n", lock);
 =

-	if (g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
-				query_resp_cb, cbd))
+	if (cbd && g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
+					query_resp_cb, cbd))
 		return;
 =

-error:
 	CALLBACK_WITH_FAILURE(cb, 0, data);
 	g_free(cbd);
 }
@@ -343,60 +312,34 @@ static void isi_set_passwd(struct ofono_call_barring =
*barr, const char *lock,
 {
 	struct barr_data *bd =3D ofono_call_barring_get_data(barr);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(barr, cb, data);
-	int ss_code;
-	char *ucs2 =3D NULL;
+	int ss_code =3D lock_code_to_mmi(lock);
 =

 	unsigned char msg[] =3D {
 		SS_SERVICE_REQ,
 		SS_GSM_PASSWORD_REGISTRATION,
 		SS_ALL_TELE_AND_BEARER,
-		0, 0,				/* Supplementary services code */
+		ss_code >> 8, ss_code & 0xFF,	/* Supplementary services code */
 		SS_SEND_ADDITIONAL_INFO,
 		1,				/* Subblock count */
 		SS_GSM_PASSWORD,
 		28,				/* Subblock length */
-		0, 0, 0, 0, 0, 0, 0, 0,		/* Old password */
-		0, 0, 0, 0, 0, 0, 0, 0,		/* New password */
-		0, 0, 0, 0, 0, 0, 0, 0,		/* New password */
+		0, old_passwd[0], 0, old_passwd[1],
+		0, old_passwd[2], 0, old_passwd[3],
+		0, new_passwd[0], 0, new_passwd[1],
+		0, new_passwd[2], 0, new_passwd[3],
+		0, new_passwd[0], 0, new_passwd[1],
+		0, new_passwd[2], 0, new_passwd[3],
 		0, 0				/* Filler */
 	};
 =

-	if (!cbd || strlen(old_passwd) > 4 || strlen(new_passwd) > 4)
-		goto error;
-
-	DBG("lock code %s old password %s new password %s\n",
-		lock, old_passwd, new_passwd);
-
-	if (strcmp(lock, "AB") =3D=3D 0)
-		ss_code =3D SS_GSM_ALL_BARRINGS;
-	else
-		goto error;
-
-	msg[3] =3D ss_code >> 8;
-	msg[4] =3D ss_code & 0xFF;
+	DBG("lock code %s (%u) old password %s new password %s\n",
+		lock, ss_code, old_passwd, new_passwd);
 =

-	ucs2 =3D g_convert(old_passwd, 4, "UCS-2BE", "UTF-8//TRANSLIT",
-				NULL, NULL, NULL);
-	if (ucs2 =3D=3D NULL)
-		goto error;
-
-	memcpy((char *)msg + 9, ucs2, 8);
-	g_free(ucs2);
-
-	ucs2 =3D g_convert(new_passwd, 4, "UCS-2BE", "UTF-8//TRANSLIT",
-				NULL, NULL, NULL);
-	if (ucs2 =3D=3D NULL)
-		goto error;
-
-	memcpy((char *)msg + 17, ucs2, 8);
-	memcpy((char *)msg + 25, ucs2, 8);
-	g_free(ucs2);
-
-	if (g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
+	if (cbd &&
+		g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
 				set_passwd_resp_cb, cbd))
 		return;
 =

-error:
 	CALLBACK_WITH_FAILURE(cb, data);
 	g_free(cbd);
 }
diff --git a/drivers/isimodem/ss.h b/drivers/isimodem/ss.h
index 7c20bcc..93554db 100644
--- a/drivers/isimodem/ss.h
+++ b/drivers/isimodem/ss.h
@@ -24,102 +24,104 @@
 #ifndef __ISIMODEM_SS_H
 #define __ISIMODEM_SS_H
 =

-#define PN_SS			0x06
-#define SS_TIMEOUT		15
-#define SS_MAX_USSD_LENGTH	160
+#define PN_SS				0x06
+#define SS_TIMEOUT			15
+#define SS_MAX_USSD_LENGTH		160
 =

 enum ss_message_id {
-	SS_SERVICE_REQ =3D 0x00,
-	SS_SERVICE_COMPLETED_RESP =3D 0x01,
-	SS_SERVICE_FAILED_RESP =3D 0x02,
-	SS_GSM_USSD_SEND_REQ =3D 0x04,
-	SS_GSM_USSD_SEND_RESP =3D 0x05,
-	SS_GSM_USSD_RECEIVE_IND =3D 0x06,
-	SS_STATUS_IND =3D 0x09,
-	SS_COMMON_MESSAGE =3D 0xF0
+	SS_SERVICE_REQ =3D 			0x00,
+	SS_SERVICE_COMPLETED_RESP =3D		0x01,
+	SS_SERVICE_FAILED_RESP =3D		0x02,
+	SS_GSM_USSD_SEND_REQ =3D			0x04,
+	SS_GSM_USSD_SEND_RESP =3D			0x05,
+	SS_GSM_USSD_RECEIVE_IND =3D		0x06,
+	SS_STATUS_IND =3D				0x09,
+	SS_COMMON_MESSAGE =3D			0xF0
 };
 =

 enum ss_ussd_type {
-	SS_GSM_USSD_MT_REPLY =3D 0x01,
-	SS_GSM_USSD_COMMAND =3D 0x02,
-	SS_GSM_USSD_REQUEST =3D 0x03,
-	SS_GSM_USSD_NOTIFY =3D 0x04,
-	SS_GSM_USSD_END =3D 0x05
+	SS_GSM_USSD_MT_REPLY =3D			0x01,
+	SS_GSM_USSD_COMMAND =3D			0x02,
+	SS_GSM_USSD_REQUEST =3D			0x03,
+	SS_GSM_USSD_NOTIFY =3D			0x04,
+	SS_GSM_USSD_END =3D			0x05
 };
 =

 enum ss_ussd_status {
-	SS_GSM_STATUS_REQUEST_USSD_START =3D 0x02,
-	SS_GSM_STATUS_REQUEST_USSD_STOP =3D 0x03,
-	SS_GSM_STATUS_REQUEST_USSD_FAILED =3D 0x04
+	SS_GSM_STATUS_REQUEST_USSD_START =3D	0x02,
+	SS_GSM_STATUS_REQUEST_USSD_STOP =3D	0x03,
+	SS_GSM_STATUS_REQUEST_USSD_FAILED =3D	0x04
 };
 =

 enum ss_operations {
-	SS_ACTIVATION =3D 0x01,
-	SS_DEACTIVATION =3D 0x02,
-	SS_REGISTRATION =3D 0x03,
-	SS_ERASURE =3D 0x04,
-	SS_INTERROGATION =3D 0x05,
-	SS_GSM_PASSWORD_REGISTRATION =3D 0x06
+	SS_ACTIVATION =3D				0x01,
+	SS_DEACTIVATION =3D			0x02,
+	SS_REGISTRATION =3D			0x03,
+	SS_ERASURE =3D				0x04,
+	SS_INTERROGATION =3D			0x05,
+	SS_GSM_PASSWORD_REGISTRATION =3D		0x06
 };
 =

 enum ss_basic_service_codes {
-	SS_ALL_TELE_AND_BEARER =3D 0x00,
-	SS_GSM_ALL_TELE =3D 0x0A,
-	SS_GSM_TELEPHONY =3D 0x0B,
-	SS_GSM_ALL_DATA_TELE =3D 0x0C,
-	SS_GSM_FACSIMILE =3D 0x0D,
-	SS_GSM_SMS =3D 0x10,
-	SS_GSM_VOICE_GROUP =3D 0x11,
-	SS_GSM_ALL_TELE_EXC_SMS =3D 0x13,
-	SS_GSM_ALL_BEARER =3D 0x14,
-	SS_GSM_ALL_ASYNC =3D 0x15,
-	SS_GSM_ALL_SYNC =3D 0x16,
-	SS_GSM_ALL_DATA_CIRCUIT_SYNC =3D 0x18,
-	SS_GSM_ALL_DATA_CIRCUIT_ASYNC =3D 0x19,
-	SS_GSM_ALL_DATA_PACKET_SYNC =3D 0x1A,
-	SS_GSM_ALL_PAD_ACCESS =3D 0x1B
+	SS_ALL_TELE_AND_BEARER =3D		0,
+	SS_GSM_ALL_TELE =3D			10,
+	SS_GSM_TELEPHONY =3D			11,
+	SS_GSM_ALL_DATA_TELE =3D			12,
+	SS_GSM_FACSIMILE =3D			13,
+	SS_GSM_SMS =3D				16,
+	SS_GSM_VOICE_GROUP =3D			17,
+	SS_GSM_ALL_TELE_EXC_SMS =3D		19,
+	SS_GSM_ALL_BEARER =3D			20,
+	SS_GSM_ALL_ASYNC =3D			21,
+	SS_GSM_ALL_SYNC =3D			22,
+	SS_GSM_ALL_DATA_CIRCUIT_SYNC =3D		24,
+	SS_GSM_ALL_DATA_CIRCUIT_ASYNC =3D		25,
+	SS_GSM_ALL_DATA_PACKET_SYNC =3D		26,
+	SS_GSM_ALL_PAD_ACCESS =3D			27
 };
 =

 enum ss_codes {
-	SS_GSM_ALL_FORWARDINGS =3D 0x02,
-	SS_GSM_ALL_COND_FORWARDINGS =3D 0x04,
-	SS_GSM_FORW_UNCONDITIONAL =3D 0x15,
-	SS_GSM_BARR_ALL_OUT =3D 0x21,
-	SS_GSM_BARR_ALL_IN =3D 0x23,
-	SS_GSM_CALL_WAITING =3D 0x2B,
-	SS_GSM_FORW_NO_REPLY =3D 0x3D,
-	SS_GSM_FORW_NO_REACH =3D 0x3E,
-	SS_GSM_FORW_BUSY =3D 0x43,
-	SS_GSM_ALL_BARRINGS =3D 0x014A,
-	SS_GSM_BARR_OUT_INTER =3D 0x014B,
-	SS_GSM_BARR_OUT_INTER_EXC_HOME =3D 0x014C,
-	SS_GSM_BARR_ALL_IN_ROAM =3D 0x015F
+	SS_GSM_ALL_FORWARDINGS =3D		002,
+	SS_GSM_ALL_COND_FORWARDINGS =3D		004,
+	SS_GSM_FORW_UNCONDITIONAL =3D		21,
+	SS_GSM_BARR_ALL_OUT =3D			33,
+	SS_GSM_OUTGOING_BARR_SERV =3D		333,
+	SS_GSM_INCOMING_BARR_SERV =3D		353,
+	SS_GSM_BARR_ALL_IN =3D			35,
+	SS_GSM_CALL_WAITING =3D			43,
+	SS_GSM_FORW_NO_REPLY =3D			61,
+	SS_GSM_FORW_NO_REACH =3D			62,
+	SS_GSM_FORW_BUSY =3D			67,
+	SS_GSM_ALL_BARRINGS =3D			330,
+	SS_GSM_BARR_OUT_INTER =3D			331,
+	SS_GSM_BARR_OUT_INTER_EXC_HOME =3D	332,
+	SS_GSM_BARR_ALL_IN_ROAM =3D		351,
 };
 =

 enum ss_response_data {
-	SS_SEND_ADDITIONAL_INFO =3D 0x01
+	SS_SEND_ADDITIONAL_INFO =3D		0x01
 };
 =

 enum ss_subblock {
-	SS_FORWARDING =3D 0x00,
-	SS_STATUS_RESULT =3D 0x01,
-	SS_GSM_PASSWORD =3D 0x03,
-	SS_GSM_FORWARDING_INFO =3D 0x04,
-	SS_GSM_FORWARDING_FEATURE =3D 0x05,
-	SS_GSM_DATA =3D 0x08,
-	SS_GSM_BSC_INFO =3D 0x09,
-	SS_GSM_PASSWORD_INFO =3D 0x0B,
-	SS_GSM_INDICATE_PASSWORD_ERROR =3D 0x0D,
-	SS_GSM_INDICATE_ERROR =3D 0x0E,
-	SS_GSM_ADDITIONAL_INFO =3D 0x2F,
-	SS_GSM_USSD_STRING =3D 0x32
+	SS_FORWARDING =3D				0x00,
+	SS_STATUS_RESULT =3D			0x01,
+	SS_GSM_PASSWORD =3D			0x03,
+	SS_GSM_FORWARDING_INFO =3D		0x04,
+	SS_GSM_FORWARDING_FEATURE =3D		0x05,
+	SS_GSM_DATA =3D				0x08,
+	SS_GSM_BSC_INFO =3D			0x09,
+	SS_GSM_PASSWORD_INFO =3D			0x0B,
+	SS_GSM_INDICATE_PASSWORD_ERROR =3D	0x0D,
+	SS_GSM_INDICATE_ERROR =3D			0x0E,
+	SS_GSM_ADDITIONAL_INFO =3D		0x2F,
+	SS_GSM_USSD_STRING =3D			0x32
 };
 =

 enum ss_isi_cause {
-	SS_GSM_ACTIVE =3D 0x01,
-	SS_GSM_REGISTERED =3D 0x02,
-	SS_GSM_PROVISIONED =3D 0x04,
-	SS_GSM_QUIESCENT =3D 0x08
+	SS_GSM_ACTIVE =3D				0x01,
+	SS_GSM_REGISTERED =3D			0x02,
+	SS_GSM_PROVISIONED =3D			0x04,
+	SS_GSM_QUIESCENT =3D			0x08
 };
 =

 #endif /* __ISIMODEM_SS_H */
-- =

1.6.3.3


--===============2112080266747393055==--

