Content-Type: multipart/mixed; boundary="===============4258901814631879277=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] atmodem: Remove at_pin_send_puk_cb,
 and use at_pin_send_cb instead.
Date: Wed, 03 Nov 2010 15:35:27 +0100
Message-ID: <1288794927-11647-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4258901814631879277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

When adding the use of pin event *EPEV also to at_pin_send_puk_cb,
it becomes identical to at_pin_send_cb, and can be removed.
---
New patch, this one should apply:)

 drivers/atmodem/sim.c |   44 +-------------------------------------------
 1 files changed, 1 insertions(+), 43 deletions(-)


diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 3abd1d8..9cfdc65 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -647,48 +647,6 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void at_pin_send_puk_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
-{
-	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D cbd->user;
-	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-
-	if (!ok)
-		goto done;
-
-	switch (sd->vendor) {
-	case OFONO_VENDOR_IFX:
-		/*
-		 * On the IFX modem, AT+CPIN? can return READY too
-		 * early and so use +XSIM notification to detect
-		 * the ready state of the SIM.
-		 */
-		sd->ready_id =3D g_at_chat_register(sd->chat, "+XSIM",
-							at_xsim_notify,
-							FALSE, cbd, g_free);
-		return;
-	case OFONO_VENDOR_MBM:
-		/*
-		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN
-		 * for a moment after successful AT+CPIN=3D"..", but then
-		 * sends *EPEV when that changes.
-		 */
-		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
-							at_epev_notify,
-							FALSE, cbd, g_free);
-		return;
-	}
-
-done:
-	cb(&error, cbd->data);
-
-	g_free(cbd);
-}
-
 static void at_pin_send_puk(struct ofono_sim *sim, const char *puk,
 				const char *passwd,
 				ofono_sim_lock_unlock_cb_t cb, void *data)
@@ -706,7 +664,7 @@ static void at_pin_send_puk(struct ofono_sim *sim, cons=
t char *puk,
 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_pin_send_puk_cb, cbd, NULL);
+				at_pin_send_cb, cbd, NULL);
 =

 	memset(buf, 0, sizeof(buf));
 =

-- =

1.7.0.4


--===============4258901814631879277==--

