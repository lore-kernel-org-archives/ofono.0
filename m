Content-Type: multipart/mixed; boundary="===============7413557224612375976=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH] hfpmodem: Handle repeated held call indicator
Date: Mon, 11 Jan 2016 18:19:35 +0100
Message-ID: <1452532775-8557-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7413557224612375976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An issue with iPhone 5C iOS 9.2 triggers desynchronization in call
states. When an active call is put on hold and another call arrives,
it is in WAITING state. It should be possible to answer it by issuing
AT+CHLD=3D2 but the phone changes its state to INCOMING so ATA should be
used. This change is advertised by sending callheld:2 event, but it is
not handled. This event can be used to trigger CLCC poll to synchronize
call states.

+CIEV: 3,1   <- first call arrives
AT+CLCC
+CLCC: 1,1,4,0,0,"01234567890",129
OK
RING
+CLIP: "01234567890",129
ATA
OK
+CIEV: 2,1
+CIEV: 3,0.
AT+CHLD=3D2.$  <- first call is put on hold
OK
+CIEV: 7,2   <- notification confirming that call #1 is on hold
+CCWA: "09876543210",129,1     <- second call arrives
+CIEV: 7,2
+CIEV: 3,1
AT+CLCC
+CLCC: 1,1,1,0,0,"01234567890",129
+CLCC: 2,1,5,0,0,"09876543210",129 <- new call is still in WAITING state
OK
+CIEV: 7,2 <- phone iternally promotes WAITING call to INCOMING
AT+CHLD=3D2  <- there is no WAITING call anymore, ATA should be used
+CME ERROR:3
---
 drivers/hfpmodem/voicecall.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index d0e9353796c335a1fc876779345eedeb6556345d..2b7524e9cccbbdb9d8ce1e47a91=
d2e32ccfbb6a8 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -1111,6 +1111,18 @@ static void ciev_callheld_notify(struct ofono_voicec=
all *vc,
 			vd->clcc_source =3D g_timeout_add(POLL_CLCC_DELAY,
 							poll_clcc, vc);
 		}
+		else {
+			if (vd->clcc_source)
+				g_source_remove(vd->clcc_source);
+
+			/* We got a notification that there is a held call
+			 * and no active call but we already are in such state.
+			 * Let's schedule a poll to see what happened.
+			 */
+			vd->clcc_source =3D g_timeout_add(POLL_CLCC_DELAY,
+							poll_clcc, vc);
+		}
+
 	}
 =

 	vd->cind_val[HFP_INDICATOR_CALLHELD] =3D value;
-- =

1.9.3

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============7413557224612375976==--

