Content-Type: multipart/mixed; boundary="===============9006156877508948556=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: [PATCH 6/8] voicecallmanager: Add DBUS method for dialing a memory
 index
Date: Tue, 31 Oct 2017 10:39:37 +0200
Message-ID: <20171031083939.4393-7-philippe.deswert@nomovok.com>
In-Reply-To: <20171031083939.4393-1-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9006156877508948556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new method dial_memory to the voicecall manager interface
---
 src/voicecall.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 106 insertions(+)

diff --git a/src/voicecall.c b/src/voicecall.c
index cef36a29..7405840b 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -28,6 +28,7 @@
 #include <time.h>
 #include <errno.h>
 #include <stdint.h>
+#include <stdlib.h>
 =

 #include <glib.h>
 #include <gdbus.h>
@@ -1577,6 +1578,107 @@ static DBusMessage *manager_dial(DBusConnection *co=
nn,
 	return __ofono_error_failed(msg);
 }
 =

+static void manager_dial_memory_callback(const struct ofono_error *error, =
void *data)
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
+static int voicecall_dial_memory(struct ofono_voicecall *vc, const char *p=
osition,
+					enum ofono_clir_option clir,
+					ofono_voicecall_cb_t cb, void *data)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	long int memory_position;
+
+	if (g_slist_length(vc->call_list) >=3D MAX_VOICE_CALLS)
+		return -EPERM;
+
+	if (ofono_modem_get_online(modem) =3D=3D FALSE)
+		return -ENETDOWN;
+
+	if (vc->driver->dial =3D=3D NULL)
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
+	memory_position =3D strtol(position, NULL, 10);
+
+	vc->driver->dial_memory(vc, memory_position, clir, cb, vc);
+
+	return 0;
+}
+
+static DBusMessage *manager_dial_memory(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	const char *memory_location;
+	const char *clirstr;
+	enum ofono_clir_option clir;
+	int err;
+
+	if (vc->pending || vc->dial_req || vc->pending_em)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &memory_location,
+					DBUS_TYPE_STRING, &clirstr,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (clir_string_to_clir(clirstr, &clir) =3D=3D FALSE)
+		return __ofono_error_invalid_format(msg);
+
+	vc->pending =3D dbus_message_ref(msg);
+
+	err =3D voicecall_dial_memory(vc, memory_location, clir, manager_dial_mem=
ory_callback, vc);
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
 static void manager_dial_last_callback(const struct ofono_error *error, vo=
id *data)
 {
 	struct ofono_voicecall *vc =3D data;
@@ -2219,6 +2321,10 @@ static const GDBusMethodTable manager_methods[] =3D {
 		GDBUS_ARGS({ "number", "s" }, { "hide_callerid", "s" }),
 		GDBUS_ARGS({ "path", "o" }),
 		manager_dial) },
+	{ GDBUS_ASYNC_METHOD("DialMemory",
+		GDBUS_ARGS({ "memory_location", "s" },{ "hide_callerid", "s" }),
+		NULL,
+		manager_dial_memory) },
 	{ GDBUS_ASYNC_METHOD("DialLast", NULL, NULL, manager_dial_last)},
 	{ GDBUS_ASYNC_METHOD("Transfer", NULL, NULL, manager_transfer) },
 	{ GDBUS_ASYNC_METHOD("SwapCalls",  NULL, NULL, manager_swap_calls) },
-- =

2.14.2


--===============9006156877508948556==--

