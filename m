Content-Type: multipart/mixed; boundary="===============3816239419123892061=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [RFC PATCH 1/4] sim: check if FD is enabled in the SIM-card
Date: Fri, 01 Oct 2010 19:25:23 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802AA1144@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1285949201-2994-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3816239419123892061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,
 =

+static void at_barring_query_enabled(struct ofono_sim *sim,
+				ofono_sim_locked_cb_t cb, void *data) {
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+
+	if (!cbd)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"FD\",2");
+
+	if (g_at_chat_send(sd->chat, buf, clck_prefix,
+				at_lock_status_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
 static gboolean at_sim_register(gpointer user)  {
 	struct ofono_sim *sim =3D user;
@@ -898,6 +920,7 @@ static struct ofono_sim_driver driver =3D {
 	.lock			=3D at_pin_enable,
 	.change_passwd		=3D at_change_passwd,
 	.query_locked		=3D at_pin_query_enabled,
+	.query_call_barred	=3D at_barring_query_enabled,
 };
  =

@@ -156,6 +157,8 @@ struct ofono_sim_driver {
 	void (*query_locked)(struct ofono_sim *sim,
 			enum ofono_sim_password_type type,
 			ofono_sim_locked_cb_t cb, void *data);
+	void (*query_call_barred)(struct ofono_sim *sim,
+			ofono_sim_locked_cb_t cb, void *data);
 };
 =

 =

+static void sim_call_barred_query_cb(const struct ofono_error *error,
+				int locked,
+				gpointer data)
+{
+	struct ofono_sim *sim =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || locked) {
+
+		ofono_error("Fixed Dialing is enabled, emergency calls
only");
+		sim_set_not_ready(sim);
+	}
+}
+
+static void sim_call_barring_check(struct ofono_sim *sim) {
+	if (!sim->driver->query_call_barred)
+		return;
+
+	sim->driver->query_call_barred(sim, sim_call_barred_query_cb,
sim); }
+
 =

Function names are misleading(eg: query_call_barred,
sim_call_barring_check). Is it better to use the function name like
query_fdn_status??

Regards,
jeevaka

--===============3816239419123892061==--

