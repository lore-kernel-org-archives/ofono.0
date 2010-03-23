Content-Type: multipart/mixed; boundary="===============3957841321460620383=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH] Fix: simplify isimodem call-barring driver.
Date: Tue, 23 Mar 2010 19:46:12 +0200
Message-ID: <1269366372-19526-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3957841321460620383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Add support for lock codes AG and AC (MMI codes 333 and 353. respectively).
---
 drivers/isimodem/call-barring.c |  153 ++++++++++++-----------------------=
----
 drivers/isimodem/ss.h           |   28 ++++----
 2 files changed, 63 insertions(+), 118 deletions(-)

diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index 6487ae8..b0246fa 100644
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
+				      set_resp_cb, cbd))
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
+				      query_resp_cb, cbd))
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
+	    lock, ss_code, old_passwd, new_passwd);
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
+	    g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
 				set_passwd_resp_cb, cbd))
 		return;
 =

-error:
 	CALLBACK_WITH_FAILURE(cb, data);
 	g_free(cbd);
 }
diff --git a/drivers/isimodem/ss.h b/drivers/isimodem/ss.h
index 7c20bcc..2313ae6 100644
--- a/drivers/isimodem/ss.h
+++ b/drivers/isimodem/ss.h
@@ -81,19 +81,21 @@ enum ss_basic_service_codes {
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
+	SS_GSM_ALL_FORWARDINGS =3D 002,
+	SS_GSM_ALL_COND_FORWARDINGS =3D 004,
+	SS_GSM_FORW_UNCONDITIONAL =3D 21,
+	SS_GSM_BARR_ALL_OUT =3D 33,
+	SS_GSM_OUTGOING_BARR_SERV =3D 333,
+	SS_GSM_INCOMING_BARR_SERV =3D 353,
+	SS_GSM_BARR_ALL_IN =3D 35,
+	SS_GSM_CALL_WAITING =3D 43,
+	SS_GSM_FORW_NO_REPLY =3D 61,
+	SS_GSM_FORW_NO_REACH =3D 62,
+	SS_GSM_FORW_BUSY =3D 67,
+	SS_GSM_ALL_BARRINGS =3D 330,
+	SS_GSM_BARR_OUT_INTER =3D 331,
+	SS_GSM_BARR_OUT_INTER_EXC_HOME =3D 332,
+	SS_GSM_BARR_ALL_IN_ROAM =3D 351,
 };
 =

 enum ss_response_data {
-- =

1.6.3.3


--===============3957841321460620383==--

