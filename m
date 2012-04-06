Content-Type: multipart/mixed; boundary="===============5671752918411142641=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v4 06/10] bluetooth: Add +BSIR support
Date: Fri, 06 Apr 2012 15:17:08 +0200
Message-ID: <1333718232-8447-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333718232-8447-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5671752918411142641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++=
++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index b6328bc..b90852d 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -78,6 +78,7 @@ struct hfp_data {
 	struct ofono_emulator *em;
 	char *path;
 	guint16 r_features;
+	guint watch;
 };
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
@@ -267,6 +268,46 @@ fail:
 	};
 }
 =

+static gboolean audio_property_changed(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct hfp_data *hfp =3D user_data;
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
+		ofono_emulator_send_unsolicited(hfp->em, buf);
+	}
+
+	return TRUE;
+}
+
 void bluetooth_free_audio_management(void *data)
 {
 	struct hfp_data *hfp =3D data;
@@ -275,6 +316,8 @@ void bluetooth_free_audio_management(void *data)
 =

 	ofono_emulator_remove_handler(hfp->em, "+NREC");
 =

+	g_dbus_remove_watch(connection, hfp->watch);
+
 	g_free(hfp->path);
 	g_free(hfp);
 }
@@ -293,6 +336,12 @@ void *bluetooth_set_audio_management(void *em, const c=
har *path,
 =

 	ofono_emulator_add_handler(em, "+NREC", emulator_nrec_cb, hfp, NULL);
 =

+	hfp->watch =3D g_dbus_add_signal_watch(connection, NULL, path,
+						BLUEZ_TRANSPORT_INTERFACE,
+						"PropertyChanged",
+						audio_property_changed,
+						hfp, NULL);
+
 	return hfp;
 }
 =

-- =

1.7.1


--===============5671752918411142641==--

