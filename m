Content-Type: multipart/mixed; boundary="===============2683595387320009092=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2] tools: add client to receive location reporting
Date: Wed, 23 Feb 2011 16:49:44 -0300
Message-ID: <1298490584-11743-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <AANLkTik3ngLwP18-pMyqSJGcEPx_cGm_RyvQ1kqV0WV4@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2683595387320009092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As of now there's no support for fd-passing in D-Bus Python bindings,
hence a small C client is needed in order to test location-reporting
atom.
---
 Makefile.am          |    5 +-
 tools/get-location.c |  259 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 263 insertions(+), 1 deletions(-)
 create mode 100644 tools/get-location.c

diff --git a/Makefile.am b/Makefile.am
index ca558ea..81c39b1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -553,13 +553,16 @@ unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

 if TOOLS
-noinst_PROGRAMS +=3D tools/huawei-audio tools/auto-enable
+noinst_PROGRAMS +=3D tools/huawei-audio tools/auto-enable tools/get-locati=
on
 =

 tools_huawei_audio_SOURCES =3D $(gdbus_sources) tools/huawei-audio.c
 tools_huawei_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
 =

 tools_auto_enable_SOURCES =3D $(gdbus_sources) tools/auto-enable.c
 tools_auto_enable_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
+
+tools_get_location_SOURCES =3D tools/get-location.c
+tools_get_location_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
 endif
 =

 noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
diff --git a/tools/get-location.c b/tools/get-location.c
new file mode 100644
index 0000000..dafb3c4
--- /dev/null
+++ b/tools/get-location.c
@@ -0,0 +1,259 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Intel Corporation. All rights reserved.
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
+#define OFONO_SERVICE "org.ofono"
+
+#define MANAGER_PATH	"/"
+#define MANAGER_INTERFACE OFONO_SERVICE ".Manager"
+#define LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationReporting"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/signalfd.h>
+#include <unistd.h>
+
+#include <dbus/dbus.h>
+#include <glib.h>
+
+static GMainLoop *event_loop;
+
+static char *get_first_modem_path(DBusConnection *conn)
+{
+	DBusMessage *msg, *reply;
+	DBusMessageIter iter, array, entry;
+	DBusError error;
+	int arg_type;
+	const char *path;
+
+	msg =3D dbus_message_new_method_call(OFONO_SERVICE, MANAGER_PATH,
+						MANAGER_INTERFACE, "GetModems");
+
+	dbus_error_init(&error);
+
+	reply =3D dbus_connection_send_with_reply_and_block(conn, msg, -1,
+									&error);
+
+	dbus_message_unref(msg);
+
+	if (!reply) {
+		if (dbus_error_is_set(&error)) {
+			fprintf(stderr, "%s\n", error.message);
+			dbus_error_free(&error);
+		} else {
+			fprintf(stderr, "GetModems failed");
+		}
+
+
+		return NULL;
+	}
+
+	dbus_message_iter_init(reply, &iter);
+
+	dbus_message_iter_recurse(&iter, &array);
+	dbus_message_iter_recurse(&array, &entry);
+
+	arg_type =3D dbus_message_iter_get_arg_type(&entry);
+	while (arg_type !=3D DBUS_TYPE_INVALID &&
+					arg_type !=3D DBUS_TYPE_OBJECT_PATH) {
+		dbus_message_iter_next(&entry);
+		arg_type =3D dbus_message_iter_get_arg_type(&entry);
+	}
+
+	if (arg_type !=3D DBUS_TYPE_OBJECT_PATH) {
+		fprintf(stderr, "modem not found\n");
+		return NULL;
+	}
+
+	dbus_message_iter_get_basic(&entry, &path);
+	fprintf(stderr, "Using modem: %s\n", path);
+
+	return strdup(path);
+}
+
+static gboolean data_read_cb(GIOChannel *channel, GIOCondition cond,
+								gpointer data)
+{
+	int fd =3D GPOINTER_TO_INT(data);
+	char buf[128];
+	int ret;
+
+	while ((ret =3D read(fd, buf, sizeof(buf) - 1)) >=3D 0) {
+		buf[ret] =3D '\0';
+		printf("%s", buf);
+	}
+
+	if (errno !=3D EAGAIN && errno !=3D EWOULDBLOCK)
+		fprintf(stderr, "Error reading fd");
+
+	return TRUE;
+}
+
+static int setup_data_channel(DBusConnection *conn, const char *path)
+{
+	DBusMessage *msg, *reply;
+	DBusError error;
+	int fd, fd_source;
+	GIOChannel *channel;
+
+	msg =3D dbus_message_new_method_call(OFONO_SERVICE, path,
+				LOCATION_REPORTING_INTERFACE, "Request");
+
+	dbus_error_init(&error);
+
+	reply =3D dbus_connection_send_with_reply_and_block(conn, msg, -1,
+									&error);
+	dbus_message_unref(msg);
+
+	printf("Requesting location-reporting...\n");
+	if (!reply) {
+		if (dbus_error_is_set(&error)) {
+			fprintf(stderr, "%s\n", error.message);
+			dbus_error_free(&error);
+		} else {
+			fprintf(stderr, "Request() failed");
+		}
+
+		return -1;
+	}
+
+	dbus_error_init(&error);
+
+	if (dbus_message_get_args(reply, &error, DBUS_TYPE_UNIX_FD, &fd,
+						DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		fprintf(stderr, "%s\n", error.message);
+		dbus_error_free(&error);
+
+		return -1;
+	}
+
+	printf("Using fd=3D%d\n", fd);
+	fcntl(fd, F_SETFL, O_NONBLOCK);
+
+	channel =3D g_io_channel_unix_new(fd);
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	fd_source =3D g_io_add_watch(channel, G_IO_IN, data_read_cb,
+							GINT_TO_POINTER(fd));
+	g_io_channel_unref(channel);
+
+	return fd_source;
+}
+
+static gboolean signal_cb(GIOChannel *channel, GIOCondition cond, gpointer=
 data)
+{
+	int signal_fd =3D GPOINTER_TO_INT(data);
+	struct signalfd_siginfo si;
+	ssize_t len;
+
+	len =3D read(signal_fd, &si, sizeof(si));
+	g_main_loop_quit(event_loop);
+
+	return TRUE;
+}
+
+static int setup_signals(void)
+{
+	sigset_t mask;
+	int signal_fd, signal_source;
+	GIOChannel *signal_io;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGTERM);
+	sigaddset(&mask, SIGINT);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
+		fprintf(stderr, "Can't set signal mask - %m");
+
+		return -1;
+	}
+
+	signal_fd =3D signalfd(-1, &mask, 0);
+	if (signal_fd < 0) {
+		fprintf(stderr, "Can't create signal filedescriptor - %m");
+
+		return -1;
+	}
+
+	signal_io =3D g_io_channel_unix_new(signal_fd);
+	g_io_channel_set_close_on_unref(signal_io, TRUE);
+	signal_source =3D g_io_add_watch(signal_io,
+			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			signal_cb, GINT_TO_POINTER(signal_fd));
+	g_io_channel_unref(signal_io);
+
+	return signal_source;
+}
+
+int main(int argc, char *argv[])
+{
+	DBusConnection *conn;
+	char *modem_path;
+	int signal_source;
+	int data_source;
+	int ret;
+
+	conn =3D dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (!conn) {
+		fprintf(stderr, "Can't get on system bus\n");
+		exit(1);
+	}
+
+	if (argc > 1)
+		modem_path =3D strdup(argv[1]);
+	else
+		modem_path =3D get_first_modem_path(conn);
+
+	if (modem_path =3D=3D NULL) {
+		ret =3D 1;
+		goto out;
+	}
+
+	signal_source =3D setup_signals();
+	if (signal_source < 0)
+		goto out;
+
+	data_source =3D setup_data_channel(conn, modem_path);
+	if (data_source < 0) {
+		g_source_remove(signal_source);
+		goto out;
+	}
+
+	event_loop =3D g_main_loop_new(NULL, FALSE);
+
+	g_main_loop_run(event_loop);
+
+	ret =3D 0;
+
+	g_source_remove(signal_source);
+	g_source_remove(data_source);
+	g_main_loop_unref(event_loop);
+
+out:
+	if (modem_path)
+		free(modem_path);
+
+	dbus_connection_unref(conn);
+
+	return ret;
+}
-- =

1.7.4.1


--===============2683595387320009092==--

