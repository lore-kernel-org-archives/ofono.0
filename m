Content-Type: multipart/mixed; boundary="===============2311680106134953102=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v4 08/10] bluetooth: Add AT+VGS support
Date: Fri, 06 Apr 2012 15:17:10 +0200
Message-ID: <1333718232-8447-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333718232-8447-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2311680106134953102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 3560440..107c197 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -81,6 +81,8 @@ struct hfp_data {
 	guint watch;
 	int mic_gain;
 	int mic_pending;
+	int sp_gain;
+	int sp_pending;
 };
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
@@ -301,6 +303,37 @@ fail:
 	};
 }
 =

+static void emulator_vgs_cb(struct ofono_emulator *em,
+		struct ofono_emulator_request *req, void *userdata)
+{
+	struct hfp_data *hfp =3D userdata;
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
+		if (hfp->sp_pending !=3D -1)
+			ofono_error("Receiving AT+VGS while processing one");
+
+		hfp->sp_pending =3D val;
+		audio_transport_set_property(hfp, "SpeakerGain",
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
@@ -371,6 +404,41 @@ static gboolean audio_property_changed(DBusConnection =
*connection,
 		} else if (hfp->mic_pending =3D=3D value)
 			hfp->mic_pending =3D -1;
 		hfp->mic_gain =3D value;
+	} else if (g_str_equal(property, "SpeakerGain") =3D=3D TRUE) {
+		DBusMessageIter variant;
+		int value;
+
+		if (!(hfp->r_features & HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL))
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
+		if (hfp->sp_pending !=3D value && hfp->sp_gain !=3D value) {
+			sprintf(buf, "+VGS: %d", value);
+			ofono_emulator_send_unsolicited(hfp->em, buf);
+			hfp->sp_pending =3D -1;
+		} else if (hfp->sp_pending =3D=3D value)
+			hfp->sp_pending =3D -1;
+		hfp->sp_gain =3D value;
 	}
 =

 	return TRUE;
@@ -384,6 +452,7 @@ void bluetooth_free_audio_management(void *data)
 =

 	ofono_emulator_remove_handler(hfp->em, "+NREC");
 	ofono_emulator_remove_handler(hfp->em, "+VGM");
+	ofono_emulator_remove_handler(hfp->em, "+VGS");
 =

 	g_dbus_remove_watch(connection, hfp->watch);
 =

@@ -403,9 +472,11 @@ void *bluetooth_set_audio_management(void *em, const c=
har *path,
 	hfp->path =3D g_strdup(path);
 	hfp->r_features =3D features;
 	hfp->mic_pending =3D -1;
+	hfp->sp_pending =3D -1;
 =

 	ofono_emulator_add_handler(em, "+NREC", emulator_nrec_cb, hfp, NULL);
 	ofono_emulator_add_handler(em, "+VGM", emulator_vgm_cb, hfp, NULL);
+	ofono_emulator_add_handler(em, "+VGS", emulator_vgs_cb, hfp, NULL);
 =

 	hfp->watch =3D g_dbus_add_signal_watch(connection, NULL, path,
 						BLUEZ_TRANSPORT_INTERFACE,
-- =

1.7.1


--===============2311680106134953102==--

