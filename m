Content-Type: multipart/mixed; boundary="===============3633522498007502792=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH V5 1/2] voicecall: add ATD support for HFP emulator
Date: Wed, 08 Jun 2011 15:47:24 +0200
Message-ID: <1307540845-9889-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1307540845-9889-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3633522498007502792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |  165 ++++++++++++++++++++++++++++++++++++++++++++++++---=
---
 1 files changed, 146 insertions(+), 19 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 3ede395..e14b88c 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -77,6 +77,8 @@ struct ofono_voicecall {
 	unsigned int hfp_watch;
 	GKeyFile *settings;
 	char *imsi;
+	struct ofono_emulator *pending_em;
+	char *em_atd_number;
 };
 =

 struct voicecall {
@@ -112,6 +114,11 @@ struct tone_queue_entry {
 	int id;
 };
 =

+struct emulator_status {
+	struct ofono_voicecall *vc;
+	int status;
+};
+
 static const char *default_en_list[] =3D { "911", "112", NULL };
 static const char *default_en_list_no_sim[] =3D { "119", "118", "999", "11=
0",
 						"08", "000", NULL };
@@ -704,31 +711,41 @@ static void voicecall_emit_multiparty(struct voicecal=
l *call, gboolean mpty)
 static void emulator_call_status_cb(struct ofono_atom *atom, void *data)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+	struct emulator_status *s =3D data;
+
+	if (em =3D=3D s->vc->pending_em)
+		return;
 =

-	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALL,
-						GPOINTER_TO_INT(data));
+	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALL, s->status);
 }
 =

 static void emulator_callsetup_status_cb(struct ofono_atom *atom, void *da=
ta)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+	struct emulator_status *s =3D data;
+
+	if (em =3D=3D s->vc->pending_em)
+		return;
 =

 	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLSETUP,
-						GPOINTER_TO_INT(data));
+					s->status);
 }
 =

 static void emulator_callheld_status_cb(struct ofono_atom *atom, void *dat=
a)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+	struct emulator_status *s =3D data;
+
+	if (em =3D=3D s->vc->pending_em)
+		return;
 =

 	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_CALLHELD,
-						GPOINTER_TO_INT(data));
+					s->status);
 }
 =

 static void notify_emulator_call_status(struct ofono_voicecall *vc)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
-	int status;
 	gboolean call =3D FALSE;
 	gboolean held =3D FALSE;
 	gboolean incoming =3D FALSE;
@@ -737,6 +754,9 @@ static void notify_emulator_call_status(struct ofono_vo=
icecall *vc)
 	gboolean waiting =3D FALSE;
 	GSList *l;
 	struct voicecall *v;
+	struct emulator_status data;
+
+	data.vc =3D vc;
 =

 	for (l =3D vc->call_list; l; l =3D l->next) {
 		v =3D l->data;
@@ -768,40 +788,39 @@ static void notify_emulator_call_status(struct ofono_=
voicecall *vc)
 		}
 	}
 =

-	status =3D call || held ? OFONO_EMULATOR_CALL_ACTIVE :
+	data.status =3D call || held ? OFONO_EMULATOR_CALL_ACTIVE :
 					OFONO_EMULATOR_CALL_INACTIVE;
 =

 	__ofono_modem_foreach_registered_atom(modem,
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
-						emulator_call_status_cb,
-						GINT_TO_POINTER(status));
+						emulator_call_status_cb, &data);
 =

 	if (incoming)
-		status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
+		data.status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
 	else if (dialing)
-		status =3D OFONO_EMULATOR_CALLSETUP_OUTGOING;
+		data.status =3D OFONO_EMULATOR_CALLSETUP_OUTGOING;
 	else if (alerting)
-		status =3D OFONO_EMULATOR_CALLSETUP_ALERTING;
+		data.status =3D OFONO_EMULATOR_CALLSETUP_ALERTING;
 	else if (waiting)
-		status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
+		data.status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
 	else
-		status =3D OFONO_EMULATOR_CALLSETUP_INACTIVE;
+		data.status =3D OFONO_EMULATOR_CALLSETUP_INACTIVE;
 =

 	__ofono_modem_foreach_registered_atom(modem,
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
 						emulator_callsetup_status_cb,
-						GINT_TO_POINTER(status));
+						&data);
 =

 	if (held)
-		status =3D call ? OFONO_EMULATOR_CALLHELD_MULTIPLE :
+		data.status =3D call ? OFONO_EMULATOR_CALLHELD_MULTIPLE :
 					OFONO_EMULATOR_CALLHELD_ON_HOLD;
 	else
-		status =3D OFONO_EMULATOR_CALLHELD_NONE;
+		data.status =3D OFONO_EMULATOR_CALLHELD_NONE;
 =

 	__ofono_modem_foreach_registered_atom(modem,
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
 						emulator_callheld_status_cb,
-						GINT_TO_POINTER(status));
+						&data);
 }
 =

 static void voicecall_set_call_status(struct voicecall *call, int status)
@@ -1497,7 +1516,7 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 	enum ofono_clir_option clir;
 	int err;
 =

-	if (vc->pending)
+	if (vc->pending || vc->dial_req || vc->pending_em)
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
@@ -2465,6 +2484,10 @@ static void emulator_hfp_unregister(struct ofono_ato=
m *atom)
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
 						emulator_remove_handler,
 						"+VTS");
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_remove_handler,
+						"D");
 =

 	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
 }
@@ -2986,6 +3009,109 @@ static void emulator_vts_cb(struct ofono_emulator *=
em,
 	ofono_emulator_send_final(em, &result);
 }
 =

+static void emulator_dial_callback(const struct ofono_error *error, void *=
data)
+{
+	struct ofono_voicecall *vc =3D data;
+	gboolean need_to_emit;
+	struct voicecall *v;
+
+	v =3D dial_handle_result(vc, error, vc->em_atd_number, &need_to_emit);
+
+	if (v =3D=3D NULL) {
+		struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+
+		if (is_emergency_number(vc, vc->em_atd_number) =3D=3D TRUE)
+			__ofono_modem_dec_emergency_mode(modem);
+	}
+
+	ofono_emulator_send_final(vc->pending_em, error);
+
+	vc->pending_em =3D NULL;
+	g_free(vc->em_atd_number);
+	vc->em_atd_number =3D NULL;
+
+	notify_emulator_call_status(vc);
+
+	if (need_to_emit)
+		voicecalls_emit_call_added(vc, v);
+}
+
+static void emulator_dial(struct ofono_emulator *em, struct ofono_voicecal=
l *vc,
+				const char *number)
+{
+	struct ofono_error result;
+	int err;
+
+	result.error =3D 0;
+
+	if (vc->pending || vc->dial_req || vc->pending_em) {
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		goto send;
+	}
+
+	vc->pending_em =3D em;
+	vc->em_atd_number =3D g_strdup(number);
+
+	err =3D voicecall_dial(vc, number, OFONO_CLIR_OPTION_DEFAULT,
+					emulator_dial_callback, vc);
+
+	if (err >=3D 0)
+		return;
+
+	vc->pending_em =3D NULL;
+	g_free(vc->em_atd_number);
+	vc->em_atd_number =3D NULL;
+
+	switch (err) {
+	case -ENETDOWN:
+		result.error =3D 30;
+		result.type =3D OFONO_ERROR_TYPE_CME;
+		break;
+
+	default:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+	}
+
+send:
+	ofono_emulator_send_final(em, &result);
+}
+
+static void emulator_atd_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+	const char *str;
+	size_t len;
+	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
+	struct ofono_error result;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_SET:
+		str =3D ofono_emulator_request_get_raw(req);
+
+		if (str =3D=3D NULL || str[0] =3D=3D '\0')
+			goto fail;
+
+		len =3D strlen(str);
+
+		if (len > OFONO_MAX_PHONE_NUMBER_LENGTH + 1 ||
+				str[len - 1] !=3D ';')
+			goto fail;
+
+		strncpy(number, str, len - 1);
+		number[len - 1] =3D '\0';
+
+		emulator_dial(em, vc, number);
+		break;
+
+	default:
+fail:
+		result.error =3D 0;
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+	};
+}
+
 static void emulator_hfp_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
@@ -3002,6 +3128,7 @@ static void emulator_hfp_watch(struct ofono_atom *ato=
m,
 	ofono_emulator_add_handler(em, "+CLCC", emulator_clcc_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+CHLD", emulator_chld_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+VTS", emulator_vts_cb, data, NULL);
+	ofono_emulator_add_handler(em, "D", emulator_atd_cb, data, NULL);
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
@@ -3072,7 +3199,7 @@ int ofono_voicecall_get_next_callid(struct ofono_voic=
ecall *vc)
 ofono_bool_t __ofono_voicecall_is_busy(struct ofono_voicecall *vc,
 					enum ofono_voicecall_interaction type)
 {
-	if (vc->pending || vc->dial_req)
+	if (vc->pending || vc->dial_req || vc->pending_em)
 		return TRUE;
 =

 	switch (type) {
-- =

1.7.1


--===============3633522498007502792==--

