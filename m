Content-Type: multipart/mixed; boundary="===============0685586591844522157=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 4/8] handsfree-audio: Add emitting CardAdded
Date: Mon, 25 Feb 2013 11:34:17 -0300
Message-ID: <1361802861-18267-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361802861-18267-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0685586591844522157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handsfree Audio Manager needs to send the CardAdded signal when a new
handsfree modem is registered.
---
 src/handsfree-audio.c | 62 ++++++++++++++++++++++++++++++++++++++++++++---=
----
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index cdb8f8f..64d1ed0 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -173,6 +173,12 @@ static const GDBusMethodTable am_methods[] =3D {
 	{ }
 };
 =

+static const GDBusSignalTable am_signals[] =3D {
+	{ GDBUS_SIGNAL("CardAdded",
+		GDBUS_ARGS({ "path", "o" }, { "properties", "a{sv}" })) },
+	{ }
+};
+
 static DBusMessage *card_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -209,19 +215,58 @@ static const GDBusMethodTable card_methods[] =3D {
 	{ }
 };
 =

+static void am_emit_card_added(const char *path, struct ofono_modem *modem)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *address;
+
+	signal =3D dbus_message_new_signal("/", HFP_AUDIO_MANAGER_INTERFACE,
+								"CardAdded");
+	if (signal =3D=3D NULL) {
+		ofono_error("Unable to allocate new CardAdded signal");
+		return;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	address =3D ofono_modem_get_string(modem, "Remote");
+
+	ofono_dbus_dict_append(&dict, "RemoteAddress",
+					DBUS_TYPE_STRING, &address);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(ofono_dbus_get_connection(), signal);
+}
+
+static void am_card_add(const char *path, struct ofono_modem *modem)
+{
+	g_dbus_register_interface(ofono_dbus_get_connection(), path,
+					HFP_AUDIO_CARD_INTERFACE, card_methods,
+					NULL, NULL, modem, NULL);
+
+	am_emit_card_added(path, modem);
+
+	DBG("Audio Card added: %s", path);
+}
+
 static void handsfree_modem_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	const char *path =3D __ofono_atom_get_path(atom);
 =

-	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
-		g_dbus_register_interface(ofono_dbus_get_connection(), path,
-					HFP_AUDIO_CARD_INTERFACE, card_methods,
-					NULL, NULL, modem, NULL);
-
-		DBG("Audio Card added: %s", path);
-	} else {
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		am_card_add(path, modem);
+	else {
 		g_dbus_unregister_interface(ofono_dbus_get_connection(), path,
 						HFP_AUDIO_CARD_INTERFACE);
 		DBG("Audio Card removed: %s", path);
@@ -246,7 +291,8 @@ void ofono_handsfree_audio_ref(void)
 =

 	if (!g_dbus_register_interface(ofono_dbus_get_connection(),
 					"/", HFP_AUDIO_MANAGER_INTERFACE,
-					am_methods, NULL, NULL, NULL, NULL)) {
+					am_methods, am_signals, NULL,
+					NULL, NULL)) {
 		ofono_error("Unable to register Handsfree Audio Manager");
 		return;
 	}
-- =

1.7.11.7


--===============0685586591844522157==--

