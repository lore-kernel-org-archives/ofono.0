Content-Type: multipart/mixed; boundary="===============1407122086185961265=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/9] voicecall: add support for cdip
Date: Wed, 12 Jan 2011 09:27:40 -0200
Message-ID: <1294831667-7447-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294831667-7447-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1407122086185961265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enable oFono to show the identification informed with CDIP.
---
 src/voicecall.c |   38 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 97fc36b..b96c417 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -370,6 +370,14 @@ static void append_voicecall_properties(struct voiceca=
ll *v,
 	ofono_dbus_dict_append(dict, "LineIdentification",
 				DBUS_TYPE_STRING, &callerid);
 =

+	if (call->called_number.number[0] !=3D '\0') {
+		const char *calledid;
+
+		calledid =3D phone_number_to_string(&call->called_number);
+		ofono_dbus_dict_append(dict, "CalledLineIdentification",
+						DBUS_TYPE_STRING, &calledid);
+	}
+
 	ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);
 =

 	if (call->status =3D=3D CALL_STATUS_ACTIVE ||
@@ -781,6 +789,30 @@ static void voicecall_set_call_lineid(struct voicecall=
 *v,
 	}
 }
 =

+static void voicecall_set_call_calledid(struct voicecall *v,
+					const struct ofono_phone_number *ph)
+{
+	struct ofono_call *call =3D v->call;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *calledid_str;
+
+	if (!strcmp(call->called_number.number, ph->number) &&
+					call->called_number.type =3D=3D ph->type)
+		return;
+
+	strcpy(call->called_number.number, ph->number);
+	call->called_number.type =3D ph->type;
+
+	path =3D voicecall_build_path(v->vc, call);
+	calledid_str =3D phone_number_to_string(ph);
+
+	ofono_dbus_signal_property_changed(conn, path,
+			OFONO_VOICECALL_INTERFACE, "CalledLineIdentification",
+			DBUS_TYPE_STRING, &calledid_str);
+}
+
+
 static void voicecall_set_call_name(struct voicecall *v,
 					const char *name,
 					int cnap_validity)
@@ -1916,8 +1948,9 @@ void ofono_voicecall_notify(struct ofono_voicecall *v=
c,
 	struct voicecall *v =3D NULL;
 	struct ofono_call *newcall;
 =

-	DBG("Got a voicecall event, status: %d, id: %u, number: %s",
-			call->status, call->id, call->phone_number.number);
+	DBG("Got a voicecall event, status: %d, id: %u, number: %s"
+			" called_number: %s", call->status, call->id,
+			call->phone_number.number, call->called_number.number);
 =

 	l =3D g_slist_find_custom(vc->call_list, GUINT_TO_POINTER(call->id),
 				call_compare_by_id);
@@ -1927,6 +1960,7 @@ void ofono_voicecall_notify(struct ofono_voicecall *v=
c,
 		voicecall_set_call_status(l->data, call->status);
 		voicecall_set_call_lineid(l->data, &call->phone_number,
 						call->clip_validity);
+		voicecall_set_call_calledid(l->data, &call->called_number);
 		voicecall_set_call_name(l->data, call->name,
 						call->cnap_validity);
 =

-- =

1.7.3.5


--===============1407122086185961265==--

