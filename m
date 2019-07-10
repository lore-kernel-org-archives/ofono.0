Content-Type: multipart/mixed; boundary="===============3812091386498114119=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 1/9] atmodem: sms: add quectel m95 quirks
Date: Wed, 10 Jul 2019 23:51:40 +0200
Message-ID: <20190710215148.78083-2-martin@geanix.com>
In-Reply-To: <20190710215148.78083-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3812091386498114119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

CNMA isn't mentioned in the m95 documentation, but trial'n'error has
revealed some details:
 * the CSMS query returns the list (0,128) instead of a range
 * CNMA is enabled by setting 128 as CSMS service
 * once enabled, SMS deliveries are acked by sending AT+CNMA without a
   value setting

Add m95 quirks to the atmodem driver, so that CNMA is correctly
detected, configured, and used.
---
 drivers/atmodem/sms.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 2f869da6..c3c82afb 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -339,6 +339,9 @@ static inline void at_ack_delivery(struct ofono_sms *sm=
s)
 		case OFONO_VENDOR_GEMALTO:
 			snprintf(buf, sizeof(buf), "AT+CNMA=3D1");
 			break;
+		case OFONO_VENDOR_QUECTEL_M95:
+			snprintf(buf, sizeof(buf), "AT+CNMA");
+			break;
 		default:
 			snprintf(buf, sizeof(buf), "AT+CNMA=3D1,%d\r%s",
 					data->cnma_ack_pdu_len,
@@ -1238,7 +1241,7 @@ static void at_csms_status_cb(gboolean ok, GAtResult =
*result,
 		if (!g_at_result_iter_next_number(&iter, &mo))
 			goto out;
 =

-		if (service =3D=3D 1)
+		if (service =3D=3D 1 || service =3D=3D 128)
 			data->cnma_enabled =3D TRUE;
 =

 		if (mt =3D=3D 1 && mo =3D=3D 1)
@@ -1269,10 +1272,10 @@ static void at_csms_query_cb(gboolean ok, GAtResult=
 *result,
 {
 	struct ofono_sms *sms =3D user_data;
 	struct sms_data *data =3D ofono_sms_get_data(sms);
-	gboolean cnma_supported =3D FALSE;
 	GAtResultIter iter;
 	int status_min, status_max;
 	char buf[128];
+	int csms =3D 0;
 =

 	if (!ok)
 		return at_sms_not_supported(sms);
@@ -1285,14 +1288,25 @@ static void at_csms_query_cb(gboolean ok, GAtResult=
 *result,
 	if (!g_at_result_iter_open_list(&iter))
 		goto out;
 =

-	while (g_at_result_iter_next_range(&iter, &status_min, &status_max))
+	switch (data->vendor) {
+	case OFONO_VENDOR_QUECTEL_M95:
+		g_at_result_iter_next_number(&iter, &status_min);
+		g_at_result_iter_next_number(&iter, &status_max);
 		if (status_min <=3D 1 && 1 <=3D status_max)
-			cnma_supported =3D TRUE;
+			csms =3D 128;
+		break;
+	default:
+		while (g_at_result_iter_next_range(&iter, &status_min,
+							&status_max))
+			if (status_min <=3D 1 && 1 <=3D status_max)
+				csms =3D 1;
+		break;
+	}
 =

 	DBG("CSMS query parsed successfully");
 =

 out:
-	snprintf(buf, sizeof(buf), "AT+CSMS=3D%d", cnma_supported ? 1 : 0);
+	snprintf(buf, sizeof(buf), "AT+CSMS=3D%d", csms);
 	g_at_chat_send(data->chat, buf, csms_prefix,
 			at_csms_set_cb, sms, NULL);
 }
-- =

2.22.0


--===============3812091386498114119==--

