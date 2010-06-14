Content-Type: multipart/mixed; boundary="===============4466664058998330555=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 7/7] Add prototype for the dun daemon
Date: Mon, 14 Jun 2010 15:04:28 -0300
Message-ID: <1276538668-12755-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1276538668-12755-6-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4466664058998330555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am  |   11 ++++
 configure.ac |    6 ++
 dun/main.c   |  187 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 204 insertions(+), 0 deletions(-)
 create mode 100644 dun/main.c

diff --git a/Makefile.am b/Makefile.am
index b6e4c35..a937ca6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -283,6 +283,17 @@ src_ofonod_DEPENDENCIES =3D src/ofono.ver
 CLEANFILES =3D src/ofono.ver src/ofono.exp src/builtin.h \
 					$(local_headers) $(rules_DATA)
 =

+if DUN
+sbin_PROGRAMS +=3D dun/dund
+
+dun_dund_SOURCES =3D $(gdbus_sources) \
+		   	dun/main.c
+
+dun_dund_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS@ =
-ldl
+
+dun_dund_LDFLAGS =3D -Wl,--export-dynamic -Wl,--version-script=3Dsrc/ofono=
.ver
+endif
+
 plugindir =3D $(libdir)/ofono/plugins
 =

 if MAINTAINER_MODE
diff --git a/configure.ac b/configure.ac
index b6a7d2e..2c9cf0f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -151,6 +151,12 @@ AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-dat=
afiles],
 =

 AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" !=3D "no")
 =

+AC_ARG_ENABLE(dun, AC_HELP_STRING([--enable-dun],
+			[enable the Bluetooth DUN daemon]),
+					[enable_dun=3D${enableval}])
+
+AM_CONDITIONAL(DUN, test "${enable_dun}" !=3D "no")
+
 if (test "${prefix}" =3D "NONE"); then
 	dnl no prefix and no localstatedir, so default to /var
 	if (test "$localstatedir" =3D '${prefix}/var'); then
diff --git a/dun/main.c b/dun/main.c
new file mode 100644
index 0000000..d79b73b
--- /dev/null
+++ b/dun/main.c
@@ -0,0 +1,187 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 Gustavo F. Padovan <gustavo@padovan.org>
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
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/signalfd.h>
+
+#include <gdbus.h>
+
+#include "ofono.h"
+
+static GMainLoop *event_loop;
+
+static gboolean signal_cb(GIOChannel *channel, GIOCondition cond, gpointer=
 data)
+{
+	if (cond & (G_IO_NVAL | G_IO_ERR))
+		return FALSE;
+
+	g_main_loop_quit(event_loop);
+
+	return TRUE;
+}
+
+static void system_bus_disconnected(DBusConnection *conn, void *user_data)
+{
+	fprintf(stderr, "System bus has disconnected!");
+
+	g_main_loop_quit(event_loop);
+}
+
+static gboolean option_detach =3D TRUE;
+static gboolean option_version =3D FALSE;
+
+static GOptionEntry options[] =3D {
+	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
+				G_OPTION_ARG_NONE, &option_detach,
+				"Don't run as daemon in background" },
+	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
+				"Show version information and exit" },
+	{ NULL },
+};
+
+int main(int argc, char **argv)
+{
+	GOptionContext *context;
+	GError *err =3D NULL;
+	sigset_t mask;
+	DBusConnection *conn;
+	DBusError error;
+	int signal_fd;
+	GIOChannel *signal_io;
+	int signal_source;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGTERM);
+	sigaddset(&mask, SIGINT);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
+		perror("Can't set signal mask");
+		return 1;
+	}
+
+	signal_fd =3D signalfd(-1, &mask, 0);
+	if (signal_fd < 0) {
+		perror("Can't create signal filedescriptor");
+		return 1;
+	}
+
+	signal_io =3D g_io_channel_unix_new(signal_fd);
+	g_io_channel_set_close_on_unref(signal_io, TRUE);
+	signal_source =3D g_io_add_watch(signal_io,
+			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			signal_cb, GINT_TO_POINTER(signal_fd));
+	g_io_channel_unref(signal_io);
+
+#ifdef NEED_THREADS
+	if (g_thread_supported() =3D=3D FALSE)
+		g_thread_init(NULL);
+#endif
+
+	context =3D g_option_context_new(NULL);
+	g_option_context_add_main_entries(context, options, NULL);
+
+	if (g_option_context_parse(context, &argc, &argv, &err) =3D=3D FALSE) {
+		if (err !=3D NULL) {
+			g_printerr("%s\n", err->message);
+			g_error_free(err);
+			return 1;
+		}
+
+		g_printerr("An unknown error occurred\n");
+		return 1;
+	}
+
+	g_option_context_free(context);
+
+	if (option_version =3D=3D TRUE) {
+		printf("%s\n", VERSION);
+		exit(0);
+	}
+
+	if (option_detach =3D=3D TRUE) {
+		if (daemon(0, 0)) {
+			perror("Can't start daemon");
+			return 1;
+		}
+	}
+
+	event_loop =3D g_main_loop_new(NULL, FALSE);
+
+#ifdef NEED_THREADS
+	if (dbus_threads_init_default() =3D=3D FALSE) {
+		fprintf(stderr, "Can't init usage of threads\n");
+		exit(1);
+	}
+#endif
+
+	//__ofono_log_init(option_debug, option_detach);
+
+	dbus_error_init(&error);
+
+	//D-Bus: change bus name
+	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, OFONO_SERVICE, &error);
+	if (!conn) {
+		if (dbus_error_is_set(&error) =3D=3D TRUE) {
+			fprintf(stderr, "Unable to hop onto D-Bus: %s",
+					error.message);
+			dbus_error_free(&error);
+		} else {
+			fprintf(stderr, "Unable to hop onto D-Bus");
+		}
+
+		goto cleanup;
+	}
+
+	g_dbus_set_disconnect_function(conn, system_bus_disconnected,
+					NULL, NULL);
+
+	//__ofono_dbus_init(conn);
+
+	//__ofono_manager_init();
+
+	//__ofono_plugin_init(NULL, NULL);
+
+	g_main_loop_run(event_loop);
+
+	//__ofono_plugin_cleanup();
+
+	//__ofono_manager_cleanup();
+
+	//__ofono_dbus_cleanup();
+	dbus_connection_unref(conn);
+
+cleanup:
+	g_source_remove(signal_source);
+	g_main_loop_unref(event_loop);
+
+	//__ofono_log_cleanup();
+
+	return 0;
+}
-- =

1.7.1


--===============4466664058998330555==--

