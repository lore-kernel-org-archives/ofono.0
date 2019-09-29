Content-Type: multipart/mixed; boundary="===============3725882120267569161=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] ublox: netreg: Also subscribe to UREG URC's
Date: Sun, 29 Sep 2019 21:39:53 +0200
Message-ID: <20190929193953.23524-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3725882120267569161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

It turns out that both L2xx and L4xx modems are a bit
buggy when it comes to send CREG URC's when the tech changes.
Try to overcome this by subscribing to both UREG and CREG,
and poll the other when any of the URC's are received.
Protect from doing simultanious polls though.
---
 drivers/ubloxmodem/network-registration.c | 198 ++++++++++++++++------
 1 file changed, 148 insertions(+), 50 deletions(-)

diff --git a/drivers/ubloxmodem/network-registration.c b/drivers/ubloxmodem=
/network-registration.c
index 69af4644..ad905fb3 100644
--- a/drivers/ubloxmodem/network-registration.c
+++ b/drivers/ubloxmodem/network-registration.c
@@ -47,11 +47,15 @@
 static const char *none_prefix[] =3D { NULL };
 static const char *cmer_prefix[] =3D { "+CMER:", NULL };
 static const char *ureg_prefix[] =3D { "+UREG:", NULL };
+static const char *creg_prefix[] =3D { "+CREG:", NULL };
+
+#define UBLOX_UPDATING_STATUS 0x01
 =

 struct netreg_data {
 	struct at_netreg_data at_data;
 =

 	const struct ublox_model *model;
+	int flags;
 };
 =

 struct tech_query {
@@ -213,13 +217,72 @@ static void ctze_notify(GAtResult *result, gpointer u=
ser_data)
 	ofono_netreg_time_notify(netreg, &nd->time);
 }
 =

-static void ublox_query_tech_cb(gboolean ok, GAtResult *result,
+static int ublox_ureg_state_to_tech(int state)
+{
+	switch (state) {
+	case 1:
+		return ACCESS_TECHNOLOGY_GSM;
+	case 2:
+		return ACCESS_TECHNOLOGY_GSM_EGPRS;
+	case 3:
+		return ACCESS_TECHNOLOGY_UTRAN;
+	case 4:
+		return ACCESS_TECHNOLOGY_UTRAN_HSDPA;
+	case 5:
+		return ACCESS_TECHNOLOGY_UTRAN_HSUPA;
+	case 6:
+		return ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
+	case 7:
+		return ACCESS_TECHNOLOGY_EUTRAN;
+	case 8:
+		return ACCESS_TECHNOLOGY_GSM;
+	case 9:
+		return ACCESS_TECHNOLOGY_GSM_EGPRS;
+	default:
+		/* Not registered for PS (0) or something unknown (>9)... */
+		return -1;
+	}
+}
+
+static gboolean is_registered(int status)
+{
+	return status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
+		status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING;
+}
+
+static void ublox_creg_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct tech_query *tq =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
+	int status, lac, ci, tech;
+
+	nd->flags &=3D ~UBLOX_UPDATING_STATUS;
+
+	if (!ok)
+		return;
+
+	if (at_util_parse_reg(result, "+CREG:", NULL, &status,
+				&lac, &ci, &tech, OFONO_VENDOR_GENERIC) =3D=3D FALSE)
+		return;
+
+	/* The query provided a tech, use that */
+	if (is_registered(status) && tq->tech !=3D -1)
+		tech =3D tq->tech;
+
+	ofono_netreg_status_notify(tq->netreg, status, lac, ci, tech);
+}
+
+static void ublox_ureg_cb(gboolean ok, GAtResult *result,
 							gpointer user_data)
 {
 	struct tech_query *tq =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
 	GAtResultIter iter;
 	gint enabled, state;
-	int tech =3D -1;
+	int tech =3D tq->tech;
+
+	nd->flags &=3D ~UBLOX_UPDATING_STATUS;
 =

 	if (!ok)
 		goto error;
@@ -235,48 +298,49 @@ static void ublox_query_tech_cb(gboolean ok, GAtResul=
t *result,
 	if (!g_at_result_iter_next_number(&iter, &state))
 		return;
 =

-	switch (state) {
-	case 0:
-		/* Not registered for PS, then we have to trust CREG... */
-		tech =3D tq->tech;
-		break;
-	case 1:
-		tech =3D ACCESS_TECHNOLOGY_GSM;
-		break;
-	case 2:
-		tech =3D ACCESS_TECHNOLOGY_GSM_EGPRS;
-		break;
-	case 3:
-		tech =3D ACCESS_TECHNOLOGY_UTRAN;
-		break;
-	case 4:
-		tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA;
-		break;
-	case 5:
-		tech =3D ACCESS_TECHNOLOGY_UTRAN_HSUPA;
-		break;
-	case 6:
-		tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
-		break;
-	case 7:
-		tech =3D ACCESS_TECHNOLOGY_EUTRAN;
-		break;
-	case 8:
-		tech =3D ACCESS_TECHNOLOGY_GSM;
-		break;
-	case 9:
-		tech =3D ACCESS_TECHNOLOGY_GSM_EGPRS;
-		break;
-	default:
-		/* Not registered for PS or something unknown, trust CREG... */
+	tech =3D ublox_ureg_state_to_tech(state);
+	if (tech < 0)
+		/* No valid UREG status, we have to trust CREG... */
 		tech =3D tq->tech;
-	}
 =

 error:
 	ofono_netreg_status_notify(tq->netreg,
 			tq->status, tq->lac, tq->ci, tech);
 }
 =

+static void ureg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	int state;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct tech_query *tq;
+	GAtResultIter iter;
+
+	if (nd->flags & UBLOX_UPDATING_STATUS)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+UREG:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &state))
+		return;
+
+	tq =3D g_new0(struct tech_query, 1);
+
+	tq->tech =3D ublox_ureg_state_to_tech(state);
+	tq->netreg =3D netreg;
+
+	if (g_at_chat_send(nd->at_data.chat, "AT+CREG?", creg_prefix,
+			ublox_creg_cb, tq, g_free) > 0) {
+		nd->flags |=3D UBLOX_UPDATING_STATUS;
+		return;
+	}
+
+	g_free(tq);
+}
+
 static void creg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -284,11 +348,14 @@ static void creg_notify(GAtResult *result, gpointer u=
ser_data)
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	struct tech_query *tq;
 =

+	if (nd->flags & UBLOX_UPDATING_STATUS)
+		return;
+
 	if (at_util_parse_reg_unsolicited(result, "+CREG:", &status,
 			&lac, &ci, &tech, OFONO_VENDOR_GENERIC) =3D=3D FALSE)
 		return;
 =

-	if (status !=3D 1 && status !=3D 5)
+	if (!is_registered(status))
 		goto notify;
 =

 	if (ublox_is_toby_l4(nd->model) || ublox_is_toby_l2(nd->model)) {
@@ -301,13 +368,15 @@ static void creg_notify(GAtResult *result, gpointer u=
ser_data)
 		tq->netreg =3D netreg;
 =

 		if (g_at_chat_send(nd->at_data.chat, "AT+UREG?", ureg_prefix,
-				ublox_query_tech_cb, tq, g_free) > 0)
+				ublox_ureg_cb, tq, g_free) > 0) {
+			nd->flags |=3D UBLOX_UPDATING_STATUS;
 			return;
+		}
 =

 		g_free(tq);
 	}
 =

-	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
+	if (tech =3D=3D -1)
 		tech =3D nd->at_data.tech;
 =

 notify:
@@ -322,24 +391,56 @@ static void at_cmer_not_supported(struct ofono_netreg=
 *netreg)
 	ofono_netreg_remove(netreg);
 }
 =

+static void ublox_finish_registration(struct ofono_netreg *netreg)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	if (ublox_is_toby_l4(nd->model) || ublox_is_toby_l2(nd->model))
+		g_at_chat_register(nd->at_data.chat, "+UREG:",
+					ureg_notify, FALSE, netreg, NULL);
+
+	g_at_chat_register(nd->at_data.chat, "+CIEV:",
+			ciev_notify, FALSE, netreg, NULL);
+
+	g_at_chat_register(nd->at_data.chat, "+CREG:",
+				creg_notify, FALSE, netreg, NULL);
+
+	ofono_netreg_register(netreg);
+}
+
+static void ublox_ureg_set_cb(gboolean ok,
+				GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+
+	if (!ok) {
+		ofono_error("Unable to initialize Network Registration");
+		ofono_netreg_remove(netreg);
+		return;
+	}
+
+	ublox_finish_registration(netreg);
+}
+
 static void ublox_cmer_set_cb(gboolean ok,
 				GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
-	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

 	if (!ok) {
 		at_cmer_not_supported(netreg);
 		return;
 	}
 =

-	g_at_chat_register(nd->chat, "+CIEV:",
-			ciev_notify, FALSE, netreg, NULL);
+	if (ublox_is_toby_l4(nd->model) || ublox_is_toby_l2(nd->model)) {
+		g_at_chat_send(nd->at_data.chat, "AT+UREG=3D1", none_prefix,
+			ublox_ureg_set_cb, netreg, NULL);
 =

-	g_at_chat_register(nd->chat, "+CREG:",
-				creg_notify, FALSE, netreg, NULL);
+		return;
+	}
 =

-	ofono_netreg_register(netreg);
+	ublox_finish_registration(netreg);
 }
 =

 static void ublox_creg_set_cb(gboolean ok,
@@ -354,12 +455,9 @@ static void ublox_creg_set_cb(gboolean ok,
 		return;
 	}
 =

-	if (ublox_is_toby_l4(nd->model)) {
+	if (ublox_is_toby_l4(nd->model))
 		/* FIXME */
 		ofono_error("TOBY L4 requires polling of ECSQ");
-		ofono_error("TOBY L4 wants UREG notifications for"
-				" tech updates");
-	}
 =

 	/* Register for network time update reports */
 	if (ublox_is_toby_l2(nd->model)) {
-- =

2.20.1

--===============3725882120267569161==--

