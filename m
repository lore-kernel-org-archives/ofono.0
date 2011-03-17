Content-Type: multipart/mixed; boundary="===============1212124192459571805=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/4] emulator: add call and callsetup indicators
Date: Thu, 17 Mar 2011 17:50:54 +0100
Message-ID: <1300380656-8757-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1300380656-8757-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1212124192459571805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c  |    3 ++
 src/voicecall.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c84f0a9..864e50b 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -455,6 +455,9 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 =

 	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP) {
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_SERVICE, 0, 1, 0);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_CALL, 0, 1, 0);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_CALLSETUP, 0, 3,
+									0);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_SIGNAL, 0, 5, 0);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0, 1, 0);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_BATTERY, 0, 5, 5);
diff --git a/src/voicecall.c b/src/voicecall.c
index cb5258d..d0ddad6 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -59,6 +59,7 @@ struct ofono_voicecall {
 	struct dial_request *dial_req;
 	GQueue *toneq;
 	guint tone_source;
+	unsigned int hfp_watch;
 };
 =

 struct voicecall {
@@ -692,6 +693,55 @@ static void voicecall_emit_multiparty(struct voicecall=
 *call, gboolean mpty)
 						&val);
 }
 =

+static void notify_emulator_call_status_cb(struct ofono_atom *atom, void *=
data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	switch (GPOINTER_TO_INT(data)) {
+	case CALL_STATUS_ACTIVE:
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALL,
+						OFONO_EMULATOR_CALL_ACTIVE);
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLSETUP,
+					OFONO_EMULATOR_CALLSETUP_INACTIVE);
+		break;
+
+	case CALL_STATUS_DIALING:
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLSETUP,
+					OFONO_EMULATOR_CALLSETUP_OUTGOING);
+		break;
+
+	case CALL_STATUS_ALERTING:
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLSETUP,
+					OFONO_EMULATOR_CALLSETUP_ALERTING);
+		break;
+
+	case CALL_STATUS_INCOMING:
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLSETUP,
+					OFONO_EMULATOR_CALLSETUP_INCOMING);
+		break;
+
+	case CALL_STATUS_DISCONNECTED:
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALL,
+						OFONO_EMULATOR_CALL_INACTIVE);
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLSETUP,
+					OFONO_EMULATOR_CALLSETUP_INACTIVE);
+		break;
+
+	case CALL_STATUS_WAITING:
+	case CALL_STATUS_HELD:
+		break;
+	}
+}
+
+static void notify_emulator_call_status(struct ofono_voicecall *vc, int st=
atus)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					notify_emulator_call_status_cb,
+					GINT_TO_POINTER(status));
+}
+
 static void voicecall_set_call_status(struct voicecall *call, int status)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -714,6 +764,8 @@ static void voicecall_set_call_status(struct voicecall =
*call, int status)
 						"State", DBUS_TYPE_STRING,
 						&status_str);
 =

+	notify_emulator_call_status(call->vc, status);
+
 	if (status =3D=3D CALL_STATUS_ACTIVE &&
 		(old_status =3D=3D CALL_STATUS_INCOMING ||
 			old_status =3D=3D CALL_STATUS_DIALING ||
@@ -1043,6 +1095,8 @@ static void voicecalls_emit_call_added(struct ofono_v=
oicecall *vc,
 	DBusMessageIter dict;
 	const char *path;
 =

+	notify_emulator_call_status(vc, v->call->status);
+
 	path =3D __ofono_atom_get_path(vc->atom);
 =

 	signal =3D dbus_message_new_signal(path,
@@ -2188,6 +2242,10 @@ static void voicecall_unregister(struct ofono_atom *=
atom)
 	const char *path =3D __ofono_atom_get_path(atom);
 	GSList *l;
 =

+	notify_emulator_call_status(vc, CALL_STATUS_DISCONNECTED);
+
+	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
+
 	if (vc->sim_watch) {
 		__ofono_modem_remove_atom_watch(modem, vc->sim_watch);
 		vc->sim_watch =3D 0;
@@ -2362,6 +2420,30 @@ static void sim_watch(struct ofono_atom *atom,
 	sim_state_watch(ofono_sim_get_state(sim), vc);
 }
 =

+static void emulator_hfp_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		if (voicecalls_have_with_status(vc, CALL_STATUS_ACTIVE))
+			notify_emulator_call_status(vc, CALL_STATUS_ACTIVE);
+
+		if (voicecalls_have_with_status(vc, CALL_STATUS_DIALING))
+			notify_emulator_call_status(vc, CALL_STATUS_DIALING);
+		else if (voicecalls_have_with_status(vc, CALL_STATUS_ALERTING))
+			notify_emulator_call_status(vc, CALL_STATUS_ALERTING);
+		else if (voicecalls_have_with_status(vc, CALL_STATUS_INCOMING))
+			notify_emulator_call_status(vc, CALL_STATUS_INCOMING);
+		else if (voicecalls_have_with_status(vc, CALL_STATUS_WAITING))
+			notify_emulator_call_status(vc, CALL_STATUS_WAITING);
+
+		if (voicecalls_have_with_status(vc, CALL_STATUS_HELD))
+			notify_emulator_call_status(vc, CALL_STATUS_HELD);
+	}
+}
+
 void ofono_voicecall_register(struct ofono_voicecall *vc)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2398,6 +2480,10 @@ void ofono_voicecall_register(struct ofono_voicecall=
 *vc)
 		sim_watch(sim_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, vc);
 =

 	__ofono_atom_register(vc->atom, voicecall_unregister);
+
+	vc->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_hfp_watch, vc, NULL);
 }
 =

 void ofono_voicecall_remove(struct ofono_voicecall *vc)
-- =

1.7.1


--===============1212124192459571805==--

