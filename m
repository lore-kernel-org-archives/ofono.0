Content-Type: multipart/mixed; boundary="===============1111843545286409131=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH 1/2] atmodem: add Sierra to be polled after entering pin
Date: Mon, 02 Feb 2015 10:32:44 +0100
Message-ID: <1422869565-11746-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1111843545286409131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

Sierra modem will return "CME ERROR: 14" when polled right after pin has
been entered. Use the existing vendor quirk to handle this.
---
 drivers/atmodem/sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index c128e33..054f548 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1350,6 +1350,7 @@ static void at_pin_send_cb(gboolean ok, GAtResult *re=
sult,
 	case OFONO_VENDOR_ALCATEL:
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_SIMCOM:
+	case OFONO_VENDOR_SIERRA:
 		/*
 		 * On ZTE modems, after pin is entered, SIM state is checked
 		 * by polling CPIN as their modem doesn't provide unsolicited
-- =

1.9.2


--===============1111843545286409131==--

