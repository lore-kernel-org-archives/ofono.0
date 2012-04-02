Content-Type: multipart/mixed; boundary="===============7256325525748472117=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v6 04/16] dundee: Add skeleton implementation
Date: Mon, 02 Apr 2012 18:20:02 +0200
Message-ID: <1333383614-4921-5-git-send-email-wagi@monom.org>
In-Reply-To: <1333383614-4921-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7256325525748472117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am         |   12 +++
 bootstrap-configure |    1 +
 configure.ac        |    4 +
 dundee/dundee.h     |   46 ++++++++++
 dundee/main.c       |  255 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 318 insertions(+)
 create mode 100644 dundee/dundee.h
 create mode 100644 dundee/main.c

diff --git a/Makefile.am b/Makefile.am
index af3c5a2..36ad8e0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -667,6 +667,18 @@ tools_lookup_provider_name_SOURCES =3D plugins/mbpi.c =
plugins/mbpi.h \
 tools_lookup_provider_name_LDADD =3D @GLIB_LIBS@
 endif
 =

+if DUNDEE
+
+sbin_PROGRAMS +=3D dundee/dundee
+
+dundee_dundee_SOURCES =3D $(gdbus_sources) \
+			src/log.c src/dbus.c \
+			dundee/dundee.h dundee/main.c
+
+dundee_dundee_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_L=
IBS@ -ldl
+
+endif
+
 noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
 =

 gatchat_gsmdial_SOURCES =3D gatchat/gsmdial.c $(gatchat_sources)
diff --git a/bootstrap-configure b/bootstrap-configure
index db70c66..1fae158 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -14,4 +14,5 @@ fi
 		--localstatedir=3D/var \
 		--enable-capng \
 		--enable-tools \
+		--enable-dundee \
 		--disable-datafiles $*
diff --git a/configure.ac b/configure.ac
index 5ed78ea..1e21cc4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -165,6 +165,10 @@ if (test "${enable_tools}" =3D "yes"); then
 fi
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" =3D "yes")
 =

+AC_ARG_ENABLE(dundee, AC_HELP_STRING([--enable-dundee],
+		[enable DUN deamon support]), [enable_dundee=3D${enableval}])
+AM_CONDITIONAL(DUNDEE, test "${enable_dundee}" =3D "yes")
+
 AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atmodem],
 				[disable ETSI AT modem support]),
 					[enable_atmodem=3D${enableval}])
diff --git a/dundee/dundee.h b/dundee/dundee.h
new file mode 100644
index 0000000..83d8969
--- /dev/null
+++ b/dundee/dundee.h
@@ -0,0 +1,46 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  BMW Car IT GmbH. All rights reserved.
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
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+
+#include <ofono/types.h>
+
+void __dundee_exit(void);
+
+#include <ofono/log.h>
+
+int __ofono_log_init(const char *program, const char *debug,
+					ofono_bool_t detach);
+void __ofono_log_cleanup(void);
+void __ofono_log_enable(struct ofono_debug_desc *start,
+					struct ofono_debug_desc *stop);
+
+#include <ofono/dbus.h>
+
+#define DUNDEE_SERVICE			"org.ofono.dundee"
+
+int __ofono_dbus_init(DBusConnection *conn);
+void __ofono_dbus_cleanup(void);
+
+void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
diff --git a/dundee/main.c b/dundee/main.c
new file mode 100644
index 0000000..0bee690
--- /dev/null
+++ b/dundee/main.c
@@ -0,0 +1,255 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  BMW Car IT GmbH. All rights reserved.
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/signalfd.h>
+
+#include <gdbus.h>
+
+#ifdef HAVE_CAPNG
+#include <cap-ng.h>
+#endif
+
+#include "dundee.h"
+
+#define SHUTDOWN_GRACE_SECONDS 10
+
+static GMainLoop *event_loop;
+
+void __dundee_exit(void)
+{
+	g_main_loop_quit(event_loop);
+}
+
+static gboolean quit_eventloop(gpointer user_data)
+{
+	__dundee_exit();
+	return FALSE;
+}
+
+static unsigned int __terminated =3D 0;
+
+static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct signalfd_siginfo si;
+	ssize_t result;
+	int fd;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
+	fd =3D g_io_channel_unix_get_fd(channel);
+
+	result =3D read(fd, &si, sizeof(si));
+	if (result !=3D sizeof(si))
+		return FALSE;
+
+	switch (si.ssi_signo) {
+	case SIGINT:
+	case SIGTERM:
+		if (__terminated =3D=3D 0) {
+			ofono_info("Terminating");
+			g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
+						quit_eventloop, NULL);
+
+			quit_eventloop(NULL);
+		}
+
+		__terminated =3D 1;
+		break;
+	}
+
+	return TRUE;
+}
+
+static guint setup_signalfd(void)
+{
+	GIOChannel *channel;
+	guint source;
+	sigset_t mask;
+	int fd;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
+		perror("Failed to set signal mask");
+		return 0;
+	}
+
+	fd =3D signalfd(-1, &mask, 0);
+	if (fd < 0) {
+		perror("Failed to create signal descriptor");
+		return 0;
+	}
+
+	channel =3D g_io_channel_unix_new(fd);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	source =3D g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				signal_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
+}
+
+static void system_bus_disconnected(DBusConnection *conn, void *user_data)
+{
+	ofono_error("System bus has disconnected!");
+
+	g_main_loop_quit(event_loop);
+}
+
+static gchar *option_debug =3D NULL;
+static gboolean option_detach =3D TRUE;
+static gboolean option_version =3D FALSE;
+
+static gboolean parse_debug(const char *key, const char *value,
+					gpointer user_data, GError **error)
+{
+	if (value)
+		option_debug =3D g_strdup(value);
+	else
+		option_debug =3D g_strdup("*");
+
+	return TRUE;
+}
+
+static GOptionEntry options[] =3D {
+	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
+				G_OPTION_ARG_CALLBACK, parse_debug,
+				"Specify debug options to enable", "DEBUG" },
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
+	DBusConnection *conn;
+	DBusError error;
+	guint signal;
+
+#ifdef HAVE_CAPNG
+	/* Drop capabilities */
+	capng_clear(CAPNG_SELECT_BOTH);
+	capng_updatev(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
+				CAP_NET_BIND_SERVICE, CAP_NET_ADMIN,
+				CAP_NET_RAW, CAP_SYS_ADMIN, -1);
+	capng_apply(CAPNG_SELECT_BOTH);
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
+	signal =3D setup_signalfd();
+
+	__ofono_log_init(argv[0], option_debug, option_detach);
+
+	dbus_error_init(&error);
+
+	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, DUNDEE_SERVICE, &error);
+	if (conn =3D=3D NULL) {
+		if (dbus_error_is_set(&error) =3D=3D TRUE) {
+			ofono_error("Unable to hop onto D-Bus: %s",
+					error.message);
+			dbus_error_free(&error);
+		} else {
+			ofono_error("Unable to hop onto D-Bus");
+		}
+
+		goto cleanup;
+	}
+
+	g_dbus_set_disconnect_function(conn, system_bus_disconnected,
+					NULL, NULL);
+
+	__ofono_dbus_init(conn);
+
+	/*
+	 * The reason why this DBG is here is that we have the __stop__debug,
+	 * __start__debug linking symbols in the object. As soon we
+	 * have real DBG we can remove this one again.
+	 */
+	DBG("");
+
+	g_main_loop_run(event_loop);
+
+	__ofono_dbus_cleanup();
+	dbus_connection_unref(conn);
+
+cleanup:
+	g_source_remove(signal);
+
+	g_main_loop_unref(event_loop);
+
+	__ofono_log_cleanup();
+
+	return 0;
+}
-- =

1.7.10.rc3.1.gb3065


--===============7256325525748472117==--

