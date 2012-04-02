Content-Type: multipart/mixed; boundary="===============8091053998592514108=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v3 11/12] emulator: Add AT+VGS support
Date: Mon, 02 Apr 2012 15:27:21 +0200
Message-ID: <1333373242-11117-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333373242-11117-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8091053998592514108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index a976a13..0ae86e0 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -57,6 +57,8 @@ struct ofono_emulator {
 	guint audio_watch;
 	int mic_gain;
 	int mic_pending;
+	int sp_gain;
+	int sp_pending;
 };
 =

 struct indicator {
@@ -992,6 +994,48 @@ fail:
 	};
 }
 =

+static void vgs_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int val;
+
+	if (em->slc =3D=3D FALSE)
+		goto fail;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		if (em->audio_transport =3D=3D NULL)
+			goto fail;
+
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto fail;
+
+		if (val < 0 || val > 15)
+			goto fail;
+
+		/* check this is last parameter */
+		if (g_at_result_iter_skip_next(&iter))
+			goto fail;
+
+		if (em->sp_pending !=3D -1)
+			ofono_error("Receiving AT+VGS while processing one");
+
+		em->sp_pending =3D val;
+		audio_transport_set_property(server, em->audio_transport,
+					"SpeakerGain", DBUS_TYPE_UINT16, &val);
+		break;
+
+	default:
+fail:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+	};
+}
+
 static void emulator_add_indicator(struct ofono_emulator *em, const char* =
name,
 					int min, int max, int dflt,
 					gboolean mandatory)
@@ -1096,6 +1140,7 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
 		g_at_server_register(em->server, "+BIA", bia_cb, em, NULL);
 		g_at_server_register(em->server, "+NREC", nrec_cb, em, NULL);
 		g_at_server_register(em->server, "+VGM", vgm_cb, em, NULL);
+		g_at_server_register(em->server, "+VGS", vgs_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -1161,6 +1206,7 @@ struct ofono_emulator *ofono_emulator_create(struct o=
fono_modem *modem,
 	em->events_mode =3D 3;	/* default mode is forwarding events */
 	em->cmee_mode =3D 0;	/* CME ERROR disabled by default */
 	em->mic_pending =3D -1;
+	em->sp_pending =3D -1;
 =

 	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
 							emulator_remove, em);
@@ -1243,6 +1289,41 @@ static gboolean audio_property_changed(DBusConnectio=
n *connection,
 		} else if (em->mic_pending =3D=3D value)
 			em->mic_pending =3D -1;
 		em->mic_gain =3D value;
+	} else if (g_str_equal(property, "SpeakerGain") =3D=3D TRUE) {
+		DBusMessageIter variant;
+		int value;
+
+		if (!(em->r_features & HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL))
+			return TRUE;
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
+							DBUS_TYPE_UINT16)
+			return TRUE;
+
+		dbus_message_iter_get_basic(&variant, &value);
+
+		/* Send unsolicited +VGS only if :
+		 *   - the value has changed
+		 *   - and this is not a side effect of AT+VGS
+		 * But, if we receive a value change while waiting for another
+		 * pending change, we may have to send +VGS for other changes
+		 * (multiple AT+VGS received) to keep speaker gain in sync
+		 */
+		if (em->sp_pending !=3D value && em->sp_gain !=3D value) {
+			sprintf(buf, "+VGS: %d", value);
+			g_at_server_send_unsolicited(em->server, buf);
+			em->sp_pending =3D -1;
+		} else if (em->sp_pending =3D=3D value)
+			em->sp_pending =3D -1;
+		em->sp_gain =3D value;
 	}
 =

 	return TRUE;
-- =

1.7.1


--===============8091053998592514108==--

