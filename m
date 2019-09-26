Content-Type: multipart/mixed; boundary="===============8648792960263810219=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 1/4] atmodem: sim: remove quectel serial vendor quirk
Date: Thu, 26 Sep 2019 21:27:22 +0200
Message-ID: <20190926192725.227285-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8648792960263810219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The sim inserted/initialized state is handled properly in the quectel
plugin now, so remove the "auto-initialized" quirk from the atmodem
sim driver.
---
 drivers/atmodem/sim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index dd42cac4..e750a139 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1354,7 +1354,6 @@ static void at_pin_send_cb(gboolean ok, GAtResult *re=
sult,
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_SIMCOM:
 	case OFONO_VENDOR_SIERRA:
-	case OFONO_VENDOR_QUECTEL_SERIAL:
 		/*
 		 * On ZTE modems, after pin is entered, SIM state is checked
 		 * by polling CPIN as their modem doesn't provide unsolicited
-- =

2.23.0


--===============8648792960263810219==--

