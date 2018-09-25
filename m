Content-Type: multipart/mixed; boundary="===============2308281221079240841=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/sms: change vendor CINTERION in GEMALTO
Date: Tue, 25 Sep 2018 09:13:12 +0200
Message-ID: <20180925071313.25119-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2308281221079240841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index fb4d67ae..64169086 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -329,7 +329,7 @@ static inline void at_ack_delivery(struct ofono_sms *sm=
s)
 	/* We must acknowledge the PDU using CNMA */
 	if (data->cnma_ack_pdu) {
 		switch (data->vendor) {
-		case OFONO_VENDOR_CINTERION:
+		case OFONO_VENDOR_GEMALTO:
 			snprintf(buf, sizeof(buf), "AT+CNMA=3D1");
 			break;
 		default:
@@ -411,10 +411,10 @@ static void at_cmt_notify(GAtResult *result, gpointer=
 user_data)
 		goto err;
 =

 	switch (data->vendor) {
-	case OFONO_VENDOR_CINTERION:
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


--===============2308281221079240841==--

