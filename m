Content-Type: multipart/mixed; boundary="===============0856114638385932785=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v5 06/12] bluetooth: Add +BSIR support
Date: Thu, 26 Apr 2012 16:26:58 +0200
Message-ID: <1335450424-19964-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1335450424-19964-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0856114638385932785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++=
++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 6624718..75a4f00 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -80,6 +80,7 @@ struct bt_audio {
 	char *path;
 	guint16 r_features;
 	DBusPendingCall *call;
+	guint watch;
 };
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
@@ -282,6 +283,46 @@ fail:
 	};
 }
 =

+static gboolean audio_property_changed(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct bt_audio *audio =3D user_data;
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
+		ofono_emulator_send_unsolicited(audio->em, buf);
+	}
+
+	return TRUE;
+}
+
 void bluetooth_free_audio_management(struct bt_audio *audio)
 {
 	DBG("");
@@ -292,6 +333,8 @@ void bluetooth_free_audio_management(struct bt_audio *a=
udio)
 	if (audio->call)
 		dbus_pending_call_cancel(audio->call);
 =

+	g_dbus_remove_watch(connection, audio->watch);
+
 	g_free(audio->path);
 	g_free(audio);
 }
@@ -310,6 +353,12 @@ struct bt_audio *bluetooth_set_audio_management(void *=
em, const char *path,
 =

 	ofono_emulator_add_handler(em, "+NREC", emulator_nrec_cb, audio, NULL);
 =

+	audio->watch =3D g_dbus_add_signal_watch(connection, NULL, path,
+						BLUEZ_TRANSPORT_INTERFACE,
+						"PropertyChanged",
+						audio_property_changed,
+						audio, NULL);
+
 	return audio;
 }
 =

-- =

1.7.1


--===============0856114638385932785==--

