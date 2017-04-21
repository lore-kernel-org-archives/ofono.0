Content-Type: multipart/mixed; boundary="===============8324066425643913292=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH 1/1] atmodem: Fix SMS reception for Gemalto modems
Date: Fri, 21 Apr 2017 16:06:56 +0200
Message-ID: <1492783616-5897-2-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <1492783616-5897-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8324066425643913292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SMS reception is not working for Gemalto modems because of +CMT parsing.
PDU length is the first argument of +CMT URCs in Gemalto modems.

Add a switch case on vendor info to handle Gemalto case.
Also handle acknowledgment, +CNMA takes only one parameter.

CMT parsing is moved from at_parse_cmt() to at_cmt_notify(). This
function is modified to match the style of at_cmgr_notify() and it
includes a switch case for CINTERION modems.
---
 drivers/atmodem/sms.c | 66 +++++++++++++++++++++++++++++------------------=
----
 plugins/gemalto.c     |  2 +-
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index b6876b0..5f9b922 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -319,26 +319,6 @@ static void at_cnma_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 				"Further SMS reception is not guaranteed");
 }
 =

-static gboolean at_parse_cmt(GAtResult *result,	const char **pdu, int *pdu=
len)
-{
-	GAtResultIter iter;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+CMT:"))
-		return FALSE;
-
-	if (!g_at_result_iter_skip_next(&iter))
-		return FALSE;
-
-	if (!g_at_result_iter_next_number(&iter, pdulen))
-		return FALSE;
-
-	*pdu =3D g_at_result_pdu(result);
-
-	return TRUE;
-}
-
 static inline void at_ack_delivery(struct ofono_sms *sms)
 {
 	struct sms_data *data =3D ofono_sms_get_data(sms);
@@ -347,11 +327,20 @@ static inline void at_ack_delivery(struct ofono_sms *=
sms)
 	DBG("");
 =

 	/* We must acknowledge the PDU using CNMA */
-	if (data->cnma_ack_pdu)
-		snprintf(buf, sizeof(buf), "AT+CNMA=3D1,%d\r%s",
-				data->cnma_ack_pdu_len, data->cnma_ack_pdu);
-	else /* Should be a safe fallback */
+	if (data->cnma_ack_pdu) {
+		switch (data->vendor) {
+		case OFONO_VENDOR_CINTERION:
+			snprintf(buf, sizeof(buf), "AT+CNMA=3D1");
+			break;
+		default:
+			snprintf(buf, sizeof(buf), "AT+CNMA=3D1,%d\r%s",
+					data->cnma_ack_pdu_len, data->cnma_ack_pdu);
+			break;
+		}
+	} else {
+		/* Should be a safe fallback */
 		snprintf(buf, sizeof(buf), "AT+CNMA=3D0");
+	}
 =

 	g_at_chat_send(data->chat, buf, none_prefix, at_cnma_cb, NULL, NULL);
 }
@@ -409,16 +398,34 @@ static void at_cmt_notify(GAtResult *result, gpointer=
 user_data)
 {
 	struct ofono_sms *sms =3D user_data;
 	struct sms_data *data =3D ofono_sms_get_data(sms);
+	GAtResultIter iter;
 	const char *hexpdu;
+	unsigned char pdu[176];
 	long pdu_len;
 	int tpdu_len;
-	unsigned char pdu[176];
 =

-	if (!at_parse_cmt(result, &hexpdu, &tpdu_len)) {
-		ofono_error("Unable to parse CMT notification");
-		return;
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CMT:"))
+		goto err;
+
+	switch (data->vendor) {
+	case OFONO_VENDOR_CINTERION:
+		if (!g_at_result_iter_next_number(&iter, &tpdu_len))
+			goto err;
+		break;
+	default:
+		if (!g_at_result_iter_skip_next(&iter))
+			goto err;
+
+		if (!g_at_result_iter_next_number(&iter, &tpdu_len))
+			goto err;
+
+		break;
 	}
 =

+	hexpdu =3D g_at_result_pdu(result);
+
 	if (strlen(hexpdu) > sizeof(pdu) * 2) {
 		ofono_error("Bad PDU length in CMT notification");
 		return;
@@ -431,6 +438,9 @@ static void at_cmt_notify(GAtResult *result, gpointer u=
ser_data)
 =

 	if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
 		at_ack_delivery(sms);
+
+err:
+	ofono_error("Unable to parse CMT notification");
 }
 =

 static void at_cmgr_notify(GAtResult *result, gpointer user_data)
diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index abc20ca..2870ce8 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -269,7 +269,7 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 =

 	ofono_phonebook_create(modem, 0, "atmodem", data->app);
 =

-	ofono_sms_create(modem, 0, "atmodem", data->app);
+	ofono_sms_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
 	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
-- =

1.9.1


--===============8324066425643913292==--

