Content-Type: multipart/mixed; boundary="===============4660521070512819523=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 02/12] handsfree: Implement voice recognition function
Date: Fri, 21 Oct 2011 18:51:27 +0200
Message-ID: <1319215897-6310-3-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319215897-6310-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4660521070512819523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index efebcc0..24f2349 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -45,6 +45,9 @@ static GSList *g_drivers =3D NULL;
 =

 struct ofono_handsfree {
 	ofono_bool_t inband_ringing;
+	ofono_bool_t voice_recognition;
+	ofono_bool_t voice_recognition_pending;
+
 	const struct ofono_handsfree_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -72,6 +75,24 @@ void ofono_handsfree_set_inband_ringing(struct ofono_han=
dsfree *hf,
 					&dbus_enabled);
 }
 =

+void ofono_handsfree_voice_recognition_notify(struct ofono_handsfree *hf,
+						ofono_bool_t enabled)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(hf->atom);
+	dbus_bool_t dbus_enabled =3D enabled;
+
+	if (hf->voice_recognition =3D=3D enabled)
+		return;
+
+	hf->voice_recognition =3D enabled;
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
@@ -80,6 +101,7 @@ static DBusMessage *handsfree_get_properties(DBusConnect=
ion *conn,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	dbus_bool_t inband_ringing;
+	dbus_bool_t voice_recognition;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -95,17 +117,49 @@ static DBusMessage *handsfree_get_properties(DBusConne=
ction *conn,
 	ofono_dbus_dict_append(&dict, "InbandRinging", DBUS_TYPE_BOOLEAN,
 				&inband_ringing);
 =

+	voice_recognition =3D hf->voice_recognition;
+	ofono_dbus_dict_append(&dict, "VoiceRecognition", DBUS_TYPE_BOOLEAN,
+				&voice_recognition);
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
+	hf->voice_recognition =3D hf->voice_recognition_pending;
+
+	__ofono_dbus_pending_reply(&hf->pending,
+				dbus_message_new_method_return(hf->pending));
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_HANDSFREE_INTERFACE,
+					"VoiceRecognition",
+					DBUS_TYPE_BOOLEAN,
+					&hf->voice_recognition);
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

@@ -120,6 +174,27 @@ static DBusMessage *handsfree_set_property(DBusConnect=
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
+		if (hf->voice_recognition =3D=3D enabled)
+			return dbus_message_new_method_return(msg);
+
+		hf->voice_recognition_pending =3D enabled;
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


--===============4660521070512819523==--

