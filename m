Content-Type: multipart/mixed; boundary="===============3082960118053348743=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH 4/6] gemalto: handle sim is inserted or removed URCs
Date: Mon, 19 Mar 2018 16:57:21 +0100
Message-ID: <1521475041-11660-1-git-send-email-gabriel.lucas@smile.fr>
In-Reply-To: <3a3ffd63-06ca-a9e7-c523-650000dd4b59@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3082960118053348743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mariem Cherif <mariem.cherif@ardia.com.tn>

---
 plugins/gemalto.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 5573606..13270d6 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -489,20 +489,82 @@ static void gemalto_set_online(struct ofono_modem *mo=
dem, ofono_bool_t online,
 	g_free(cbd);
 }
 =

+static void sim_ready_cb(gboolean present, gpointer user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+
+	DBG("sim present: %d", present);
+
+	ofono_sim_inserted_notify(sim, present);
+}
+
+static void gemalto_ciev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim =3D data->sim;
+
+	const char *sim_status =3D "simstatus";
+	const char *ind_str;
+	int status;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	/* Example: +CIEV: simstatus,<status> */
+	if (!g_at_result_iter_next(&iter, "+CIEV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &ind_str))
+		return;
+
+	if (!g_str_equal(sim_status, ind_str))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &status))
+		return;
+
+	DBG("sim status %d", status);
+
+	switch (status) {
+	/* SIM is removed from the holder */
+	case 0:
+		ofono_sim_inserted_notify(sim, FALSE);
+		break;
+
+	/* SIM is inserted inside the holder */
+	case 1:
+		/* The SIM won't be ready yet */
+		data->sim_state_query =3D at_util_sim_state_query_new(data->app,
+					1, 20, sim_ready_cb, sim,
+					NULL);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static void gemalto_pre_sim(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->app);
 	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
-	sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION, "atmodem",
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION, "atmodem",
 						data->app);
 =

-	if (sim && data->have_sim =3D=3D TRUE)
-		ofono_sim_inserted_notify(sim, TRUE);
+	/* Register for specific sim status reports */
+	g_at_chat_register(data->app, "+CIEV:",
+			gemalto_ciev_notify, FALSE, modem, NULL);
+
+	g_at_chat_send(data->app, "AT^SIND=3D\"simstatus\",1", none_prefix,
+			NULL, NULL, NULL);
+
+	if (data->sim && data->have_sim =3D=3D TRUE)
+		ofono_sim_inserted_notify(data->sim, TRUE);
 }
 =

 static void gemalto_post_sim(struct ofono_modem *modem)
-- =

1.9.1


--===============3082960118053348743==--

