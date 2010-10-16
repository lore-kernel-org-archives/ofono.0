Content-Type: multipart/mixed; boundary="===============0822956542623864327=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] atmodem: Add SIM ready quirk for IFX when entering PUK
Date: Sat, 16 Oct 2010 13:26:26 +0300
Message-ID: <1287224786-12653-1-git-send-email-marcel@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0822956542623864327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For the Infineon modem, also the PUK entering needs to be extended with
a quirk to wait for the SIM ready notification.
---
 drivers/atmodem/sim.c |   60 ++++++++++++++++++++++++++++++++++++++-------=
---
 1 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index c7ae32b..94658f2 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -618,18 +618,6 @@ done:
 	g_free(cbd);
 }
 =

-static void at_lock_unlock_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
-{
-	struct cb_data *cbd =3D user_data;
-	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-
-	cb(&error, cbd->data);
-}
-
 static void at_pin_send(struct ofono_sim *sim, const char *passwd,
 			ofono_sim_lock_unlock_cb_t cb, void *data)
 {
@@ -659,6 +647,38 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void at_pin_send_puk_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct sim_data *sd =3D cbd->user;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok)
+		goto done;
+
+	switch (sd->vendor) {
+	case OFONO_VENDOR_IFX:
+		/*
+		 * On the IFX modem, AT+CPIN? can return READY too
+		 * early and so use +XSIM notification to detect
+		 * the ready state of the SIM.
+		 */
+		sd->ready_id =3D g_at_chat_register(sd->chat, "+XSIM",
+							at_xsim_notify,
+							FALSE, cbd, g_free);
+		return;
+	}
+
+done:
+	cb(&error, cbd->data);
+
+	g_free(cbd);
+}
+
 static void at_pin_send_puk(struct ofono_sim *sim, const char *puk,
 				const char *passwd,
 				ofono_sim_lock_unlock_cb_t cb, void *data)
@@ -671,10 +691,12 @@ static void at_pin_send_puk(struct ofono_sim *sim, co=
nst char *puk,
 	if (!cbd)
 		goto error;
 =

+	cbd->user =3D sd;
+
 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_lock_unlock_cb, cbd, g_free);
+				at_pin_send_puk_cb, cbd, NULL);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -687,6 +709,18 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void at_lock_unlock_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
 static const char *const at_clck_cpwd_fac[] =3D {
 	[OFONO_SIM_PASSWORD_SIM_PIN] =3D "SC",
 	[OFONO_SIM_PASSWORD_SIM_PIN2] =3D "P2",
-- =

1.7.2.3


--===============0822956542623864327==--

