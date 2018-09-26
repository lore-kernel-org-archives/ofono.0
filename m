Content-Type: multipart/mixed; boundary="===============6083813045431513799=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/sms: no mms support for Gemalto
Date: Wed, 26 Sep 2018 13:32:32 +0200
Message-ID: <20180926113232.22923-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6083813045431513799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sms.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 64d0f6e8..db04cb1e 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -219,16 +219,21 @@ static void at_cmgs(struct ofono_sms *sms, const unsi=
gned char *pdu,
 	char buf[512];
 	int len;
 =

-	switch(data->vendor) {
-	case OFONO_VENDOR_GEMALTO:
-		break;
-	default:
-		if (mms) {
+	if (mms) {
+
+		switch (data->vendor) {
+
+		case OFONO_VENDOR_GEMALTO:
+			/* no mms support */
+			break;
+
+		default:
 			snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
 			g_at_chat_send(data->chat, buf, none_prefix,
 					NULL, NULL, NULL);
+			break;
+
 		}
-		break;
 	}
 =

 	len =3D snprintf(buf, sizeof(buf), "AT+CMGS=3D%d\r", tpdu_len);
-- =

2.17.1


--===============6083813045431513799==--

