Content-Type: multipart/mixed; boundary="===============8982961311131420724=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] sim: split ril_pin_change_state_cb based on functionality
Date: Sat, 06 Aug 2016 09:57:30 +0530
Message-ID: <1470457650-11044-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8982961311131420724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

split ril_pin_change_state_cb based on functionality w.r.t.
facility lock, puk and pin. Rename ril_pin_change_state to
more appropriate name ril_set_facility_lock and rename
ril_pin_change_state_cb to ril_enter_sim_pin_cb.
---
 drivers/rilmodem/sim.c | 120 ++++++++++++++++++++++++++++++++++-----------=
----
 1 file changed, 84 insertions(+), 36 deletions(-)

diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index 0eec10a..74f9d6b 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -79,7 +79,7 @@
  * The same applies to the app_type.
  */
 =

-static void ril_pin_change_state(struct ofono_sim *sim,
+static void ril_set_facility_lock(struct ofono_sim *sim,
 				enum ofono_sim_password_type passwd_type,
 				int enable, const char *passwd,
 				ofono_sim_lock_unlock_cb_t cb, void *data);
@@ -1083,7 +1083,7 @@ static void ril_query_passwd_state(struct ofono_sim *=
sim,
 		CALLBACK_WITH_SUCCESS(cb, sd->passwd_state, data);
 }
 =

-static void ril_pin_change_state_cb(struct ril_msg *message, gpointer user=
_data)
+static void ril_enter_sim_pin_cb(struct ril_msg *message, gpointer user_da=
ta)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
@@ -1101,38 +1101,17 @@ static void ril_pin_change_state_cb(struct ril_msg =
*message, gpointer user_data)
 =

 	g_ril_init_parcel(message, &rilp);
 =

-	/* maguro/infineon: no data is returned */
-	if (parcel_data_avail(&rilp) =3D=3D 0)
-		goto done;
-
 	parcel_r_int32(&rilp);
 =

-	switch (g_ril_vendor(sd->ril)) {
-	case OFONO_RIL_VENDOR_AOSP:
-	case OFONO_RIL_VENDOR_QCOM_MSIM:
-		/*
-		 * The number of retries is valid only when a wrong password has
-		 * been introduced in Nexus 4. TODO: check Nexus 5 behaviour.
-		 */
-		if (message->error =3D=3D RIL_E_PASSWORD_INCORRECT)
-			sd->retries[sd->passwd_type] =3D parcel_r_int32(&rilp);
-		else
-			sd->retries[sd->passwd_type] =3D -1;
-
-		g_ril_append_print_buf(sd->ril, "{%d}",
-					sd->retries[sd->passwd_type]);
-		g_ril_print_response(sd->ril, message);
+	if (message->error =3D=3D RIL_E_SUCCESS)
+		sd->retries[sd->passwd_type] =3D -1;
+	else
+		sd->retries[sd->passwd_type] =3D parcel_r_int32(&rilp);
 =

-		break;
-	/* Taken care of elsewhere */
-	case OFONO_RIL_VENDOR_INFINEON:
-	case OFONO_RIL_VENDOR_MTK:
-		break;
-	default:
-		break;
-	}
+	g_ril_append_print_buf(sd->ril, "{%d}",
+				sd->retries[sd->passwd_type]);
+	g_ril_print_response(sd->ril, message);
 =

-done:
 	if (message->error =3D=3D RIL_E_SUCCESS) {
 		CALLBACK_WITH_SUCCESS(cb, cbd->data);
 		return;
@@ -1146,6 +1125,74 @@ done:
 	send_get_sim_status(sim);
 }
 =

+static void ril_enter_sim_puk_cb(struct ril_msg *message, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct parcel rilp;
+
+	g_ril_init_parcel(message, &rilp);
+
+	parcel_r_int32(&rilp);
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		sd->retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D parcel_r_int32(&rilp);
+	} else {
+		sd->retries[OFONO_SIM_PASSWORD_SIM_PIN] =3D -1;
+		sd->retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D -1;
+	}
+
+	g_ril_append_print_buf(sd->ril, "{%d}",
+				sd->retries[OFONO_SIM_PASSWORD_SIM_PUK]);
+	g_ril_print_response(sd->ril, message);
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void ril_set_facility_lock_cb(struct ril_msg *message, gpointer use=
r_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct parcel rilp;
+
+	/*
+	 * There is no reason to ask SIM status until
+	 * unsolicited sim status change indication
+	 * Looks like state does not change before that.
+	 */
+	DBG("Enter password: type %d, result %d",
+				sd->passwd_type, message->error);
+
+	g_ril_init_parcel(message, &rilp);
+
+	parcel_r_int32(&rilp);
+
+	if (message->error =3D=3D RIL_E_SUCCESS)
+		sd->retries[sd->passwd_type] =3D -1;
+	else
+		sd->retries[sd->passwd_type] =3D parcel_r_int32(&rilp);
+
+	g_ril_append_print_buf(sd->ril, "{%d}",
+				sd->retries[sd->passwd_type]);
+	g_ril_print_response(sd->ril, message);
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
 static void ril_pin_send(struct ofono_sim *sim, const char *passwd,
 				ofono_sim_lock_unlock_cb_t cb, void *data)
 {
@@ -1169,7 +1216,7 @@ static void ril_pin_send(struct ofono_sim *sim, const=
 char *passwd,
 	g_ril_append_print_buf(sd->ril, "(%s,aid=3D%s)", passwd, sd->aid_str);
 =

 	if (g_ril_send(sd->ril, RIL_REQUEST_ENTER_SIM_PIN, &rilp,
-			ril_pin_change_state_cb, cbd, g_free) > 0)
+			ril_enter_sim_pin_cb, cbd, g_free) > 0)
 		return;
 =

 	g_free(cbd);
@@ -1189,7 +1236,7 @@ static const char *const clck_cpwd_fac[] =3D {
 =

 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 =

-static void ril_pin_change_state(struct ofono_sim *sim,
+static void ril_set_facility_lock(struct ofono_sim *sim,
 				enum ofono_sim_password_type passwd_type,
 				int enable, const char *passwd,
 				ofono_sim_lock_unlock_cb_t cb, void *data)
@@ -1199,6 +1246,7 @@ static void ril_pin_change_state(struct ofono_sim *si=
m,
 	struct parcel rilp;
 =

 	sd->unlock_pending =3D FALSE;
+	sd->passwd_type =3D passwd_type;
 =

 	if (passwd_type >=3D ARRAY_SIZE(clck_cpwd_fac) ||
 			clck_cpwd_fac[passwd_type] =3D=3D NULL)
@@ -1220,7 +1268,7 @@ static void ril_pin_change_state(struct ofono_sim *si=
m,
 				sd->aid_str);
 =

 	if (g_ril_send(sd->ril, RIL_REQUEST_SET_FACILITY_LOCK, &rilp,
-				ril_pin_change_state_cb, cbd, g_free) > 0)
+				ril_set_facility_lock_cb, cbd, g_free) > 0)
 		return;
 =

 	g_free(cbd);
@@ -1249,7 +1297,7 @@ static void ril_pin_send_puk(struct ofono_sim *sim,
 				puk, passwd, sd->aid_str);
 =

 	if (g_ril_send(sd->ril, RIL_REQUEST_ENTER_SIM_PUK, &rilp,
-			ril_pin_change_state_cb, cbd, g_free) > 0)
+			ril_enter_sim_puk_cb, cbd, g_free) > 0)
 		return;
 =

 	g_free(cbd);
@@ -1287,7 +1335,7 @@ static void ril_change_passwd(struct ofono_sim *sim,
 	g_ril_append_print_buf(sd->ril, "(old=3D%s,new=3D%s,aid=3D%s)",
 				old_passwd, new_passwd, sd->aid_str);
 =

-	if (g_ril_send(sd->ril, request, &rilp, ril_pin_change_state_cb,
+	if (g_ril_send(sd->ril, request, &rilp, ril_enter_sim_pin_cb,
 			cbd, g_free) > 0)
 		return;
 =

@@ -1446,7 +1494,7 @@ static struct ofono_sim_driver driver =3D {
 	.query_pin_retries	=3D ril_query_pin_retries,
 	.reset_passwd		=3D ril_pin_send_puk,
 	.change_passwd		=3D ril_change_passwd,
-	.lock			=3D ril_pin_change_state,
+	.lock			=3D ril_set_facility_lock,
 	.query_facility_lock    =3D ril_query_facility_lock,
 };
 =

-- =

1.9.1


--===============8982961311131420724==--

