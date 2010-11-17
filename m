Content-Type: multipart/mixed; boundary="===============5663083961955374634=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH] plugin: Add ste modem initd integration
Date: Wed, 17 Nov 2010 12:18:50 +0100
Message-ID: <1289992730-25303-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5663083961955374634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

This patch introduces auto discovery of ST-Ericsson modems.
ST-Ericsson modems are managed by a Modem Init Daemon that
is responsible for start/stop/restart flashing etc. The
STE plugin monitors the modem state exposed from the
Modem Init Damon Dbus API. When the modem is in state "on"
the STE modem is created and registered.
---
 Makefile.am      |    5 ++
 configure.ac     |    6 ++
 plugins/stemid.c |  195 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 206 insertions(+), 0 deletions(-)
 create mode 100644 plugins/stemid.c

diff --git a/Makefile.am b/Makefile.am
index f841b4c..aaf5de5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -81,6 +81,11 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 =

 udev_files =3D plugins/ofono.rules
 =

+if STE_MODEM_INITD
+builtin_modules +=3D stemid
+builtin_sources +=3D plugins/stemid.c
+endif
+
 if UDEV
 builtin_modules +=3D udev
 builtin_sources +=3D plugins/udev.c
diff --git a/configure.ac b/configure.ac
index 6aeab7c..6fafadd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -175,6 +175,12 @@ AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-dat=
afiles],
 =

 AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" !=3D "no")
 =

+AC_ARG_ENABLE(ste_modem_initd, AC_HELP_STRING([--disable-ste-modem-initd],
+			[disable auto discovery of STE modem using modem init daemon]),
+					[enable_ste_modem_initd=3D${enableval}])
+
+AM_CONDITIONAL(STE_MODEM_INITD, test "${enable_ste_modem_initd}" !=3D "no")
+
 if (test "${prefix}" =3D "NONE"); then
 	dnl no prefix and no localstatedir, so default to /var
 	if (test "$localstatedir" =3D '${prefix}/var'); then
diff --git a/plugins/stemid.c b/plugins/stemid.c
new file mode 100644
index 0000000..7041e5e
--- /dev/null
+++ b/plugins/stemid.c
@@ -0,0 +1,195 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 ST-Ericsson AB.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <net/if.h>
+
+#include <gdbus.h>
+#include <glib.h>
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/dbus.h>
+#include <ofono/version.h>
+
+/*
+ * ST-Ericsson's modem init daemon defines the signal StateChange
+ * and the method GetState. When state is "on" the STE modem is
+ * created and registered.
+ */
+#define STATUS_CHANGED	"StateChange"
+#define MID_SERVICE	"com.stericsson.modeminit"
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
+	DBG("state:%s", state);
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
+
+		if (ste_modem =3D=3D NULL)
+			return;
+
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
+
+error:
+	dbus_message_unref(reply);
+}
+
+static gboolean mid_signal_status_change(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	const char *state;
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
+	DBG("");
+	message =3D dbus_message_new_method_call(MID_SERVICE, "/",
+					MID_INTERFACE, "GetState");
+
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
+
+error:
+	dbus_message_unref(message);
+}
+
+static void mid_disconnect(DBusConnection *connection, void *user_data)
+{
+	handle_stemodem(MID_STATE_DISCONNECT);
+}
+
+static int stemid_init()
+{
+	DBusConnection *connection;
+
+	DBG("");
+
+	connection =3D ofono_dbus_get_connection();
+
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
+	return 0;
+}
+
+static void stemid_exit()
+{
+	DBusConnection *connection =3D ofono_dbus_get_connection();
+
+	g_dbus_remove_watch(connection, mid_state_watch);
+	g_dbus_remove_watch(connection, mid_api_watch);
+}
+
+OFONO_PLUGIN_DEFINE(stemid, "STE modem init daemon dbus api", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, stemid_init, stemid_exit)
-- =

1.6.3.3


--===============5663083961955374634==--

