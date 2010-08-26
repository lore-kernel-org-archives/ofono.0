Content-Type: multipart/mixed; boundary="===============7380762952388680262=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] __ofono_voicecall_dial internal api for making calls.
Date: Thu, 26 Aug 2010 13:36:47 +0200
Message-ID: <1282822608-17535-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7380762952388680262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The callback is only invoked when the call is CONNECTED (becomes
active).  Cancel ensures that the callback will not be called and
does nothing more in this version, it's an open question if we
want to release the call.
---
 src/ofono.h     |   19 +++-
 src/voicecall.c |  328 ++++++++++++++++++++++++++++++++++++++++++++++-----=
----
 2 files changed, 296 insertions(+), 51 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 4a42f0c..656d0d7 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -169,11 +169,28 @@ void __ofono_atom_free(struct ofono_atom *atom);
 #include <ofono/cbs.h>
 #include <ofono/devinfo.h>
 #include <ofono/phonebook.h>
-#include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
 =

+#include <ofono/voicecall.h>
+
+enum ofono_voicecall_interaction {
+	OFONO_VOICECALL_INTERACTION_NONE	=3D 0,
+	OFONO_VOICECALL_INTERACTION_PUT_ON_HOLD	=3D 1,
+	OFONO_VOICECALL_INTERACTION_DISCONNECT	=3D 2,
+};
+
+typedef void (*ofono_voicecall_dial_cb_t)(struct ofono_call *call, void *d=
ata);
+
+ofono_bool_t __ofono_voicecall_busy(struct ofono_voicecall *vc);
+int __ofono_voicecall_dial(struct ofono_voicecall *vc,
+				const char *addr, int addr_type,
+				const char *message, unsigned char icon_id,
+				enum ofono_voicecall_interaction interaction,
+				ofono_voicecall_dial_cb_t cb, void *user_data);
+void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc);
+
 #include <ofono/sms.h>
 =

 struct sms;
diff --git a/src/voicecall.c b/src/voicecall.c
index e62c434..9199ab6 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -27,6 +27,7 @@
 #include <stdio.h>
 #include <time.h>
 #include <errno.h>
+#include <stdint.h>
 =

 #include <glib.h>
 #include <gdbus.h>
@@ -57,6 +58,7 @@ struct ofono_voicecall {
 	const struct ofono_voicecall_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct dial_request *dial_req;
 };
 =

 struct voicecall {
@@ -64,6 +66,20 @@ struct voicecall {
 	struct ofono_voicecall *vc;
 	time_t start_time;
 	time_t detect_time;
+	const char *message;
+	uint8_t icon_id;
+	gboolean untracked;
+};
+
+struct dial_request {
+	struct ofono_voicecall *vc;
+	const char *message;
+	uint8_t icon_id;
+	enum ofono_voicecall_interaction interaction;
+	ofono_voicecall_dial_cb_t cb;
+	void *user_data;
+	struct voicecall *call;
+	struct ofono_phone_number ph;
 };
 =

 static const char *default_en_list[] =3D { "911", "112", NULL };
@@ -235,6 +251,14 @@ static void append_voicecall_properties(struct voiceca=
ll *v,
 		mpty =3D FALSE;
 =

 	ofono_dbus_dict_append(dict, "Multiparty", DBUS_TYPE_BOOLEAN, &mpty);
+
+	if (v->message)
+		ofono_dbus_dict_append(dict, "Information", DBUS_TYPE_STRING,
+					&v->message);
+
+	if (v->icon_id)
+		ofono_dbus_dict_append(dict, "Icon", DBUS_TYPE_BYTE,
+					&v->icon_id);
 }
 =

 static DBusMessage *voicecall_get_properties(DBusConnection *conn,
@@ -529,6 +553,32 @@ static void voicecall_set_call_status(struct voicecall=
 *call,
 						OFONO_VOICECALL_INTERFACE,
 						"StartTime", DBUS_TYPE_STRING,
 						&timestr);
+
+		if (call->vc->dial_req && call =3D=3D call->vc->dial_req->call) {
+			struct dial_request *req =3D call->vc->dial_req;
+
+			if (req->cb)
+				req->cb(call->call, req->user_data);
+
+			/*
+			 * TODO: parse the called number for DTMF tones to be
+			 * sent after call becomes active, and send them.
+			 */
+
+			call->vc->dial_req =3D NULL;
+			g_free(req);
+		}
+	}
+
+	if (status =3D=3D CALL_STATUS_DISCONNECTED && call->vc->dial_req &&
+			call =3D=3D call->vc->dial_req->call) {
+		struct dial_request *req =3D call->vc->dial_req;
+
+		if (req->cb)
+			req->cb(NULL, req->user_data);
+
+		call->vc->dial_req =3D NULL;
+		g_free(req);
 	}
 }
 =

@@ -906,10 +956,9 @@ static ofono_bool_t clir_string_to_clir(const char *cl=
irstr,
 }
 =

 static struct ofono_call *synthesize_outgoing_call(struct ofono_voicecall =
*vc,
-						DBusMessage *msg)
+							const char *number)
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
-	const char *number;
 	struct ofono_call *call;
 =

 	call =3D g_try_new0(struct ofono_call, 1);
@@ -927,10 +976,7 @@ static struct ofono_call *synthesize_outgoing_call(str=
uct ofono_voicecall *vc,
 =

 	__ofono_modem_callid_hold(modem, call->id);
 =

-	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
-				DBUS_TYPE_INVALID) =3D=3D FALSE)
-		number =3D "";
-	else
+	if (number)
 		string_to_phone_number(number, &call->phone_number);
 =

 	call->direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
@@ -940,70 +986,80 @@ static struct ofono_call *synthesize_outgoing_call(st=
ruct ofono_voicecall *vc,
 	return call;
 }
 =

-static void dial_callback(const struct ofono_error *error, void *data)
+static struct voicecall *dial_handle_result(struct ofono_voicecall *vc,
+						const struct ofono_error *error,
+						const char *number,
+						gboolean *need_to_emit)
 {
-	struct ofono_voicecall *vc =3D data;
-	DBusMessage *reply;
 	GSList *l;
 	struct voicecall *v;
 	struct ofono_call *call;
-	const char *path;
-	gboolean need_to_emit =3D FALSE;
+
+	*need_to_emit =3D FALSE;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Dial callback returned error: %s",
 			telephony_error_to_str(error));
-		reply =3D __ofono_error_failed(vc->pending);
-		__ofono_dbus_pending_reply(&vc->pending, reply);
-		return;
+
+		return NULL;
 	}
 =

 	/* Two things can happen, the call notification arrived before dial
 	 * callback or dial callback was first.	Handle here */
 	for (l =3D vc->call_list; l; l =3D l->next) {
-		struct voicecall *v =3D l->data;
+		v =3D l->data;
 =

 		if (v->call->status =3D=3D CALL_STATUS_DIALING ||
 				v->call->status =3D=3D CALL_STATUS_ALERTING ||
 				v->call->status =3D=3D CALL_STATUS_ACTIVE)
-			break;
+			return v;
 	}
 =

-	if (!l) {
-		call =3D synthesize_outgoing_call(vc, vc->pending);
+	call =3D synthesize_outgoing_call(vc, number);
+	if (!call)
+		return NULL;
 =

-		if (!call) {
-			__ofono_dbus_pending_reply(&vc->pending,
-				__ofono_error_failed(vc->pending));
-			return;
-		}
+	v =3D voicecall_create(vc, call);
+	if (!v)
+		return NULL;
 =

-		v =3D voicecall_create(vc, call);
+	v->detect_time =3D time(NULL);
 =

-		if (!v) {
-			__ofono_dbus_pending_reply(&vc->pending,
-				__ofono_error_failed(vc->pending));
-			return;
-		}
+	DBG("Registering new call: %d", call->id);
+	voicecall_dbus_register(v);
 =

-		v->detect_time =3D time(NULL);
+	vc->call_list =3D g_slist_insert_sorted(vc->call_list, v,
+				call_compare);
 =

-		DBG("Registering new call: %d", call->id);
-		voicecall_dbus_register(v);
+	*need_to_emit =3D TRUE;
 =

-		vc->call_list =3D g_slist_insert_sorted(vc->call_list, v,
-					call_compare);
+	return v;
+}
 =

-		need_to_emit =3D TRUE;
-	} else {
-		v =3D l->data;
-		call =3D v->call;
-	}
+static void manager_dial_callback(const struct ofono_error *error, void *d=
ata)
+{
+	struct ofono_voicecall *vc =3D data;
+	DBusMessage *reply;
+	const char *number;
+	gboolean need_to_emit;
+	struct voicecall *v;
+
+	if (dbus_message_get_args(vc->pending, NULL, DBUS_TYPE_STRING, &number,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		number =3D NULL;
+
+	v =3D dial_handle_result(vc, error, number, &need_to_emit);
+
+	if (v) {
+		const char *path =3D voicecall_build_path(vc, v->call);
+
+		reply =3D dbus_message_new_method_return(vc->pending);
+
+		dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID);
+	} else
+		reply =3D __ofono_error_failed(vc->pending);
 =

-	reply =3D dbus_message_new_method_return(vc->pending);
-	path =3D voicecall_build_path(vc, call);
-	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
-					DBUS_TYPE_INVALID);
 	__ofono_dbus_pending_reply(&vc->pending, reply);
 =

 	if (need_to_emit)
@@ -1054,7 +1110,7 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 	string_to_phone_number(number, &ph);
 =

 	vc->driver->dial(vc, &ph, clir, OFONO_CUG_OPTION_DEFAULT,
-				dial_callback, vc);
+				manager_dial_callback, vc);
 =

 	return NULL;
 }
@@ -1644,12 +1700,14 @@ void ofono_voicecall_disconnected(struct ofono_voic=
ecall *vc, int id,
 =

 	voicecall_set_call_status(call, CALL_STATUS_DISCONNECTED);
 =

-	if (prev_status =3D=3D CALL_STATUS_INCOMING ||
-			prev_status =3D=3D CALL_STATUS_WAITING)
-		__ofono_history_call_missed(modem, call->call, ts);
-	else
-		__ofono_history_call_ended(modem, call->call,
-						call->detect_time, ts);
+	if (!call->untracked) {
+		if (prev_status =3D=3D CALL_STATUS_INCOMING ||
+				prev_status =3D=3D CALL_STATUS_WAITING)
+			__ofono_history_call_missed(modem, call->call, ts);
+		else
+			__ofono_history_call_ended(modem, call->call,
+							call->detect_time, ts);
+	}
 =

 	voicecalls_emit_call_removed(vc, call);
 =

@@ -2095,3 +2153,173 @@ int ofono_voicecall_get_next_callid(struct ofono_vo=
icecall *vc)
 =

 	return __ofono_modem_callid_next(modem);
 }
+
+ofono_bool_t __ofono_voicecall_busy(struct ofono_voicecall *vc)
+{
+	return vc->dial_req || vc->pending || voicecalls_have_active(vc) ||
+			g_slist_length(vc->call_list) >=3D MAX_VOICE_CALLS ||
+			voicecalls_have_incoming(vc) ||
+			voicecalls_num_connecting(vc) > 0;
+}
+
+static void dial_request_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	gboolean need_to_emit;
+	struct voicecall *v;
+
+	v =3D dial_handle_result(vc, error,
+				phone_number_to_string(&vc->dial_req->ph),
+				&need_to_emit);
+
+	if (v) {
+		v->message =3D vc->dial_req->message;
+		v->icon_id =3D vc->dial_req->icon_id;
+
+		/*
+		 * TS 102 223 Section 6.4.13: The terminal shall not store
+		 * in the UICC the call set-up details (called party number
+		 * and associated parameters)
+		 */
+		v->untracked =3D TRUE;
+	}
+
+	if (need_to_emit)
+		voicecalls_emit_call_added(vc, v);
+
+	if (vc->dial_req->cb) {
+		if (v && v->call->status !=3D CALL_STATUS_ACTIVE) {
+			vc->dial_req->call =3D v;
+
+			/* Wait for the call connected message */
+			return;
+		}
+
+		vc->dial_req->cb(v ? v->call : NULL, vc->dial_req->user_data);
+	}
+
+	g_free(vc->dial_req);
+	vc->dial_req =3D NULL;
+}
+
+static int dial_request(struct ofono_voicecall *vc)
+{
+	if (g_slist_length(vc->call_list) >=3D MAX_VOICE_CALLS ||
+			voicecalls_have_incoming(vc) ||
+			voicecalls_num_connecting(vc) > 0 ||
+			vc->pending) {
+		g_free(vc->dial_req);
+		vc->dial_req =3D NULL;
+
+		return -EBUSY;
+	}
+
+	vc->driver->dial(vc, &vc->dial_req->ph, OFONO_CLIR_OPTION_DEFAULT,
+				OFONO_CUG_OPTION_DEFAULT, dial_request_cb, vc);
+
+	return 0;
+}
+
+static void hold_or_disconnect_cb(const struct ofono_error *error, void *d=
ata)
+{
+	struct ofono_voicecall *vc =3D data;
+	ofono_voicecall_dial_cb_t cb =3D vc->dial_req->cb;
+	void *user_data =3D vc->dial_req->user_data;
+	int err;
+
+	if (!cb) {
+		g_free(vc->dial_req);
+		vc->dial_req =3D NULL;
+
+		return;
+	}
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		cb(FALSE, user_data);
+
+		g_free(vc->dial_req);
+		vc->dial_req =3D NULL;
+
+		return;
+	}
+
+	err =3D dial_request(vc);
+
+	if (err < 0)
+		cb(FALSE, user_data);
+}
+
+int __ofono_voicecall_dial(struct ofono_voicecall *vc,
+				const char *addr, int addr_type,
+				const char *message, unsigned char icon_id,
+				enum ofono_voicecall_interaction interaction,
+				ofono_voicecall_dial_cb_t cb, void *user_data)
+{
+	struct dial_request *req;
+
+	if (!valid_phone_number_format(addr))
+		return -EINVAL;
+
+	if (!vc->driver->dial)
+		return -ENOSYS;
+
+	if (vc->dial_req || vc->pending)
+		return -EBUSY;
+
+	/*
+	 * TODO: if addr starts with "112", possibly translate into the
+	 * technology-specific emergency number.
+	 */
+
+	req =3D g_try_new0(struct dial_request, 1);
+	req->message =3D message;
+	req->icon_id =3D icon_id;
+	req->interaction =3D interaction;
+	req->cb =3D cb;
+	req->user_data =3D user_data;
+
+	/* TODO: parse the tones to dial after call connected */
+	req->ph.type =3D addr_type;
+	strncpy(req->ph.number, addr, 20);
+
+	if (!voicecalls_have_active(vc)) {
+		vc->dial_req =3D req;
+
+		return dial_request(vc);
+	}
+
+	switch (interaction) {
+	case OFONO_VOICECALL_INTERACTION_NONE:
+		return -EBUSY;
+
+	case OFONO_VOICECALL_INTERACTION_PUT_ON_HOLD:
+		/* Note: dialling automatically puts active calls on hold */
+		vc->dial_req =3D req;
+
+		return dial_request(vc);
+
+	case OFONO_VOICECALL_INTERACTION_DISCONNECT:
+		if (!vc->driver->release_all_active) {
+			g_free(req);
+
+			return -ENOSYS;
+		}
+
+		vc->driver->release_all_active(vc, hold_or_disconnect_cb, vc);
+		break;
+	}
+
+	vc->dial_req =3D req;
+
+	return 0;
+}
+
+void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc)
+{
+	if (!vc->dial_req || !vc->dial_req->cb)
+		return;
+
+	vc->dial_req->cb =3D NULL;
+
+	/* XXX: If vc->dial_req->call is set, try to release it? */
+}
-- =

1.7.1.86.g0e460.dirty


--===============7380762952388680262==--

