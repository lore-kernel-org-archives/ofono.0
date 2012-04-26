Content-Type: multipart/mixed; boundary="===============6307868298661616304=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v5 05/12] bluetooth: Add AT+NREC support
Date: Thu, 26 Apr 2012 16:26:57 +0200
Message-ID: <1335450424-19964-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1335450424-19964-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6307868298661616304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |  159 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 159 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 971e2c6..6624718 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -37,6 +37,8 @@
 #include <ofono/log.h>
 =

 #include <btio.h>
+#include <ofono/modem.h>
+#include <ofono/emulator.h>
 #include "bluetooth.h"
 =

 static DBusConnection *connection;
@@ -73,6 +75,13 @@ struct agent {
 	guint16 features;
 };
 =

+struct bt_audio {
+	struct ofono_emulator *em;
+	char *path;
+	guint16 r_features;
+	DBusPendingCall *call;
+};
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
 {
@@ -154,6 +163,156 @@ fail:
 	return err;
 }
 =

+static void audio_transport_set_property_cb(DBusPendingCall *call,
+						gpointer user_data)
+{
+	struct bt_audio *audio =3D user_data;
+	DBusMessage *reply;
+	struct DBusError derr;
+	struct ofono_error result;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("MediaTransport.SetProperties replied an error: " \
+				"%s, %s", derr.name, derr.message);
+		dbus_error_free(&derr);
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+	} else
+		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+
+	result.error =3D 0;
+	ofono_emulator_send_final(audio->em, &result);
+
+	dbus_message_unref(reply);
+
+	dbus_pending_call_unref(audio->call);
+	audio->call =3D NULL;
+}
+
+static void audio_transport_set_property(struct bt_audio *audio,
+				const char *name, int type, const void *value)
+{
+	DBusMessage *msg;
+	DBusMessageIter iter, var;
+	const char *str_type;
+	DBusConnection *connection;
+	struct ofono_error result;
+
+	if (audio->call !=3D NULL)
+		goto fail;
+
+	if (audio->path =3D=3D NULL)
+		goto fail;
+
+	switch (type) {
+	case DBUS_TYPE_BOOLEAN:
+		str_type =3D DBUS_TYPE_BOOLEAN_AS_STRING;
+		break;
+
+	case DBUS_TYPE_UINT16:
+		str_type =3D DBUS_TYPE_UINT16_AS_STRING;
+		break;
+
+	default:
+		goto fail;
+	}
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, audio->path,
+				BLUEZ_TRANSPORT_INTERFACE, "SetProperty");
+	if (msg =3D=3D NULL)
+		goto fail;
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT, str_type,
+						&var);
+	dbus_message_iter_append_basic(&var, type, value);
+	dbus_message_iter_close_container(&iter, &var);
+
+	connection =3D ofono_dbus_get_connection();
+
+	if (!dbus_connection_send_with_reply(connection, msg, &audio->call,
+									-1)) {
+		ofono_error("Sending SetProperty failed");
+		dbus_message_unref(msg);
+		goto fail;
+	}
+
+	dbus_pending_call_set_notify(audio->call,
+						audio_transport_set_property_cb,
+						audio, NULL);
+
+	dbus_message_unref(msg);
+	return;
+
+fail:
+	result.error =3D 0;
+	result.type =3D OFONO_ERROR_TYPE_FAILURE;
+	ofono_emulator_send_final(audio->em, &result);
+}
+
+static void emulator_nrec_cb(struct ofono_emulator *em,
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
+		if (val !=3D 0 && val !=3D 1)
+			goto fail;
+
+		audio_transport_set_property(audio, "NREC", DBUS_TYPE_BOOLEAN,
+									&val);
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
+void bluetooth_free_audio_management(struct bt_audio *audio)
+{
+	DBG("");
+
+	if (audio =3D=3D NULL)
+		return;
+
+	if (audio->call)
+		dbus_pending_call_cancel(audio->call);
+
+	g_free(audio->path);
+	g_free(audio);
+}
+
+struct bt_audio *bluetooth_set_audio_management(void *em, const char *path,
+							guint16 features)
+{
+	struct bt_audio *audio;
+
+	DBG("");
+
+	audio =3D g_new0(struct bt_audio, 1);
+	audio->em =3D em;
+	audio->path =3D g_strdup(path);
+	audio->r_features =3D features;
+
+	ofono_emulator_add_handler(em, "+NREC", emulator_nrec_cb, audio, NULL);
+
+	return audio;
+}
+
 static void register_telephony_agent(const char *path, const char *handle,
 						struct agent *agent)
 {
-- =

1.7.1


--===============6307868298661616304==--

