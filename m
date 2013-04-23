Content-Type: multipart/mixed; boundary="===============2818561176987019921=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 7/7] core: Add SetProperty for EchoCancelingNoiseReduction
Date: Tue, 23 Apr 2013 09:44:45 -0300
Message-ID: <1366721085-17837-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366721085-17837-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2818561176987019921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch extends SetProperty method of the Handsfree interface
allowing to disable echo canceling and noise reduction feature in
the audio gateway through a D-Bus method call. Once disabled, it
is not allowed to enable it using this procedure.
---
 src/handsfree.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++------=
---
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index 75751e8..9487aec 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -46,6 +46,7 @@ static GSList *g_drivers =3D NULL;
 =

 struct ofono_handsfree {
 	ofono_bool_t nrec;
+	ofono_bool_t nrec_pending;
 	ofono_bool_t inband_ringing;
 	ofono_bool_t voice_recognition;
 	ofono_bool_t voice_recognition_pending;
@@ -220,11 +221,36 @@ static void voicerec_set_cb(const struct ofono_error =
*error, void *data)
 					&hf->voice_recognition);
 }
 =

+static void nrec_set_cb(const struct ofono_error *error, void *data)
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
+	hf->nrec =3D hf->nrec_pending;
+
+	__ofono_dbus_pending_reply(&hf->pending,
+				dbus_message_new_method_return(hf->pending));
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_HANDSFREE_INTERFACE,
+					"EchoCancelingNoiseReduction",
+					DBUS_TYPE_BOOLEAN,
+					&hf->nrec);
+}
+
 static DBusMessage *handsfree_set_property(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct ofono_handsfree *hf =3D data;
 	DBusMessageIter iter, var;
+	ofono_bool_t enabled;
 	const char *name;
 =

 	if (hf->pending)
@@ -244,28 +270,40 @@ static DBusMessage *handsfree_set_property(DBusConnec=
tion *conn,
 =

 	dbus_message_iter_recurse(&iter, &var);
 =

+	if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&var, &enabled);
+
 	if (g_str_equal(name, "VoiceRecognition") =3D=3D TRUE) {
-		ofono_bool_t enabled;
 =

 		if (!hf->driver->voice_recognition)
 			return __ofono_error_not_implemented(msg);
 =

-		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
-			return __ofono_error_invalid_args(msg);
-
-		dbus_message_iter_get_basic(&var, &enabled);
-
 		if (hf->voice_recognition =3D=3D enabled)
 			return dbus_message_new_method_return(msg);
 =

 		hf->voice_recognition_pending =3D enabled;
 		hf->pending =3D dbus_message_ref(msg);
 		hf->driver->voice_recognition(hf, enabled, voicerec_set_cb, hf);
+	} else if (g_str_equal(name, "EchoCancelingNoiseReduction") =3D=3D TRUE) {
 =

-		return NULL;
-	}
+		if (!(hf->ag_features & HFP_AG_FEATURE_ECNR))
+			return __ofono_error_not_supported(msg);
 =

-	return __ofono_error_invalid_args(msg);
+		if (!hf->driver->nrec || enabled =3D=3D TRUE)
+			return __ofono_error_not_implemented(msg);
+
+		if (hf->nrec =3D=3D enabled)
+			return dbus_message_new_method_return(msg);
+
+		hf->pending =3D dbus_message_ref(msg);
+		hf->nrec_pending =3D enabled;
+		hf->driver->nrec(hf, enabled, nrec_set_cb, hf);
+	} else
+		return __ofono_error_invalid_args(msg);
+
+	return NULL;
 }
 =

 static void request_phone_number_cb(const struct ofono_error *error,
-- =

1.7.11.7


--===============2818561176987019921==--

