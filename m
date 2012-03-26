Content-Type: multipart/mixed; boundary="===============7737789165332220996=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v2 10/12] emulator: Add AT+VGM support
Date: Mon, 26 Mar 2012 11:25:27 +0200
Message-ID: <1332753929-9711-11-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1332753929-9711-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7737789165332220996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 08f63ee..8c5a89a 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -55,6 +55,8 @@ struct ofono_emulator {
 	int pns_id;
 	char *audio_transport;
 	guint audio_watch;
+	int mic_gain;
+	int mic_pending;
 };
 =

 struct indicator {
@@ -948,6 +950,48 @@ fail:
 	};
 }
 =

+static void vgm_cb(GAtServer *server, GAtServerRequestType type,
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
+		if (em->mic_pending !=3D -1)
+			ofono_error("Receiving AT+VGM while processing one");
+
+		em->mic_pending =3D val;
+		audio_transport_set_property(server, em->audio_transport,
+				"MicrophoneGain", DBUS_TYPE_UINT16, &val);
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
@@ -1051,6 +1095,7 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
 		g_at_server_register(em->server, "+CMEE", cmee_cb, em, NULL);
 		g_at_server_register(em->server, "+BIA", bia_cb, em, NULL);
 		g_at_server_register(em->server, "+NREC", nrec_cb, em, NULL);
+		g_at_server_register(em->server, "+VGM", vgm_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -1115,6 +1160,7 @@ struct ofono_emulator *ofono_emulator_create(struct o=
fono_modem *modem,
 	em->l_features |=3D HFP_AG_FEATURE_EXTENDED_RES_CODE;
 	em->events_mode =3D 3;	/* default mode is forwarding events */
 	em->cmee_mode =3D 0;	/* CME ERROR disabled by default */
+	em->mic_pending =3D -1;
 =

 	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
 							emulator_remove, em);
@@ -1162,6 +1208,41 @@ static gboolean audio_property_changed(DBusConnectio=
n *connection,
 =

 		sprintf(buf, "+BSIR: %d", value);
 		g_at_server_send_unsolicited(em->server, buf);
+	} else if (g_str_equal(property, "MicrophoneGain") =3D=3D TRUE) {
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
+		/* Send unsolicited +VGM only if :
+		 *   - the value has changed
+		 *   - and this is not a side effect of AT+VGM
+		 * But, if we receive a value change while waiting for another
+		 * pending change, we may have to send +VGM for other changes
+		 * (multiple AT+VGM received) to keep mic gain in sync
+		 */
+		if (em->mic_pending !=3D value && em->mic_gain !=3D value) {
+			sprintf(buf, "+VGM: %d", value);
+			g_at_server_send_unsolicited(em->server, buf);
+			em->mic_pending =3D -1;
+		} else if (em->mic_pending =3D=3D value)
+			em->mic_pending =3D -1;
+		em->mic_gain =3D value;
 	}
 =

 	return TRUE;
-- =

1.7.1


--===============7737789165332220996==--

