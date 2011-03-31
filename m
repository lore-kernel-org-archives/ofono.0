Content-Type: multipart/mixed; boundary="===============3786049780563185014=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC PATCH 9/9] voicecall: add emergency mode handling
Date: Thu, 31 Mar 2011 09:18:32 -0700
Message-ID: <1301588312-6932-10-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3786049780563185014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index f25c770..04be551 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1281,8 +1281,14 @@ static void manager_dial_callback(const struct ofono=
_error *error, void *data)
 =

 		dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID);
-	} else
+	} else {
+		struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+
+		if (is_emergency_number(vc, number) =3D=3D TRUE)
+			__ofono_modem_dec_emergency_mode(modem);
+
 		reply =3D __ofono_error_failed(vc->pending);
+	}
 =

 	__ofono_dbus_pending_reply(&vc->pending, reply);
 =

@@ -1294,6 +1300,7 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	const char *number;
 	struct ofono_phone_number ph;
 	const char *clirstr;
@@ -1316,6 +1323,9 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 	if (clir_string_to_clir(clirstr, &clir) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

+	if (ofono_modem_get_online(modem) =3D=3D FALSE)
+		return __ofono_error_not_available(msg);
+
 	if (vc->driver->dial =3D=3D NULL)
 		return __ofono_error_not_implemented(msg);
 =

@@ -1329,6 +1339,9 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
 		return __ofono_error_failed(msg);
 =

+	if (is_emergency_number(vc, number) =3D=3D TRUE)
+		__ofono_modem_inc_emergency_mode(modem);
+
 	vc->pending =3D dbus_message_ref(msg);
 =

 	string_to_phone_number(number, &ph);
@@ -1891,6 +1904,7 @@ void ofono_voicecall_disconnected(struct ofono_voicec=
all *vc, int id,
 	struct voicecall *call;
 	time_t ts;
 	enum call_status prev_status;
+	const char *number;
 =

 	DBG("Got disconnection event for id: %d, reason: %d", id, reason);
 =

@@ -1931,6 +1945,10 @@ void ofono_voicecall_disconnected(struct ofono_voice=
call *vc, int id,
 	if (reason !=3D OFONO_DISCONNECT_REASON_UNKNOWN)
 		voicecall_emit_disconnect_reason(call, reason);
 =

+	number =3D phone_number_to_string(&call->call->phone_number);
+	if (is_emergency_number(vc, number) =3D=3D TRUE)
+		__ofono_modem_dec_emergency_mode(modem);
+
 	voicecall_set_call_status(call, CALL_STATUS_DISCONNECTED);
 =

 	if (!call->untracked) {
-- =

1.7.0.4


--===============3786049780563185014==--

