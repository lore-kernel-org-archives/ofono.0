Content-Type: multipart/mixed; boundary="===============6622379005274425904=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v5 08/12] bluetooth: Add AT+VGS support
Date: Thu, 26 Apr 2012 16:27:00 +0200
Message-ID: <1335450424-19964-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1335450424-19964-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6622379005274425904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 07a73b3..65d7954 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -83,6 +83,8 @@ struct bt_audio {
 	guint watch;
 	int mic_gain;
 	int mic_pending;
+	int sp_gain;
+	int sp_pending;
 };
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
@@ -316,6 +318,37 @@ fail:
 	};
 }
 =

+static void emulator_vgs_cb(struct ofono_emulator *em,
+		struct ofono_emulator_request *req, void *userdata)
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
+		if (audio->sp_pending !=3D -1)
+			ofono_error("Receiving AT+VGS while processing one");
+
+		audio->sp_pending =3D val;
+		audio_transport_set_property(audio, "SpeakerGain",
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
@@ -386,6 +419,41 @@ static gboolean audio_property_changed(DBusConnection =
*connection,
 		} else if (audio->mic_pending =3D=3D value)
 			audio->mic_pending =3D -1;
 		audio->mic_gain =3D value;
+	} else if (g_str_equal(property, "SpeakerGain") =3D=3D TRUE) {
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
+		/* Send unsolicited +VGS only if :
+		 *   - the value has changed
+		 *   - and this is not a side effect of AT+VGS
+		 * But, if we receive a value change while waiting for another
+		 * pending change, we may have to send +VGS for other changes
+		 * (multiple AT+VGS received) to keep speaker gain in sync
+		 */
+		if (audio->sp_pending !=3D value && audio->sp_gain !=3D value) {
+			sprintf(buf, "+VGS: %d", value);
+			ofono_emulator_send_unsolicited(audio->em, buf);
+			audio->sp_pending =3D -1;
+		} else if (audio->sp_pending =3D=3D value)
+			audio->sp_pending =3D -1;
+		audio->sp_gain =3D value;
 	}
 =

 	return TRUE;
@@ -419,9 +487,11 @@ struct bt_audio *bluetooth_set_audio_management(void *=
em, const char *path,
 	audio->path =3D g_strdup(path);
 	audio->r_features =3D features;
 	audio->mic_pending =3D -1;
+	audio->sp_pending =3D -1;
 =

 	ofono_emulator_add_handler(em, "+NREC", emulator_nrec_cb, audio, NULL);
 	ofono_emulator_add_handler(em, "+VGM", emulator_vgm_cb, audio, NULL);
+	ofono_emulator_add_handler(em, "+VGS", emulator_vgs_cb, audio, NULL);
 =

 	audio->watch =3D g_dbus_add_signal_watch(connection, NULL, path,
 						BLUEZ_TRANSPORT_INTERFACE,
-- =

1.7.1


--===============6622379005274425904==--

