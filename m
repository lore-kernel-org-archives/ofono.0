Content-Type: multipart/mixed; boundary="===============4493288845456111650=="
MIME-Version: 1.0
From: christopher.vogl@hale.at
Subject: [PATCH] sim: return from cpin when sim ready for telit
Date: Fri, 14 Dec 2012 15:19:41 +0100
Message-ID: <1355494782-31572-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4493288845456111650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christopher Vogl <christopher.vogl@hale.at>

Especially for Telit HE910 it is not enough to wait for
entering a PIN code.
If we do not wait for #QSS: 3, subsequent commands,
like +CMER will report SIM BUSY and the network registration
atom will be removed as a consequence.
---
 drivers/atmodem/sim.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 4095337..4448e3d 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1178,7 +1178,7 @@ static void at_qss_notify(GAtResult *result, gpointer=
 user_data)
 		return;
 =

 	switch (state) {
-	case 2:	/* PIN unlocked */
+	case 3:	/* SIM inserted and READY. */
 		break;
 	default:
 		return;
-- =

1.7.7.6


--===============4493288845456111650==--

