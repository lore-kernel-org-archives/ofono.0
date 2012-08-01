Content-Type: multipart/mixed; boundary="===============3448197808617451514=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v6 08/12] hfp_ag: Add +BSIR support
Date: Wed, 01 Aug 2012 12:09:43 +0200
Message-ID: <1343815787-22670-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343815787-22670-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3448197808617451514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 1 file changed, 52 insertions(+)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index 342f959..6821500 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -38,6 +38,7 @@
 #define AGENT_PATH "/hfp_ag"
 #define VERSION_1_5 0x0105
 #define FEATURES	(HFP_AG_FEATURE_3WAY | HFP_AG_FEATURE_ECNR | \
+			HFP_AG_FEATURE_IN_BAND_RING_TONE | \
 			HFP_AG_FEATURE_REJECT_CALL | \
 			HFP_AG_FEATURE_ENHANCED_CALL_STATUS | \
 			HFP_AG_FEATURE_ENHANCED_CALL_CONTROL | \
@@ -52,6 +53,7 @@ struct bt_audio {
 	char *path;
 	guint16 r_features;
 	DBusPendingCall *call;
+	guint watch;
 };
 =

 static guint modemwatch_id;
@@ -177,8 +179,50 @@ fail:
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
 static void free_audio_management(struct bt_audio *audio)
 {
+	DBusConnection *connection =3D ofono_dbus_get_connection();
+
 	DBG("");
 =

 	if (audio =3D=3D NULL)
@@ -187,6 +231,8 @@ static void free_audio_management(struct bt_audio *audi=
o)
 	if (audio->call)
 		dbus_pending_call_cancel(audio->call);
 =

+	g_dbus_remove_watch(connection, audio->watch);
+
 	g_free(audio->path);
 	g_free(audio);
 }
@@ -234,6 +280,12 @@ static DBusMessage *hfp_ag_agent_new_connection(DBusCo=
nnection *conn,
 =

 	ofono_emulator_add_handler(em, "+NREC", emulator_nrec_cb, audio, NULL);
 =

+	audio->watch =3D g_dbus_add_signal_watch(conn, NULL, path,
+						BLUEZ_TRANSPORT_INTERFACE,
+						"PropertyChanged",
+						audio_property_changed,
+						audio, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 =

-- =

1.7.9.5


--===============3448197808617451514==--

