Content-Type: multipart/mixed; boundary="===============7763941872154221098=="
MIME-Version: 1.0
From: John Mathew <john.mathew@elektrobit.com>
Subject: [PATCH] voicecall: Add emergency property
Date: Tue, 07 Dec 2010 07:20:43 -0500
Message-ID: <1291724443-1851-1-git-send-email-john.mathew@elektrobit.com>
In-Reply-To: <4CDC0B2D.6010407@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7763941872154221098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecall-api.txt |    5 +++++
 src/voicecall.c       |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index f0ba316..95a43a6 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -125,3 +125,8 @@ Properties	string LineIdentification [readonly]
 =

 			Icon identifier to be used instead of or together
 			with the text information.
+
+		boolean Emergency [readonly]
+
+			Contains the indication if the voice call is an emergency
+			call or not.
diff --git a/src/voicecall.c b/src/voicecall.c
index dbf3e9a..3f9fe54 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -316,6 +316,23 @@ static void tone_request_finish(struct ofono_voicecall=
 *vc,
 	g_free(entry);
 }
 =

+static gint number_compare(gconstpointer a, gconstpointer b)
+{
+	const char *s1 =3D a, *s2 =3D b;
+	return strcmp(s1, s2);
+}
+
+static gboolean voicecall_is_emergency(struct voicecall *v)
+{
+	struct ofono_call *call =3D v->call;
+	const char *lineid_str;
+
+	lineid_str =3D phone_number_to_string(&call->phone_number);
+
+	return (g_slist_find_custom(v->vc->en_list, lineid_str,
+						number_compare)) ? TRUE : FALSE;
+}
+
 static void append_voicecall_properties(struct voicecall *v,
 					DBusMessageIter *dict)
 {
@@ -324,6 +341,7 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 	const char *callerid;
 	const char *timestr;
 	ofono_bool_t mpty;
+	dbus_bool_t emergency_call;
 =

 	status =3D call_status_to_string(call->status);
 	callerid =3D phone_number_to_string(&call->phone_number);
@@ -359,6 +377,15 @@ static void append_voicecall_properties(struct voiceca=
ll *v,
 	if (v->icon_id)
 		ofono_dbus_dict_append(dict, "Icon", DBUS_TYPE_BYTE,
 					&v->icon_id);
+
+	if (voicecall_is_emergency(v) =3D=3D TRUE)
+		emergency_call =3D TRUE;
+	else
+		emergency_call =3D FALSE;
+
+	ofono_dbus_dict_append(dict, "Emergency", DBUS_TYPE_BOOLEAN,
+					&emergency_call);
+
 }
 =

 static DBusMessage *voicecall_get_properties(DBusConnection *conn,
@@ -721,6 +748,16 @@ static void voicecall_set_call_lineid(struct voicecall=
 *v,
 						OFONO_VOICECALL_INTERFACE,
 						"LineIdentification",
 						DBUS_TYPE_STRING, &lineid_str);
+
+	if (voicecall_is_emergency(v)) {
+		dbus_bool_t emergency_call =3D TRUE;
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_VOICECALL_INTERFACE,
+						"Emergency",
+						DBUS_TYPE_BOOLEAN,
+						&emergency_call);
+	}
 }
 =

 static gboolean voicecall_dbus_register(struct voicecall *v)
-- =

1.7.0.4


--===============7763941872154221098==--

