Content-Type: multipart/mixed; boundary="===============5192242883389012643=="
MIME-Version: 1.0
From: John Mathew <john.mathew@elektrobit.com>
Subject: [PATCH] voicecall: Add EmergencyCall property.
Date: Thu, 11 Nov 2010 10:12:13 -0500
Message-ID: <1289488333-1481-1-git-send-email-john.mathew@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5192242883389012643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecall-api.txt |    4 ++++
 src/voicecall.c       |   34 +++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index f0ba316..60c692c 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -125,3 +125,7 @@ Properties	string LineIdentification [readonly]
 =

 			Icon identifier to be used instead of or together
 			with the text information.
+
+		boolean EmergencyCall [readonly]
+
+			Contains the indication if the voice call is emergency call or not.
diff --git a/src/voicecall.c b/src/voicecall.c
index bd64432..e39f4b7 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -315,6 +315,20 @@ static void tone_request_finish(struct ofono_voicecall=
 *vc,
 	g_free(entry);
 }
 =

+static gboolean voicecall_isemergency(struct voicecall *v)
+{
+	struct ofono_call *call =3D v->call;
+	const char *lineid_str;
+
+	lineid_str =3D phone_number_to_string(&call->phone_number);
+
+	if (g_slist_find_custom(v->vc->en_list, lineid_str,
+						(GCompareFunc) strcmp))
+		return TRUE;
+	else
+		return FALSE;
+}
+
 static void append_voicecall_properties(struct voicecall *v,
 					DBusMessageIter *dict)
 {
@@ -322,7 +336,8 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 	const char *status;
 	const char *callerid;
 	const char *timestr;
-	ofono_bool_t mpty;
+	ofono_bool_t mpt;
+	dbus_bool_t emergency_call;
 =

 	status =3D call_status_to_string(call->status);
 	callerid =3D phone_number_to_string(&call->phone_number);
@@ -358,6 +373,14 @@ static void append_voicecall_properties(struct voiceca=
ll *v,
 	if (v->icon_id)
 		ofono_dbus_dict_append(dict, "Icon", DBUS_TYPE_BYTE,
 					&v->icon_id);
+
+	if (voicecall_isemergency(v))
+			emergency_call =3D TRUE;
+	else
+			emergency_call =3D FALSE;
+
+	ofono_dbus_dict_append(dict, "EmergencyCall", DBUS_TYPE_BOOLEAN,
+					&emergency_call);
 }
 =

 static DBusMessage *voicecall_get_properties(DBusConnection *conn,
@@ -722,6 +745,15 @@ static void voicecall_set_call_lineid(struct voicecall=
 *v,
 						OFONO_VOICECALL_INTERFACE,
 						"LineIdentification",
 						DBUS_TYPE_STRING, &lineid_str);
+
+	if (voicecall_isemergency(v)) {
+		dbus_bool_t emergency_call =3D TRUE;
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_VOICECALL_INTERFACE,
+						"EmergencyCall",
+						DBUS_TYPE_BOOLEAN,
+						&emergency_call);
+	}
 }
 =

 static gboolean voicecall_dbus_register(struct voicecall *v)
-- =

1.7.0.4


--===============5192242883389012643==--

