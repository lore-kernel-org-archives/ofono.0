Content-Type: multipart/mixed; boundary="===============1259079044915249775=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH 2/2] atmodem: Add use of pin event *EPEV after sending PUK.
Date: Tue, 02 Nov 2010 16:10:29 +0100
Message-ID: <1288710629-10199-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1259079044915249775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

The MBM/STE modems send the unsolicited result code *EPEV to report when =

the PIN code has been inserted and accepted.
---
 drivers/atmodem/sim.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 94658f2..3abd1d8 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -671,6 +671,16 @@ static void at_pin_send_puk_cb(gboolean ok, GAtResult =
*result,
 							at_xsim_notify,
 							FALSE, cbd, g_free);
 		return;
+	case OFONO_VENDOR_MBM:
+		/*
+		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN
+		 * for a moment after successful AT+CPIN=3D"..", but then
+		 * sends *EPEV when that changes.
+		 */
+		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
+							at_epev_notify,
+							FALSE, cbd, g_free);
+		return;
 	}
 =

 done:
-- =

1.7.0.4


--===============1259079044915249775==--

