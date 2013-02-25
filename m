Content-Type: multipart/mixed; boundary="===============4912365070602800015=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 2/8] handsfree-audio: Add Audio Card registration
Date: Mon, 25 Feb 2013 11:34:15 -0300
Message-ID: <1361802861-18267-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361802861-18267-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4912365070602800015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the Handsfree Audio Card registration based on the
registered Handsfree modem.
---
 src/handsfree-audio.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index a8680b1..d14a767 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -35,6 +35,7 @@
 =

 #define HFP_AUDIO_MANAGER_INTERFACE	OFONO_SERVICE ".HandsfreeAudioManager"
 #define HFP_AUDIO_AGENT_INTERFACE	OFONO_SERVICE ".HandsfreeAudioAgent"
+#define HFP_AUDIO_CARD_INTERFACE	OFONO_SERVICE ".HandsfreeAudioCard"
 =

 /* Supported agent codecs */
 enum hfp_codec {
@@ -172,9 +173,35 @@ static const GDBusMethodTable am_methods[] =3D {
 	{ }
 };
 =

+static DBusMessage *card_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return __ofono_error_not_implemented(msg);
+}
+
+static const GDBusMethodTable card_methods[] =3D {
+	{ GDBUS_METHOD("GetProperties",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				card_get_properties) },
+	{ }
+};
+
 static void handsfree_modem_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *user_data)
 {
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		g_dbus_register_interface(ofono_dbus_get_connection(), path,
+					HFP_AUDIO_CARD_INTERFACE, card_methods,
+					NULL, NULL, NULL, NULL);
+
+		DBG("Audio Card added: %s", path);
+	} else {
+		g_dbus_unregister_interface(ofono_dbus_get_connection(), path,
+						HFP_AUDIO_CARD_INTERFACE);
+		DBG("Audio Card removed: %s", path);
+	}
 }
 =

 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
-- =

1.7.11.7


--===============4912365070602800015==--

