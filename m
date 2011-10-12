Content-Type: multipart/mixed; boundary="===============9214260107757236170=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 13/19] handsfree: Implement voice recognition function
Date: Wed, 12 Oct 2011 14:35:34 +0200
Message-ID: <1318422940-14955-14-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9214260107757236170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index 579434b..bf30b9c 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -45,6 +45,9 @@ static GSList *g_drivers =3D NULL;
 =

 struct ofono_handsfree {
 	ofono_bool_t inband_ringing;
+	ofono_bool_t voicerec_state;
+	ofono_bool_t pending_voicerec_state;
+
 	const struct ofono_handsfree_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -69,6 +72,24 @@ void ofono_handsfree_set_inband_ringing(struct ofono_han=
dsfree *hf,
 					&dbus_enabled);
 }
 =

+void ofono_handsfree_set_voice_recognition(struct ofono_handsfree *hf,
+						ofono_bool_t enabled)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(hf->atom);
+	dbus_bool_t dbus_enabled =3D enabled;
+
+	if (hf->voicerec_state =3D=3D enabled)
+		return;
+
+	hf->voicerec_state =3D enabled;
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_HANDSFREE_INTERFACE,
+					"VoiceRecognition", DBUS_TYPE_BOOLEAN,
+					&dbus_enabled);
+}
+
 static DBusMessage *handsfree_get_properties(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -77,6 +98,7 @@ static DBusMessage *handsfree_get_properties(DBusConnecti=
on *conn,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	dbus_bool_t inband_ringing;
+	dbus_bool_t voicerec_state;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -92,17 +114,49 @@ static DBusMessage *handsfree_get_properties(DBusConne=
ction *conn,
 	ofono_dbus_dict_append(&dict, "InbandRinging", DBUS_TYPE_BOOLEAN,
 				&inband_ringing);
 =

+	voicerec_state =3D hf->voicerec_state;
+	ofono_dbus_dict_append(&dict, "VoiceRecognition", DBUS_TYPE_BOOLEAN,
+				&voicerec_state);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
 }
 =

+static void voicerec_set_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_handsfree *hf =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(hf->atom);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		__ofono_dbus_pending_reply(&hf->pending,
+					__ofono_error_failed(hf->pending));
+		return;
+	}
+
+	hf->voicerec_state =3D hf->pending_voicerec_state;
+
+	__ofono_dbus_pending_reply(&hf->pending,
+				dbus_message_new_method_return(hf->pending));
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_HANDSFREE_INTERFACE,
+					"VoiceRecognition",
+					DBUS_TYPE_BOOLEAN,
+					&hf->voicerec_state);
+}
+
 static DBusMessage *handsfree_set_property(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	struct ofono_handsfree *hf =3D data;
 	DBusMessageIter iter, var;
 	const char *name;
 =

+	if (hf->pending)
+		return __ofono_error_busy(msg);
+
 	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

@@ -117,6 +171,24 @@ static DBusMessage *handsfree_set_property(DBusConnect=
ion *conn,
 =

 	dbus_message_iter_recurse(&iter, &var);
 =

+	if (g_str_equal(name, "VoiceRecognition") =3D=3D TRUE) {
+		ofono_bool_t enabled;
+
+		if (!hf->driver->voice_recognition)
+			return __ofono_error_not_implemented(msg);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &enabled);
+
+		hf->pending_voicerec_state =3D enabled;
+		hf->pending =3D dbus_message_ref(msg);
+		hf->driver->voice_recognition(hf, enabled, voicerec_set_cb, hf);
+
+		return NULL;
+	}
+
 	return __ofono_error_invalid_args(msg);
 }
 =

-- =

1.7.6.4


--===============9214260107757236170==--

