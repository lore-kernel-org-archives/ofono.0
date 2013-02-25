Content-Type: multipart/mixed; boundary="===============2308726389217066546=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 6/8] handsfree-audio: Add emitting CardRemoved
Date: Mon, 25 Feb 2013 11:34:19 -0300
Message-ID: <1361802861-18267-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361802861-18267-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2308726389217066546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Handsfree Audio Manager needs to send the CardRemoved signal
when the handsfree modem is unregistered.
---
 src/handsfree-audio.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 2a4b3d5..674a289 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -194,6 +194,8 @@ static const GDBusMethodTable am_methods[] =3D {
 static const GDBusSignalTable am_signals[] =3D {
 	{ GDBUS_SIGNAL("CardAdded",
 		GDBUS_ARGS({ "path", "o" }, { "properties", "a{sv}" })) },
+	{ GDBUS_SIGNAL("CardRemoved",
+		GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
 =

@@ -243,6 +245,25 @@ static void am_emit_card_added(const char *path, struc=
t ofono_modem *modem)
 	g_dbus_send_message(ofono_dbus_get_connection(), signal);
 }
 =

+static void am_emit_card_removed(const char *path, struct ofono_modem *mod=
em)
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
 static void am_card_add(const char *path, struct ofono_modem *modem)
 {
 	g_dbus_register_interface(ofono_dbus_get_connection(), path,
@@ -254,6 +275,16 @@ static void am_card_add(const char *path, struct ofono=
_modem *modem)
 	DBG("Audio Card added: %s", path);
 }
 =

+static void am_card_remove(const char *path, struct ofono_modem *modem)
+{
+	am_emit_card_removed(path, modem);
+
+	g_dbus_unregister_interface(ofono_dbus_get_connection(), path,
+						HFP_AUDIO_CARD_INTERFACE);
+
+	DBG("Audio Card removed: %s", path);
+}
+
 static void handsfree_modem_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *user_data)
 {
@@ -262,11 +293,8 @@ static void handsfree_modem_watch(struct ofono_atom *a=
tom,
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
 		am_card_add(path, modem);
-	else {
-		g_dbus_unregister_interface(ofono_dbus_get_connection(), path,
-						HFP_AUDIO_CARD_INTERFACE);
-		DBG("Audio Card removed: %s", path);
-	}
+	else
+		am_card_remove(path, modem);
 }
 =

 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
-- =

1.7.11.7


--===============2308726389217066546==--

