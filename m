Content-Type: multipart/mixed; boundary="===============0143677018717689495=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] atmodem: Use ZTE specific vendor quirk for SMS status report
 support
Date: Fri, 06 Apr 2012 11:47:32 +0200
Message-ID: <1333705652-5621-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0143677018717689495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sms.c |   37 ++++++++++++++++++++++++++++---------
 1 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index c31eb39..27dc2c0 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -319,17 +319,16 @@ static void at_cnma_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 				"Further SMS reception is not guaranteed");
 }
 =

-static gboolean at_parse_pdu_common(GAtResult *result, const char *prefix,
-					const char **pdu, int *pdulen)
+static gboolean at_parse_cmt(GAtResult *result,	const char **pdu, int *pdu=
len)
 {
 	GAtResultIter iter;
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (!g_at_result_iter_next(&iter, prefix))
+	if (!g_at_result_iter_next(&iter, "+CMT:"))
 		return FALSE;
 =

-	if (!strcmp(prefix, "+CMT:") && !g_at_result_iter_skip_next(&iter))
+	if (!g_at_result_iter_skip_next(&iter))
 		return FALSE;
 =

 	if (!g_at_result_iter_next_number(&iter, pdulen))
@@ -365,11 +364,26 @@ static void at_cds_notify(GAtResult *result, gpointer=
 user_data)
 	int tpdu_len;
 	const char *hexpdu;
 	unsigned char pdu[176];
+	GAtResultIter iter;
 =

-	if (!at_parse_pdu_common(result, "+CDS:", &hexpdu, &tpdu_len)) {
-		ofono_error("Unable to parse CDS notification");
-		return;
-	}
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CDS:"))
+		goto err;
+
+	/*
+	 * Quirk for ZTE firmware which is not compliant with 27.005
+	 * The +CDS syntax used by ZTE is including a comma before the length
+	 * +CDS: ,<length><CR><LF><pdu>
+	 * As a result, we need to skip this omitted subparameter
+	 */
+	if (data->vendor =3D=3D OFONO_VENDOR_ZTE)
+		g_at_result_iter_skip_next(&iter);
+
+	if (!g_at_result_iter_next_number(&iter, &tpdu_len))
+		goto err;
+
+	hexpdu =3D g_at_result_pdu(result);
 =

 	if (strlen(hexpdu) > sizeof(pdu) * 2) {
 		ofono_error("Bad PDU length in CDS notification");
@@ -384,6 +398,11 @@ static void at_cds_notify(GAtResult *result, gpointer =
user_data)
 =

 	if (data->cnma_enabled)
 		at_ack_delivery(sms);
+
+	return;
+
+err:
+	ofono_error("Unable to parse CDS notification");
 }
 =

 static void at_cmt_notify(GAtResult *result, gpointer user_data)
@@ -395,7 +414,7 @@ static void at_cmt_notify(GAtResult *result, gpointer u=
ser_data)
 	int tpdu_len;
 	unsigned char pdu[176];
 =

-	if (!at_parse_pdu_common(result, "+CMT:", &hexpdu, &tpdu_len)) {
+	if (!at_parse_cmt(result, &hexpdu, &tpdu_len)) {
 		ofono_error("Unable to parse CMT notification");
 		return;
 	}
-- =

1.7.1


--===============0143677018717689495==--

