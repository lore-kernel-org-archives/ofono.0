Content-Type: multipart/mixed; boundary="===============7016593313496990971=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 11/12] handsfree: Writable voice-recogn. prop (AT+BVRA)
Date: Thu, 15 Sep 2011 18:34:42 +0200
Message-ID: <1316104483-13144-12-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1316104483-13144-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7016593313496990971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/handsfree.h |    5 +++++
 src/handsfree.c     |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/include/handsfree.h b/include/handsfree.h
index 26a4c4f..8f29dee 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -30,6 +30,8 @@ extern "C" {
 =

 struct ofono_handsfree;
 =

+typedef void (*ofono_handsfree_cb_t)(const struct ofono_error *error,
+					void *data);
 typedef void (*ofono_handsfree_phone_cb_t)(const struct ofono_error *error,
 					const struct ofono_phone_number *number,
 					void *data);
@@ -42,6 +44,9 @@ struct ofono_handsfree_driver {
 	void (*request_phone_number) (struct ofono_handsfree *hf,
 					ofono_handsfree_phone_cb_t cb,
 					void *data);
+	void (*voice_recognition)(struct ofono_handsfree *cv,
+					ofono_bool_t enabled,
+					ofono_handsfree_cb_t cb, void *data);
 };
 =

 void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
diff --git a/src/handsfree.c b/src/handsfree.c
index 4b0756b..9e53cac 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -45,6 +45,7 @@ static GSList *g_drivers =3D NULL;
 struct ofono_handsfree {
 	ofono_bool_t inband_ringing;
 	ofono_bool_t voicerec_state;
+	ofono_bool_t pending_voicerec_state;
 =

 	const struct ofono_handsfree_driver *driver;
 	void *driver_data;
@@ -121,12 +122,40 @@ static DBusMessage *handsfree_get_properties(DBusConn=
ection *conn,
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

@@ -141,6 +170,24 @@ static DBusMessage *handsfree_set_property(DBusConnect=
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

1.7.6


--===============7016593313496990971==--

