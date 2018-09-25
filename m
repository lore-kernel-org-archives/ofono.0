Content-Type: multipart/mixed; boundary="===============6223098921693858998=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/sms: no mms support for gemalto
Date: Tue, 25 Sep 2018 15:19:37 +0200
Message-ID: <20180925131937.19265-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6223098921693858998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sms.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 64169086..64d0f6e8 100644
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
-- =

2.17.1


--===============6223098921693858998==--

