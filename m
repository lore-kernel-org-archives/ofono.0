Content-Type: multipart/mixed; boundary="===============5688279439053895710=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC sim-ready-v0 PATCH 2/3] atmodem/sim: use ofono_sim_ready_notify
Date: Tue, 05 Oct 2010 19:04:20 +0300
Message-ID: <1286294661-24300-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286294661-24300-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5688279439053895710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The ofono_sim_driver->query_passwd_state callback will return
OFONO_SIM_PASSWORD_INVALID if SIM is not really ready yet. When the sim
gets ready or timeout occurs, ofono_sim_ready_notify() is called.
---
 drivers/atmodem/sim.c |   92 ++++++++++++++++++++++++++++-----------------=
----
 1 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index d0a7148..546ab58 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -41,6 +41,8 @@
 =

 #include "atmodem.h"
 =

+#define READY_TIMEOUT		5	/* in seconds */
+
 struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
@@ -496,6 +498,9 @@ static void at_cpin_cb(gboolean ok, GAtResult *result, =
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
@@ -524,28 +529,26 @@ error:
 =

 static gboolean ready_notify_unregister(gpointer user_data)
 {
-	struct sim_data *sd =3D user_data;
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

 	sd->ready_source =3D 0;
 =

 	g_at_chat_unregister(sd->chat, sd->ready_id);
 	sd->ready_id =3D 0;
 =

+	ofono_sim_ready_notify(sim);
+
 	return FALSE;
 }
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

-	if (sd->ready_source > 0)
-		return;
-
 	g_at_result_iter_init(&iter, result);
 =

 	if (!g_at_result_iter_next(&iter, "+XSIM:"))
@@ -562,38 +565,28 @@ static void at_xsim_notify(GAtResult *result, gpointe=
r user_data)
 		return;
 	}
 =

-	cb(&error, cbd->data);
+	if (sd->ready_source =3D=3D 0)
+		return;
 =

-	sd->ready_source =3D g_timeout_add(0, ready_notify_unregister, sd);
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

-	if (sd->ready_source > 0)
+	if (sd->ready_source =3D=3D 0)
 		return;
 =

-	cb(&error, cbd->data);
-
-	sd->ready_source =3D g_timeout_add(0, ready_notify_unregister, sd);
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
 =

 	switch (sd->vendor) {
 	case OFONO_VENDOR_IFX:
@@ -604,24 +597,45 @@ static void at_pin_send_cb(gboolean ok, GAtResult *re=
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
-		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN
-		 * for a moment after successful AT+CPIN=3D"..", but then
-		 * sends *EPEV when that changes.
+		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN for a
+		 * moment after successful AT+CPIN=3D"..", but sends *EPEV
+		 * when that changes. Sometimes.
 		 */
 		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
 							at_epev_notify,
-							FALSE, cbd, g_free);
+							FALSE, sim, NULL);
+		break;
+
+	default:
 		return;
 	}
 =

-done:
+	if (sd->ready_source)
+		g_source_remove(sd->ready_source);
+
+	sd->ready_source =3D g_timeout_add_seconds(READY_TIMEOUT,
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
 	cb(&error, cbd->data);
 =

-	g_free(cbd);
+	if (ok)
+		at_wait_for_ready(sim);
 }
 =

 static void at_lock_unlock_cb(gboolean ok, GAtResult *result,
@@ -647,12 +661,12 @@ static void at_pin_send(struct ofono_sim *sim, const =
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

-- =

1.7.0.4


--===============5688279439053895710==--

