Content-Type: multipart/mixed; boundary="===============6082210725139336580=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Emit initial LineIdentification and State.
Date: Mon, 09 Aug 2010 21:47:55 +0300
Message-ID: <1281379675-10055-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6082210725139336580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Allow following of call states without calling GetProperties.
---
 src/voicecall.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index a30aaa5..8f996e6 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -66,6 +66,8 @@ struct voicecall {
 	struct ofono_voicecall *vc;
 	time_t start_time;
 	time_t detect_time;
+	gboolean clip_emitted;
+	gboolean status_emitted;
 };
 =

 static const char *default_en_list[] =3D { "911", "112", NULL };
@@ -428,6 +430,7 @@ static void voicecall_set_call_status(struct voicecall =
*call,
 						OFONO_VOICECALL_INTERFACE,
 						"State", DBUS_TYPE_STRING,
 						&status_str);
+	call->status_emitted =3D TRUE;
 =

 	if (status =3D=3D CALL_STATUS_ACTIVE &&
 		(old_status =3D=3D CALL_STATUS_INCOMING ||
@@ -485,6 +488,8 @@ static void voicecall_set_call_lineid(struct voicecall =
*v,
 						OFONO_VOICECALL_INTERFACE,
 						"LineIdentification",
 						DBUS_TYPE_STRING, &lineid_str);
+
+	v->clip_emitted =3D TRUE;
 }
 =

 static gboolean voicecall_dbus_register(struct voicecall *v)
@@ -684,6 +689,63 @@ static gboolean voicecalls_have_incoming(struct ofono_=
voicecall *vc)
 	return voicecalls_have_with_status(vc, CALL_STATUS_INCOMING);
 }
 =

+static void emit_initial_call_clip(struct ofono_voicecall *vc,
+					struct voicecall *v)
+{
+	const struct ofono_call *call =3D v->call;
+	const struct ofono_phone_number *ph =3D &call->phone_number;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *lineid;
+	const char *path;
+
+	path =3D voicecall_build_path(vc, call);
+
+	if (call->direction =3D=3D CALL_DIRECTION_MOBILE_TERMINATED)
+		lineid =3D phone_and_clip_to_string(ph, call->clip_validity);
+	else
+		lineid =3D phone_number_to_string(ph);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_VOICECALL_INTERFACE,
+						"LineIdentification",
+						DBUS_TYPE_STRING, &lineid);
+
+	v->clip_emitted =3D TRUE;
+}
+
+static void emit_initial_call_status(struct ofono_voicecall *vc,
+					struct voicecall *v)
+{
+	const struct ofono_call *call =3D v->call;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	char const *path;
+	char const *status;
+
+	path =3D voicecall_build_path(vc, call);
+	status =3D call_status_to_string(call->status);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_VOICECALL_INTERFACE,
+						"State",
+						DBUS_TYPE_STRING, &status);
+
+	v->status_emitted =3D TRUE;
+}
+
+static void emit_initial_call(struct ofono_voicecall *vc)
+{
+	GSList *l;
+
+	for (l =3D vc->call_list; l; l =3D l->next) {
+		struct voicecall *v =3D (struct voicecall *)l->data;
+
+		if (!v->clip_emitted)
+			emit_initial_call_clip(vc, v);
+		if (!v->status_emitted)
+			emit_initial_call_status(vc, v);
+	}
+}
+
 static gboolean real_emit_call_list_changed(void *data)
 {
 	struct ofono_voicecall *vc =3D data;
@@ -702,6 +764,8 @@ static gboolean real_emit_call_list_changed(void *data)
 =

 	vc->emit_calls_source =3D 0;
 =

+	emit_initial_call(vc);
+
 	return FALSE;
 }
 =

-- =

1.7.0.4


--===============6082210725139336580==--

