Content-Type: multipart/mixed; boundary="===============4320964081928549331=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH] rilmodem: fix sim_status_cb debug logging
Date: Fri, 04 Dec 2015 16:15:03 -0500
Message-ID: <1449263703-14123-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4320964081928549331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During the re-factoring of rilmodem's sim atom
messaging code, the sim_status_cb function's
RIL tracing code was converted to DBG calls.
This change adds the same prefix to DBG/trace
calls when a single message's parameters span
more than one DBG call. This makes it easier
to filter out trace messages when looking at a
log file.
---
 drivers/rilmodem/sim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index ada7c20..5307d67 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -777,9 +777,11 @@ static void sim_status_cb(struct ril_msg *message, gpo=
inter user_data)
 				message->serial_no,
 				"RIL_REQUEST_GET_SIM_STATUS");
 =

-	DBG("card_state=3D%d,universal_pin_state=3D%d,"
+	DBG("[%d,%04d]< card_state=3D%d,universal_pin_state=3D%d,"
 			"gsm_umts_index=3D%d,cdma_index=3D%d,ims_index=3D%d,"
 			"num_apps=3D%d",
+			g_ril_get_slot(sd->ril),
+			message->serial_no,
 			card_state, universal_pin_state,
 			gsm_umts_app_index, cdma_app_index, ims_app_index,
 			num_apps);
@@ -886,7 +888,8 @@ static void sim_status_cb(struct ril_msg *message, gpoi=
nter user_data)
 	g_free(sd->aid_str);
 	sd->aid_str =3D parcel_r_string(&rilp);	/* AID */
 =

-	DBG("app_type: %d, passwd_state: %d, aid_str (AID): %s",
+	DBG("[%d,%04d]< app_type: %d, passwd_state: %d, aid_str (AID): %s",
+		g_ril_get_slot(sd->ril), message->serial_no,
 		sd->app_type, sd->passwd_state, sd->aid_str);
 =

 	/*
-- =

2.1.4


--===============4320964081928549331==--

