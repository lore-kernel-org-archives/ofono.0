Content-Type: multipart/mixed; boundary="===============8265622178608813685=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH 7/7] Fix: isimodem handling of call barring services.
Date: Thu, 18 Mar 2010 16:44:31 +0200
Message-ID: <1268923471-29059-7-git-send-email-ppessi@gmail.com>
In-Reply-To: <1268923471-29059-6-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8265622178608813685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>


Signed-off-by: Pekka Pessi <Pekka.Pessi@nokia.com>
---
 drivers/isimodem/call-barring.c |   64 ++++++++++++++++++++---------------=
---
 drivers/isimodem/ss.h           |   28 +++++++++--------
 2 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index 6487ae8..6261b23 100644
--- a/drivers/isimodem/call-barring.c
+++ b/drivers/isimodem/call-barring.c
@@ -85,14 +85,13 @@ static void isi_set(struct ofono_call_barring *barr, co=
nst char *lock,
 	struct barr_data *bd =3D ofono_call_barring_get_data(barr);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(barr, cb, data);
 	int ss_code;
-	char *ucs2 =3D NULL;
 =

 	unsigned char msg[] =3D {
 		SS_SERVICE_REQ,
 		enable ? SS_ACTIVATION : SS_DEACTIVATION,
 		SS_ALL_TELE_AND_BEARER,
 		0, 0,				/* Supplementary services code */
-		SS_SEND_ADDITIONAL_INFO,
+		SS_SEND_ADDITIONAL_INFO,	/* ? */
 		1,				/* Subblock count */
 		SS_GSM_PASSWORD,
 		28,				/* Subblock length */
@@ -105,7 +104,9 @@ static void isi_set(struct ofono_call_barring *barr, co=
nst char *lock,
 	DBG("lock code %s enable %d class %d password %s\n",
 		lock, enable, cls, passwd);
 =

-	if (!cbd || !passwd || strlen(passwd) > 4 || cls !=3D 7)
+	if (!cbd || !lock)
+		goto error;
+	if (!passwd || strlen(passwd) !=3D 4 || strspn(passwd, "0123456789") !=3D=
 4)
 		goto error;
 =

 	if (strcmp(lock, "AO") =3D=3D 0)
@@ -120,23 +121,23 @@ static void isi_set(struct ofono_call_barring *barr, =
const char *lock,
 		ss_code =3D SS_GSM_BARR_ALL_IN_ROAM;
 	else if (strcmp(lock, "AB") =3D=3D 0)
 		ss_code =3D SS_GSM_ALL_BARRINGS;
+	else if (enable)
+		/* Only Deactivate supports AG (333) and AC (353) */
+		goto error;
 	else if (strcmp(lock, "AG") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_ALL_OUT;
+		ss_code =3D SS_GSM_OUTGOING_BARR_SERV;
 	else if (strcmp(lock, "AC") =3D=3D 0)
-		ss_code =3D SS_GSM_BARR_ALL_IN;
+		ss_code =3D SS_GSM_INCOMING_BARR_SERV;
 	else
 		goto error;
 =

 	msg[3] =3D ss_code >> 8;
 	msg[4] =3D ss_code & 0xFF;
 =

-	ucs2 =3D g_convert(passwd, 4, "UCS-2BE", "UTF-8//TRANSLIT",
-				NULL, NULL, NULL);
-	if (ucs2 =3D=3D NULL)
-		goto error;
-
-	memcpy((char *)msg + 9, ucs2, 8);
-	g_free(ucs2);
+	msg[10] =3D passwd[0];
+	msg[12] =3D passwd[1];
+	msg[14] =3D passwd[2];
+	msg[16] =3D passwd[4];
 =

 	if (g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
 				set_resp_cb, cbd))
@@ -274,13 +275,13 @@ static void isi_query(struct ofono_call_barring *barr=
, const char *lock, int cls
 		SS_INTERROGATION,
 		SS_ALL_TELE_AND_BEARER,
 		0, 0,				/* Supplementary services code */
-		SS_SEND_ADDITIONAL_INFO,
+		SS_SEND_ADDITIONAL_INFO,	/* Get BER-encoded result, too */
 		0				/* Subblock count */
 	};
 =

 	DBG("barring query lock code %s class %d\n", lock, cls);
 =

-	if (!cbd || cls !=3D 7)
+	if (!cbd)
 		goto error;
 =

 	if (strcmp(lock, "AO") =3D=3D 0)
@@ -344,7 +345,6 @@ static void isi_set_passwd(struct ofono_call_barring *b=
arr, const char *lock,
 	struct barr_data *bd =3D ofono_call_barring_get_data(barr);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(barr, cb, data);
 	int ss_code;
-	char *ucs2 =3D NULL;
 =

 	unsigned char msg[] =3D {
 		SS_SERVICE_REQ,
@@ -361,7 +361,11 @@ static void isi_set_passwd(struct ofono_call_barring *=
barr, const char *lock,
 		0, 0				/* Filler */
 	};
 =

-	if (!cbd || strlen(old_passwd) > 4 || strlen(new_passwd) > 4)
+	if (!cbd)
+		goto error;
+	if (strlen(old_passwd) !=3D 4 || strspn(old_passwd, "0123456789") !=3D 4)
+		goto error;
+	if (strlen(new_passwd) !=3D 4 || strspn(new_passwd, "0123456789") !=3D 4)
 		goto error;
 =

 	DBG("lock code %s old password %s new password %s\n",
@@ -369,28 +373,28 @@ static void isi_set_passwd(struct ofono_call_barring =
*barr, const char *lock,
 =

 	if (strcmp(lock, "AB") =3D=3D 0)
 		ss_code =3D SS_GSM_ALL_BARRINGS;
+	else if (strcmp(lock, "") =3D=3D 0)
+		ss_code =3D 0;
 	else
 		goto error;
 =

 	msg[3] =3D ss_code >> 8;
 	msg[4] =3D ss_code & 0xFF;
 =

-	ucs2 =3D g_convert(old_passwd, 4, "UCS-2BE", "UTF-8//TRANSLIT",
-				NULL, NULL, NULL);
-	if (ucs2 =3D=3D NULL)
-		goto error;
-
-	memcpy((char *)msg + 9, ucs2, 8);
-	g_free(ucs2);
+	msg[10] =3D old_passwd[0];
+	msg[12] =3D old_passwd[1];
+	msg[14] =3D old_passwd[2];
+	msg[16] =3D old_passwd[4];
 =

-	ucs2 =3D g_convert(new_passwd, 4, "UCS-2BE", "UTF-8//TRANSLIT",
-				NULL, NULL, NULL);
-	if (ucs2 =3D=3D NULL)
-		goto error;
+	msg[18] =3D new_passwd[0];
+	msg[20] =3D new_passwd[1];
+	msg[22] =3D new_passwd[2];
+	msg[24] =3D new_passwd[4];
 =

-	memcpy((char *)msg + 17, ucs2, 8);
-	memcpy((char *)msg + 25, ucs2, 8);
-	g_free(ucs2);
+	msg[26] =3D new_passwd[0];
+	msg[28] =3D new_passwd[1];
+	msg[30] =3D new_passwd[2];
+	msg[32] =3D new_passwd[4];
 =

 	if (g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
 				set_passwd_resp_cb, cbd))
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


--===============8265622178608813685==--

