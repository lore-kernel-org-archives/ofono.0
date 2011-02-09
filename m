Content-Type: multipart/mixed; boundary="===============7239157751862777618=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 3/3] voicecall: handle voice call SS notifications
Date: Wed, 09 Feb 2011 12:34:10 +0200
Message-ID: <6e4f5ac41cd92177d1334896d7ac5b41e1979f36.1297244230.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1297244229.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7239157751862777618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    2 +
 src/voicecall.c |  242 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 241 insertions(+), 3 deletions(-)

diff --git a/include/types.h b/include/types.h
index d25f409..b639c8a 100644
--- a/include/types.h
+++ b/include/types.h
@@ -96,6 +96,8 @@ struct ofono_call {
 	char name[OFONO_MAX_CALLER_NAME_LENGTH + 1];
 	int clip_validity;
 	int cnap_validity;
+	ofono_bool_t remote_held;
+	ofono_bool_t remote_multiparty;
 };
 =

 struct ofono_network_time {
diff --git a/src/voicecall.c b/src/voicecall.c
index 4606668..7178714 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -53,6 +53,15 @@ struct ofono_voicecall {
 	struct ofono_sim_context *sim_context;
 	unsigned int sim_watch;
 	unsigned int sim_state_watch;
+	struct ofono_ssn *ssn;
+	unsigned int ssn_watch;
+	unsigned int ssn_mt_fwd_watch;
+	unsigned int ssn_mt_hold_watch;
+	unsigned int ssn_mt_unhold_watch;
+	unsigned int ssn_mt_mpty_watch;
+	unsigned int ssn_mo_fwd_watch;
+	unsigned int ssn_mo_local_bar_watch;
+	unsigned int ssn_mo_remote_bar_watch;
 	const struct ofono_voicecall_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -400,6 +409,12 @@ static void append_voicecall_properties(struct voiceca=
ll *v,
 =

 	ofono_dbus_dict_append(dict, "Multiparty", DBUS_TYPE_BOOLEAN, &mpty);
 =

+	ofono_dbus_dict_append(dict, "RemoteHeld", DBUS_TYPE_BOOLEAN,
+				&v->call->remote_held);
+
+	ofono_dbus_dict_append(dict, "RemoteMultiparty", DBUS_TYPE_BOOLEAN,
+				&v->call->remote_multiparty);
+
 	if (v->message)
 		ofono_dbus_dict_append(dict, "Information",
 						DBUS_TYPE_STRING, &v->message);
@@ -1869,9 +1884,11 @@ static GDBusMethodTable manager_methods[] =3D {
 };
 =

 static GDBusSignalTable manager_signals[] =3D {
-	{ "PropertyChanged",	"sv" },
-	{ "CallAdded",		"oa{sv}" },
-	{ "CallRemoved",	"o" },
+	{ "Forwarded",	 	 "s" },
+	{ "BarringActive",	 "s" },
+	{ "PropertyChanged",	 "sv" },
+	{ "CallAdded",		 "oa{sv}" },
+	{ "CallRemoved",	 "o" },
 	{ }
 };
 =

@@ -2182,6 +2199,11 @@ static void voicecall_unregister(struct ofono_atom *=
atom)
 		vc->sim_watch =3D 0;
 	}
 =

+	if (vc->ssn_watch) {
+		__ofono_modem_remove_atom_watch(modem, vc->ssn_watch);
+		vc->ssn_watch =3D 0;
+	}
+
 	if (vc->dial_req)
 		dial_request_finish(vc);
 =

@@ -2225,6 +2247,29 @@ static void voicecall_remove(struct ofono_atom *atom)
 		vc->sim =3D NULL;
 	}
 =

+	if (vc->ssn_mt_fwd_watch)
+		__ofono_ssn_mt_watch_remove(vc->ssn, vc->ssn_mt_fwd_watch);
+
+	if (vc->ssn_mt_hold_watch)
+		__ofono_ssn_mt_watch_remove(vc->ssn, vc->ssn_mt_hold_watch);
+
+	if (vc->ssn_mt_unhold_watch)
+		__ofono_ssn_mt_watch_remove(vc->ssn, vc->ssn_mt_unhold_watch);
+
+	if (vc->ssn_mt_mpty_watch)
+		__ofono_ssn_mt_watch_remove(vc->ssn, vc->ssn_mt_mpty_watch);
+
+	if (vc->ssn_mo_fwd_watch)
+		__ofono_ssn_mt_watch_remove(vc->ssn, vc->ssn_mo_fwd_watch);
+
+	if (vc->ssn_mo_local_bar_watch)
+		__ofono_ssn_mt_watch_remove(vc->ssn,
+						vc->ssn_mo_local_bar_watch);
+
+	if (vc->ssn_mo_remote_bar_watch)
+		__ofono_ssn_mo_watch_remove(vc->ssn,
+						vc->ssn_mo_remote_bar_watch);
+
 	if (vc->tone_source) {
 		g_source_remove(vc->tone_source);
 		vc->tone_source =3D 0;
@@ -2341,12 +2386,194 @@ static void sim_watch(struct ofono_atom *atom,
 	sim_state_watch(ofono_sim_get_state(sim), vc);
 }
 =

+static void ssn_mt_forwarded_notify(unsigned int id, int code1, int idx,
+					const struct ofono_phone_number *ph,
+					void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(vc->atom);
+	char *info =3D "incoming";
+
+	g_dbus_emit_signal(conn, path, OFONO_VOICECALL_MANAGER_INTERFACE,
+				"Forwarded",
+				DBUS_TYPE_STRING, &info,
+				DBUS_TYPE_INVALID);
+}
+
+static struct voicecall *voicecall_select(struct ofono_voicecall *vc,
+						unsigned int id, int code)
+{
+	struct voicecall *v =3D NULL;
+	GSList *l;
+
+	for (l =3D vc->call_list; l; l =3D l->next) {
+		struct voicecall *v1 =3D l->data;
+
+		if (id =3D=3D 0 && g_slist_length(vc->call_list) =3D=3D 1) {
+			if (code =3D=3D SS_MT_VOICECALL_RETRIEVED &&
+					v1->call->remote_held =3D=3D TRUE) {
+				v =3D v1;
+				break;
+			} else if (code =3D=3D SS_MT_VOICECALL_ON_HOLD &&
+					v1->call->remote_held =3D=3D FALSE) {
+				v =3D v1;
+				break;
+			} else if (code =3D=3D SS_MT_MULTIPARTY_VOICECALL &&
+					v1->call->remote_multiparty =3D=3D FALSE) {
+				v =3D v1;
+				break;
+			}
+		} else if (v1->call->id =3D=3D id) {
+			v =3D v1;
+			break;
+		}
+	}
+
+	return v;
+}
+
+static void ssn_mt_remote_held_notify(unsigned int id, int code1, int idx,
+					const struct ofono_phone_number *ph,
+					void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	struct voicecall *v =3D voicecall_select(vc, id, code1);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+
+	if (v =3D=3D NULL)
+		return;
+
+	if (code1 =3D=3D SS_MT_VOICECALL_ON_HOLD)
+		v->call->remote_held =3D TRUE;
+	else
+		v->call->remote_held =3D FALSE;
+
+	path =3D voicecall_build_path(vc, v->call);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_VOICECALL_INTERFACE,
+						"RemoteHeld", DBUS_TYPE_BOOLEAN,
+						&v->call->remote_held);
+}
+
+static void ssn_mt_remote_multiparty_notify(unsigned int id, int code1, in=
t idx,
+					const struct ofono_phone_number *ph,
+					void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	struct voicecall *v =3D voicecall_select(vc, id, code1);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+
+	if (v =3D=3D NULL)
+		return;
+
+	v->call->remote_multiparty =3D TRUE;
+
+	path =3D voicecall_build_path(vc, v->call);
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_VOICECALL_INTERFACE,
+					"RemoteMultiparty", DBUS_TYPE_BOOLEAN,
+					&v->call->remote_multiparty);
+}
+
+static void ssn_mo_call_barred_notify(unsigned int id, int code2,
+					int idx, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(vc->atom);
+	const char *info;
+
+	if (code2 =3D=3D SS_MO_INCOMING_BARRING)
+		info =3D "remote";
+	else
+		info =3D "local";
+
+	g_dbus_emit_signal(conn, path, OFONO_VOICECALL_MANAGER_INTERFACE,
+				"BarringActive",
+				DBUS_TYPE_STRING, &info,
+				DBUS_TYPE_INVALID);
+}
+
+static void ssn_mo_forwarded_notify(unsigned int id, int code2,
+					int idx, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(vc->atom);
+	char *info =3D "outgoing";
+
+	g_dbus_emit_signal(conn, path, OFONO_VOICECALL_MANAGER_INTERFACE,
+				"Forwarded",
+				DBUS_TYPE_STRING, &info,
+				DBUS_TYPE_INVALID);
+}
+
+static void ssn_watch_notify(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		vc->ssn_mt_fwd_watch =3D 0;
+		vc->ssn_mt_hold_watch =3D 0;
+		vc->ssn_mt_unhold_watch =3D 0;
+		vc->ssn_mt_mpty_watch =3D 0;
+		vc->ssn_mo_local_bar_watch =3D 0;
+		vc->ssn_mo_remote_bar_watch =3D 0;
+		vc->ssn =3D NULL;
+		return;
+	}
+
+	vc->ssn =3D __ofono_atom_get_data(atom);
+
+	vc->ssn_mt_fwd_watch =3D __ofono_ssn_mt_watch_add(vc->ssn,
+						SS_MT_CALL_FORWARDED,
+						ssn_mt_forwarded_notify,
+						vc, NULL);
+
+	vc->ssn_mt_hold_watch =3D __ofono_ssn_mt_watch_add(vc->ssn,
+						SS_MT_VOICECALL_ON_HOLD,
+						ssn_mt_remote_held_notify,
+						vc, NULL);
+
+	vc->ssn_mt_unhold_watch =3D __ofono_ssn_mt_watch_add(vc->ssn,
+						SS_MT_VOICECALL_RETRIEVED,
+						ssn_mt_remote_held_notify,
+						vc, NULL);
+
+	vc->ssn_mt_mpty_watch =3D __ofono_ssn_mt_watch_add(vc->ssn,
+						SS_MT_MULTIPARTY_VOICECALL,
+						ssn_mt_remote_multiparty_notify,
+						vc, NULL);
+
+	vc->ssn_mo_fwd_watch =3D __ofono_ssn_mo_watch_add(vc->ssn,
+						SS_MO_CALL_FORWARDED,
+						ssn_mo_forwarded_notify,
+						vc, NULL);
+
+	vc->ssn_mo_local_bar_watch =3D __ofono_ssn_mo_watch_add(vc->ssn,
+						SS_MO_OUTGOING_BARRING,
+						ssn_mo_call_barred_notify,
+						vc, NULL);
+
+	vc->ssn_mo_remote_bar_watch =3D __ofono_ssn_mo_watch_add(vc->ssn,
+						SS_MO_INCOMING_BARRING,
+						ssn_mo_call_barred_notify,
+						vc, NULL);
+}
+
 void ofono_voicecall_register(struct ofono_voicecall *vc)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	const char *path =3D __ofono_atom_get_path(vc->atom);
 	struct ofono_atom *sim_atom;
+	struct ofono_atom *ssn_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_VOICECALL_MANAGER_INTERFACE,
@@ -2376,6 +2603,15 @@ void ofono_voicecall_register(struct ofono_voicecall=
 *vc)
 	if (sim_atom && __ofono_atom_get_registered(sim_atom))
 		sim_watch(sim_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, vc);
 =

+	vc->ssn_watch =3D __ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SSN,
+					ssn_watch_notify, vc, NULL);
+
+	ssn_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SSN);
+
+	if (ssn_atom && __ofono_atom_get_registered(ssn_atom))
+		ssn_watch_notify(ssn_atom,
+				OFONO_ATOM_WATCH_CONDITION_REGISTERED, vc);
+
 	__ofono_atom_register(vc->atom, voicecall_unregister);
 }
 =

-- =

1.7.0.4


--===============7239157751862777618==--

