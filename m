Content-Type: multipart/mixed; boundary="===============3799788137835171556=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/sms: added vendor Gemalto support.
Date: Sun, 23 Sep 2018 07:31:14 +0200
Message-ID: <20180923053114.8428-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3799788137835171556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cinterion and Gemalto overlap for now, but
eventually Cinterion will be removed.
---
 drivers/atmodem/sms.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index fb4d67ae..7944c4e4 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -219,10 +219,16 @@ static void at_cmgs(struct ofono_sms *sms, const unsi=
gned char *pdu,
 	char buf[512];
 	int len;
 =

-	if (mms) {
-		snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
-		g_at_chat_send(data->chat, buf, none_prefix,
-				NULL, NULL, NULL);
+	switch(data->vendor) {
+	case OFONO_VENDOR_GEMALTO:
+		break;
+	default:
+		if (mms) {
+			snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
+			g_at_chat_send(data->chat, buf, none_prefix,
+					NULL, NULL, NULL);
+		}
+		break;
 	}
 =

 	len =3D snprintf(buf, sizeof(buf), "AT+CMGS=3D%d\r", tpdu_len);
@@ -330,6 +336,7 @@ static inline void at_ack_delivery(struct ofono_sms *sm=
s)
 	if (data->cnma_ack_pdu) {
 		switch (data->vendor) {
 		case OFONO_VENDOR_CINTERION:
+		case OFONO_VENDOR_GEMALTO:
 			snprintf(buf, sizeof(buf), "AT+CNMA=3D1");
 			break;
 		default:
@@ -412,9 +419,10 @@ static void at_cmt_notify(GAtResult *result, gpointer =
user_data)
 =

 	switch (data->vendor) {
 	case OFONO_VENDOR_CINTERION:
+	case OFONO_VENDOR_GEMALTO:
 		if (!g_at_result_iter_next_number(&iter, &tpdu_len)) {
 			/*
-			 * Some cinterions modems (ALS3,PLS8...), act in
+			 * Some Gemalto modems (ALS3,PLS8...), act in
 			 * accordance with 3GPP 27.005.  So we need to skip
 			 * the first (<alpha>) field
 			 *  \r\n+CMT: ,23\r\nCAFECAFECAFE... ...\r\n
-- =

2.17.1


--===============3799788137835171556==--

