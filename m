Content-Type: multipart/mixed; boundary="===============8455706692982384811=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v3 09/12] emulator: Add +BSIR support
Date: Mon, 02 Apr 2012 15:27:19 +0200
Message-ID: <1333373242-11117-10-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333373242-11117-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8455706692982384811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c5ec105..0760c79 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -54,6 +54,7 @@ struct ofono_emulator {
 	gboolean ccwa;
 	int pns_id;
 	char *audio_transport;
+	guint audio_watch;
 };
 =

 struct indicator {
@@ -1071,9 +1072,15 @@ void ofono_emulator_register(struct ofono_emulator *=
em, int fd)
 static void emulator_remove(struct ofono_atom *atom)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+	DBusConnection *connection;
 =

 	DBG("atom: %p", atom);
 =

+	connection =3D ofono_dbus_get_connection();
+
+	if (em->audio_watch)
+		g_dbus_remove_watch(connection, em->audio_watch);
+
 	g_free(em->audio_transport);
 	g_free(em);
 }
@@ -1101,6 +1108,7 @@ struct ofono_emulator *ofono_emulator_create(struct o=
fono_modem *modem,
 	em->type =3D type;
 	em->l_features |=3D HFP_AG_FEATURE_3WAY;
 	em->l_features |=3D HFP_AG_FEATURE_ECNR;
+	em->l_features |=3D HFP_AG_FEATURE_IN_BAND_RING_TONE;
 	em->l_features |=3D HFP_AG_FEATURE_REJECT_CALL;
 	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_STATUS;
 	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_CONTROL;
@@ -1119,10 +1127,60 @@ void ofono_emulator_remove(struct ofono_emulator *e=
m)
 	__ofono_atom_free(em->atom);
 }
 =

+static gboolean audio_property_changed(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	const char *property;
+	char buf[10];
+	DBusMessageIter iter;
+
+	dbus_message_iter_init(message, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &property);
+
+	if (g_str_equal(property, "InbandRingtone") =3D=3D TRUE) {
+		DBusMessageIter variant;
+		gboolean value;
+
+		if (!dbus_message_iter_next(&iter))
+			return TRUE;
+
+		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+			return TRUE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+
+		if (dbus_message_iter_get_arg_type(&variant) !=3D
+							DBUS_TYPE_BOOLEAN)
+			return TRUE;
+
+		dbus_message_iter_get_basic(&variant, &value);
+
+		sprintf(buf, "+BSIR: %d", value);
+		g_at_server_send_unsolicited(em->server, buf);
+	}
+
+	return TRUE;
+}
+
 void ofono_emulator_set_audio_transport(struct ofono_emulator *em,
 						const char *path)
 {
+	DBusConnection *connection;
+
 	em->audio_transport =3D g_strdup(path);
+
+	connection =3D ofono_dbus_get_connection();
+
+	em->audio_watch =3D g_dbus_add_signal_watch(connection, NULL, path,
+						BLUEZ_TRANSPORT_INTERFACE,
+						"PropertyChanged",
+						audio_property_changed, em,
+						NULL);
 }
 =

 void ofono_emulator_send_final(struct ofono_emulator *em,
-- =

1.7.1


--===============8455706692982384811==--

