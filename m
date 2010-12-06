Content-Type: multipart/mixed; boundary="===============7268028744231895947=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 06/14] voicecall: add support for CNAP
Date: Mon, 06 Dec 2010 18:12:34 -0200
Message-ID: <1291666362-19128-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-5-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7268028744231895947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enable oFono to get a info about the Calling Name.
---
 src/voicecall.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index dbf3e9a..84d45f9 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -178,6 +178,17 @@ static const char *phone_and_clip_to_string(const stru=
ct ofono_phone_number *n,
 	return phone_number_to_string(n);
 }
 =

+static const char *cnap_to_string(const char *name, int cnap_validity)
+{
+	if (cnap_validity =3D=3D CNAP_VALIDITY_WITHHELD && !strlen(name))
+		return "withheld";
+
+	if (cnap_validity =3D=3D CNAP_VALIDITY_NOT_AVAILABLE)
+		return "";
+
+	return name;
+}
+
 static const char *time_to_str(const time_t *t)
 {
 	static char buf[128];
@@ -323,16 +334,24 @@ static void append_voicecall_properties(struct voicec=
all *v,
 	const char *status;
 	const char *callerid;
 	const char *timestr;
+	char buf[OFONO_MAX_CALLER_NAME_LENGTH + 1];
+	char *name;
 	ofono_bool_t mpty;
 =

 	status =3D call_status_to_string(call->status);
 	callerid =3D phone_number_to_string(&call->phone_number);
 =

+	strncpy(buf, call->name, OFONO_MAX_CALLER_NAME_LENGTH);
+	buf[OFONO_MAX_CALLER_NAME_LENGTH] =3D '\0';
+	name =3D buf;
+
 	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING, &status);
 =

 	ofono_dbus_dict_append(dict, "LineIdentification",
 				DBUS_TYPE_STRING, &callerid);
 =

+	ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);
+
 	if (call->status =3D=3D CALL_STATUS_ACTIVE ||
 			call->status =3D=3D CALL_STATUS_HELD ||
 			(call->status =3D=3D CALL_STATUS_DISCONNECTED &&
@@ -723,6 +742,38 @@ static void voicecall_set_call_lineid(struct voicecall=
 *v,
 						DBUS_TYPE_STRING, &lineid_str);
 }
 =

+static void voicecall_set_call_name(struct voicecall *v,
+					const char *name,
+					int cnap_validity)
+{
+	struct ofono_call *call =3D v->call;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *name_str;
+
+	if (!strcmp(call->name, name) &&
+		call->cnap_validity =3D=3D cnap_validity)
+		return;
+
+	/* For plugins that don't keep state, ignore */
+	if (call->cnap_validity =3D=3D CNAP_VALIDITY_VALID &&
+		cnap_validity =3D=3D CNAP_VALIDITY_NOT_AVAILABLE)
+		return;
+
+	strncpy(call->name, name, OFONO_MAX_CALLER_NAME_LENGTH);
+	call->name[OFONO_MAX_CALLER_NAME_LENGTH] =3D '\0';
+	call->cnap_validity =3D cnap_validity;
+
+	path =3D voicecall_build_path(v->vc, call);
+
+	name_str =3D cnap_to_string(name, cnap_validity);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_VOICECALL_INTERFACE,
+						"Name",
+						DBUS_TYPE_STRING, &name_str);
+}
+
 static gboolean voicecall_dbus_register(struct voicecall *v)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -1838,6 +1889,8 @@ void ofono_voicecall_notify(struct ofono_voicecall *v=
c,
 		voicecall_set_call_status(l->data, call->status);
 		voicecall_set_call_lineid(l->data, &call->phone_number,
 						call->clip_validity);
+		voicecall_set_call_name(l->data, call->name,
+						call->cnap_validity);
 =

 		return;
 	}
-- =

1.7.3.2


--===============7268028744231895947==--

