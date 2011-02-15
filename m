Content-Type: multipart/mixed; boundary="===============6640492606365784400=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready-notify RFC 1/2] atmodem/sim: use ofono_sim_ready_notify
Date: Tue, 15 Feb 2011 18:59:36 +0200
Message-ID: <1297789177-16459-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6640492606365784400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Call ofono_sim_ready_notify if pin code query returns SIM READY, unless
there is a vendor quirk for SIM status indications.

Schedule calls to ofono_sim_ready_notify() from vendor-specific
status indications:
- IFX: register unsolicated +XSIM result code
- MBM: register unsolicated *EPEV result code

IFX quirk also takes care of SIM presence notifications.
---
 drivers/atmodem/sim.c |  189 +++++++++++++++++++++++++++++++++++----------=
----
 1 files changed, 136 insertions(+), 53 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index d9c0d8d..88d9fc1 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -46,10 +46,14 @@
 =

 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 =

+#define READY_TIMEOUT		5000
+
 struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
 	guint ready_id;
+	guint ready_source;
+	ofono_bool_t ready;
 };
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
@@ -679,10 +683,49 @@ static void at_pin_retries_query(struct ofono_sim *si=
m,
 	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

+static void ready_unregister_and_notify(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("");
+
+	if (sd->ready_source > 0) {
+		g_source_remove(sd->ready_source);
+		sd->ready_source =3D 0;
+	}
+
+	ofono_sim_ready_notify(sim);
+}
+
+static gboolean ready_timeout(gpointer user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("");
+
+	sd->ready_source =3D 0;
+
+	ofono_sim_ready_notify(sim);
+
+	return FALSE;
+}
+
+static void at_wait_for_ready(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	if (sd->ready_source > 0)
+		return;
+
+	sd->ready_source =3D g_timeout_add(READY_TIMEOUT, ready_timeout, sim);
+}
+
 static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D ofono_sim_get_data(cbd->user);
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	GAtResultIter iter;
 	ofono_sim_passwd_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
@@ -732,6 +775,16 @@ static void at_cpin_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	DBG("crsm_pin_cb: %s", pin_required);
 =

 	cb(&error, pin_type, cbd->data);
+
+	if (pin_type !=3D OFONO_SIM_PASSWORD_NONE)
+		return;
+
+	if (sd->ready_id > 0 && sd->ready =3D=3D FALSE) {
+		at_wait_for_ready(sim);
+		return;
+	}
+
+	ofono_sim_ready_notify(sim);
 }
 =

 static void at_pin_query(struct ofono_sim *sim, ofono_sim_passwd_cb_t cb,
@@ -753,10 +806,8 @@ static void at_pin_query(struct ofono_sim *sim, ofono_=
sim_passwd_cb_t cb,
 =

 static void at_xsim_notify(GAtResult *result, gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D cbd->user;
-	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
-	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	GAtResultIter iter;
 	int state;
 =

@@ -768,73 +819,69 @@ static void at_xsim_notify(GAtResult *result, gpointe=
r user_data)
 	if (!g_at_result_iter_next_number(&iter, &state))
 		return;
 =

+	DBG("state %d", state);
+
 	switch (state) {
+	case 0:	/* SIM not present */
+	case 9:	/* SIM Removed */
+		ofono_sim_inserted_notify(sim, FALSE);
+		break;
+
+	case 1:	/* PIN verification needed */
+	case 2:	/* PIN verification not needed =EF=BF=BD=EF=BF=BD=EF=BF=BD Ready =
*/
 	case 3:	/* PIN verified =EF=BF=BD=EF=BF=BD=EF=BF=BD Ready */
+	case 4:	/* PUK verification needed */
+	case 5:	/* SIM permanently blocked */
+		ofono_sim_inserted_notify(sim, TRUE);
+		/* Check for further lock codes */
+		ready_unregister_and_notify(sim);
+		break;
+
+	case 6:	/* SIM Error */
+	case 8:	/* SIM Technical Problem */
+		ofono_sim_inserted_notify(sim, TRUE);
+		break;
+
 	case 7:	/* ready for attach (+COPS) */
+		ofono_sim_inserted_notify(sim, TRUE);
+		sd->ready =3D TRUE;
+		ready_unregister_and_notify(sim);
 		break;
+
 	default:
-		return;
+		ofono_warn("Unknown SIM state %d received", state);
+		break;
 	}
-
-	cb(&error, cbd->data);
-
-	g_at_chat_unregister(sd->chat, sd->ready_id);
-	sd->ready_id =3D 0;
 }
 =

 static void at_epev_notify(GAtResult *result, gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D cbd->user;
-	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
-	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

-	cb(&error, cbd->data);
+	DBG("");
+
+	sd->ready =3D TRUE;
 =

-	g_at_chat_unregister(sd->chat, sd->ready_id);
-	sd->ready_id =3D 0;
+	if (sd->ready_source > 0)
+		ready_unregister_and_notify(sim);
 }
 =

 static void at_pin_send_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D cbd->user;
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 =

-	decode_at_error(&error, g_at_result_final_response(result));
+	if (ok && sd->ready_id)
+		at_wait_for_ready(sim);
 =

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
+	decode_at_error(&error, g_at_result_final_response(result));
 =

-done:
 	cb(&error, cbd->data);
-
-	g_free(cbd);
 }
 =

 static void at_pin_send(struct ofono_sim *sim, const char *passwd,
@@ -845,12 +892,14 @@ static void at_pin_send(struct ofono_sim *sim, const =
char *passwd,
 	char buf[64];
 	int ret;
 =

-	cbd->user =3D sd;
+	cbd->user =3D sim;
+
+	sd->ready =3D FALSE;
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_pin_send_cb, cbd, NULL);
+				at_pin_send_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -871,12 +920,14 @@ static void at_pin_send_puk(struct ofono_sim *sim, co=
nst char *puk,
 	char buf[64];
 	int ret;
 =

-	cbd->user =3D sd;
+	cbd->user =3D sim;
+
+	sd->ready =3D FALSE;
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_pin_send_cb, cbd, NULL);
+				at_pin_send_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -1052,14 +1103,43 @@ static int at_sim_probe(struct ofono_sim *sim, unsi=
gned int vendor,
 	case OFONO_VENDOR_WAVECOM:
 		g_at_chat_add_terminator(sd->chat, "+CPIN:", 6, TRUE);
 		break;
+
+	case OFONO_VENDOR_IFX:
+		/*
+		 * On the IFX modem, AT+CPIN? can return READY too
+		 * early and so use +XSIM notification to detect
+		 * the ready state of the SIM.
+		 */
+		sd->ready_id =3D g_at_chat_register(sd->chat, "+XSIM",
+							at_xsim_notify,
+							FALSE, sim, NULL);
+		/* Enable XSIM and XLOCK notifications */
+		g_at_chat_send(sd->chat, "AT+XSIMSTATE=3D1", none_prefix,
+				NULL, NULL, NULL);
+		g_at_chat_send(sd->chat, "AT+XSIMSTATE?", none_prefix,
+				NULL, NULL, NULL);
+		break;
+
 	case OFONO_VENDOR_MBM:
-		g_at_chat_send(sd->chat, "AT*EPEE=3D1", NULL, NULL, NULL, NULL);
+		/*
+		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN
+		 * for a moment after successful AT+CPIN=3D"..", but then
+		 * sends *EPEV when that changes.
+		 */
+		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
+							at_epev_notify,
+							FALSE, sim, NULL);
+		/* Enable *EPEV notifications */
+		g_at_chat_send(sd->chat, "AT*EPEE=3D1", none_prefix,
+				NULL, NULL, NULL);
 		break;
+
 	default:
 		break;
 	}
 =

 	ofono_sim_set_data(sim, sd);
+
 	g_idle_add(at_sim_register, sim);
 =

 	return 0;
@@ -1071,6 +1151,9 @@ static void at_sim_remove(struct ofono_sim *sim)
 =

 	ofono_sim_set_data(sim, NULL);
 =

+	if (sd->ready_source > 0)
+		g_source_remove(sd->ready_source);
+
 	g_at_chat_unref(sd->chat);
 	g_free(sd);
 }
-- =

1.7.1


--===============6640492606365784400==--

