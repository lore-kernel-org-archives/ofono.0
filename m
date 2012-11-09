Content-Type: multipart/mixed; boundary="===============6141008835758550119=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH] atmodem: Poll SIM state after entering PIN
Date: Fri, 09 Nov 2012 14:16:53 +0100
Message-ID: <1352467013-1418-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6141008835758550119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

Encountered a problem of CME ERROR 14: SIM busy on Alcatel and Huawei modem.
The Huawei modem has a ^SIMST unsollicited sim state indication, but not all
Huawei modems support this.
So poll the SIM state, as was already done for ZTE modems.
---
 drivers/atmodem/sim.c    |    2 ++
 drivers/atmodem/vendor.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index ea3b180..9f05f4b 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1179,6 +1179,8 @@ static void at_pin_send_cb(gboolean ok, GAtResult *re=
sult,
 							FALSE, cbd, g_free);
 		return;
 	case OFONO_VENDOR_ZTE:
+	case OFONO_VENDOR_ALCATEL:
+	case OFONO_VENDOR_HUAWEI:
 		/*
 		 * On ZTE modems, after pin is entered, SIM state is checked
 		 * by polling CPIN as their modem doesn't provide unsolicited
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 80aed3e..0532d10 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -41,4 +41,5 @@ enum ofono_vendor {
 	OFONO_VENDOR_SIMCOM,
 	OFONO_VENDOR_ICERA,
 	OFONO_VENDOR_WAVECOM_Q2XXX,
+	OFONO_VENDOR_ALCATEL
 };
-- =

1.7.1


--===============6141008835758550119==--

