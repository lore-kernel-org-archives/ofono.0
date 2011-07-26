Content-Type: multipart/mixed; boundary="===============8169873773159806340=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] hfpmodem: fix network status
Date: Tue, 26 Jul 2011 16:56:53 +0200
Message-ID: <1311692213-18020-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8169873773159806340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When receiving roaming indicator update to 0 (no roaming) network
registration status should be updated with latest value of service
indicator.
---
 drivers/hfpmodem/network-registration.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index 4cb2b14..7d26424 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -130,10 +130,14 @@ static void ciev_notify(GAtResult *result, gpointer u=
ser_data)
 	} else if (index =3D=3D nd->cind_pos[HFP_INDICATOR_ROAM]) {
 		nd->cind_val[HFP_INDICATOR_ROAM] =3D value;
 =

-		if (value) {
+		if (value)
 			status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
-			ofono_netreg_status_notify(netreg, status, -1, -1, -1);
-		}
+		else if (nd->cind_val[HFP_INDICATOR_SERVICE])
+			status =3D NETWORK_REGISTRATION_STATUS_REGISTERED;
+		else
+			status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+
+		ofono_netreg_status_notify(netreg, status, -1, -1, -1);
 	} else if (index =3D=3D nd->cind_pos[HFP_INDICATOR_SIGNAL]) {
 		nd->cind_val[HFP_INDICATOR_SIGNAL] =3D value;
 		ofono_netreg_strength_notify(netreg, value * 20);
-- =

1.7.1


--===============8169873773159806340==--

