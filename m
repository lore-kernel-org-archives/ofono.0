Content-Type: multipart/mixed; boundary="===============8720315309039828850=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3] netreg: add +COPS support for HFP emulator
Date: Tue, 22 Mar 2011 11:50:00 +0100
Message-ID: <1300791000-6506-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8720315309039828850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++++----=
----
 1 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/src/network.c b/src/network.c
index 2d0a9f8..7df6786 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1693,6 +1693,13 @@ void ofono_netreg_driver_unregister(const struct ofo=
no_netreg_driver *d)
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
 static void netreg_unregister(struct ofono_atom *atom)
 {
 	struct ofono_netreg *netreg =3D __ofono_atom_get_data(atom);
@@ -1707,6 +1714,9 @@ static void netreg_unregister(struct ofono_atom *atom)
 	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
 				notify_emulator_strength, GINT_TO_POINTER(0));
 =

+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+				emulator_remove_handler, "+COPS");
+
 	__ofono_modem_remove_atom_watch(modem, netreg->hfp_watch);
 =

 	__ofono_watchlist_free(netreg->status_watches);
@@ -1890,21 +1900,65 @@ static void sim_spn_spdi_changed(int id, void *user=
data)
 			sim_spn_read_cb, netreg);
 }
 =

-static void emulator_hfp_watch(struct ofono_atom *atom,
-				enum ofono_atom_watch_condition cond,
-				void *data)
+static void emulator_cops_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_netreg *netreg =3D userdata;
+	struct ofono_error result;
+	int val;
+	char name[17];
+	char buf[32];
+
+	result.error =3D 0;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_SET:
+		ofono_emulator_request_next_number(req, &val);
+		if (val !=3D 3)
+			goto fail;
+
+		ofono_emulator_request_next_number(req, &val);
+		if (val !=3D 0)
+			goto fail;
+
+		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		ofono_emulator_send_final(em, &result);
+		break;
+
+	case OFONO_EMULATOR_REQUEST_TYPE_QUERY:
+		strncpy(name, get_operator_display_name(netreg), 16);
+		name[16] =3D '\0';
+		sprintf(buf, "+COPS: %d,0,\"%s\"", netreg->mode, name);
+		ofono_emulator_send_info(em, buf, TRUE);
+		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		ofono_emulator_send_final(em, &result);
+		break;
+
+	default:
+fail:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+	};
+}
+
+static void emulator_hfp_init(struct ofono_atom *atom, void *data)
 {
 	struct ofono_netreg *netreg =3D data;
-	struct ofono_modem *modem =3D __ofono_atom_get_modem(netreg->atom);
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 =

-	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
-		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
-				notify_emulator_status,
-				GINT_TO_POINTER(netreg->status));
-		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
-				notify_emulator_strength,
+	notify_emulator_status(atom, GINT_TO_POINTER(netreg->status));
+	notify_emulator_strength(atom,
 				GINT_TO_POINTER(netreg->signal_strength));
-	}
+
+	ofono_emulator_add_handler(em, "+COPS", emulator_cops_cb, data, NULL);
+}
+
+static void emulator_hfp_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		emulator_hfp_init(atom, data);
 }
 =

 void ofono_netreg_register(struct ofono_netreg *netreg)
@@ -1968,6 +2022,9 @@ void ofono_netreg_register(struct ofono_netreg *netre=
g)
 	netreg->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
 					OFONO_ATOM_TYPE_EMULATOR_HFP,
 					emulator_hfp_watch, netreg, NULL);
+
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_hfp_init, netreg);
 }
 =

 void ofono_netreg_remove(struct ofono_netreg *netreg)
-- =

1.7.1


--===============8720315309039828850==--

