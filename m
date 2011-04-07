Content-Type: multipart/mixed; boundary="===============6034283247769552614=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 2/8] emulator: add call, callsetup and callheld indicators
Date: Thu, 07 Apr 2011 18:33:54 +0200
Message-ID: <1302194040-18811-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1302194040-18811-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6034283247769552614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c  |    5 ++
 src/voicecall.c |  131 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 136 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c84f0a9..2707592 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -455,6 +455,11 @@ void ofono_emulator_register(struct ofono_emulator *em=
, int fd)
 =

 	if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP) {
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_SERVICE, 0, 1, 0);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_CALL, 0, 1, 0);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_CALLSETUP, 0, 3,
+									0);
+		emulator_add_indicator(em, OFONO_EMULATOR_IND_CALLHELD, 0, 2,
+									0);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_SIGNAL, 0, 5, 0);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_ROAMING, 0, 1, 0);
 		emulator_add_indicator(em, OFONO_EMULATOR_IND_BATTERY, 0, 5, 5);
diff --git a/src/voicecall.c b/src/voicecall.c
index 469b939..a3ea6de 100644
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
@@ -689,6 +690,107 @@ static void voicecall_emit_multiparty(struct voicecal=
l *call, gboolean mpty)
 						&val);
 }
 =

+static void emulator_call_status_cb(struct ofono_atom *atom, void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALL,
+						GPOINTER_TO_INT(data));
+}
+
+static void emulator_callsetup_status_cb(struct ofono_atom *atom, void *da=
ta)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLSETUP,
+						GPOINTER_TO_INT(data));
+}
+
+static void emulator_callheld_status_cb(struct ofono_atom *atom, void *dat=
a)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLHELD,
+						GPOINTER_TO_INT(data));
+}
+
+static void notify_emulator_call_status(struct ofono_voicecall *vc)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	int status;
+	gboolean call =3D FALSE;
+	gboolean held =3D FALSE;
+	gboolean incoming =3D FALSE;
+	gboolean dialing =3D FALSE;
+	gboolean alerting =3D FALSE;
+	gboolean waiting =3D FALSE;
+	GSList *l;
+	struct voicecall *v;
+
+	for (l =3D vc->call_list; l; l =3D l->next) {
+		v =3D l->data;
+
+		switch (v->call->status) {
+		case CALL_STATUS_ACTIVE:
+			call =3D TRUE;
+			break;
+
+		case CALL_STATUS_HELD:
+			held =3D TRUE;
+			break;
+
+		case CALL_STATUS_DIALING:
+			dialing =3D TRUE;
+			break;
+
+		case CALL_STATUS_ALERTING:
+			alerting =3D TRUE;
+			break;
+
+		case CALL_STATUS_INCOMING:
+			incoming =3D TRUE;
+			break;
+
+		case CALL_STATUS_WAITING:
+			waiting =3D TRUE;
+			break;
+		}
+	}
+
+	status =3D call || held ? OFONO_EMULATOR_CALL_ACTIVE :
+					OFONO_EMULATOR_CALL_INACTIVE;
+
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_call_status_cb,
+						GINT_TO_POINTER(status));
+
+	if (incoming || waiting)
+		status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
+	else if (dialing)
+		status =3D OFONO_EMULATOR_CALLSETUP_OUTGOING;
+	else if (alerting)
+		status =3D OFONO_EMULATOR_CALLSETUP_ALERTING;
+	else
+		status =3D OFONO_EMULATOR_CALLSETUP_INACTIVE;
+
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_callsetup_status_cb,
+						GINT_TO_POINTER(status));
+
+	if (held)
+		status =3D call ? OFONO_EMULATOR_CALLHELD_MULTIPLE :
+					OFONO_EMULATOR_CALLHELD_ON_HOLD;
+	else
+		status =3D OFONO_EMULATOR_CALLHELD_NONE;
+
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_callheld_status_cb,
+						GINT_TO_POINTER(status));
+}
+
 static void voicecall_set_call_status(struct voicecall *call, int status)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -711,6 +813,8 @@ static void voicecall_set_call_status(struct voicecall =
*call, int status)
 						"State", DBUS_TYPE_STRING,
 						&status_str);
 =

+	notify_emulator_call_status(call->vc);
+
 	if (status =3D=3D CALL_STATUS_ACTIVE &&
 		(old_status =3D=3D CALL_STATUS_INCOMING ||
 			old_status =3D=3D CALL_STATUS_DIALING ||
@@ -1040,6 +1144,8 @@ static void voicecalls_emit_call_added(struct ofono_v=
oicecall *vc,
 	DBusMessageIter dict;
 	const char *path;
 =

+	notify_emulator_call_status(vc);
+
 	path =3D __ofono_atom_get_path(vc->atom);
 =

 	signal =3D dbus_message_new_signal(path,
@@ -2203,6 +2309,19 @@ static void voicecall_unregister(struct ofono_atom *=
atom)
 	const char *path =3D __ofono_atom_get_path(atom);
 	GSList *l;
 =

+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_call_status_cb, 0);
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_callsetup_status_cb,
+						0);
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_callheld_status_cb, 0);
+
+	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
+
 	if (vc->sim_watch) {
 		__ofono_modem_remove_atom_watch(modem, vc->sim_watch);
 		vc->sim_watch =3D 0;
@@ -2378,6 +2497,14 @@ static void sim_watch(struct ofono_atom *atom,
 	sim_state_watch(ofono_sim_get_state(sim), vc);
 }
 =

+static void emulator_hfp_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		notify_emulator_call_status(data);
+}
+
 void ofono_voicecall_register(struct ofono_voicecall *vc)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2408,6 +2535,10 @@ void ofono_voicecall_register(struct ofono_voicecall=
 *vc)
 						sim_watch, vc, NULL);
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


--===============6034283247769552614==--

