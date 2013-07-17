Content-Type: multipart/mixed; boundary="===============0921637321748423674=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC] voicecall: Allow second stage string on Dial()
Date: Wed, 17 Jul 2013 20:23:57 -0300
Message-ID: <1374103437-21260-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0921637321748423674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lucas De Marchi <lucas.demarchi@intel.com>

Use a pause to separate the number to dial from the second stage part,
that is sent as tones. We wait until the call becomes ACTIVE and even
the first pause is applied (we wait 3s before continuing with the
second stage).
---

A starting point to implement the dialtstring item in the TODO list.  I
couldn't find a better way to propagate the second stage string until the c=
all
reaches the ACTIVE state.  So I've put it in ofono_voicecall, that "propaga=
tes"
the string until we reach that state.

Due to the fact that manager_dial_callback() can be called before or after =
the
voicecall is in ACTIVE state, we need some checks here and there in order n=
ot
to do the wrong thing.

Let me know if there's an easier way to handle it.


Maybe we should export a property in the voicecall? And set it to an error
if later the send-tones failed?  Thoughts?

Lucas De Marchi

 src/voicecall.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index ae76b91..f49942d 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -72,6 +72,7 @@ struct ofono_voicecall {
 	unsigned int hfp_watch;
 	GKeyFile *settings;
 	char *imsi;
+	char *pending_tones;
 	ofono_voicecall_cb_t release_queue_done_cb;
 	struct ofono_emulator *pending_em;
 	unsigned int pending_id;
@@ -83,6 +84,7 @@ struct voicecall {
 	time_t start_time;
 	time_t detect_time;
 	char *message;
+	char *pending_tones;
 	uint8_t icon_id;
 	gboolean untracked;
 	gboolean dial_result_handled;
@@ -394,7 +396,7 @@ static void tone_request_finish(struct ofono_voicecall =
*vc,
 {
 	g_queue_remove(vc->toneq, entry);
 =

-	if (callback)
+	if (callback && entry->cb)
 		entry->cb(error, entry->user_data);
 =

 	if (entry->destroy)
@@ -707,6 +709,7 @@ static void voicecall_destroy(gpointer userdata)
 =

 	g_free(voicecall->call);
 	g_free(voicecall->message);
+	g_free(voicecall->pending_tones);
 =

 	g_free(voicecall);
 }
@@ -750,6 +753,19 @@ static void voicecall_emit_multiparty(struct voicecall=
 *call, gboolean mpty)
 						&val);
 }
 =

+static void voicecall_handle_pending_tones(struct voicecall *call)
+{
+	if (call->call->status !=3D CALL_STATUS_ACTIVE)
+		return;
+
+	if (call->pending_tones =3D=3D NULL)
+		return;
+
+	tone_queue(call->vc, call->pending_tones, NULL, NULL, NULL);
+	g_free(call->pending_tones);
+	call->pending_tones =3D NULL;
+}
+
 static void emulator_set_indicator_forced(struct ofono_voicecall *vc,
 						const char *name, int value)
 {
@@ -946,6 +962,13 @@ static void voicecall_set_call_status(struct voicecall=
 *call, int status)
 =

 		if (call->vc->dial_req && call =3D=3D call->vc->dial_req->call)
 			dial_request_finish(call->vc);
+
+		if (call->vc->pending_tones !=3D NULL) {
+			call->pending_tones =3D call->vc->pending_tones;
+			call->vc->pending_tones =3D NULL;
+		}
+
+		voicecall_handle_pending_tones(call);
 	}
 =

 	if (status =3D=3D CALL_STATUS_DISCONNECTED && call->vc->dial_req &&
@@ -1459,6 +1482,10 @@ static struct voicecall *dial_handle_result(struct o=
fono_voicecall *vc,
 	vc->call_list =3D g_slist_insert_sorted(vc->call_list, v,
 				call_compare);
 =

+	v->pending_tones =3D vc->pending_tones;
+	vc->pending_tones =3D NULL;
+	voicecall_handle_pending_tones(v);
+
 	*need_to_emit =3D TRUE;
 =

 handled:
@@ -1494,6 +1521,9 @@ static void manager_dial_callback(const struct ofono_=
error *error, void *data)
 		if (is_emergency_number(vc, number) =3D=3D TRUE)
 			__ofono_modem_dec_emergency_mode(modem);
 =

+		g_free(vc->pending_tones);
+		vc->pending_tones =3D NULL;
+
 		reply =3D __ofono_error_failed(vc->pending);
 	}
 =

@@ -1552,7 +1582,8 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
-	const char *number;
+	char *number_nopause =3D NULL;
+	const char *number, *tones;
 	const char *clirstr;
 	enum ofono_clir_option clir;
 	int err;
@@ -1570,12 +1601,24 @@ static DBusMessage *manager_dial(DBusConnection *co=
nn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

+	tones =3D strpbrk(number, "pP");
+
+	if (tones !=3D NULL) {
+		number_nopause =3D g_strndup(number, tones - number);
+		vc->pending_tones =3D g_ascii_strup(tones, -1);
+		number =3D number_nopause;
+	}
+
 	err =3D voicecall_dial(vc, number, clir, manager_dial_callback, vc);
+	g_free(number_nopause);
 =

 	if (err >=3D 0)
 		return NULL;
 =

 	vc->pending =3D NULL;
+	g_free(vc->pending_tones);
+	vc->pending_tones =3D NULL;
+
 	dbus_message_unref(msg);
 =

 	switch (err) {
-- =

1.8.3.3


--===============0921637321748423674==--

