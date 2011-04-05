Content-Type: multipart/mixed; boundary="===============5270261645501949823=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 6/7] voicecall: add ATA support for HFP emulator
Date: Tue, 05 Apr 2011 17:40:30 +0200
Message-ID: <1302018031-12401-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1302018031-12401-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5270261645501949823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 8e68243..cf02bb6 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2314,6 +2314,13 @@ void ofono_voicecall_driver_unregister(const struct =
ofono_voicecall_driver *d)
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
 static void voicecall_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2333,6 +2340,11 @@ static void voicecall_unregister(struct ofono_atom *=
atom)
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
 						emulator_callheld_status_cb, 0);
 =

+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_remove_handler,
+						"A");
+
 	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
 =

 	if (vc->sim_watch) {
@@ -2510,12 +2522,54 @@ static void sim_watch(struct ofono_atom *atom,
 	sim_state_watch(ofono_sim_get_state(sim), vc);
 }
 =

+static void emulator_generic_cb(const struct ofono_error *error, void *dat=
a)
+{
+	struct ofono_emulator *em =3D data;
+	struct ofono_error result;
+
+	result.type =3D error->type;
+
+	ofono_emulator_send_final(em, &result);
+}
+
+static void emulator_ata_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+	struct ofono_error result;
+
+	result.error =3D 0;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
+		if (!voicecalls_have_incoming(vc))
+			goto fail;
+
+		if (vc->driver->answer =3D=3D NULL)
+			goto fail;
+
+		vc->driver->answer(vc, emulator_generic_cb, em);
+		break;
+
+	default:
+fail:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+	};
+}
+
 static void emulator_hfp_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
 {
-	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
-		notify_emulator_call_status(data);
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	if (cond !=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		return;
+
+	notify_emulator_call_status(data);
+
+	ofono_emulator_add_handler(em, "A", emulator_ata_cb, data, NULL);
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
-- =

1.7.1


--===============5270261645501949823==--

