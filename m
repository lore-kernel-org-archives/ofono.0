Content-Type: multipart/mixed; boundary="===============5087854376902356341=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/sms: no mms support for Gemalto
Date: Thu, 27 Sep 2018 04:43:47 +0200
Message-ID: <20180927024347.4902-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5087854376902356341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sms.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 64169086..db04cb1e 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -220,9 +220,20 @@ static void at_cmgs(struct ofono_sms *sms, const unsig=
ned char *pdu,
 	int len;
 =

 	if (mms) {
-		snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
-		g_at_chat_send(data->chat, buf, none_prefix,
-				NULL, NULL, NULL);
+
+		switch (data->vendor) {
+
+		case OFONO_VENDOR_GEMALTO:
+			/* no mms support */
+			break;
+
+		default:
+			snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
+			g_at_chat_send(data->chat, buf, none_prefix,
+					NULL, NULL, NULL);
+			break;
+
+		}
 	}
 =

 	len =3D snprintf(buf, sizeof(buf), "AT+CMGS=3D%d\r", tpdu_len);
-- =

2.17.1


--===============5087854376902356341==--

