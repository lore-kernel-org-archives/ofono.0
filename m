Content-Type: multipart/mixed; boundary="===============2385869398292235626=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH v4] gprs: Quectel EC21 does not understand AT+CPSB
Date: Mon, 17 Aug 2020 09:58:07 +0200
Message-ID: <20200817075807.491927-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2385869398292235626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

The Quectel EC21 modem does not understand the AT+CPSB command, and we
did not find a suitable replacement in the
Quectel_EC25&EC21_AT_Commands_Manual_V1.3.pdf
AT+CPSB gives an error on this modem, so we just skip it.
---
 drivers/atmodem/gprs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index b637f733..d829e2e6 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -624,6 +624,8 @@ static void gprs_initialized(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		g_at_chat_send(gd->chat, "AT#PSNT=3D1", none_prefix,
 						NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_QUECTEL_EC2X:
+		break;
 	default:
 		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
 						FALSE, gprs, NULL);
-- =

2.27.0

--===============2385869398292235626==--

