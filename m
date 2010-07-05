Content-Type: multipart/mixed; boundary="===============7387391161881476677=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 5/6] emulator: Add test case for ofono emulator
Date: Mon, 05 Jul 2010 13:45:08 +0800
Message-ID: <1278308709-13908-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278308709-13908-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7387391161881476677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add gatchat/test-emulator to test DUN emulator.
1. Start ofonod and power on phonesim modem.
2. Run gatchat/test-emulator. It could find dun emulator and create pty
terminal. Use minicom to talk to the DUN emulator.
---
 Makefile.am             |    7 +-
 gatchat/test-emulator.c |  654 +++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 660 insertions(+), 1 deletions(-)
 create mode 100644 gatchat/test-emulator.c

diff --git a/Makefile.am b/Makefile.am
index 908e945..b5e53a9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -405,7 +405,8 @@ unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_s=
ources) \
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

-noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
+noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm=
 \
+					gatchat/test-emulator
 =

 gatchat_gsmdial_SOURCES =3D gatchat/gsmdial.c $(gatchat_sources)
 gatchat_gsmdial_LDADD =3D @GLIB_LIBS@
@@ -416,6 +417,10 @@ gatchat_test_server_LDADD =3D @GLIB_LIBS@ -lutil
 gatchat_test_qcdm_SOURCES =3D gatchat/test-qcdm.c $(gatchat_sources)
 gatchat_test_qcdm_LDADD =3D @GLIB_LIBS@
 =

+gatchat_test_emulator_SOURCES =3D gatchat/test-emulator.c $(gatchat_source=
s) \
+					$(gdbus_sources)
+gatchat_test_emulator_LDADD =3D @GLIB_LIBS@ -lutil -ldbus-1
+
 =

 DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles
 =

diff --git a/gatchat/test-emulator.c b/gatchat/test-emulator.c
new file mode 100644
index 0000000..562d9e2
--- /dev/null
+++ b/gatchat/test-emulator.c
@@ -0,0 +1,654 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#include <unistd.h>
+#include <stdio.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <signal.h>
+#include <sys/signalfd.h>
+
+#include <gdbus.h>
+#include <glib.h>
+#include <utmp.h>
+#include <pty.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include "gatserver.h"
+
+#define OFONO_SERVICE "org.ofono"
+#define OFONO_MANAGER_INTERFACE "org.ofono.Manager"
+#define OFONO_MODEM_INTERFACE "org.ofono.Modem"
+#define OFONO_GPRS_INTERFACE "org.ofono.DataConnectionManager"
+#define OFONO_EMULATOR_INTERFACE "org.ofono.Emulator"
+
+#define DEFAULT_TCP_PORT 12346
+#define DEFAULT_SOCK_PATH "./server_sock"
+
+struct sock_server{
+	int server_sock;
+};
+
+static GMainLoop *mainloop;
+static DBusConnection *connection;
+static GSList *modem_list;
+static char *modem_path;
+static unsigned int server_watch;
+const char *emulator =3D "DUN";
+
+typedef void (*DBusNotifyFunction) (DBusMessage *message, void *user_data);
+
+static gboolean send_method_call_with_block(const char *dest, const char *=
path,
+				const char *interface, const char *method,
+				DBusNotifyFunction cb,
+				void *user_data, int type, ...)
+{
+	DBusMessage *msg, *reply;
+	DBusError err;
+	va_list args;
+
+	msg =3D dbus_message_new_method_call(dest, path, interface, method);
+	if (!msg) {
+		g_print("Unable to allocate new D-Bus %s message\n", method);
+		return FALSE;
+	}
+
+	va_start(args, type);
+
+	if (!dbus_message_append_args_valist(msg, type, args)) {
+		dbus_message_unref(msg);
+		va_end(args);
+		return FALSE;
+	}
+
+	va_end(args);
+
+	dbus_error_init(&err);
+	reply =3D dbus_connection_send_with_reply_and_block(connection, msg, 100,
+								&err);
+	if (!reply) {
+		dbus_message_unref(msg);
+		g_print("ofono replied with an error: %s, %s\n",
+					err.name, err.message);
+		dbus_error_free(&err);
+		return FALSE;
+	}
+
+	cb(reply, user_data);
+
+	dbus_message_unref(msg);
+
+	return TRUE;
+}
+
+static gboolean server_cleanup()
+{
+	if (server_watch)
+		g_source_remove(server_watch);
+
+	g_free(modem_path);
+
+	if (modem_list) {
+		g_slist_foreach(modem_list, (GFunc)g_free, NULL);
+		g_slist_free(modem_list);
+	}
+
+	dbus_connection_unref(connection);
+
+	unlink(DEFAULT_SOCK_PATH);
+
+	g_main_loop_quit(mainloop);
+
+	return FALSE;
+}
+
+static void server_destroy(gpointer user)
+{
+	struct sock_server *data =3D user;
+
+	g_free(data);
+}
+
+static void enable_emulator_cb(DBusMessage *reply, gpointer user_data)
+{
+	DBusError derr;
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		g_print("Failed to create emulator: %s\n", derr.message);
+		dbus_error_free(&derr);
+	}
+
+	dbus_message_unref(reply);
+}
+
+static void enable_emulator(int fd)
+{
+	char path[256];
+
+	if (!connection || !modem_path || !emulator)
+		return;
+
+	g_print("Enable %s emulator on %s\n", emulator, modem_path);
+
+	snprintf(path, sizeof(path), "%s/dun_emulator", modem_path);
+
+	send_method_call_with_block(OFONO_SERVICE, path,
+					OFONO_EMULATOR_INTERFACE,
+					"Enable", enable_emulator_cb,
+					NULL, DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_INVALID);
+}
+
+static void set_raw_mode(int fd)
+{
+	struct termios ti;
+
+	tcflush(fd, TCIOFLUSH);
+
+	memset(&ti, 0, sizeof(ti));
+	tcgetattr(fd, &ti);
+	cfmakeraw(&ti);
+	tcsetattr(fd, TCSANOW, &ti);
+}
+
+static gboolean create_tty()
+{
+	int master, slave;
+	char pty_name[256];
+
+	if (openpty(&master, &slave, pty_name, NULL, NULL) < 0)
+		return FALSE;
+
+	set_raw_mode(slave);
+
+	g_print("new pty is created@%s\n", pty_name);
+
+	enable_emulator(master);
+
+	close(master);
+
+	return TRUE;
+}
+
+static gboolean on_socket_connected(GIOChannel *chan, GIOCondition cond,
+							gpointer user)
+{
+	struct sockaddr saddr;
+	unsigned int len =3D sizeof(saddr);
+	int fd;
+	struct sock_server *data =3D user;
+
+	if (cond !=3D G_IO_IN)
+		goto error;
+
+	fd =3D accept(data->server_sock, &saddr, &len);
+	if (fd =3D=3D -1)
+		goto error;
+
+	enable_emulator(fd);
+
+	close(fd);
+
+	return TRUE;
+
+error:
+	g_free(data);
+
+	return FALSE;
+}
+
+static struct sock_server *socket_common(int sk, struct sockaddr *addr,
+						const char *modem_path)
+{
+	struct sock_server *sock;
+	int reuseaddr =3D 1;
+
+	setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &reuseaddr, sizeof(reuseaddr));
+
+	if (bind(sk, addr, sizeof(struct sockaddr)) < 0) {
+		g_print("Can't bind socket: %s (%d)", strerror(errno), errno);
+
+		close(sk);
+
+		return NULL;
+	}
+
+	if (listen(sk, 1) < 0) {
+		g_print("Can't listen on socket: %s (%d)",
+						strerror(errno), errno);
+
+		close(sk);
+
+		return NULL;
+	}
+
+	sock =3D g_try_new0(struct sock_server, 1);
+	if (!sock)
+		return FALSE;
+
+	sock->server_sock =3D sk;
+
+	return sock;
+}
+
+static gboolean create_tcp(int port)
+{
+	struct sockaddr_in addr;
+	int sk;
+	struct sock_server *server;
+	GIOChannel *server_io;
+
+	sk =3D socket(PF_INET, SOCK_STREAM, 0);
+	if (sk < 0) {
+		g_print("Can't create tcp/ip socket: %s (%d)\n",
+						strerror(errno), errno);
+		return FALSE;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+
+	addr.sin_family =3D AF_INET;
+	addr.sin_addr.s_addr =3D INADDR_ANY;
+	addr.sin_port =3D htons(port);
+
+	server =3D socket_common(sk, (struct sockaddr *) &addr, modem_path);
+	if (!server)
+		return FALSE;
+
+	g_print("new tcp is created at tcp port %d\n", port);
+
+	server_io =3D g_io_channel_unix_new(sk);
+
+	g_io_channel_set_close_on_unref(server_io, TRUE);
+
+	server_watch =3D g_io_add_watch_full(server_io,
+				G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				on_socket_connected, server, server_destroy);
+
+	g_io_channel_unref(server_io);
+
+	return TRUE;
+}
+
+static gboolean create_unix(const char *sock_path)
+{
+	struct sockaddr_un addr;
+	int sk;
+	struct sock_server *server;
+	GIOChannel *server_io;
+
+	sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
+	if (sk < 0) {
+		g_print("Can't create unix socket: %s (%d)\n",
+						strerror(errno), errno);
+
+		return FALSE;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+
+	addr.sun_family =3D AF_UNIX;
+	strncpy(addr.sun_path, sock_path, sizeof(addr.sun_path) - 1);
+
+	/* Unlink any existing socket for this session */
+	unlink(addr.sun_path);
+
+	server =3D socket_common(sk, (struct sockaddr *) &addr, modem_path);
+	if (!server)
+		return FALSE;
+
+	g_print("new unix socket is created at %s\n", sock_path);
+
+	server_io =3D g_io_channel_unix_new(sk);
+
+	g_io_channel_set_close_on_unref(server_io, TRUE);
+
+	server_watch =3D g_io_add_watch_full(server_io,
+				G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				on_socket_connected, server, server_destroy);
+
+	g_io_channel_unref(server_io);
+
+	return TRUE;
+}
+
+static gboolean test_emulator(int type)
+{
+	if (!connection || !modem_path || !emulator)
+		return FALSE;
+
+	switch (type) {
+	case 0:
+		if (create_tty() =3D=3D FALSE)
+			return FALSE;
+		break;
+	case 1:
+		if (create_tcp(DEFAULT_TCP_PORT) =3D=3D FALSE)
+			return FALSE;
+		break;
+	case 2:
+		if (create_unix(DEFAULT_SOCK_PATH) =3D=3D FALSE)
+			return FALSE;
+		break;
+	}
+
+	return TRUE;
+}
+
+static gboolean signal_cb(GIOChannel *channel, GIOCondition cond, gpointer=
 data)
+{
+	int signal_fd =3D GPOINTER_TO_INT(data);
+	struct signalfd_siginfo si;
+	ssize_t res;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR))
+		return FALSE;
+
+	res =3D read(signal_fd, &si, sizeof(si));
+	if (res !=3D sizeof(si))
+		return FALSE;
+
+	switch (si.ssi_signo) {
+	case SIGINT:
+		server_cleanup();
+		break;
+	case SIGTERM:
+		server_cleanup();
+		break;
+	default:
+		break;
+	}
+
+	return TRUE;
+}
+
+static int create_signal_io()
+{
+	sigset_t mask;
+	GIOChannel *signal_io;
+	int signal_fd, signal_source;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGTERM);
+	sigaddset(&mask, SIGINT);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
+		g_error("Can't set signal mask");
+		return 1;
+	}
+
+	signal_fd =3D signalfd(-1, &mask, 0);
+	if (signal_fd < 0) {
+		g_error("Can't create signal filedescriptor");
+		return 1;
+	}
+
+	signal_io =3D g_io_channel_unix_new(signal_fd);
+
+	g_io_channel_set_close_on_unref(signal_io, TRUE);
+
+	signal_source =3D g_io_add_watch(signal_io,
+			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			signal_cb, GINT_TO_POINTER(signal_fd));
+
+	g_io_channel_unref(signal_io);
+
+	return signal_source;
+}
+
+static void usage(void)
+{
+	g_print("test-emulator - oFono emulator testing\n"
+		"Usage:\n");
+	g_print("\ttest-emulator [-t type] [-e emulator] \n");
+	g_print("Types:\n"
+		"\t0: Pseudo TTY port (default)\n"
+		"\t1: TCP sock at port 12346)\n"
+		"\t2: Unix sock@./server_sock\n\n"
+		"Emulators:\n"
+		"\tDUN: Dial-up Network (default)\n");
+}
+
+static gboolean modem_has_gprs(DBusMessageIter *array)
+{
+	DBusMessageIter entry;
+
+	dbus_message_iter_recurse(array, &entry);
+
+	while (dbus_message_iter_get_arg_type(&entry) =3D=3D DBUS_TYPE_STRING) {
+		const char *interface;
+
+		dbus_message_iter_get_basic(&entry, &interface);
+
+		if (g_strcmp0(OFONO_GPRS_INTERFACE, interface) =3D=3D 0)
+			return TRUE;
+
+		dbus_message_iter_next(&entry);
+	}
+
+	return FALSE;
+}
+
+static void get_modem_properties_cb(DBusMessage *reply, gpointer user_data)
+{
+	DBusError err;
+	DBusMessageIter array, dict;
+	const char *path =3D user_data;
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		g_print("ofono replied with an error: %s, %s\n",
+				err.name, err.message);
+		dbus_error_free(&err);
+		goto done;
+	}
+
+	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
+		goto done;
+
+	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
+		goto done;
+
+	dbus_message_iter_recurse(&array, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTRY)=
 {
+		DBusMessageIter entry, value;
+		const char *key;
+		dbus_bool_t powered;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (g_str_equal(key, "Powered") =3D=3D TRUE) {
+			dbus_message_iter_get_basic(&value, &powered);
+
+			if (powered =3D=3D FALSE)
+				goto done;
+		}
+
+		if (g_str_equal(key, "Interfaces") =3D=3D TRUE) {
+			if (modem_has_gprs(&value) =3D=3D TRUE) {
+				modem_path =3D g_strdup(path);
+				goto done;
+			}
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void get_modem_properties(const char *path)
+{
+
+	if (path =3D=3D NULL)
+		return;
+
+	send_method_call_with_block(OFONO_SERVICE, path, OFONO_MODEM_INTERFACE,
+					"GetProperties",
+					get_modem_properties_cb,
+					(void *)path, DBUS_TYPE_INVALID);
+}
+
+static void get_properties_cb(DBusMessage *reply, gpointer user_data)
+{
+	DBusError err;
+	DBusMessageIter iter, iter_entry, iter_property, iter_arrary, sub;
+	char *property;
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		g_print("ofono replied with an error: %s, %s\n",
+				err.name, err.message);
+		dbus_error_free(&err);
+		goto done;
+	}
+
+	dbus_message_iter_init(reply, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_ARRAY) {
+		g_print("Unexpected signature in ListModems return\n");
+		goto done;
+	}
+
+	dbus_message_iter_recurse(&iter, &iter_entry);
+
+	if (dbus_message_iter_get_arg_type(&iter_entry)
+					!=3D DBUS_TYPE_DICT_ENTRY) {
+		g_print("Unexpected signature in ListModems return 2, %c\n",
+				dbus_message_iter_get_arg_type(&iter_entry));
+		goto done;
+	}
+
+	dbus_message_iter_recurse(&iter_entry, &iter_property);
+
+	dbus_message_iter_get_basic(&iter_property, &property);
+
+	dbus_message_iter_next(&iter_property);
+	dbus_message_iter_recurse(&iter_property, &iter_arrary);
+	dbus_message_iter_recurse(&iter_arrary, &sub);
+	while (dbus_message_iter_get_arg_type(&sub) !=3D DBUS_TYPE_INVALID) {
+		const char *path;
+
+		dbus_message_iter_get_basic(&sub, &path);
+		dbus_message_iter_next(&sub);
+
+		modem_list =3D g_slist_prepend(modem_list, g_strdup(path));
+	}
+
+done:
+	dbus_message_unref(reply);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, signal_source;
+	int type =3D 0;
+	DBusError error;
+	GSList *l;
+
+	while ((opt =3D getopt(argc, argv, "ht:e:")) !=3D EOF) {
+		switch (opt) {
+		case 't':
+			type =3D atoi(optarg);
+			break;
+		case 'e':
+			emulator =3D optarg;
+			break;
+		case 'h':
+			usage();
+			exit(1);
+			break;
+		default:
+			break;
+		}
+	}
+
+	dbus_error_init(&error);
+
+	connection =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &error);
+	if (!connection) {
+		if (dbus_error_is_set(&error) =3D=3D TRUE) {
+			g_print("Unable to hop onto D-Bus: %s\n",
+						error.message);
+			dbus_error_free(&error);
+		} else {
+			g_print("Unable to hop onto D-Bus\n");
+		}
+
+		return -1;
+	}
+
+	send_method_call_with_block(OFONO_SERVICE, "/", OFONO_MANAGER_INTERFACE,
+					"GetProperties", get_properties_cb,
+					NULL, DBUS_TYPE_INVALID);
+
+	for (l =3D modem_list; l; l =3D l->next) {
+		const char *path =3D l->data;
+
+		get_modem_properties(path);
+	}
+
+	if (!test_emulator(type)) {
+		if (modem_list) {
+			g_slist_foreach(modem_list, (GFunc)g_free, NULL);
+			g_slist_free(modem_list);
+		}
+
+		g_free(modem_path);
+		dbus_connection_unref(connection);
+
+		exit(1);
+	}
+
+	signal_source =3D create_signal_io();
+
+	mainloop =3D g_main_loop_new(NULL, FALSE);
+
+	g_main_loop_run(mainloop);
+
+	g_main_loop_unref(mainloop);
+
+	g_source_remove(signal_source);
+
+	return 0;
+}
-- =

1.6.3.3


--===============7387391161881476677==--

