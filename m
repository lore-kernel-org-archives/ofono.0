Content-Type: multipart/mixed; boundary="===============0665868585499971656=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 4/4] emulator: add +COPS support
Date: Thu, 17 Mar 2011 17:50:56 +0100
Message-ID: <1300380656-8757-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1300380656-8757-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0665868585499971656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This needs to be in emulator as HFP plugin should answer AT+COPS requests
even when oFono is not registered on network.
---
 src/emulator.c |   72 ++++++++++++++++++++++++++++++++++++++++++++
 src/network.c  |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++-=
---
 2 files changed, 155 insertions(+), 7 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 864e50b..eb4f49e 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -49,6 +49,8 @@ struct ofono_emulator {
 	int events_mode;
 	gboolean events_ind;
 	GSList *indicators;
+	char op_name[17];
+	int net_mode;
 };
 =

 struct indicator {
@@ -387,6 +389,59 @@ fail:
 	}
 }
 =

+static void cops_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	char buf[32];
+
+	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP && em->slc =3D=3D FALSE) {
+		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
+		return;
+	}
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		sprintf(buf, "+COPS: %d,0,\"%s\"", em->net_mode, em->op_name);
+		g_at_server_send_info(em->server, buf, TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+	{
+		GAtResultIter iter;
+		int val;
+
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto fail;
+
+		if (val !=3D 3)
+			goto fail;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto fail;
+
+		if (val !=3D 0)
+			goto fail;
+
+		/* check there is no more parameter */
+		if (g_at_result_iter_skip_next(&iter))
+			goto fail;
+
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	}
+
+	default:
+fail:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void emulator_add_indicator(struct ofono_emulator *em, const char* =
name,
 					int min, int max, int dflt)
 {
@@ -465,6 +520,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 		g_at_server_register(em->server, "+BRSF", brsf_cb, em, NULL);
 		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
 		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
+		g_at_server_register(em->server, "+COPS", cops_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -508,6 +564,7 @@ struct ofono_emulator *ofono_emulator_create(struct ofo=
no_modem *modem,
 	/* TODO: Check real local features */
 	em->l_features =3D 32;
 	em->events_mode =3D 3;	/* default mode is forwarding events */
+	em->op_name[0] =3D '\0';
 =

 	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
 							emulator_remove, em);
@@ -703,3 +760,18 @@ void ofono_emulator_set_indicator(struct ofono_emulato=
r *em,
 		return;
 	}
 }
+
+void ofono_emulator_set_network_name(struct ofono_emulator *em,
+					const char *name)
+{
+	if (name =3D=3D NULL)
+		return;
+
+	strncpy(em->op_name, name, 16);
+	em->op_name[16] =3D '\0';
+}
+
+void ofono_emulator_set_network_mode(struct ofono_emulator *em, int mode)
+{
+	em->net_mode =3D mode;
+}
diff --git a/src/network.c b/src/network.c
index 2d0a9f8..d529431 100644
--- a/src/network.c
+++ b/src/network.c
@@ -145,11 +145,19 @@ static char **network_operator_technologies(struct ne=
twork_operator_data *opd)
 	return techs;
 }
 =

+static void notify_emulator_mode(struct ofono_atom *atom, void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	ofono_emulator_set_network_mode(em, GPOINTER_TO_INT(data));
+}
+
 static void set_registration_mode(struct ofono_netreg *netreg, int mode)
 {
 	DBusConnection *conn;
 	const char *strmode;
 	const char *path;
+	struct ofono_modem *modem;
 =

 	if (netreg->mode =3D=3D mode)
 		return;
@@ -170,6 +178,10 @@ static void set_registration_mode(struct ofono_netreg =
*netreg, int mode)
 	ofono_dbus_signal_property_changed(conn, path,
 					OFONO_NETWORK_REGISTRATION_INTERFACE,
 					"Mode", DBUS_TYPE_STRING, &strmode);
+
+	modem =3D __ofono_atom_get_modem(netreg->atom);
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+				notify_emulator_mode, GINT_TO_POINTER(mode));
 }
 =

 static void registration_status_callback(const struct ofono_error *error,
@@ -400,13 +412,20 @@ static char *get_operator_display_name(struct ofono_n=
etreg *netreg)
 	return name;
 }
 =

+static void notify_emulator_operator_name(struct ofono_atom *atom, void *d=
ata)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	ofono_emulator_set_network_name(em, data);
+}
+
 static void set_network_operator_name(struct network_operator_data *opd,
 					const char *name)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_netreg *netreg =3D opd->netreg;
 	const char *path;
-	const char *operator;
+	char *operator;
 =

 	if (name[0] =3D=3D '\0')
 		return;
@@ -426,6 +445,7 @@ static void set_network_operator_name(struct network_op=
erator_data *opd,
 =

 	if (opd =3D=3D netreg->current_operator) {
 		const char *path =3D __ofono_atom_get_path(netreg->atom);
+		struct ofono_modem *modem;
 =

 		operator =3D get_operator_display_name(netreg);
 =

@@ -433,6 +453,11 @@ static void set_network_operator_name(struct network_o=
perator_data *opd,
 					OFONO_NETWORK_REGISTRATION_INTERFACE,
 					"Name", DBUS_TYPE_STRING,
 					&operator);
+
+		modem =3D __ofono_atom_get_modem(netreg->atom);
+		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+						notify_emulator_operator_name,
+						operator);
 	}
 =

 	/* Don't emit when only operator name is reported */
@@ -481,13 +506,19 @@ static void set_network_operator_eons_info(struct net=
work_operator_data *opd,
 =

 		if (opd =3D=3D netreg->current_operator) {
 			const char *npath =3D __ofono_atom_get_path(netreg->atom);
-			const char *operator =3D
-				get_operator_display_name(netreg);
+			char *operator =3D get_operator_display_name(netreg);
+			struct ofono_modem *modem;
 =

 			ofono_dbus_signal_property_changed(conn, npath,
 					OFONO_NETWORK_REGISTRATION_INTERFACE,
 					"Name", DBUS_TYPE_STRING,
 					&operator);
+
+			modem =3D __ofono_atom_get_modem(netreg->atom);
+			__ofono_modem_foreach_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						notify_emulator_operator_name,
+						operator);
 		}
 	}
 =

@@ -1178,7 +1209,8 @@ static void current_operator_callback(const struct of=
ono_error *error,
 	struct ofono_netreg *netreg =3D data;
 	const char *path =3D __ofono_atom_get_path(netreg->atom);
 	GSList *op =3D NULL;
-	const char *operator;
+	char *operator;
+	struct ofono_modem *modem;
 =

 	DBG("%p, %p", netreg, netreg->current_operator);
 =

@@ -1254,6 +1286,11 @@ emit:
 					"Name", DBUS_TYPE_STRING,
 					&operator);
 =

+	modem =3D __ofono_atom_get_modem(netreg->atom);
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					notify_emulator_operator_name,
+					operator);
+
 	if (netreg->current_operator) {
 		if (netreg->current_operator->mcc[0] !=3D '\0') {
 			const char *mcc =3D netreg->current_operator->mcc;
@@ -1540,7 +1577,8 @@ static void sim_spdi_read_cb(int ok, int length, int =
record,
 	if (netreg->status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
 		DBusConnection *conn =3D ofono_dbus_get_connection();
 		const char *path =3D __ofono_atom_get_path(netreg->atom);
-		const char *operator;
+		char *operator;
+		struct ofono_modem *modem;
 =

 		if (!sim_spdi_lookup(netreg->spdi,
 					current->mcc, current->mnc))
@@ -1552,6 +1590,11 @@ static void sim_spdi_read_cb(int ok, int length, int=
 record,
 					OFONO_NETWORK_REGISTRATION_INTERFACE,
 					"Name", DBUS_TYPE_STRING,
 					&operator);
+
+		modem =3D __ofono_atom_get_modem(netreg->atom);
+		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+						notify_emulator_operator_name,
+						operator);
 	}
 }
 =

@@ -1609,7 +1652,8 @@ static void sim_spn_read_cb(int ok, int length, int r=
ecord,
 	if (netreg->current_operator) {
 		DBusConnection *conn =3D ofono_dbus_get_connection();
 		const char *path =3D __ofono_atom_get_path(netreg->atom);
-		const char *operator;
+		char *operator;
+		struct ofono_modem *modem;
 =

 		operator =3D get_operator_display_name(netreg);
 =

@@ -1617,6 +1661,11 @@ static void sim_spn_read_cb(int ok, int length, int =
record,
 					OFONO_NETWORK_REGISTRATION_INTERFACE,
 					"Name", DBUS_TYPE_STRING,
 					&operator);
+
+		modem =3D __ofono_atom_get_modem(netreg->atom);
+		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+						notify_emulator_operator_name,
+						operator);
 	}
 }
 =

@@ -1704,9 +1753,16 @@ static void netreg_unregister(struct ofono_atom *ato=
m)
 	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
 				notify_emulator_status,
 				GINT_TO_POINTER(0));
+
 	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
 				notify_emulator_strength, GINT_TO_POINTER(0));
 =

+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+				notify_emulator_mode, GINT_TO_POINTER(0));
+
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+				notify_emulator_operator_name, "");
+
 	__ofono_modem_remove_atom_watch(modem, netreg->hfp_watch);
 =

 	__ofono_watchlist_free(netreg->status_watches);
@@ -1875,7 +1931,8 @@ static void sim_spn_spdi_changed(int id, void *userda=
ta)
 	if (netreg->current_operator) {
 		DBusConnection *conn =3D ofono_dbus_get_connection();
 		const char *path =3D __ofono_atom_get_path(netreg->atom);
-		const char *operator;
+		char *operator;
+		struct ofono_modem *modem;
 =

 		operator =3D get_operator_display_name(netreg);
 =

@@ -1883,6 +1940,11 @@ static void sim_spn_spdi_changed(int id, void *userd=
ata)
 					OFONO_NETWORK_REGISTRATION_INTERFACE,
 					"Name", DBUS_TYPE_STRING,
 					&operator);
+
+		modem =3D __ofono_atom_get_modem(netreg->atom);
+		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+						notify_emulator_operator_name,
+						operator);
 	}
 =

 	ofono_sim_read(netreg->sim_context, SIM_EFSPN_FILEID,
@@ -1901,9 +1963,23 @@ static void emulator_hfp_watch(struct ofono_atom *at=
om,
 		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
 				notify_emulator_status,
 				GINT_TO_POINTER(netreg->status));
+
 		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
 				notify_emulator_strength,
 				GINT_TO_POINTER(netreg->signal_strength));
+
+		__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+				notify_emulator_mode,
+				GINT_TO_POINTER(netreg->mode));
+
+		if (netreg->current_operator) {
+			char *operator =3D get_operator_display_name(netreg);
+
+			__ofono_modem_foreach_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						notify_emulator_operator_name,
+						operator);
+		}
 	}
 }
 =

-- =

1.7.1


--===============0665868585499971656==--

