Content-Type: multipart/mixed; boundary="===============1286461497906605788=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 4/9] handsfree-audio: Add emitting CardRemoved
Date: Tue, 26 Feb 2013 10:50:48 -0300
Message-ID: <1361886653-30873-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361886653-30873-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1286461497906605788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Emits the CardAdded signal using the Handfree Audio Manager interface
when a Audio Card is removed. The common way to trigger this action is
when the service level connection is disconnected.
---
 src/handsfree-audio.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 39d90c5..fcebce8 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -202,6 +202,8 @@ static const GDBusMethodTable am_methods[] =3D {
 static const GDBusSignalTable am_signals[] =3D {
 	{ GDBUS_SIGNAL("CardAdded",
 		GDBUS_ARGS({ "path", "o" }, { "properties", "a{sv}" })) },
+	{ GDBUS_SIGNAL("CardRemoved",
+		GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
 =

@@ -226,6 +228,25 @@ static void am_emit_card_added(const char *path, struc=
t audio_card *card)
 	g_dbus_send_message(ofono_dbus_get_connection(), signal);
 }
 =

+static void am_emit_card_removed(const char *path)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+
+	signal =3D dbus_message_new_signal("/", HFP_AUDIO_MANAGER_INTERFACE,
+								"CardRemoved");
+	if (signal =3D=3D NULL) {
+		ofono_error("Unable to allocate new CardRemoved signal");
+		return;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	g_dbus_send_message(ofono_dbus_get_connection(), signal);
+}
+
 void ofono_handsfree_audio_ref(void)
 {
 	ref_count +=3D 1;
@@ -301,6 +322,8 @@ char *ofono_handsfree_card_create(const char *remote)
 =

 void ofono_handsfree_card_remove(const char *path)
 {
+	am_emit_card_removed(path);
+
 	g_dbus_unregister_interface(ofono_dbus_get_connection(), path,
 						HFP_AUDIO_CARD_INTERFACE);
 =

-- =

1.7.11.7


--===============1286461497906605788==--

