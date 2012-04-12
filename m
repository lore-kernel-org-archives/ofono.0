Content-Type: multipart/mixed; boundary="===============1879387000014641633=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] atmodem: Do some polling on at_pin_query
Date: Thu, 12 Apr 2012 16:28:33 +0200
Message-ID: <1334240913-27063-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1879387000014641633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For some modem like ZTE MF180/190, we need to do some
polling to check SIM state when it returns +CME ERROR: 14 busy.
---
 drivers/atmodem/sim.c |   59 +++++++++++++++++++++++++++++++++++++++------=
---
 1 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index c51b1d4..a23738b 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -51,6 +51,8 @@ struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
 	guint ready_id;
+	guint poll_source;
+	guint poll_count;
 };
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
@@ -856,6 +858,8 @@ static void at_pin_retries_query(struct ofono_sim *sim,
 	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

+static gboolean sim_state_check(gpointer user_data);
+
 static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -874,9 +878,22 @@ static void at_cpin_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	else
 		decode_at_error(&error, final);
 =

-	if (!ok) {
+	switch (error.type) {
+	case OFONO_ERROR_TYPE_NO_ERROR:
+		break;
+	case OFONO_ERROR_TYPE_CME:
+		/* Check for SIM busy - try again later */
+		if (error.error =3D=3D 14) {
+			if (sd->poll_count++ < 12) {
+				sd->poll_source =3D g_timeout_add_seconds(2,
+						sim_state_check, cbd);
+				return;
+			}
+		}
+		/* fall through */
+	default:
 		cb(&error, -1, cbd->data);
-		return;
+		goto done;
 	}
 =

 	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM) {
@@ -887,7 +904,7 @@ static void at_cpin_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 =

 		if (!g_at_result_iter_next(&iter, "+CPIN:")) {
 			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-			return;
+			goto done;
 		}
 =

 		g_at_result_iter_next_unquoted_string(&iter, &pin_required);
@@ -903,12 +920,34 @@ static void at_cpin_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	if (pin_type =3D=3D OFONO_SIM_PASSWORD_INVALID) {
 		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
+		goto done;
 	}
 =

 	DBG("crsm_pin_cb: %s", pin_required);
 =

 	cb(&error, pin_type, cbd->data);
+
+done:
+	g_free(cbd);
+}
+
+static gboolean sim_state_check(gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(cbd->user);
+	ofono_sim_passwd_cb_t cb =3D cbd->cb;
+
+	sd->poll_source =3D 0;
+
+	if (g_at_chat_send(sd->chat, "AT+CPIN?", cpin_prefix,
+				at_cpin_cb, cbd, NULL) > 0)
+		return FALSE;
+
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+
+	g_free(cbd);
+
+	return FALSE;
 }
 =

 static void at_pin_query(struct ofono_sim *sim, ofono_sim_passwd_cb_t cb,
@@ -919,13 +958,8 @@ static void at_pin_query(struct ofono_sim *sim, ofono_=
sim_passwd_cb_t cb,
 =

 	cbd->user =3D sim;
 =

-	if (g_at_chat_send(sd->chat, "AT+CPIN?", cpin_prefix,
-				at_cpin_cb, cbd, g_free) > 0)
-		return;
-
-	g_free(cbd);
-
-	CALLBACK_WITH_FAILURE(cb, -1, data);
+	sd->poll_count =3D 0;
+	sim_state_check(cbd);
 }
 =

 static void at_xsim_notify(GAtResult *result, gpointer user_data)
@@ -1246,6 +1280,9 @@ static void at_sim_remove(struct ofono_sim *sim)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

+	if (sd->poll_source > 0)
+		g_source_remove(sd->poll_source);
+
 	ofono_sim_set_data(sim, NULL);
 =

 	g_at_chat_unref(sd->chat);
-- =

1.7.4.1


--===============1879387000014641633==--

