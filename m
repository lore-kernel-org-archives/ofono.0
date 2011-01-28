Content-Type: multipart/mixed; boundary="===============2500518940536991151=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [ss-notify FYI 5/6] voicecall: watch mt ssn events
Date: Fri, 28 Jan 2011 19:38:18 +0200
Message-ID: <1296236300-19189-6-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1296236300-19189-5-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2500518940536991151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Watch supplementary service notifications from barring services, remote
party putting call on hold, retrieving or join call into a multiparty
conference.

The barring indications augment the DisconnectReason and they contain
additional information about the reason why a call is rejected or why it
is not connected.
---
 src/voicecall.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 147 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 6246787..e176e02 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -52,6 +52,12 @@ struct ofono_voicecall {
 	struct ofono_sim *sim;
 	unsigned int sim_watch;
 	unsigned int sim_state_watch;
+	struct ofono_ssn *ssn;
+	unsigned int ssn_watch;
+	unsigned int ssn_hold_watch;
+	unsigned int ssn_retrieve_watch;
+	unsigned int ssn_mpty_watch;
+	unsigned int ssn_wait_watch;
 	const struct ofono_voicecall_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -69,6 +75,7 @@ struct voicecall {
 	uint8_t icon_id;
 	gboolean untracked;
 	gboolean dial_result_handled;
+	dbus_bool_t mt_hold;
 };
 =

 struct dial_request {
@@ -399,6 +406,8 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 =

 	ofono_dbus_dict_append(dict, "Multiparty", DBUS_TYPE_BOOLEAN, &mpty);
 =

+	ofono_dbus_dict_append(dict, "OnHold", DBUS_TYPE_BOOLEAN, &v->mt_hold);
+
 	if (v->message)
 		ofono_dbus_dict_append(dict, "Information",
 						DBUS_TYPE_STRING, &v->message);
@@ -655,6 +664,19 @@ static const char *voicecall_build_path(struct ofono_v=
oicecall *vc,
 	return path;
 }
 =

+static struct voicecall *voicecall_by_id(struct ofono_voicecall *vc, int i=
d)
+{
+	GSList *l;
+
+	l =3D g_slist_find_custom(vc->call_list, GUINT_TO_POINTER(id),
+				call_compare_by_id);
+	if (l =3D=3D NULL)
+		return NULL;
+
+	return l->data;
+}
+
+
 static void voicecall_emit_disconnect_reason(struct voicecall *call,
 					enum ofono_disconnect_reason reason)
 {
@@ -2181,6 +2203,19 @@ static void voicecall_unregister(struct ofono_atom *=
atom)
 		vc->sim_watch =3D 0;
 	}
 =

+	if (vc->ssn_watch) {
+		__ofono_modem_remove_atom_watch(modem, vc->ssn_watch);
+		vc->ssn_watch =3D 0;
+	}
+
+	if (vc->ssn) {
+		__ofono_ssn_mt_watch_remove(vc->ssn, vc->ssn_hold_watch);
+		__ofono_ssn_mt_watch_remove(vc->ssn, vc->ssn_retrieve_watch);
+		__ofono_ssn_mt_watch_remove(vc->ssn, vc->ssn_mpty_watch);
+		__ofono_ssn_mt_watch_remove(vc->ssn, vc->ssn_wait_watch);
+		vc->ssn =3D NULL;
+	}
+
 	if (vc->dial_req)
 		dial_request_finish(vc);
 =

@@ -2278,6 +2313,108 @@ struct ofono_voicecall *ofono_voicecall_create(stru=
ct ofono_modem *modem,
 	return vc;
 }
 =

+static void ssn_mo_watch(int index, int mo_code, void *user)
+{
+	struct ofono_voicecall *vc =3D user;
+	struct voicecall *call;
+	DBusConnection *conn;
+	char const *path;
+	char const *member;
+
+	call =3D voicecall_by_id(vc, index);
+	if (call =3D=3D NULL) {
+		ofono_error("Got MO SSN notify %u for unknown call", mo_code);
+		return;
+	}
+
+	conn =3D ofono_dbus_get_connection();
+	path =3D voicecall_build_path(vc, call->call);
+
+	switch (mo_code) {
+	case OFONO_SS_MO_CALL_WAITING:
+		member =3D "Waiting";
+		break;
+	case OFONO_SS_MO_INCOMING_BARRING:
+		member =3D "IncomingBarred";
+		break;
+	case OFONO_SS_MO_OUTGOING_BARRING:
+		member =3D "OutgoingBarred";
+		break;
+	default:
+		return;
+	}
+
+	g_dbus_emit_signal(conn, path, OFONO_VOICECALL_INTERFACE,
+				member, DBUS_TYPE_INVALID);
+}
+
+static void ssn_mt_watch(int index, int mt_code,
+				const struct ofono_phone_number *ph,
+				void *user)
+{
+	struct ofono_voicecall *vc =3D user;
+	struct voicecall *call;
+	DBusConnection *conn;
+	char const *path;
+	dbus_bool_t mt_hold;
+
+	call =3D voicecall_by_id(vc, index);
+	if (call =3D=3D NULL) {
+		ofono_error("Got MT SSN notify %u for unknown call", mt_code);
+		return;
+	}
+
+	conn =3D ofono_dbus_get_connection();
+	path =3D voicecall_build_path(vc, call->call);
+
+	switch (mt_code) {
+	case OFONO_SS_MT_VOICECALL_ON_HOLD:
+		call->mt_hold =3D mt_hold =3D TRUE;
+		break;
+
+	case OFONO_SS_MT_VOICECALL_RETRIEVED:
+		call->mt_hold =3D mt_hold =3D FALSE;
+		break;
+
+	case OFONO_SS_MT_MULTIPARTY_VOICECALL:
+		g_dbus_emit_signal(conn, path, OFONO_VOICECALL_INTERFACE,
+					"JoinedMultiparty", DBUS_TYPE_INVALID);
+		return;
+
+	default:
+		return;
+	}
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_VOICECALL_INTERFACE, "OnHold",
+				DBUS_TYPE_BOOLEAN, &mt_hold);
+}
+
+static void ssn_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		vc->ssn =3D NULL;
+		return;
+	}
+
+	vc->ssn =3D  __ofono_atom_get_data(atom);
+
+	vc->ssn_hold_watch =3D __ofono_ssn_mt_watch_add(vc->ssn,
+		OFONO_SS_MT_VOICECALL_ON_HOLD, ssn_mt_watch, vc, NULL);
+
+	vc->ssn_retrieve_watch =3D __ofono_ssn_mt_watch_add(vc->ssn,
+		OFONO_SS_MT_VOICECALL_RETRIEVED, ssn_mt_watch, vc, NULL);
+
+	vc->ssn_mpty_watch =3D __ofono_ssn_mt_watch_add(vc->ssn,
+		OFONO_SS_MT_MULTIPARTY_VOICECALL, ssn_mt_watch, vc, NULL);
+
+	vc->ssn_wait_watch =3D __ofono_ssn_mo_watch_add(vc->ssn,
+		OFONO_SS_MO_CALL_WAITING, ssn_mo_watch, vc, NULL);
+}
+
 static void sim_state_watch(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_voicecall *vc =3D user;
@@ -2338,6 +2475,7 @@ void ofono_voicecall_register(struct ofono_voicecall =
*vc)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	const char *path =3D __ofono_atom_get_path(vc->atom);
 	struct ofono_atom *sim_atom;
+	struct ofono_atom *ssn_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
 					OFONO_VOICECALL_MANAGER_INTERFACE,
@@ -2367,6 +2505,15 @@ void ofono_voicecall_register(struct ofono_voicecall=
 *vc)
 	if (sim_atom && __ofono_atom_get_registered(sim_atom))
 		sim_watch(sim_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, vc);
 =

+	vc->ssn_watch =3D __ofono_modem_add_atom_watch(modem,
+						OFONO_ATOM_TYPE_SSN,
+						ssn_watch, vc, NULL);
+
+	ssn_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+
+	if (ssn_atom && __ofono_atom_get_registered(ssn_atom))
+		ssn_watch(ssn_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, vc);
+
 	__ofono_atom_register(vc->atom, voicecall_unregister);
 }
 =

-- =

1.7.1


--===============2500518940536991151==--

