Content-Type: multipart/mixed; boundary="===============6446284612405229062=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 1/6] Change in at_cds_notify for status report.
Date: Fri, 04 Jun 2010 14:17:32 +0300
Message-ID: <1275650257-30593-2-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1275650257-30593-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6446284612405229062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sms.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 439beea..3dafbc9 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -283,16 +283,27 @@ static void at_cds_notify(GAtResult *result, gpointer=
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
+	if (strlen(hexpdu) > sizeof(pdu) * 2) {
+		ofono_error("Bad PDU length in CMT notification");
+		return;
+	}
+
+	DBG("Got new Status-Report PDU via CDS: %s, %d", hexpdu, tpdu_len);
+
+	/*Decode pdu and notify about new SMS status report*/
+	decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
+	ofono_sms_status_notify(sms, pdu, pdu_len, tpdu_len);
 =

 	/* We must acknowledge the PDU using CNMA */
 	if (data->cnma_ack_pdu)
-- =

1.6.0.4



--===============6446284612405229062==--

