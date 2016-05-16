Content-Type: multipart/mixed; boundary="===============2327919968205990502=="
MIME-Version: 1.0
From: Suman Mallela <suman.m@intel.com>
Subject: [PATCH] rilmodem: rest the sim PIN retries when the correct pin
 enters.
Date: Mon, 16 May 2016 12:54:23 +0530
Message-ID: <1463383463-13833-1-git-send-email-suman.m@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2327919968205990502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The SIM PIN retires where not getting reset
when the correct PIN/PUK enters.
---
 drivers/rilmodem/sim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index 4ae2e40..a2c1567 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -1116,6 +1116,8 @@ static void ril_pin_change_state_cb(struct ril_msg *m=
essage, gpointer user_data)
 		 */
 		if (message->error =3D=3D RIL_E_PASSWORD_INCORRECT)
 			sd->retries[sd->passwd_type] =3D parcel_r_int32(&rilp);
+		else  =

+			sd->retries[sd->passwd_type] =3D -1;
 =

 		g_ril_append_print_buf(sd->ril, "{%d}",
 					sd->retries[sd->passwd_type]);
-- =

1.9.1


--===============2327919968205990502==--

