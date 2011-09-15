Content-Type: multipart/mixed; boundary="===============4789645024261453769=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 10/12] handsfree: Read-only voice-recognition D-Bus prop
Date: Thu, 15 Sep 2011 18:34:41 +0200
Message-ID: <1316104483-13144-11-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1316104483-13144-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4789645024261453769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/handsfree.h |    2 ++
 src/handsfree.c     |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/include/handsfree.h b/include/handsfree.h
index 18c6f26..26a4c4f 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -46,6 +46,8 @@ struct ofono_handsfree_driver {
 =

 void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
 						ofono_bool_t enabled);
+void ofono_handsfree_set_voice_recognition(struct ofono_handsfree *hf,
+						ofono_bool_t enabled);
 =

 int ofono_handsfree_driver_register(const struct ofono_handsfree_driver *d=
);
 void ofono_handsfree_driver_unregister(
diff --git a/src/handsfree.c b/src/handsfree.c
index 3138474..4b0756b 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -44,6 +44,8 @@ static GSList *g_drivers =3D NULL;
 =

 struct ofono_handsfree {
 	ofono_bool_t inband_ringing;
+	ofono_bool_t voicerec_state;
+
 	const struct ofono_handsfree_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -68,6 +70,24 @@ void ofono_handsfree_set_inband_ringing(struct ofono_han=
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
@@ -76,6 +96,7 @@ static DBusMessage *handsfree_get_properties(DBusConnecti=
on *conn,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	dbus_bool_t inband_ringing;
+	dbus_bool_t voicerec_state;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -91,6 +112,10 @@ static DBusMessage *handsfree_get_properties(DBusConnec=
tion *conn,
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
-- =

1.7.6


--===============4789645024261453769==--

