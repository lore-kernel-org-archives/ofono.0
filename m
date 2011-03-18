Content-Type: multipart/mixed; boundary="===============5132135478842906889=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/2] emulator: add call, callsetup and callheld indicators
Date: Fri, 18 Mar 2011 17:10:48 +0100
Message-ID: <1300464648-11074-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1300464648-11074-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5132135478842906889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c  |    5 +++
 src/voicecall.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 97 insertions(+), 0 deletions(-)

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
index cb5258d..f86d478 100644
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
@@ -101,6 +102,7 @@ static const char *default_en_list_no_sim[] =3D { "119"=
, "118", "999", "110",
 static void generic_callback(const struct ofono_error *error, void *data);
 static void multirelease_callback(const struct ofono_error *err, void *dat=
a);
 static gboolean tone_request_run(gpointer user_data);
+static gboolean voicecalls_have_with_status(struct ofono_voicecall *vc, in=
t status);
 =

 static gint call_compare_by_id(gconstpointer a, gconstpointer b)
 {
@@ -692,6 +694,69 @@ static void voicecall_emit_multiparty(struct voicecall=
 *call, gboolean mpty)
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
+
+	status =3D voicecalls_have_with_status(vc, CALL_STATUS_ACTIVE) ?
+						OFONO_EMULATOR_CALL_ACTIVE :
+						OFONO_EMULATOR_CALL_INACTIVE;
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_call_status_cb,
+					GINT_TO_POINTER(status));
+
+	if (voicecalls_have_with_status(vc, CALL_STATUS_HELD)) {
+		if (status)
+			status =3D OFONO_EMULATOR_CALLHELD_MULTIPLE;
+		else
+			status =3D OFONO_EMULATOR_CALLHELD_ON_HOLD;
+	} else
+		status =3D OFONO_EMULATOR_CALLHELD_NONE;
+
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_callheld_status_cb,
+					GINT_TO_POINTER(status));
+
+	if (voicecalls_have_with_status(vc, CALL_STATUS_DIALING))
+		status =3D OFONO_EMULATOR_CALLSETUP_OUTGOING;
+	else if (voicecalls_have_with_status(vc, CALL_STATUS_ALERTING))
+		status =3D OFONO_EMULATOR_CALLSETUP_ALERTING;
+	else if (voicecalls_have_with_status(vc, CALL_STATUS_INCOMING)
+		|| voicecalls_have_with_status(vc, CALL_STATUS_WAITING))
+		status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
+	else
+		status =3D OFONO_EMULATOR_CALLSETUP_INACTIVE;
+
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_callsetup_status_cb,
+					GINT_TO_POINTER(status));
+}
+
 static void voicecall_set_call_status(struct voicecall *call, int status)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -714,6 +779,8 @@ static void voicecall_set_call_status(struct voicecall =
*call, int status)
 						"State", DBUS_TYPE_STRING,
 						&status_str);
 =

+	notify_emulator_call_status(call->vc);
+
 	if (status =3D=3D CALL_STATUS_ACTIVE &&
 		(old_status =3D=3D CALL_STATUS_INCOMING ||
 			old_status =3D=3D CALL_STATUS_DIALING ||
@@ -1043,6 +1110,8 @@ static void voicecalls_emit_call_added(struct ofono_v=
oicecall *vc,
 	DBusMessageIter dict;
 	const char *path;
 =

+	notify_emulator_call_status(vc);
+
 	path =3D __ofono_atom_get_path(vc->atom);
 =

 	signal =3D dbus_message_new_signal(path,
@@ -2188,6 +2257,15 @@ static void voicecall_unregister(struct ofono_atom *=
atom)
 	const char *path =3D __ofono_atom_get_path(atom);
 	GSList *l;
 =

+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_call_status_cb, 0);
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_callsetup_status_cb, 0);
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_callheld_status_cb, 0);
+
+	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
+
 	if (vc->sim_watch) {
 		__ofono_modem_remove_atom_watch(modem, vc->sim_watch);
 		vc->sim_watch =3D 0;
@@ -2362,6 +2440,16 @@ static void sim_watch(struct ofono_atom *atom,
 	sim_state_watch(ofono_sim_get_state(sim), vc);
 }
 =

+static void emulator_hfp_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		notify_emulator_call_status(vc);
+}
+
 void ofono_voicecall_register(struct ofono_voicecall *vc)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -2398,6 +2486,10 @@ void ofono_voicecall_register(struct ofono_voicecall=
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


--===============5132135478842906889==--

