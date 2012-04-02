Content-Type: multipart/mixed; boundary="===============6222684747816796803=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v3 08/12] emulator: Add AT+NREC support
Date: Mon, 02 Apr 2012 15:27:18 +0200
Message-ID: <1333373242-11117-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333373242-11117-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6222684747816796803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |  120 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 120 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index dc3c10d..c5ec105 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -33,6 +33,7 @@
 #include "common.h"
 #include "gatserver.h"
 #include "gatppp.h"
+#include "../plugins/bluetooth.h"
 =

 #define RING_TIMEOUT 3
 =

@@ -312,6 +313,85 @@ error:
 	}
 }
 =

+static void audio_transport_set_property_cb(DBusPendingCall *call,
+						gpointer user_data)
+{
+	GAtServer *server =3D user_data;
+	DBusMessage *reply;
+	struct DBusError derr;
+	GAtServerResult result;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("MediaTransport.SetProperties replied an error: " \
+				"%s, %s", derr.name, derr.message);
+		dbus_error_free(&derr);
+		result =3D G_AT_SERVER_RESULT_ERROR;
+	} else
+		result =3D G_AT_SERVER_RESULT_OK;
+
+	g_at_server_send_final(server, result);
+
+	dbus_message_unref(reply);
+}
+
+static void audio_transport_set_property(GAtServer *server, const char *pa=
th,
+						const char *name, int type,
+						const void *value)
+{
+	DBusMessage *msg;
+	DBusMessageIter iter, var;
+	const char *str_type;
+	DBusConnection *connection;
+	DBusPendingCall *c;
+
+	if (path =3D=3D NULL)
+		return;
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
+		return;
+	}
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, path,
+				BLUEZ_TRANSPORT_INTERFACE, "SetProperty");
+	if (msg =3D=3D NULL)
+		return;
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
+	if (!dbus_connection_send_with_reply(connection, msg, &c, -1)) {
+		ofono_error("Sending SetProperty failed");
+		goto fail;
+	}
+
+	dbus_pending_call_set_notify(c, audio_transport_set_property_cb, server,
+									NULL);
+	dbus_pending_call_unref(c);
+
+fail:
+	dbus_message_unref(msg);
+}
+
 static struct indicator *find_indicator(struct ofono_emulator *em,
 						const char *name, int *index)
 {
@@ -829,6 +909,44 @@ fail:
 	}
 }
 =

+static void nrec_cb(GAtServer *server, GAtServerRequestType type,
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
+		if (val !=3D 0 && val !=3D 1)
+			goto fail;
+
+		/* check this is last parameter */
+		if (g_at_result_iter_skip_next(&iter))
+			goto fail;
+
+		audio_transport_set_property(server, em->audio_transport,
+					"NREC", DBUS_TYPE_BOOLEAN, &val);
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
@@ -931,6 +1049,7 @@ void ofono_emulator_register(struct ofono_emulator *em=
, int fd)
 		g_at_server_register(em->server, "+CCWA", ccwa_cb, em, NULL);
 		g_at_server_register(em->server, "+CMEE", cmee_cb, em, NULL);
 		g_at_server_register(em->server, "+BIA", bia_cb, em, NULL);
+		g_at_server_register(em->server, "+NREC", nrec_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -981,6 +1100,7 @@ struct ofono_emulator *ofono_emulator_create(struct of=
ono_modem *modem,
 =

 	em->type =3D type;
 	em->l_features |=3D HFP_AG_FEATURE_3WAY;
+	em->l_features |=3D HFP_AG_FEATURE_ECNR;
 	em->l_features |=3D HFP_AG_FEATURE_REJECT_CALL;
 	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_STATUS;
 	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_CONTROL;
-- =

1.7.1


--===============6222684747816796803==--

