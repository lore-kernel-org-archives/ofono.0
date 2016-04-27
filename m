Content-Type: multipart/mixed; boundary="===============2109518084648715414=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] sim: rilmodem driver changes for query facility lock
Date: Wed, 27 Apr 2016 21:08:52 +0530
Message-ID: <1461771532-4496-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2109518084648715414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/sim.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
 1 file changed, 49 insertions(+)

diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index 02399ff..ba31446 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -1405,6 +1405,54 @@ static int ril_sim_probe(struct ofono_sim *sim, unsi=
gned int vendor,
 	return 0;
 }
 =

+static void ril_query_facility_lock_cb(struct ril_msg *message, gpointer u=
ser_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_query_facility_lock_cb_t cb =3D cbd->cb;
+	struct sim_data *sd =3D cbd->user;
+	struct parcel rilp;
+	ofono_bool_t status;
+
+	if (message->error !=3D RIL_E_SUCCESS)
+		goto error;
+
+	g_ril_init_parcel(message, &rilp);
+
+	status =3D (ofono_bool_t)parcel_r_int32(&rilp);
+
+	g_ril_append_print_buf(sd->ril, "{%d}", status);
+	g_ril_print_response(sd->ril, message);
+
+	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+}
+
+static void ril_query_facility_lock(struct ofono_sim *sim,
+					enum ofono_sim_password_type lock,
+					ofono_query_facility_lock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sim);
+	struct parcel rilp;
+
+	parcel_init(&rilp);
+	parcel_w_int32(&rilp, 4);	/* # of strings */
+	parcel_w_string(&rilp, clck_cpwd_fac[lock]);
+	parcel_w_string(&rilp, "");	/* Password is empty when not needed */
+	parcel_w_string(&rilp, "0"); /* Class is "0" */
+	parcel_w_string(&rilp, NULL); /* AID value is NULL */
+
+	if (g_ril_send(sd->ril, RIL_REQUEST_QUERY_FACILITY_LOCK, &rilp,
+			ril_query_facility_lock_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, 0, data);
+}
+
 static void ril_sim_remove(struct ofono_sim *sim)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
@@ -1434,6 +1482,7 @@ static struct ofono_sim_driver driver =3D {
 	.reset_passwd		=3D ril_pin_send_puk,
 	.change_passwd		=3D ril_change_passwd,
 	.lock			=3D ril_pin_change_state,
+	.query_facility_lock    =3D ril_query_facility_lock,
 /*
  * TODO: Implmenting PIN/PUK support requires defining
  * the following driver methods.
-- =

1.9.1


--===============2109518084648715414==--

