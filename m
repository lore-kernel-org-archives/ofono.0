Content-Type: multipart/mixed; boundary="===============6242939690819964451=="
MIME-Version: 1.0
From: pasi.miettinen@ixonos.com
Subject: [PATCH 02/11] Made needed changes to at_cds_notify() for status
 report and corrected at_cmgl_cpms_cb() to meet the ISO standard.
Date: Thu, 27 May 2010 13:54:41 +0300
Message-ID: <1274957690-4893-2-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1274957690-4893-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6242939690819964451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pasi Miettinen <pasi.miettinen@ixonos.com>

---
 drivers/atmodem/sms.c |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 27de77b..a1c885b 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -283,16 +283,28 @@ static void at_cds_notify(GAtResult *result, gpointer=
 user_data)
 {
 	struct ofono_sms *sms =3D user_data;
 	struct sms_data *data =3D ofono_sms_get_data(sms);
-	int pdulen;
-	const char *pdu;
+	long pdu_len;
+	int tpdu_len;
+	const char *hexpdu;
+	unsigned char pdu[176];
 	char buf[256];
 =

-	if (!at_parse_pdu_common(result, "+CDS:", &pdu, &pdulen)) {
+	if (!at_parse_pdu_common(result, "+CDS:", &hexpdu, &tpdu_len)) {
 		ofono_error("Unable to parse CDS notification");
 		return;
 	}
 =

-	DBG("Got new Status-Report PDU via CDS: %s, %d", pdu, pdulen);
+	/*Is this necessary?*/
+	if (strlen(hexpdu) > sizeof(pdu) * 2) {
+		ofono_error("Bad PDU length in CMT notification");
+		return;
+	}
+
+	DBG("Got new Status-Report PDU via CDS: %s, %d", hexpdu, tpdu_len);
+
+	/*Decode pdu and notify about new SMS status report*/
+	decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
+	ofono_sms_status_report_notify(sms, pdu, pdu_len, tpdu_len);
 =

 	/* We must acknowledge the PDU using CNMA */
 	if (data->cnma_ack_pdu)
@@ -545,13 +557,13 @@ static void at_cmgl_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 static void at_cmgl_cpms_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 =

-	DBG("PASS AT+CMGL=3D4!!!");
-	return;
-
 	struct cpms_request *req =3D user_data;
 	struct ofono_sms *sms =3D req->sms;
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 =

+	DBG("PASS AT+CMGL=3D4!!!");
+	return;
+
 	if (!ok) {
 		ofono_error("Initial CPMS request failed");
 		at_cmgl_done(sms);
-- =

1.6.0.4


--===============6242939690819964451==--

