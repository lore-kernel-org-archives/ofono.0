Content-Type: multipart/mixed; boundary="===============0726244367978077748=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v6 09/12] hfp_ag: Add AT+VGM support
Date: Wed, 01 Aug 2012 12:09:44 +0200
Message-ID: <1343815787-22670-10-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343815787-22670-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0726244367978077748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 74 insertions(+)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index 6821500..f865208 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -54,6 +54,8 @@ struct bt_audio {
 	guint16 r_features;
 	DBusPendingCall *call;
 	guint watch;
+	int mic_gain;
+	int mic_pending;
 };
 =

 static guint modemwatch_id;
@@ -179,6 +181,39 @@ fail:
 	};
 }
 =

+static void emulator_vgm_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct bt_audio *audio =3D userdata;
+	struct ofono_error result;
+	int val;
+	dbus_uint16_t dbus_val;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_SET:
+		if (!ofono_emulator_request_next_number(req, &val))
+			goto fail;
+
+		if (val < 0 && val > 15)
+			goto fail;
+
+		if (audio->mic_pending !=3D -1)
+			ofono_error("Receiving AT+VGM while processing one");
+
+		audio->mic_pending =3D val;
+		dbus_val =3D val;
+		audio_transport_set_property(audio, "InputGain",
+						DBUS_TYPE_UINT16, &dbus_val);
+		break;
+
+	default:
+fail:
+		result.error =3D 0;
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+	};
+}
+
 static gboolean audio_property_changed(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -214,6 +249,43 @@ static gboolean audio_property_changed(DBusConnection =
*connection,
 =

 		sprintf(buf, "+BSIR: %d", value);
 		ofono_emulator_send_unsolicited(audio->em, buf);
+	} else if (g_str_equal(property, "InputGain") =3D=3D TRUE) {
+		DBusMessageIter variant;
+		dbus_uint16_t dbus_val;
+		int value;
+
+		if (!(audio->r_features & HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL))
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
+		dbus_message_iter_get_basic(&variant, &dbus_val);
+		value =3D dbus_val;
+
+		/* Send unsolicited +VGM only if :
+		 *   - the value has changed
+		 *   - and this is not a side effect of AT+VGM
+		 * But, if we receive a value change while waiting for another
+		 * pending change, we may have to send +VGM for other changes
+		 * (multiple AT+VGM received) to keep mic gain in sync
+		 */
+		if (audio->mic_pending !=3D value && audio->mic_gain !=3D value) {
+			sprintf(buf, "+VGM: %d", value);
+			ofono_emulator_send_unsolicited(audio->em, buf);
+			audio->mic_pending =3D -1;
+		} else if (audio->mic_pending =3D=3D value)
+			audio->mic_pending =3D -1;
+		audio->mic_gain =3D value;
 	}
 =

 	return TRUE;
@@ -275,10 +347,12 @@ static DBusMessage *hfp_ag_agent_new_connection(DBusC=
onnection *conn,
 	audio->em =3D em;
 	audio->path =3D g_strdup(path);
 	audio->r_features =3D features;
+	audio->mic_pending =3D -1;
 	ofono_emulator_set_data(em, audio,
 				(ofono_destroy_func)free_audio_management);
 =

 	ofono_emulator_add_handler(em, "+NREC", emulator_nrec_cb, audio, NULL);
+	ofono_emulator_add_handler(em, "+VGM", emulator_vgm_cb, audio, NULL);
 =

 	audio->watch =3D g_dbus_add_signal_watch(conn, NULL, path,
 						BLUEZ_TRANSPORT_INTERFACE,
-- =

1.7.9.5


--===============0726244367978077748==--

