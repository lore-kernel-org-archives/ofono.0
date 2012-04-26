Content-Type: multipart/mixed; boundary="===============0893646287877862135=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v5 07/12] bluetooth: Add AT+VGM support
Date: Thu, 26 Apr 2012 16:26:59 +0200
Message-ID: <1335450424-19964-8-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1335450424-19964-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0893646287877862135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 75a4f00..07a73b3 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -81,6 +81,8 @@ struct bt_audio {
 	guint16 r_features;
 	DBusPendingCall *call;
 	guint watch;
+	int mic_gain;
+	int mic_pending;
 };
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
@@ -283,6 +285,37 @@ fail:
 	};
 }
 =

+static void emulator_vgm_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct bt_audio *audio =3D userdata;
+	struct ofono_error result;
+	int val;
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
+		audio_transport_set_property(audio, "MicrophoneGain",
+							DBUS_TYPE_UINT16, &val);
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
@@ -318,6 +351,41 @@ static gboolean audio_property_changed(DBusConnection =
*connection,
 =

 		sprintf(buf, "+BSIR: %d", value);
 		ofono_emulator_send_unsolicited(audio->em, buf);
+	} else if (g_str_equal(property, "MicrophoneGain") =3D=3D TRUE) {
+		DBusMessageIter variant;
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
+		dbus_message_iter_get_basic(&variant, &value);
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
@@ -350,8 +418,10 @@ struct bt_audio *bluetooth_set_audio_management(void *=
em, const char *path,
 	audio->em =3D em;
 	audio->path =3D g_strdup(path);
 	audio->r_features =3D features;
+	audio->mic_pending =3D -1;
 =

 	ofono_emulator_add_handler(em, "+NREC", emulator_nrec_cb, audio, NULL);
+	ofono_emulator_add_handler(em, "+VGM", emulator_vgm_cb, audio, NULL);
 =

 	audio->watch =3D g_dbus_add_signal_watch(connection, NULL, path,
 						BLUEZ_TRANSPORT_INTERFACE,
-- =

1.7.1


--===============0893646287877862135==--

