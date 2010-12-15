Content-Type: multipart/mixed; boundary="===============9089052534584056047=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCHv2] plugin: Add ste modem initd integration
Date: Wed, 15 Dec 2010 22:49:26 +0100
Message-ID: <1292449768-6060-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9089052534584056047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

This patch introduces auto discovery of ST-Ericsson modems.
ST-Ericsson modems (M5XX, M57XX, M7XX, M74XX) are managed by a
Modem Init Daemon responsible for start, power cycles,
flashing etc. This STE plugin monitors the modem state exposed
from the Modem Init Damon's Dbus API. When the modem is in state
"on" the STE modem is created and registered. Multiple modem
instances, and reset handling is supported.
---
Changes:
- Support for multiple STE modems.
- Better naming of STE modem instances, using received dbus path.
- CAIF Link layer to use for AT channels specified pr modem instance.
- Added support for reset.

 Makefile.am      |    5 +
 configure.ac     |    6 +
 plugins/stemid.c |  310 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 321 insertions(+), 0 deletions(-)
 create mode 100644 plugins/stemid.c

diff --git a/Makefile.am b/Makefile.am
index 12b3c33..98096ae 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -82,6 +82,11 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
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
index 5c18f68..f733fc4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -177,6 +177,12 @@ AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-dat=
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
index 0000000..9f5da22
--- /dev/null
+++ b/plugins/stemid.c
@@ -0,0 +1,310 @@
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
+#include <string.h>
+#include <net/if.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/dbus.h>
+
+/*
+ * ST-Ericsson's Modem Init Daemon is used for controling the modem power
+ * cycles and provides a dbus API for modem state and properties.
+ */
+#define MID_SERVICE		"com.stericsson.modeminit"
+#define MID_INTERFACE		MID_SERVICE ".Modem"
+
+/* The signal StateChange sends the modem state.*/
+#define STATUS_CHANGED		"StateChange"
+
+#define MID_ACTION_ON		"on"		/* Modem is on */
+#define MID_ACTION_RESET	"dumping"	/* Modem is resetting */
+#define MID_ACTION_UNKNOWN	"unknown"	/* Don't care */
+
+/* ResetState requests resending of StateChange. */
+#define MID_RESEND_STATE	"ResendState"
+
+/* GetCaifIfName requests the CAIF Interface Name. */
+#define MID_GET_CAIFIF		"GetCaifIfName"
+
+#define TIMEOUT		5000
+#define STE_DRIVER_NAME	"ste"
+#define STE_INTERFACE_PROPERTY	"Interface"
+
+enum ste_state {
+	STE_PENDING,    /* Waiting for caifif and "on" notification */
+	STE_PENDING_IF, /* Waiting for caifif, already got "on" */
+	STE_REGISTERED, /* Modem is registered */
+	STE_RESETTING   /* Modem is resetting */
+};
+
+struct ste_modem {
+	char *path;
+	struct ofono_modem *modem;
+	enum ste_state state;
+	gboolean got_caifif;
+	gboolean pending_call;
+};
+
+static GHashTable *modem_list;
+static guint mid_api_watch;
+static guint mid_state_watch;
+static DBusConnection *connection;
+
+static void get_caifif_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *reply;
+	char *ifname;
+	struct ste_modem *stemodem =3D user_data;
+
+	stemodem->pending_call =3D FALSE;
+	stemodem->got_caifif =3D TRUE;
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		ofono_error("STE Modem Init Daemon: unavailable");
+		goto error;
+	}
+
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &ifname,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("STE Modem Init Daemon: bad signature for %s",
+				MID_GET_CAIFIF);
+		goto error;
+	}
+
+	if (strlen(ifname) > IF_NAMESIZE) {
+		ofono_error("STE Modem Init Daemon: %s bad response %s\n",
+				MID_GET_CAIFIF, ifname);
+		goto error;
+	}
+
+	if (ifname !=3D NULL) {
+		DBG("STE Modem '%s' uses CAIF interface '%s'\n", stemodem->path,
+			ifname);
+		ofono_modem_set_string(stemodem->modem, STE_INTERFACE_PROPERTY,
+			ifname);
+	}
+
+error:
+	if (stemodem->state =3D=3D STE_PENDING_IF) {
+		DBG("Register STE modem %s", stemodem->path);
+		ofono_modem_register(stemodem->modem);
+		stemodem->state =3D STE_REGISTERED;
+	}
+
+	dbus_message_unref(reply);
+}
+
+static void get_caif_interface(const char *path, struct ste_modem *stemode=
m)
+{
+	DBusMessage *message;
+	DBusPendingCall *call;
+
+	stemodem->pending_call =3D TRUE;
+	message =3D dbus_message_new_method_call(MID_SERVICE, path,
+					MID_INTERFACE, MID_GET_CAIFIF);
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
+		stemodem->got_caifif =3D TRUE;
+		goto error;
+	}
+
+	if (call =3D=3D NULL) {
+		DBG("D-Bus connection not available");
+		stemodem->got_caifif =3D TRUE;
+		goto error;
+	}
+
+	dbus_pending_call_set_notify(call, get_caifif_reply, stemodem, NULL);
+	dbus_pending_call_unref(call);
+
+error:
+	dbus_message_unref(message);
+}
+
+static void handle_stemodem(const char *action, const char *path)
+{
+	struct ste_modem *stemodem =3D g_hash_table_lookup(modem_list, path);
+
+	if (stemodem =3D=3D NULL) {
+		DBG("created STE modem %s", path);
+		stemodem =3D g_try_new0(struct ste_modem, 1);
+		if (stemodem =3D=3D NULL)
+			return;
+
+		/* remove '/' from path to create a leagal modem name */
+		stemodem->modem =3D ofono_modem_create(path+1, STE_DRIVER_NAME);
+		if (stemodem->modem =3D=3D NULL) {
+			ofono_error("STE Modem Init: Bad path: '%s'\n", path);
+			g_free(stemodem);
+			return;
+		}
+
+		stemodem->path =3D g_strdup(path);
+		stemodem->state =3D STE_PENDING;
+		g_hash_table_insert(modem_list, stemodem->path, stemodem);
+	}
+
+	if (!stemodem->got_caifif) {
+		DBG("request caif interface %s", path);
+		get_caif_interface(path, stemodem);
+		stemodem->state =3D STE_PENDING;
+	}
+
+	switch (stemodem->state) {
+	case STE_PENDING:
+		if (g_strcmp0(action, MID_ACTION_ON) !=3D 0)
+			break;
+		if (stemodem->got_caifif) {
+			DBG("register STE modem %s", path);
+			ofono_modem_register(stemodem->modem);
+			stemodem->state =3D STE_REGISTERED;
+		} else
+			stemodem->state =3D STE_PENDING_IF;
+		break;
+	case STE_PENDING_IF:
+		break;
+	case STE_REGISTERED:
+		if (g_strcmp0(action, MID_ACTION_RESET) =3D=3D 0) {
+			DBG("reset ongoing %s", path);
+			/* NOTE: Should we set powered =3D FALSE here? */
+			stemodem->state =3D STE_RESETTING;
+		} else if (g_strcmp0(action, MID_ACTION_ON) !=3D 0) {
+			DBG("STE modem unregistering %s %s", path, action);
+			g_hash_table_remove(modem_list, path);
+		}
+
+		break;
+	case STE_RESETTING:
+		if (g_strcmp0(action, MID_ACTION_ON) =3D=3D 0) {
+			DBG("STE modem reset complete %s", path);
+			if (ofono_modem_get_powered(stemodem->modem))
+				ofono_modem_reset(stemodem->modem);
+		} else if (g_strcmp0(action, MID_ACTION_RESET) !=3D 0) {
+			DBG("STE modem unregistering %s %s", path, action);
+			g_hash_table_remove(modem_list, path);
+		}
+
+		break;
+	}
+}
+
+static gboolean mid_signal_status_change(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	const char *state;
+	const char *path =3D dbus_message_get_path(message);
+
+	if (dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &state,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("STE Modem Init Daemon: invalid signal signature");
+		return FALSE;
+	}
+
+	if (g_strcmp0(path, "/") =3D=3D 0)
+		return TRUE;
+
+	handle_stemodem(state, path);
+	return TRUE;
+}
+
+static void mid_connect(DBusConnection *connection, void *user_data)
+{
+	DBusMessage *message;
+
+	mid_state_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						MID_INTERFACE,
+						STATUS_CHANGED,
+						mid_signal_status_change,
+						NULL, NULL);
+
+	message =3D dbus_message_new_method_call(MID_SERVICE, "/",
+					MID_INTERFACE, MID_RESEND_STATE);
+	if (!message) {
+		ofono_error("Unable to allocate new D-Bus message");
+		goto error;
+	}
+
+	if (dbus_connection_send(connection, message, NULL) =3D=3D FALSE)
+		ofono_error("Sending D-Bus message failed");
+
+error:
+	dbus_message_unref(message);
+}
+
+static void mid_disconnect(DBusConnection *connection, void *user_data)
+{
+	g_hash_table_remove_all(modem_list);
+	g_dbus_remove_watch(connection, mid_state_watch);
+}
+
+static void destroy_stemodem(gpointer data)
+{
+	struct ste_modem *stemodem =3D data;
+
+	ofono_modem_remove(stemodem->modem);
+	g_free(stemodem->path);
+	g_free(stemodem);
+}
+
+static int stemid_init()
+{
+	connection =3D ofono_dbus_get_connection();
+	if (connection =3D=3D NULL)
+		return -EIO;
+
+	modem_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						NULL, destroy_stemodem);
+	mid_api_watch =3D g_dbus_add_service_watch(connection, MID_SERVICE,
+				mid_connect, mid_disconnect, NULL, NULL);
+	return 0;
+}
+
+static void stemid_exit()
+{
+	DBusConnection *connection =3D ofono_dbus_get_connection();
+
+	g_hash_table_destroy(modem_list);
+	g_dbus_remove_watch(connection, mid_api_watch);
+}
+
+OFONO_PLUGIN_DEFINE(stemid, "STE Modem Init Daemon dbus api", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, stemid_init, stemid_exit)
-- =

1.7.0.4


--===============9089052534584056047==--

