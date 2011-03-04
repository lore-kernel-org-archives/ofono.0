Content-Type: multipart/mixed; boundary="===============6655980396747521979=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 3/5] voicecall: implement SSN handling functions
Date: Fri, 04 Mar 2011 19:12:38 +0200
Message-ID: <56722c85908a3516f0d5936cbef7b7e14c33efbd.1299258404.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1299258404.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6655980396747521979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |  174 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 174 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index ec001c0..7eee7dd 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -70,6 +70,8 @@ struct voicecall {
 	uint8_t icon_id;
 	gboolean untracked;
 	gboolean dial_result_handled;
+	ofono_bool_t remote_held;
+	ofono_bool_t remote_multiparty;
 };
 =

 struct dial_request {
@@ -400,6 +402,12 @@ static void append_voicecall_properties(struct voiceca=
ll *v,
 =

 	ofono_dbus_dict_append(dict, "Multiparty", DBUS_TYPE_BOOLEAN, &mpty);
 =

+	ofono_dbus_dict_append(dict, "RemoteHeld", DBUS_TYPE_BOOLEAN,
+				&v->remote_held);
+
+	ofono_dbus_dict_append(dict, "RemoteMultiparty", DBUS_TYPE_BOOLEAN,
+				&v->remote_multiparty);
+
 	if (v->message)
 		ofono_dbus_dict_append(dict, "Information",
 						DBUS_TYPE_STRING, &v->message);
@@ -1869,6 +1877,8 @@ static GDBusMethodTable manager_methods[] =3D {
 };
 =

 static GDBusSignalTable manager_signals[] =3D {
+	{ "Forwarded",	 	 "s" },
+	{ "BarringActive",	 "s" },
 	{ "PropertyChanged",	"sv" },
 	{ "CallAdded",		"oa{sv}" },
 	{ "CallRemoved",	"o" },
@@ -2684,3 +2694,167 @@ void __ofono_voicecall_tone_cancel(struct ofono_voi=
cecall *vc, int id)
 		tone_request_run(vc);
 	}
 }
+
+static void ssn_mt_forwarded_notify(struct ofono_voicecall *vc,
+					unsigned int id, int code,
+					const struct ofono_phone_number *ph)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(vc->atom);
+	char *info =3D "incoming";
+
+	g_dbus_emit_signal(conn, path, OFONO_VOICECALL_MANAGER_INTERFACE,
+				"Forwarded",
+				DBUS_TYPE_STRING, &info,
+				DBUS_TYPE_INVALID);
+}
+
+static struct voicecall *voicecall_select(struct ofono_voicecall *vc,
+						unsigned int id, int code)
+{
+	struct voicecall *v =3D NULL;
+	GSList *l;
+
+	if (id !=3D 0) {
+		l =3D g_slist_find_custom(vc->call_list, GUINT_TO_POINTER(id),
+				call_compare_by_id);
+
+		if (l =3D=3D NULL)
+			return NULL;
+
+		v =3D l->data;
+	} else if (g_slist_length(vc->call_list) =3D=3D 1) {
+		v =3D vc->call_list->data;
+
+		switch (code) {
+		case SS_MT_VOICECALL_RETRIEVED:
+			if (v->remote_held !=3D TRUE)
+				return NULL;
+			break;
+		case SS_MT_VOICECALL_ON_HOLD:
+			if (v->remote_held =3D=3D TRUE)
+				return NULL;
+			break;
+		case SS_MT_MULTIPARTY_VOICECALL:
+			if (v->remote_multiparty =3D=3D TRUE)
+				return NULL;
+			break;
+		default:
+			return NULL;
+		}
+	}
+
+	return v;
+}
+
+static void ssn_mt_remote_held_notify(struct ofono_voicecall *vc,
+					unsigned int id, int code,
+					const struct ofono_phone_number *ph)
+{
+	struct voicecall *v =3D voicecall_select(vc, id, code);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+
+	if (v =3D=3D NULL)
+		return;
+
+	if (code =3D=3D SS_MT_VOICECALL_ON_HOLD)
+		v->remote_held =3D TRUE;
+	else
+		v->remote_held =3D FALSE;
+
+	path =3D voicecall_build_path(vc, v->call);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_VOICECALL_INTERFACE,
+						"RemoteHeld", DBUS_TYPE_BOOLEAN,
+						&v->remote_held);
+}
+
+static void ssn_mt_remote_multiparty_notify(struct ofono_voicecall *vc,
+					unsigned int id, int code,
+					const struct ofono_phone_number *ph)
+{
+	struct voicecall *v =3D voicecall_select(vc, id, code);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+
+	if (v =3D=3D NULL)
+		return;
+
+	v->remote_multiparty =3D TRUE;
+
+	path =3D voicecall_build_path(vc, v->call);
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_VOICECALL_INTERFACE,
+					"RemoteMultiparty", DBUS_TYPE_BOOLEAN,
+					&v->remote_multiparty);
+}
+
+void ofono_voicecall_ssn_mt_notify(struct ofono_voicecall *vc,
+					unsigned int id, int code, int index,
+					const struct ofono_phone_number *ph)
+{
+	switch (code) {
+	case SS_MT_CALL_FORWARDED:
+		ssn_mt_forwarded_notify(vc, id, code, ph);
+		break;
+	case SS_MT_VOICECALL_ON_HOLD:
+		ssn_mt_remote_held_notify(vc, id, code, ph);
+		break;
+	case SS_MT_VOICECALL_RETRIEVED:
+		ssn_mt_remote_held_notify(vc, id, code, ph);
+		break;
+	case SS_MT_MULTIPARTY_VOICECALL:
+		ssn_mt_remote_multiparty_notify(vc, id, code, ph);
+		break;
+	}
+}
+
+static void ssn_mo_call_barred_notify(struct ofono_voicecall *vc,
+					unsigned int id, int code)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(vc->atom);
+	const char *info;
+
+	if (code =3D=3D SS_MO_INCOMING_BARRING)
+		info =3D "remote";
+	else
+		info =3D "local";
+
+	g_dbus_emit_signal(conn, path, OFONO_VOICECALL_MANAGER_INTERFACE,
+				"BarringActive",
+				DBUS_TYPE_STRING, &info,
+				DBUS_TYPE_INVALID);
+}
+
+static void ssn_mo_forwarded_notify(struct ofono_voicecall *vc,
+					unsigned int id, int code)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(vc->atom);
+	char *info =3D "outgoing";
+
+	g_dbus_emit_signal(conn, path, OFONO_VOICECALL_MANAGER_INTERFACE,
+				"Forwarded",
+				DBUS_TYPE_STRING, &info,
+				DBUS_TYPE_INVALID);
+}
+
+void ofono_voicecall_ssn_mo_notify(struct ofono_voicecall *vc,
+					unsigned int id, int code, int index)
+{
+	switch (code) {
+	case SS_MO_OUTGOING_BARRING:
+		ssn_mo_call_barred_notify(vc, id, code);
+		break;
+	case SS_MO_INCOMING_BARRING:
+		ssn_mo_call_barred_notify(vc, id, code);
+		break;
+	case SS_MO_CALL_FORWARDED:
+		ssn_mo_forwarded_notify(vc, id, code);
+		break;
+	}
+}
-- =

1.7.0.4


--===============6655980396747521979==--

