Content-Type: multipart/mixed; boundary="===============7732991787573039505=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 3/9] handsfree-audio: Add emitting CardAdded
Date: Tue, 26 Feb 2013 10:50:47 -0300
Message-ID: <1361886653-30873-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361886653-30873-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7732991787573039505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Emits the CardAdded signal using the Handfree Audio Manager interface
when a new Audio Card is created.
---
 src/handsfree-audio.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index a9eb7c9..39d90c5 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -95,6 +95,21 @@ static void agent_disconnect(DBusConnection *conn, void =
*user_data)
 	agent =3D NULL;
 }
 =

+static void card_append_properties(DBusMessageIter *iter,
+						struct audio_card *card)
+{
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	ofono_dbus_dict_append(&dict, "RemoteAddress",
+					DBUS_TYPE_STRING, &card->remote);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
 static DBusMessage *am_get_cards(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -184,6 +199,33 @@ static const GDBusMethodTable am_methods[] =3D {
 	{ }
 };
 =

+static const GDBusSignalTable am_signals[] =3D {
+	{ GDBUS_SIGNAL("CardAdded",
+		GDBUS_ARGS({ "path", "o" }, { "properties", "a{sv}" })) },
+	{ }
+};
+
+static void am_emit_card_added(const char *path, struct audio_card *card)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
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
+	card_append_properties(&iter, card);
+
+	g_dbus_send_message(ofono_dbus_get_connection(), signal);
+}
+
 void ofono_handsfree_audio_ref(void)
 {
 	ref_count +=3D 1;
@@ -193,7 +235,8 @@ void ofono_handsfree_audio_ref(void)
 =

 	if (!g_dbus_register_interface(ofono_dbus_get_connection(),
 					"/", HFP_AUDIO_MANAGER_INTERFACE,
-					am_methods, NULL, NULL, NULL, NULL))
+					am_methods, am_signals, NULL,
+					NULL, NULL))
 		ofono_error("Unable to register Handsfree Audio Manager");
 }
 =

@@ -249,6 +292,8 @@ char *ofono_handsfree_card_create(const char *remote)
 	}
 =

 	card->remote =3D g_strdup(remote);
+	am_emit_card_added(path, card);
+
 	DBG("Audio Card added: %s", path);
 =

 	return path;
-- =

1.7.11.7


--===============7732991787573039505==--

