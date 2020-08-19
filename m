Content-Type: multipart/mixed; boundary="===============0446269654587855435=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 2/2] atmodem: Deactivate AT+CPSB for quectel serial modems
Date: Wed, 19 Aug 2020 14:13:39 +0200
Message-ID: <20200819121339.879624-2-poeschel@lemonage.de>
In-Reply-To: <20200819121339.879624-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0446269654587855435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

There are at the moment two quectel modems in ofono vendored as
OFONO_VENDOR_QUECTEL_SERIAL: The M95 and the MC60.
Both modems are GSM only modems, and their official documentation does
not mention the AT+CPSB command.
I have a M95 here that gives an error on issuing the AT+CPSB=3D1 command.
So skip this command for these two modems.
---
 drivers/atmodem/gprs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 3900b95b..f4c714e8 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -626,6 +626,7 @@ static void gprs_initialized(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 						NULL, NULL, NULL);
 		break;
 	case OFONO_VENDOR_QUECTEL_EC2X:
+	case OFONO_VENDOR_QUECTEL_SERIAL:
 		break;
 	default:
 		g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify,
-- =

2.27.0

--===============0446269654587855435==--

