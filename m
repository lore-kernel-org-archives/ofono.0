Content-Type: multipart/mixed; boundary="===============0923524004596036637=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC sim-ready-v1 PATCH 3/3] atmodem/sim: use ofono_sim_ready_notify
Date: Mon, 18 Oct 2010 18:40:35 +0300
Message-ID: <1287416435-4307-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1287416435-4307-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0923524004596036637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

After a PIN or PUK code is entered, the driver will wait for a ready
notification.  While waiting the query_passwd_state callback will return
OFONO_SIM_PASSWORD_INVALID. When the SIM gets ready or a timeout occurs,
ofono_sim_ready_notify() is called and the core will again query the SIM
password state.

By default the driver don't trust the modem to do the right thing and
adds a delay of 1000 milliseconds after entering the PIN/PUK.  It is
possible to remove the delay by adding a suitable quirk in
at_wait_for_ready().

However, the delay seems to be SIM-card-specific and 1000 ms might not
be enough. Finding a suitable default value might require experimenting
with a number of different SIM cards and modems.

Currently, identical quirks are applied in PIN or PUK cases. If a
different quirk was needed for PUK, at_pin_send_puk_cb() could be
reintroduced.
---
 drivers/atmodem/sim.c |  139 +++++++++++++++++++++++++--------------------=
----
 1 files changed, 70 insertions(+), 69 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 94658f2..e566053 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -44,10 +44,13 @@
 #define EF_STATUS_INVALIDATED 0
 #define EF_STATUS_VALID 1
 =

+#define READY_TIMEOUT		5000	/* milliseconds */
+
 struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
 	guint ready_id;
+	guint ready_source;
 };
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
@@ -506,6 +509,9 @@ static void at_cpin_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 		return;
 	}
 =

+	if (sd->ready_source)
+		pin_type =3D OFONO_SIM_PASSWORD_INVALID;
+
 	DBG("crsm_pin_cb: %s", pin_required);
 =

 	cb(&error, pin_type, cbd->data);
@@ -532,12 +538,25 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static gboolean ready_notify_unregister(gpointer user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	sd->ready_source =3D 0;
+
+	g_at_chat_unregister(sd->chat, sd->ready_id);
+	sd->ready_id =3D 0;
+
+	ofono_sim_ready_notify(sim);
+
+	return FALSE;
+}
+
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

@@ -557,37 +576,29 @@ static void at_xsim_notify(GAtResult *result, gpointe=
r user_data)
 		return;
 	}
 =

-	cb(&error, cbd->data);
+	if (sd->ready_source =3D=3D 0)
+		return;
 =

-	g_at_chat_unregister(sd->chat, sd->ready_id);
-	sd->ready_id =3D 0;
+	g_source_remove(sd->ready_source);
+	sd->ready_source =3D g_timeout_add(0, ready_notify_unregister, sim);
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
+	if (sd->ready_source =3D=3D 0)
+		return;
 =

-	g_at_chat_unregister(sd->chat, sd->ready_id);
-	sd->ready_id =3D 0;
+	g_source_remove(sd->ready_source);
+	sd->ready_source =3D g_timeout_add(0, ready_notify_unregister, sim);
 }
 =

-static void at_pin_send_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
+static void at_wait_for_ready(struct ofono_sim *sim)
 {
-	struct cb_data *cbd =3D user_data;
-	struct sim_data *sd =3D cbd->user;
-	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-
-	if (!ok)
-		goto done;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	guint timeout =3D READY_TIMEOUT;
 =

 	switch (sd->vendor) {
 	case OFONO_VENDOR_IFX:
@@ -598,24 +609,46 @@ static void at_pin_send_cb(gboolean ok, GAtResult *re=
sult,
 		 */
 		sd->ready_id =3D g_at_chat_register(sd->chat, "+XSIM",
 							at_xsim_notify,
-							FALSE, cbd, g_free);
-		return;
+							FALSE, sim, NULL);
+		break;
+
 	case OFONO_VENDOR_MBM:
 		/*
 		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN
 		 * for a moment after successful AT+CPIN=3D"..", but then
-		 * sends *EPEV when that changes.
+		 * sends *EPEV when that changes. Sometimes.
 		 */
 		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
 							at_epev_notify,
-							FALSE, cbd, g_free);
-		return;
+							FALSE, sim, NULL);
+		break;
+
+	default:
+		/* By default wait for 1000 ms */
+		timeout =3D 1000;
 	}
 =

-done:
-	cb(&error, cbd->data);
+	if (sd->ready_source)
+		g_source_remove(sd->ready_source);
 =

-	g_free(cbd);
+	sd->ready_source =3D g_timeout_add(timeout,
+					ready_notify_unregister, sim);
+}
+
+static void at_pin_send_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_sim *sim =3D cbd->user;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (ok)
+		at_wait_for_ready(sim);
+
+	cb(&error, cbd->data);
 }
 =

 static void at_pin_send(struct ofono_sim *sim, const char *passwd,
@@ -629,12 +662,12 @@ static void at_pin_send(struct ofono_sim *sim, const =
char *passwd,
 	if (!cbd)
 		goto error;
 =

-	cbd->user =3D sd;
+	cbd->user =3D sim;
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_pin_send_cb, cbd, NULL);
+				at_pin_send_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

@@ -647,38 +680,6 @@ error:
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
@@ -691,12 +692,12 @@ static void at_pin_send_puk(struct ofono_sim *sim, co=
nst char *puk,
 	if (!cbd)
 		goto error;
 =

-	cbd->user =3D sd;
+	cbd->user =3D sim;
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
-				at_pin_send_puk_cb, cbd, NULL);
+				at_pin_send_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
 =

-- =

1.7.1


--===============0923524004596036637==--

