Content-Type: multipart/mixed; boundary="===============6559786654021106771=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [RFC] plugin/ste: Use D-Bus API from Modem Init Daemon for autoconfig.
Date: Thu, 04 Nov 2010 15:18:24 +0100
Message-ID: <1288880304-16142-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6559786654021106771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

This patch introduces auto discovery of ST-Ericsson modems.
ST-Ericsson modems are managed by a Modem Init Daemon which
is responsible for start/stop/restart flashing etc. The
STE plugin monitors the modem state exposed from the
Modem Init Damon Dbus API. When the modem is in state "on"
the STE modem is created and registered.

The reason for not using the standard udev paradigm is that
the CAIF device is up before the modem is ready to setup AT channels.
For flashless modems CAIF is used as part of the boot. The Modem Init
Daemon is managing the flashless boot procedure and sets the State to
"on" when the modem is available.
---
 plugins/ste.c |  146 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 145 insertions(+), 1 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 508ad58..3e6b895 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -32,6 +32,7 @@
 #include <unistd.h>
 #include <net/if.h>
 =

+#include <gdbus.h>
 #include <glib.h>
 #include <gatchat.h>
 =

@@ -73,6 +74,144 @@ struct ste_data {
 	gboolean have_sim;
 };
 =

+/*
+ * ST-Ericsson's modem init daemon defines the signal StateChange
+ * and the method GetState. When state is "on" the STE modem is
+ * created and registered.
+ */
+#define STATUS_CHANGED	"StateChange"
+#define MID_SERVICE	"com.stericsson.mid"
+#define MID_INTERFACE	MID_SERVICE ".Modem"
+#define GET_STATE	"GetState"
+#define MID_STATE_ON	"on"
+#define MID_STATE_DISCONNECT	"disconnect"
+#define TIMEOUT	5000
+
+static struct ofono_modem *ste_modem;
+static guint mid_api_watch;
+static guint mid_state_watch;
+
+static void handle_stemodem(const char *state)
+{
+
+	if (strcmp(state, MID_STATE_ON) =3D=3D 0) {
+		int err;
+
+		if (ste_modem !=3D NULL)
+			return;
+
+		ste_modem =3D ofono_modem_create("ste", "ste");
+		DBG("register STE modem");
+		err =3D ofono_modem_register(ste_modem);
+	} else {
+		if (ste_modem =3D=3D NULL)
+			return;
+		ofono_modem_remove(ste_modem);
+		ste_modem =3D NULL;
+	}
+}
+
+static void mid_getstate_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *reply;
+	char *state;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		ofono_error("STE Modem Init Daemon is unavailable");
+		goto error;
+	}
+
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &state,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("STE Modem Init Damon: bad signature for GetState");
+		goto error;
+	}
+
+	handle_stemodem(state);
+error:
+	dbus_message_unref(reply);
+}
+
+static gboolean mid_signal_status_change(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	const char *state =3D NULL;
+
+	if (dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &state,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("STE Modem Init Daemon: invalid signal signature");
+		return FALSE;
+	}
+
+	handle_stemodem(state);
+	return TRUE;
+}
+
+static void mid_connect(DBusConnection *connection, void *user_data)
+{
+	DBusMessage *message;
+	DBusPendingCall *call;
+
+	message =3D dbus_message_new_method_call(MID_SERVICE, "/",
+					MID_INTERFACE, "GetState");
+	if (!message) {
+		ofono_error("Unable to allocate new D-Bus message");
+		goto error;
+	}
+
+	dbus_message_set_auto_start(message, FALSE);
+
+	if (dbus_connection_send_with_reply(connection, message,
+						&call, TIMEOUT) =3D=3D FALSE) {
+		ofono_error("Sending D-Bus message failed");
+		goto error;
+	}
+
+	if (call =3D=3D NULL) {
+		DBG("D-Bus connection not available");
+		goto error;
+	}
+
+	dbus_pending_call_set_notify(call, mid_getstate_reply, NULL, NULL);
+	dbus_pending_call_unref(call);
+error:
+	dbus_message_unref(message);
+}
+
+static void mid_disconnect(DBusConnection *connection, void *user_data)
+{
+	handle_stemodem(MID_STATE_DISCONNECT);
+}
+
+static int modem_initd_setup()
+{
+	DBusConnection *connection;
+
+	connection =3D ofono_dbus_get_connection();
+	if (connection =3D=3D NULL)
+		return -EIO;
+
+	mid_api_watch =3D g_dbus_add_service_watch(connection, MID_SERVICE,
+				mid_connect, mid_disconnect, NULL, NULL);
+
+	mid_state_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						MID_INTERFACE,
+						STATUS_CHANGED,
+						mid_signal_status_change,
+						NULL, NULL);
+
+	return 0;
+}
+
+static void modem_initd_teardown()
+{
+	DBusConnection *connection =3D ofono_dbus_get_connection();
+	g_dbus_remove_watch(connection, mid_state_watch);
+	g_dbus_remove_watch(connection, mid_api_watch);
+}
+
 static int ste_probe(struct ofono_modem *modem)
 {
 	struct ste_data *data;
@@ -382,12 +521,17 @@ static struct ofono_modem_driver ste_driver =3D {
 =

 static int ste_init(void)
 {
-	return ofono_modem_driver_register(&ste_driver);
+	int err;
+	err =3D ofono_modem_driver_register(&ste_driver);
+	if (err < 0)
+		return err;
+	return modem_initd_setup();
 }
 =

 static void ste_exit(void)
 {
 	ofono_modem_driver_unregister(&ste_driver);
+	modem_initd_teardown();
 }
 =

 OFONO_PLUGIN_DEFINE(ste, "ST-Ericsson modem driver", VERSION,
-- =

1.6.3.3


--===============6559786654021106771==--

