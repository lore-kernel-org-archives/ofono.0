Content-Type: multipart/mixed; boundary="===============6035947156269753400=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 11/12] voicecall: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:21:00 +0300
Message-ID: <1529601661-4856-11-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6035947156269753400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c | 144 ++++++++++++++++++++++++++++------------------------=
----
 1 file changed, 73 insertions(+), 71 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index e4f6a4c..a5de038 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -177,10 +177,10 @@ static const char *disconnect_reason_to_string(enum o=
fono_disconnect_reason r)
 static const char *phone_and_clip_to_string(const struct ofono_phone_numbe=
r *n,
 						int clip_validity)
 {
-	if (clip_validity =3D=3D CLIP_VALIDITY_WITHHELD && !strlen(n->number))
+	if (clip_validity =3D=3D OFONO_CLIP_VALIDITY_WITHHELD && !strlen(n->numbe=
r))
 		return "withheld";
 =

-	if (clip_validity =3D=3D CLIP_VALIDITY_NOT_AVAILABLE)
+	if (clip_validity =3D=3D OFONO_CLIP_VALIDITY_NOT_AVAILABLE)
 		return "";
 =

 	return phone_number_to_string(n);
@@ -188,10 +188,10 @@ static const char *phone_and_clip_to_string(const str=
uct ofono_phone_number *n,
 =

 static const char *cnap_to_string(const char *name, int cnap_validity)
 {
-	if (cnap_validity =3D=3D CNAP_VALIDITY_WITHHELD && !strlen(name))
+	if (cnap_validity =3D=3D OFONO_CNAP_VALIDITY_WITHHELD && !strlen(name))
 		return "withheld";
 =

-	if (cnap_validity =3D=3D CNAP_VALIDITY_NOT_AVAILABLE)
+	if (cnap_validity =3D=3D OFONO_CNAP_VALIDITY_NOT_AVAILABLE)
 		return "";
 =

 	return name;
@@ -227,20 +227,20 @@ static unsigned int voicecalls_num_with_status(struct=
 ofono_voicecall *vc,
 =

 static unsigned int voicecalls_num_active(struct ofono_voicecall *vc)
 {
-	return voicecalls_num_with_status(vc, CALL_STATUS_ACTIVE);
+	return voicecalls_num_with_status(vc, OFONO_CALL_STATUS_ACTIVE);
 }
 =

 static unsigned int voicecalls_num_held(struct ofono_voicecall *vc)
 {
-	return voicecalls_num_with_status(vc, CALL_STATUS_HELD);
+	return voicecalls_num_with_status(vc, OFONO_CALL_STATUS_HELD);
 }
 =

 static unsigned int voicecalls_num_connecting(struct ofono_voicecall *vc)
 {
 	unsigned int r =3D 0;
 =

-	r +=3D voicecalls_num_with_status(vc, CALL_STATUS_DIALING);
-	r +=3D voicecalls_num_with_status(vc, CALL_STATUS_ALERTING);
+	r +=3D voicecalls_num_with_status(vc, OFONO_CALL_STATUS_DIALING);
+	r +=3D voicecalls_num_with_status(vc, OFONO_CALL_STATUS_ALERTING);
 =

 	return r;
 }
@@ -253,9 +253,9 @@ static gboolean voicecalls_have_active(struct ofono_voi=
cecall *vc)
 	for (l =3D vc->call_list; l; l =3D l->next) {
 		v =3D l->data;
 =

-		if (v->call->status =3D=3D CALL_STATUS_ACTIVE ||
-				v->call->status =3D=3D CALL_STATUS_DIALING ||
-				v->call->status =3D=3D CALL_STATUS_ALERTING)
+		if (v->call->status =3D=3D OFONO_CALL_STATUS_ACTIVE ||
+				v->call->status =3D=3D OFONO_CALL_STATUS_DIALING ||
+				v->call->status =3D=3D OFONO_CALL_STATUS_ALERTING)
 			return TRUE;
 	}
 =

@@ -280,17 +280,17 @@ static gboolean voicecalls_have_with_status(struct of=
ono_voicecall *vc,
 =

 static gboolean voicecalls_have_held(struct ofono_voicecall *vc)
 {
-	return voicecalls_have_with_status(vc, CALL_STATUS_HELD);
+	return voicecalls_have_with_status(vc, OFONO_CALL_STATUS_HELD);
 }
 =

 static gboolean voicecalls_have_waiting(struct ofono_voicecall *vc)
 {
-	return voicecalls_have_with_status(vc, CALL_STATUS_WAITING);
+	return voicecalls_have_with_status(vc, OFONO_CALL_STATUS_WAITING);
 }
 =

 static gboolean voicecalls_have_incoming(struct ofono_voicecall *vc)
 {
-	return voicecalls_have_with_status(vc, CALL_STATUS_INCOMING);
+	return voicecalls_have_with_status(vc, OFONO_CALL_STATUS_INCOMING);
 }
 =

 static void dial_request_finish(struct ofono_voicecall *vc)
@@ -314,11 +314,11 @@ static gboolean voicecalls_can_dtmf(struct ofono_voic=
ecall *vc)
 	for (l =3D vc->call_list; l; l =3D l->next) {
 		v =3D l->data;
 =

-		if (v->call->status =3D=3D CALL_STATUS_ACTIVE)
+		if (v->call->status =3D=3D OFONO_CALL_STATUS_ACTIVE)
 			return TRUE;
 =

 		/* Connected for 2nd stage dialing */
-		if (v->call->status =3D=3D CALL_STATUS_ALERTING)
+		if (v->call->status =3D=3D OFONO_CALL_STATUS_ALERTING)
 			return TRUE;
 	}
 =

@@ -405,7 +405,7 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 =

 	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING, &status);
 =

-	if (call->direction =3D=3D CALL_DIRECTION_MOBILE_TERMINATED)
+	if (call->direction =3D=3D OFONO_CALL_DIRECTION_MOBILE_TERMINATED)
 		callerid =3D phone_and_clip_to_string(&call->phone_number,
 							call->clip_validity);
 	else
@@ -427,9 +427,9 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 =

 	ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);
 =

-	if (call->status =3D=3D CALL_STATUS_ACTIVE ||
-			call->status =3D=3D CALL_STATUS_HELD ||
-			(call->status =3D=3D CALL_STATUS_DISCONNECTED &&
+	if (call->status =3D=3D OFONO_CALL_STATUS_ACTIVE ||
+			call->status =3D=3D OFONO_CALL_STATUS_HELD ||
+			(call->status =3D=3D OFONO_CALL_STATUS_DISCONNECTED &&
 				v->start_time !=3D 0)) {
 		timestr =3D time_to_str(&v->start_time);
 =

@@ -502,8 +502,8 @@ static DBusMessage *voicecall_deflect(DBusConnection *c=
onn,
 	struct ofono_phone_number ph;
 	const char *number;
 =

-	if (call->status !=3D CALL_STATUS_INCOMING &&
-			call->status !=3D CALL_STATUS_WAITING)
+	if (call->status !=3D OFONO_CALL_STATUS_INCOMING &&
+			call->status !=3D OFONO_CALL_STATUS_WAITING)
 		return __ofono_error_failed(msg);
 =

 	if (vc->driver->deflect =3D=3D NULL)
@@ -543,10 +543,10 @@ static DBusMessage *voicecall_hangup(DBusConnection *=
conn,
 		return __ofono_error_busy(msg);
 =

 	switch (call->status) {
-	case CALL_STATUS_DISCONNECTED:
+	case OFONO_CALL_STATUS_DISCONNECTED:
 		return __ofono_error_failed(msg);
 =

-	case CALL_STATUS_INCOMING:
+	case OFONO_CALL_STATUS_INCOMING:
 		if (vc->driver->hangup_all =3D=3D NULL &&
 				vc->driver->hangup_active =3D=3D NULL)
 			return __ofono_error_not_implemented(msg);
@@ -560,7 +560,7 @@ static DBusMessage *voicecall_hangup(DBusConnection *co=
nn,
 =

 		return NULL;
 =

-	case CALL_STATUS_WAITING:
+	case OFONO_CALL_STATUS_WAITING:
 		if (vc->driver->set_udub =3D=3D NULL)
 			return __ofono_error_not_implemented(msg);
 =

@@ -569,7 +569,7 @@ static DBusMessage *voicecall_hangup(DBusConnection *co=
nn,
 =

 		return NULL;
 =

-	case CALL_STATUS_HELD:
+	case OFONO_CALL_STATUS_HELD:
 		if (vc->driver->release_all_held &&
 				voicecalls_num_held(vc) =3D=3D 1 &&
 				voicecalls_have_waiting(vc) =3D=3D FALSE) {
@@ -581,8 +581,8 @@ static DBusMessage *voicecall_hangup(DBusConnection *co=
nn,
 =

 		break;
 =

-	case CALL_STATUS_DIALING:
-	case CALL_STATUS_ALERTING:
+	case OFONO_CALL_STATUS_DIALING:
+	case OFONO_CALL_STATUS_ALERTING:
 		if (vc->driver->hangup_active !=3D NULL) {
 			vc->pending =3D dbus_message_ref(msg);
 			vc->driver->hangup_active(vc, generic_callback, vc);
@@ -596,7 +596,7 @@ static DBusMessage *voicecall_hangup(DBusConnection *co=
nn,
 		 */
 =

 		/* fall through */
-	case CALL_STATUS_ACTIVE:
+	case OFONO_CALL_STATUS_ACTIVE:
 		if (single_call =3D=3D TRUE && vc->driver->hangup_all !=3D NULL) {
 			vc->pending =3D dbus_message_ref(msg);
 			vc->driver->hangup_all(vc, generic_callback, vc);
@@ -632,7 +632,7 @@ static DBusMessage *voicecall_answer(DBusConnection *co=
nn,
 	struct ofono_voicecall *vc =3D v->vc;
 	struct ofono_call *call =3D v->call;
 =

-	if (call->status !=3D CALL_STATUS_INCOMING)
+	if (call->status !=3D OFONO_CALL_STATUS_INCOMING)
 		return __ofono_error_failed(msg);
 =

 	if (vc->driver->answer =3D=3D NULL)
@@ -791,7 +791,7 @@ static void notify_emulator_call_status(struct ofono_vo=
icecall *vc)
 		v =3D l->data;
 =

 		switch (v->call->status) {
-		case CALL_STATUS_ACTIVE:
+		case OFONO_CALL_STATUS_ACTIVE:
 			call =3D TRUE;
 			if (g_slist_find_custom(vc->multiparty_list,
 						GINT_TO_POINTER(v->call->id),
@@ -801,7 +801,7 @@ static void notify_emulator_call_status(struct ofono_vo=
icecall *vc)
 				non_mpty++;
 			break;
 =

-		case CALL_STATUS_HELD:
+		case OFONO_CALL_STATUS_HELD:
 			held =3D TRUE;
 			if (g_slist_find_custom(vc->multiparty_list,
 						GINT_TO_POINTER(v->call->id),
@@ -811,19 +811,19 @@ static void notify_emulator_call_status(struct ofono_=
voicecall *vc)
 				non_mpty_held++;
 			break;
 =

-		case CALL_STATUS_DIALING:
+		case OFONO_CALL_STATUS_DIALING:
 			dialing =3D TRUE;
 			break;
 =

-		case CALL_STATUS_ALERTING:
+		case OFONO_CALL_STATUS_ALERTING:
 			alerting =3D TRUE;
 			break;
 =

-		case CALL_STATUS_INCOMING:
+		case OFONO_CALL_STATUS_INCOMING:
 			incoming =3D TRUE;
 			break;
 =

-		case CALL_STATUS_WAITING:
+		case OFONO_CALL_STATUS_WAITING:
 			waiting =3D TRUE;
 			break;
 		}
@@ -910,11 +910,11 @@ static void voicecall_set_call_status(struct voicecal=
l *call, int status)
 =

 	notify_emulator_call_status(call->vc);
 =

-	if (status =3D=3D CALL_STATUS_ACTIVE &&
-		(old_status =3D=3D CALL_STATUS_INCOMING ||
-			old_status =3D=3D CALL_STATUS_DIALING ||
-			old_status =3D=3D CALL_STATUS_ALERTING ||
-			old_status =3D=3D CALL_STATUS_WAITING)) {
+	if (status =3D=3D OFONO_CALL_STATUS_ACTIVE &&
+		(old_status =3D=3D OFONO_CALL_STATUS_INCOMING ||
+			old_status =3D=3D OFONO_CALL_STATUS_DIALING ||
+			old_status =3D=3D OFONO_CALL_STATUS_ALERTING ||
+			old_status =3D=3D OFONO_CALL_STATUS_WAITING)) {
 		const char *timestr;
 =

 		call->start_time =3D time(NULL);
@@ -929,7 +929,7 @@ static void voicecall_set_call_status(struct voicecall =
*call, int status)
 			dial_request_finish(call->vc);
 	}
 =

-	if (status =3D=3D CALL_STATUS_DISCONNECTED && call->vc->dial_req &&
+	if (status =3D=3D OFONO_CALL_STATUS_DISCONNECTED && call->vc->dial_req &&
 			call =3D=3D call->vc->dial_req->call)
 		dial_request_finish(call->vc);
 =

@@ -963,8 +963,8 @@ static void voicecall_set_call_lineid(struct voicecall =
*v,
 	 */
 =

 	/* For plugins that don't keep state, ignore */
-	if (call->clip_validity =3D=3D CLIP_VALIDITY_VALID &&
-			clip_validity =3D=3D CLIP_VALIDITY_NOT_AVAILABLE)
+	if (call->clip_validity =3D=3D OFONO_CLIP_VALIDITY_VALID &&
+			clip_validity =3D=3D OFONO_CLIP_VALIDITY_NOT_AVAILABLE)
 		return;
 =

 	strcpy(call->phone_number.number, ph->number);
@@ -973,7 +973,7 @@ static void voicecall_set_call_lineid(struct voicecall =
*v,
 =

 	path =3D voicecall_build_path(v->vc, call);
 =

-	if (call->direction =3D=3D CALL_DIRECTION_MOBILE_TERMINATED)
+	if (call->direction =3D=3D OFONO_CALL_DIRECTION_MOBILE_TERMINATED)
 		lineid_str =3D phone_and_clip_to_string(ph, clip_validity);
 	else
 		lineid_str =3D phone_number_to_string(ph);
@@ -1033,8 +1033,8 @@ static void voicecall_set_call_name(struct voicecall =
*v,
 		return;
 =

 	/* For plugins that don't keep state, ignore */
-	if (call->cnap_validity =3D=3D CNAP_VALIDITY_VALID &&
-			cnap_validity =3D=3D CNAP_VALIDITY_NOT_AVAILABLE)
+	if (call->cnap_validity =3D=3D OFONO_CNAP_VALIDITY_VALID &&
+			cnap_validity =3D=3D OFONO_CNAP_VALIDITY_NOT_AVAILABLE)
 		return;
 =

 	strncpy(call->name, name, OFONO_MAX_CALLER_NAME_LENGTH);
@@ -1114,7 +1114,7 @@ static GSList *voicecalls_held_list(struct ofono_voic=
ecall *vc)
 	for (l =3D vc->call_list; l; l =3D l->next) {
 		v =3D l->data;
 =

-		if (v->call->status =3D=3D CALL_STATUS_HELD)
+		if (v->call->status =3D=3D OFONO_CALL_STATUS_HELD)
 			r =3D g_slist_prepend(r, v);
 	}
 =

@@ -1137,7 +1137,7 @@ static GSList *voicecalls_active_list(struct ofono_vo=
icecall *vc)
 	for (l =3D vc->call_list; l; l =3D l->next) {
 		v =3D l->data;
 =

-		if (v->call->status =3D=3D CALL_STATUS_ACTIVE)
+		if (v->call->status =3D=3D OFONO_CALL_STATUS_ACTIVE)
 			r =3D g_slist_prepend(r, v);
 	}
 =

@@ -1246,10 +1246,10 @@ static void voicecalls_release_queue(struct ofono_v=
oicecall *vc, GSList *calls,
 	for (l =3D calls; l; l =3D l->next) {
 		call =3D l->data;
 =

-		if (call->call->status =3D=3D CALL_STATUS_WAITING)
+		if (call->call->status =3D=3D OFONO_CALL_STATUS_WAITING)
 			continue;
 =

-		if (skip_held && call->call->status =3D=3D CALL_STATUS_HELD)
+		if (skip_held && call->call->status =3D=3D OFONO_CALL_STATUS_HELD)
 			continue;
 =

 		vc->release_list =3D g_slist_prepend(vc->release_list, l->data);
@@ -1272,15 +1272,15 @@ static void voicecalls_release_next(struct ofono_vo=
icecall *vc)
 	if (vc->driver->hangup_active =3D=3D NULL)
 		goto fallback;
 =

-	if (call->call->status =3D=3D CALL_STATUS_ACTIVE &&
+	if (call->call->status =3D=3D OFONO_CALL_STATUS_ACTIVE &&
 					voicecalls_num_active(vc) =3D=3D 1) {
 		vc->driver->hangup_active(vc, multirelease_callback, vc);
 		return;
 	}
 =

-	if (call->call->status =3D=3D CALL_STATUS_ALERTING ||
-		call->call->status =3D=3D CALL_STATUS_DIALING ||
-			call->call->status =3D=3D CALL_STATUS_INCOMING) {
+	if (call->call->status =3D=3D OFONO_CALL_STATUS_ALERTING ||
+			call->call->status =3D=3D OFONO_CALL_STATUS_DIALING ||
+			call->call->status =3D=3D OFONO_CALL_STATUS_INCOMING) {
 		vc->driver->hangup_active(vc, multirelease_callback, vc);
 		return;
 	}
@@ -1378,9 +1378,9 @@ static struct voicecall *synthesize_outgoing_call(str=
uct ofono_voicecall *vc,
 	if (number)
 		string_to_phone_number(number, &call->phone_number);
 =

-	call->direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
-	call->status =3D CALL_STATUS_DIALING;
-	call->clip_validity =3D CLIP_VALIDITY_VALID;
+	call->direction =3D OFONO_CALL_DIRECTION_MOBILE_ORIGINATED;
+	call->status =3D OFONO_CALL_STATUS_DIALING;
+	call->clip_validity =3D OFONO_CLIP_VALIDITY_VALID;
 =

 	v =3D voicecall_create(vc, call);
 	if (v =3D=3D NULL) {
@@ -1422,17 +1422,17 @@ static struct voicecall *dial_handle_result(struct =
ofono_voicecall *vc,
 	for (l =3D vc->call_list; l; l =3D l->next) {
 		v =3D l->data;
 =

-		if (v->call->status =3D=3D CALL_STATUS_DIALING ||
-				v->call->status =3D=3D CALL_STATUS_ALERTING)
+		if (v->call->status =3D=3D OFONO_CALL_STATUS_DIALING ||
+				v->call->status =3D=3D OFONO_CALL_STATUS_ALERTING)
 			goto handled;
 =

 		/*
 		 * Dial request may return before existing active call
 		 * is put on hold or after dialed call has got active
 		 */
-		if (v->call->status =3D=3D CALL_STATUS_ACTIVE &&
+		if (v->call->status =3D=3D OFONO_CALL_STATUS_ACTIVE &&
 				v->call->direction =3D=3D
-				CALL_DIRECTION_MOBILE_ORIGINATED &&
+				OFONO_CALL_DIRECTION_MOBILE_ORIGINATED &&
 				!v->dial_result_handled)
 			goto handled;
 	}
@@ -2129,7 +2129,7 @@ static DBusMessage *multiparty_hangup(DBusConnection =
*conn,
 	if (!voicecalls_have_waiting(vc)) {
 		struct voicecall *v =3D vc->multiparty_list->data;
 =

-		if (v->call->status =3D=3D CALL_STATUS_HELD) {
+		if (v->call->status =3D=3D OFONO_CALL_STATUS_HELD) {
 			vc->driver->release_all_held(vc, generic_callback,
 							vc);
 			goto out;
@@ -2320,7 +2320,7 @@ void ofono_voicecall_disconnected(struct ofono_voicec=
all *vc, int id,
 	GSList *l;
 	struct voicecall *call;
 	time_t ts;
-	enum call_status prev_status;
+	enum ofono_call_status prev_status;
 	const char *number;
 =

 	DBG("Got disconnection event for id: %d, reason: %d", id, reason);
@@ -2366,11 +2366,11 @@ void ofono_voicecall_disconnected(struct ofono_voic=
ecall *vc, int id,
 	if (is_emergency_number(vc, number) =3D=3D TRUE)
 		__ofono_modem_dec_emergency_mode(modem);
 =

-	voicecall_set_call_status(call, CALL_STATUS_DISCONNECTED);
+	voicecall_set_call_status(call, OFONO_CALL_STATUS_DISCONNECTED);
 =

 	if (!call->untracked) {
-		if (prev_status =3D=3D CALL_STATUS_INCOMING ||
-				prev_status =3D=3D CALL_STATUS_WAITING)
+		if (prev_status =3D=3D OFONO_CALL_STATUS_INCOMING ||
+				prev_status =3D=3D OFONO_CALL_STATUS_WAITING)
 			__ofono_history_call_missed(modem, call->call, ts);
 		else
 			__ofono_history_call_ended(modem, call->call,
@@ -2436,13 +2436,14 @@ void ofono_voicecall_notify(struct ofono_voicecall =
*vc,
 		if (!strcmp(phone_number, "112"))
 			__ofono_modem_inc_emergency_mode(modem);
 =

-		if (v->call->clip_validity =3D=3D CLIP_VALIDITY_NOT_AVAILABLE) {
+		if (v->call->clip_validity =3D=3D
+					OFONO_CLIP_VALIDITY_NOT_AVAILABLE) {
 			char *number =3D v->call->phone_number.number;
 =

 			v->call->phone_number.type =3D req->ph.type;
 			strncpy(number, req->ph.number,
 					OFONO_MAX_PHONE_NUMBER_LENGTH);
-			v->call->clip_validity =3D CLIP_VALIDITY_VALID;
+			v->call->clip_validity =3D OFONO_CLIP_VALIDITY_VALID;
 			number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
 		}
 =

@@ -3264,7 +3265,8 @@ static void emulator_clcc_cb(struct ofono_emulator *e=
m,
 			else
 				mpty =3D FALSE;
 =

-			if (v->call->clip_validity =3D=3D CLIP_VALIDITY_VALID) {
+			if (v->call->clip_validity =3D=3D
+						OFONO_CLIP_VALIDITY_VALID) {
 				number =3D v->call->phone_number.number;
 				type =3D v->call->phone_number.type;
 			}
@@ -3807,7 +3809,7 @@ static void dial_request_cb(const struct ofono_error =
*error, void *data)
 	 */
 	v->untracked =3D TRUE;
 =

-	if (v->call->status =3D=3D CALL_STATUS_ACTIVE)
+	if (v->call->status =3D=3D OFONO_CALL_STATUS_ACTIVE)
 		dial_request_finish(vc);
 =

 	if (need_to_emit)
-- =

1.9.1


--===============6035947156269753400==--

