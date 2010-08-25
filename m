Content-Type: multipart/mixed; boundary="===============2780985847256386860=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3][RfC] Add __ofono_voicecall_dial for other atoms to make
 calls.
Date: Wed, 25 Aug 2010 17:49:16 +0200
Message-ID: <1282751357-7086-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1282751357-7086-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2780985847256386860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The callback is only invoked when the call is CONNECTED (becomes
active).  Cancel ensures that the callback will not be called and
does nothing more in this version, it's an open question if we
want to release the call.
---
 src/ofono.h     |   19 ++++-
 src/voicecall.c |  247 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 265 insertions(+), 1 deletions(-)

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
index 4b4d314..fb0c515 100644
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
@@ -59,6 +60,7 @@ struct ofono_voicecall {
 	const struct ofono_voicecall_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct dial_request *dial_req;
 };
 =

 struct voicecall {
@@ -66,6 +68,19 @@ struct voicecall {
 	struct ofono_voicecall *vc;
 	time_t start_time;
 	time_t detect_time;
+	const char *message;
+	uint8_t icon_id;
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
@@ -243,6 +258,14 @@ static DBusMessage *voicecall_get_properties(DBusConne=
ction *conn,
 					&timestr);
 	}
 =

+	if (v->message)
+		ofono_dbus_dict_append(&dict, "Information", DBUS_TYPE_STRING,
+					&v->message);
+
+	if (v->icon_id)
+		ofono_dbus_dict_append(&dict, "Icon", DBUS_TYPE_BYTE,
+					&v->icon_id);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -504,6 +527,32 @@ static void voicecall_set_call_status(struct voicecall=
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

@@ -2020,3 +2069,201 @@ int ofono_voicecall_get_next_callid(struct ofono_vo=
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
+	GSList *l;
+	struct voicecall *v =3D NULL;
+	gboolean need_to_emit =3D FALSE;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Dial callback returned error: %s",
+			telephony_error_to_str(error));
+
+		goto done;
+	}
+
+	/* Two things can happen, the call notification arrived before dial
+	 * callback or dial callback was first.	Handle here */
+	for (l =3D vc->call_list; l; l =3D l->next) {
+		v =3D l->data;
+
+		if (v->call->status =3D=3D CALL_STATUS_DIALING ||
+				v->call->status =3D=3D CALL_STATUS_ALERTING ||
+				v->call->status =3D=3D CALL_STATUS_ACTIVE)
+			break;
+	}
+
+	if (!l) {
+		struct ofono_call *call =3D
+			synthesize_outgoing_call(vc, vc->pending);
+		if (!call) {
+			v =3D NULL;
+
+			goto done;
+		}
+
+		v =3D voicecall_create(vc, call);
+		if (!v)
+			goto done;
+
+		v->detect_time =3D time(NULL);
+
+		DBG("Registering new call: %d", call->id);
+		voicecall_dbus_register(v);
+
+		vc->call_list =3D g_slist_insert_sorted(vc->call_list, v,
+					call_compare);
+
+		need_to_emit =3D TRUE;
+	}
+
+	v->message =3D vc->dial_req->message;
+	v->icon_id =3D vc->dial_req->icon_id;
+
+	if (need_to_emit)
+		emit_call_list_changed(vc);
+
+done:
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
+	/* If vc->dial_req->call is set, try to release it? */
+}
-- =

1.7.1.86.g0e460.dirty


--===============2780985847256386860==--

