Content-Type: multipart/mixed; boundary="===============5423345231459385677=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: [PATCH V2 2/8] voicecallmanager: Handle last number dialled DBUS call
Date: Tue, 31 Oct 2017 10:39:33 +0200
Message-ID: <20171031083939.4393-3-philippe.deswert@nomovok.com>
In-Reply-To: <20171031083939.4393-1-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5423345231459385677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handle the new DialLast method on the voicecallmanager interface
---
 src/voicecall.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 87 insertions(+)

diff --git a/src/voicecall.c b/src/voicecall.c
index a8a2bcde..cef36a29 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1577,6 +1577,92 @@ static DBusMessage *manager_dial(DBusConnection *con=
n,
 	return __ofono_error_failed(msg);
 }
 =

+static void manager_dial_last_callback(const struct ofono_error *error, vo=
id *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	DBusMessage *reply;
+	struct voicecall *v;
+
+	v =3D synthesize_outgoing_call(vc, NULL);
+
+	if (v) {
+		const char *path =3D voicecall_build_path(vc, v->call);
+
+		reply =3D dbus_message_new_method_return(vc->pending);
+
+		dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID);
+	} else {
+		reply =3D __ofono_error_failed(vc->pending);
+	}
+
+	__ofono_dbus_pending_reply(&vc->pending, reply);
+
+	voicecalls_emit_call_added(vc, v);
+}
+
+static int voicecall_dial_last(struct ofono_voicecall *vc,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+
+	if (g_slist_length(vc->call_list) >=3D MAX_VOICE_CALLS)
+		return -EPERM;
+
+	if (ofono_modem_get_online(modem) =3D=3D FALSE)
+		return -ENETDOWN;
+
+	if (vc->driver->dial_last =3D=3D NULL)
+		return -ENOTSUP;
+
+	if (voicecalls_have_incoming(vc))
+		return -EBUSY;
+
+	/* We can't have two dialing/alerting calls, reject outright */
+	if (voicecalls_num_connecting(vc) > 0)
+		return -EBUSY;
+
+	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
+		return -EBUSY;
+
+	vc->driver->dial_last(vc, cb, vc);
+
+	return 0;
+}
+
+static DBusMessage *manager_dial_last(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	int err;
+
+	if (vc->pending || vc->dial_req || vc->pending_em)
+		return __ofono_error_busy(msg);
+
+	vc->pending =3D dbus_message_ref(msg);
+
+	err =3D voicecall_dial_last(vc, manager_dial_last_callback, vc);
+
+	if (err >=3D 0)
+		return NULL;
+
+	vc->pending =3D NULL;
+	dbus_message_unref(msg);
+
+	switch (err) {
+	case -EINVAL:
+		return __ofono_error_invalid_format(msg);
+
+	case -ENETDOWN:
+		return __ofono_error_not_available(msg);
+
+	case -ENOTSUP:
+		return __ofono_error_not_implemented(msg);
+	}
+
+	return __ofono_error_failed(msg);
+}
+
 static DBusMessage *manager_transfer(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -2133,6 +2219,7 @@ static const GDBusMethodTable manager_methods[] =3D {
 		GDBUS_ARGS({ "number", "s" }, { "hide_callerid", "s" }),
 		GDBUS_ARGS({ "path", "o" }),
 		manager_dial) },
+	{ GDBUS_ASYNC_METHOD("DialLast", NULL, NULL, manager_dial_last)},
 	{ GDBUS_ASYNC_METHOD("Transfer", NULL, NULL, manager_transfer) },
 	{ GDBUS_ASYNC_METHOD("SwapCalls",  NULL, NULL, manager_swap_calls) },
 	{ GDBUS_ASYNC_METHOD("ReleaseAndAnswer", NULL, NULL,
-- =

2.14.2


--===============5423345231459385677==--

