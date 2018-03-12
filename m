Content-Type: multipart/mixed; boundary="===============0198717231164451032=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH 4/6] gemalto: handle sim is inserted or removed URCs
Date: Mon, 12 Mar 2018 14:19:26 +0100
Message-ID: <1520860766-14926-2-git-send-email-gabriel.lucas@smile.fr>
In-Reply-To: <1520860766-14926-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0198717231164451032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mariem Cherif <mariem.cherif@ardia.com.tn>

---
 plugins/gemalto.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 16ca463..c7fb783 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -497,6 +497,36 @@ static void gemalto_set_online(struct ofono_modem *mod=
em, ofono_bool_t online,
 	g_free(cbd);
 }
 =

+static void gemalto_ciev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	const char *sim_status =3D "simstatus";
+	const char *ind_str;
+	int status;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
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
+	if (status =3D=3D 0) {
+		ofono_sim_inserted_notify(sim, FALSE);
+	} else if(status =3D=3D 1) {
+		ofono_sim_inserted_notify(sim, TRUE);
+	}
+}
+
 static void gemalto_pre_sim(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
@@ -509,6 +539,13 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 	sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION, "atmodem",
 						data->app);
 =

+	/* Register for specific sim status reports */
+	g_at_chat_register(data->app, "+CIEV:",
+			gemalto_ciev_notify, FALSE, sim, NULL);
+
+	g_at_chat_send(data->app, "AT^SIND=3D\"simstatus\",1", none_prefix,
+			NULL, NULL, NULL);
+
 	if (sim && data->have_sim =3D=3D TRUE)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
-- =

1.9.1


--===============0198717231164451032==--

