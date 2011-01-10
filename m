Content-Type: multipart/mixed; boundary="===============7492717538657597957=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 2/5] voicecall: Add tty property support
Date: Mon, 10 Jan 2011 16:01:29 +0200
Message-ID: <1294668092-27896-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294668092-27896-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7492717538657597957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 97fc36b..da42fac 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -354,6 +354,7 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 	const char *name;
 	ofono_bool_t mpty;
 	dbus_bool_t emergency_call;
+	dbus_bool_t tty;
 =

 	status =3D call_status_to_string(call->status);
 =

@@ -391,6 +392,9 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 =

 	ofono_dbus_dict_append(dict, "Multiparty", DBUS_TYPE_BOOLEAN, &mpty);
 =

+	tty =3D call->tty;
+	ofono_dbus_dict_append(dict, "TextTelephony", DBUS_TYPE_BOOLEAN, &tty);
+
 	if (v->message)
 		ofono_dbus_dict_append(dict, "Information", DBUS_TYPE_STRING,
 					&v->message);
@@ -675,6 +679,21 @@ static void voicecall_emit_multiparty(struct voicecall=
 *call, gboolean mpty)
 						&val);
 }
 =

+static void voicecall_set_call_tty(struct voicecall *call, gboolean tty)
+{
+	if (call->call->tty !=3D tty) {
+		DBusConnection *conn =3D ofono_dbus_get_connection();
+		const char *path =3D voicecall_build_path(call->vc, call->call);
+		dbus_bool_t val =3D tty;
+
+		call->call->tty =3D tty;
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_VOICECALL_INTERFACE,
+						"TextTelephony",
+						DBUS_TYPE_BOOLEAN, &val);
+	}
+}
+
 static void voicecall_set_call_status(struct voicecall *call, int status)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -1924,6 +1943,7 @@ void ofono_voicecall_notify(struct ofono_voicecall *v=
c,
 =

 	if (l) {
 		DBG("Found call with id: %d", call->id);
+		voicecall_set_call_tty(l->data, call->tty);
 		voicecall_set_call_status(l->data, call->status);
 		voicecall_set_call_lineid(l->data, &call->phone_number,
 						call->clip_validity);
-- =

1.7.0.4


--===============7492717538657597957==--

