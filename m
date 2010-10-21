Content-Type: multipart/mixed; boundary="===============6933837395933883361=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] voicecall: __ofono_voicecall_tone_send internal api.
Date: Thu, 21 Oct 2010 07:09:05 +0200
Message-ID: <1287637748-7230-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6933837395933883361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This provides a way for other atoms to send DTMF tones during a call.
It is assumed that vc->driver->send_tone returns only after the tones
have finished being emitted.

In this version Dbus DTMF requests are in the same queue as STK
requests.
---
 src/ofono.h     |    6 ++
 src/voicecall.c |  269 ++++++++++++++++++++++++++++++++++++++++++++++++---=
----
 2 files changed, 243 insertions(+), 32 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 78e6be1..bd7f33c 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -207,6 +207,7 @@ enum ofono_voicecall_interaction {
 };
 =

 typedef void (*ofono_voicecall_dial_cb_t)(struct ofono_call *call, void *d=
ata);
+typedef void (*ofono_voicecall_tone_cb_t)(int error, void *data);
 =

 ofono_bool_t __ofono_voicecall_is_busy(struct ofono_voicecall *vc,
 					enum ofono_voicecall_interaction type);
@@ -218,6 +219,11 @@ int __ofono_voicecall_dial(struct ofono_voicecall *vc,
 				ofono_voicecall_dial_cb_t cb, void *user_data);
 void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc);
 =

+int __ofono_voicecall_tone_send(struct ofono_voicecall *vc,
+				const char *tone_str,
+				ofono_voicecall_tone_cb_t cb, void *user_data);
+void __ofono_voicecall_tone_cancel(struct ofono_voicecall *vc, int id);
+
 #include <ofono/sms.h>
 =

 struct sms;
diff --git a/src/voicecall.c b/src/voicecall.c
index 7b5fe3b..26cfb9a 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -56,6 +56,8 @@ struct ofono_voicecall {
 	void *driver_data;
 	struct ofono_atom *atom;
 	struct dial_request *dial_req;
+	GQueue *toneq;
+	guint tone_source;
 };
 =

 struct voicecall {
@@ -79,12 +81,22 @@ struct dial_request {
 	struct ofono_phone_number ph;
 };
 =

+struct tone_queue_entry {
+	char *tone_str;
+	char *left;
+	ofono_voicecall_tone_cb_t cb;
+	void *user_data;
+	ofono_destroy_func destroy;
+	int id;
+};
+
 static const char *default_en_list[] =3D { "911", "112", NULL };
 static const char *default_en_list_no_sim[] =3D { "119", "118", "999", "11=
0",
 						"08", "000", NULL };
 =

 static void generic_callback(const struct ofono_error *error, void *data);
 static void multirelease_callback(const struct ofono_error *err, void *dat=
a);
+static gboolean tone_request_run(gpointer user_data);
 =

 static gint call_compare_by_id(gconstpointer a, gconstpointer b)
 {
@@ -226,6 +238,83 @@ static void dial_request_finish(struct ofono_voicecall=
 *vc)
 	vc->dial_req =3D NULL;
 }
 =

+static gboolean voicecalls_can_dtmf(struct ofono_voicecall *vc)
+{
+	GSList *l;
+	struct voicecall *v;
+
+	for (l =3D vc->call_list; l; l =3D l->next) {
+		v =3D l->data;
+
+		if (v->call->status =3D=3D CALL_STATUS_ACTIVE)
+			return TRUE;
+
+		/* Connected for 2nd stage dialing */
+		if (v->call->status =3D=3D CALL_STATUS_ALERTING)
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+static int tone_queue(struct ofono_voicecall *vc, const char *tone_str,
+			ofono_voicecall_tone_cb_t cb, void *data,
+			ofono_destroy_func destroy)
+{
+	struct tone_queue_entry *entry;
+	int id =3D 1;
+	int n =3D 0;
+	int i;
+
+	/*
+	 * Tones can be 0-9, *, #, A-D according to 27.007 C.2.11,
+	 * and p for Pause.
+	 */
+	for (i =3D 0; tone_str[i]; i++)
+		if (!g_ascii_isdigit(tone_str[i]) && tone_str[i] !=3D 'p' &&
+				tone_str[i] !=3D '*' && tone_str[i] !=3D '#' &&
+				(tone_str[i] < 'A' || tone_str[i] > 'D'))
+			return -EINVAL;
+
+	while ((entry =3D g_queue_peek_nth(vc->toneq, n++)) !=3D NULL)
+		if (entry->id >=3D id)
+			id =3D entry->id + 1;
+
+	entry =3D g_try_new0(struct tone_queue_entry, 1);
+	if (entry =3D=3D NULL)
+		return -ENOMEM;
+
+	entry->tone_str =3D g_strdup(tone_str);
+	entry->left =3D entry->tone_str;
+	entry->cb =3D cb;
+	entry->user_data =3D data;
+	entry->destroy =3D destroy;
+	entry->id =3D id;
+
+	g_queue_push_tail(vc->toneq, entry);
+
+	if (g_queue_get_length(vc->toneq) =3D=3D 1)
+		g_timeout_add(0, tone_request_run, vc);
+
+	return id;
+}
+
+static void tone_request_finish(struct ofono_voicecall *vc,
+				struct tone_queue_entry *entry,
+				int error, gboolean callback)
+{
+	g_queue_remove(vc->toneq, entry);
+
+	if (callback)
+		entry->cb(error, entry->user_data);
+
+	if (entry->destroy)
+		entry->destroy(entry->user_data);
+
+	g_free(entry->tone_str);
+	g_free(entry);
+}
+
 static void append_voicecall_properties(struct voicecall *v,
 					DBusMessageIter *dict)
 {
@@ -583,6 +672,13 @@ static void voicecall_set_call_status(struct voicecall=
 *call, int status)
 	if (status =3D=3D CALL_STATUS_DISCONNECTED && call->vc->dial_req &&
 			call =3D=3D call->vc->dial_req->call)
 		dial_request_finish(call->vc);
+
+	if (!voicecalls_can_dtmf(call->vc)) {
+		struct tone_queue_entry *entry;
+
+		while ((entry =3D g_queue_peek_head(call->vc->toneq)))
+			tone_request_finish(call->vc, entry, ENOENT, TRUE);
+	}
 }
 =

 static void voicecall_set_call_lineid(struct voicecall *v,
@@ -699,25 +795,6 @@ static gboolean voicecalls_have_active(struct ofono_vo=
icecall *vc)
 	return FALSE;
 }
 =

-static gboolean voicecalls_can_dtmf(struct ofono_voicecall *vc)
-{
-	GSList *l;
-	struct voicecall *v;
-
-	for (l =3D vc->call_list; l; l =3D l->next) {
-		v =3D l->data;
-
-		if (v->call->status =3D=3D CALL_STATUS_ACTIVE)
-			return TRUE;
-
-		/* Connected for 2nd stage dialing */
-		if (v->call->status =3D=3D CALL_STATUS_ALERTING)
-			return TRUE;
-	}
-
-	return FALSE;
-}
-
 static gboolean voicecalls_have_with_status(struct ofono_voicecall *vc, in=
t status)
 {
 	GSList *l;
@@ -1527,13 +1604,26 @@ out:
 	return NULL;
 }
 =

+static void tone_callback(int error, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	DBusMessage *reply;
+
+	if (error)
+		reply =3D __ofono_error_failed(vc->pending);
+	else
+		reply =3D dbus_message_new_method_return(vc->pending);
+
+	__ofono_dbus_pending_reply(&vc->pending, reply);
+}
+
 static DBusMessage *manager_tone(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
 	const char *in_tones;
 	char *tones;
-	int i, len;
+	int err, len;
 =

 	if (vc->pending)
 		return __ofono_error_busy(msg);
@@ -1556,23 +1646,15 @@ static DBusMessage *manager_tone(DBusConnection *co=
nn,
 =

 	tones =3D g_ascii_strup(in_tones, len);
 =

-	/* Tones can be 0-9, *, #, A-D according to 27.007 C.2.11 */
-	for (i =3D 0; i < len; i++) {
-		if (g_ascii_isdigit(tones[i]) ||
-			tones[i] =3D=3D '*' || tones[i] =3D=3D '#' ||
-				(tones[i] >=3D 'A' && tones[i] <=3D 'D'))
-			continue;
+	err =3D tone_queue(vc, tones, tone_callback, vc, NULL);
 =

-		g_free(tones);
+	g_free(tones);
+
+	if (err < 0)
 		return __ofono_error_invalid_format(msg);
-	}
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

-	vc->driver->send_tones(vc, tones, generic_callback, vc);
-
-	g_free(tones);
-
 	return NULL;
 }
 =

@@ -2012,6 +2094,20 @@ static void voicecall_remove(struct ofono_atom *atom)
 		vc->sim =3D NULL;
 	}
 =

+	if (vc->tone_source) {
+		g_source_remove(vc->tone_source);
+		vc->tone_source =3D 0;
+	}
+
+	if (vc->toneq) {
+		struct tone_queue_entry *entry;
+
+		while ((entry =3D g_queue_peek_head(vc->toneq)))
+			tone_request_finish(vc, entry, ESHUTDOWN, TRUE);
+
+		g_queue_free(vc->toneq);
+	}
+
 	g_free(vc);
 }
 =

@@ -2031,6 +2127,8 @@ struct ofono_voicecall *ofono_voicecall_create(struct=
 ofono_modem *modem,
 	if (vc =3D=3D NULL)
 		return NULL;
 =

+	vc->toneq =3D g_queue_new();
+
 	vc->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_VOICECALL,
 						voicecall_remove, vc);
 =

@@ -2326,3 +2424,110 @@ void __ofono_voicecall_dial_cancel(struct ofono_voi=
cecall *vc)
 =

 	vc->dial_req->cb =3D NULL;
 }
+
+static void tone_request_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	struct tone_queue_entry *entry =3D g_queue_peek_head(vc->toneq);
+	int len =3D 0;
+
+	if (!entry)
+		return;
+
+	/*
+	 * Call back with error only if the error is related to the
+	 * current entry.  If the error corresponds to a cancelled
+	 * request, do nothing.
+	 */
+	if (error && error->type !=3D OFONO_ERROR_TYPE_NO_ERROR &&
+			entry->left > entry->tone_str) {
+		DBG("command failed with error: %s",
+				telephony_error_to_str(error));
+
+		tone_request_finish(vc, entry, EIO, TRUE);
+
+		goto done;
+	}
+
+	if (*entry->left =3D=3D '\0') {
+		tone_request_finish(vc, entry, 0, TRUE);
+
+		goto done;
+	}
+
+	len =3D strspn(entry->left, "pP");
+	entry->left +=3D len;
+
+done:
+	/*
+	 * Wait 3 seconds per PAUSE, same as for DTMF separator characters
+	 * passed in a telephone number according to TS 22.101 A.21,
+	 * although 27.007 claims this delay can be set using S8 and
+	 * defaults to 2 seconds.
+	 */
+	vc->tone_source =3D g_timeout_add_seconds(len * 3, tone_request_run, vc);
+}
+
+static gboolean tone_request_run(gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct tone_queue_entry *entry =3D g_queue_peek_head(vc->toneq);
+	char buf[256];
+	unsigned len;
+
+	vc->tone_source =3D 0;
+
+	if (!entry)
+		return FALSE;
+
+	len =3D strcspn(entry->left, "pP");
+
+	if (len) {
+		if (len >=3D sizeof(buf))
+			len =3D sizeof(buf) - 1;
+
+		memcpy(buf, entry->left, len);
+		buf[len] =3D '\0';
+		entry->left +=3D len;
+
+		vc->driver->send_tones(vc, buf, tone_request_cb, vc);
+	} else
+		tone_request_cb(NULL, vc);
+
+	return FALSE;
+}
+
+int __ofono_voicecall_tone_send(struct ofono_voicecall *vc,
+				const char *tone_str,
+				ofono_voicecall_tone_cb_t cb, void *user_data)
+{
+	if (!vc->driver->send_tones)
+		return -ENOSYS;
+
+	/* Send DTMFs only if we have at least one connected call */
+	if (!voicecalls_can_dtmf(vc))
+		return -ENOENT;
+
+	return tone_queue(vc, tone_str, cb, user_data, NULL);
+}
+
+void __ofono_voicecall_tone_cancel(struct ofono_voicecall *vc, int id)
+{
+	struct tone_queue_entry *entry;
+	int n =3D 0;
+
+	while ((entry =3D g_queue_peek_nth(vc->toneq, n++)) !=3D NULL)
+		if (entry->id =3D=3D id)
+			break;
+
+	tone_request_finish(vc, entry, 0, FALSE);
+
+	/*
+	 * If we were in the middle of a PAUSE, wake queue up
+	 * now, else wake up when current tone finishes.
+	 */
+	if (n =3D=3D 1 && vc->tone_source) {
+		g_source_remove(vc->tone_source);
+		tone_request_run(vc);
+	}
+}
-- =

1.7.1.86.g0e460.dirty


--===============6933837395933883361==--

