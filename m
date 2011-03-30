Content-Type: multipart/mixed; boundary="===============8505797081915175738=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] sim: add +CNUM support for HFP emulator
Date: Wed, 30 Mar 2011 15:49:37 +0200
Message-ID: <1301492977-15082-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8505797081915175738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 98d4cc4..a9e73e6 100644
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
@@ -2519,6 +2520,56 @@ struct ofono_sim *ofono_sim_create(struct ofono_mode=
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
+			ofono_emulator_send_info(em, buf, TRUE);
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
+static void emulator_hfp_init(struct ofono_atom *atom, void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	ofono_emulator_add_handler(em, "+CNUM", emulator_cnum_cb, data, NULL);
+}
+
+static void emulator_hfp_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		emulator_hfp_init(atom, data);
+}
+
 void ofono_sim_register(struct ofono_sim *sim)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2545,6 +2596,13 @@ void ofono_sim_register(struct ofono_sim *sim)
 =

 	if (sim->state > OFONO_SIM_STATE_NOT_PRESENT)
 		sim_initialize(sim);
+
+	sim->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_hfp_watch, sim, NULL);
+
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_hfp_init, sim);
 }
 =

 void ofono_sim_remove(struct ofono_sim *sim)
-- =

1.7.1


--===============8505797081915175738==--

