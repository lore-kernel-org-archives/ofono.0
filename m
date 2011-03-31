Content-Type: multipart/mixed; boundary="===============3857692704268886193=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2] sim: add +CNUM support for HFP emulator
Date: Thu, 31 Mar 2011 13:55:55 +0200
Message-ID: <1301572555-11318-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3857692704268886193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 98d4cc4..af7a715 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -106,6 +106,7 @@ struct ofono_sim {
 	const struct ofono_sim_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	unsigned int hfp_watch;
 };
 =

 struct msisdn_set_request {
@@ -2445,6 +2446,13 @@ void ofono_sim_driver_unregister(const struct ofono_=
sim_driver *d)
 	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

+static void emulator_remove_handler(struct ofono_atom *atom, void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	ofono_emulator_remove_handler(em, data);
+}
+
 static void sim_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2452,6 +2460,13 @@ static void sim_unregister(struct ofono_atom *atom)
 	const char *path =3D __ofono_atom_get_path(atom);
 	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
 =

+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_remove_handler,
+						"+CNUM");
+
+	__ofono_modem_remove_atom_watch(modem, sim->hfp_watch);
+
 	__ofono_watchlist_free(sim->state_watches);
 	sim->state_watches =3D NULL;
 =

@@ -2519,6 +2534,53 @@ struct ofono_sim *ofono_sim_create(struct ofono_mode=
m *modem,
 	return sim;
 }
 =

+static void emulator_cnum_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	struct ofono_error result;
+	GSList *l;
+	const char *phone;
+	/*
+	 * '+CNUM: ,"+",,,4' + phone number + phone type on 3 digits max
+	 * + terminating null
+	 */
+	char buf[OFONO_MAX_PHONE_NUMBER_LENGTH + 18 + 1];
+
+	result.error =3D 0;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
+		for (l =3D sim->own_numbers; l; l =3D l->next) {
+			struct ofono_phone_number *ph =3D l->data;
+
+			phone =3D phone_number_to_string(ph);
+			sprintf(buf, "+CNUM: ,\"%s\",%d,,4", phone, ph->type);
+			ofono_emulator_send_info(em, buf, l->next =3D=3D NULL ?
+							TRUE : FALSE);
+		}
+
+		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		ofono_emulator_send_final(em, &result);
+		break;
+
+	default:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+	};
+}
+
+static void emulator_hfp_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		ofono_emulator_add_handler(em, "+CNUM", emulator_cnum_cb, data,
+						NULL);
+}
+
 void ofono_sim_register(struct ofono_sim *sim)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2545,6 +2607,10 @@ void ofono_sim_register(struct ofono_sim *sim)
 =

 	if (sim->state > OFONO_SIM_STATE_NOT_PRESENT)
 		sim_initialize(sim);
+
+	sim->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_hfp_watch, sim, NULL);
 }
 =

 void ofono_sim_remove(struct ofono_sim *sim)
-- =

1.7.1


--===============3857692704268886193==--

