Content-Type: multipart/mixed; boundary="===============8312465699543015430=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 12/16] emulator: Add test case for ofono emulator
Date: Thu, 13 May 2010 18:02:35 +0800
Message-ID: <1273744959-3711-13-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-12-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8312465699543015430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am             |    6 +-
 gatchat/test-emulator.c |  616 +++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 621 insertions(+), 1 deletions(-)
 create mode 100644 gatchat/test-emulator.c

diff --git a/Makefile.am b/Makefile.am
index 707c622..12cdd3e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -383,7 +383,8 @@ unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_s=
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
@@ -394,6 +395,9 @@ gatchat_test_server_LDADD =3D @GLIB_LIBS@ -lutil
 gatchat_test_qcdm_SOURCES =3D gatchat/test-qcdm.c $(gatchat_sources)
 gatchat_test_qcdm_LDADD =3D @GLIB_LIBS@
 =

+gatchat_test_emulator_SOURCES =3D gatchat/test-emulator.c $(gatchat_source=
s) \
+					$(gdbus_sources)
+gatchat_test_emulator_LDADD =3D @GLIB_LIBS@ -lutil -ldbus-1
 =

 DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles
 =

diff --git a/gatchat/test-emulator.c b/gatchat/test-emulator.c
new file mode 100644
index 0000000..96a248e
--- /dev/null
+++ b/gatchat/test-emulator.c
@@ -0,0 +1,616 @@
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
+#define OFONO_EMULATOR_MANAGER_INTERFACE "org.ofono.EmulatorManager"
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
+static char *modem_path;
+static unsigned int server_watch;
+static unsigned int emulator_manager_watch;
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
+	g_dbus_remove_watch(connection, emulator_manager_watch);
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
+static void create_emulator_cb(DBusMessage *reply, gpointer user_data)
+{
+	DBusError derr;
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		g_print("Create reply: %s\n", derr.message);
+		dbus_error_free(&derr);
+	}
+
+	dbus_message_unref(reply);
+}
+
+static void create_emulator(int fd)
+{
+	if (!connection || !modem_path || !emulator)
+		return;
+
+	g_print("Create %s emulator on %s fd %d\n", emulator,
+					modem_path, fd);
+
+	send_method_call_with_block(OFONO_SERVICE, modem_path,
+					OFONO_EMULATOR_MANAGER_INTERFACE,
+					"Create", create_emulator_cb,
+					NULL, DBUS_TYPE_STRING, &emulator,
+					DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_INVALID);
+}
+
+static void set_raw_mode(int fd)
+{
+	struct termios options;
+
+	tcgetattr(fd, &options);
+
+	/* Set TTY as raw mode to disable echo back of input characters
+	 * when they are received from Modem to avoid feedback loop */
+	options.c_lflag &=3D ~(ICANON | ECHO | ECHOE | ISIG);
+
+	tcsetattr(fd, TCSANOW, &options);
+}
+
+static gboolean create_tty(const char *modem_path)
+{
+	int master, slave;
+	char pty_name[256];
+
+	if (!modem_path)
+		return FALSE;
+
+	if (openpty(&master, &slave, pty_name, NULL, NULL) < 0)
+		return FALSE;
+
+	set_raw_mode(slave);
+
+	g_print("new pty is created@%s\n", pty_name);
+
+	create_emulator(master);
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
+	create_emulator(fd);
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
+static gboolean create_tcp(const char *modem_path, int port)
+{
+	struct sockaddr_in addr;
+	int sk;
+	struct sock_server *server;
+	GIOChannel *server_io;
+
+	if (!modem_path)
+		return FALSE;
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
+static gboolean create_unix(const char *modem_path, const char *sock_path)
+{
+	struct sockaddr_un addr;
+	int sk;
+	struct sock_server *server;
+	GIOChannel *server_io;
+
+	if (!modem_path)
+		return FALSE;
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
+		if (create_tty("/phonesim1") =3D=3D FALSE)
+			return FALSE;
+		break;
+	case 1:
+		if (create_tcp("/phonesim1", DEFAULT_TCP_PORT) =3D=3D FALSE)
+			return FALSE;
+		break;
+	case 2:
+		if (create_unix("/phonesim1", DEFAULT_SOCK_PATH) =3D=3D FALSE)
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
+	g_print("test-emulator - Emulator manager testing\n"
+		"Usage:\n");
+	g_print("\ttest-emulator [-t type] [-e emulator] \n");
+	g_print("Types:\n"
+		"\t0: Pseudo TTY port (default)\n"
+		"\t1: TCP sock at port 12346)\n"
+		"\t2: Unix sock@./server_sock\n\n"
+		"Emulators:\n"
+		"\tDUN: Dial-up Network (default)\n"
+		"\tHFP AG: Hands-free Profile\n"
+		"\tSPP: Serial Port Profile\n");
+}
+
+static void get_properties_cb(DBusMessage *reply, gpointer user_data)
+{
+	DBusError err;
+	DBusMessageIter iter, iter_entry, iter_property, iter_arrary, sub;
+	char *property, *modem_obj_path_local;
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
+
+		dbus_message_iter_get_basic(&sub, &modem_obj_path_local);
+		modem_path =3D g_strdup(modem_obj_path_local);
+		if (modem_path)
+			break;
+		dbus_message_iter_next(&sub);
+	}
+
+done:
+	dbus_message_unref(reply);
+}
+
+static gboolean emulator_manager_property_changed(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter, sub, array;
+	const char *property, *emu_obj_path;
+	GSList *emu_list =3D NULL;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING) {
+		g_print("Unexpected signature in emulator manager"
+					" PropertyChanged signal");
+		return TRUE;
+	}
+
+	dbus_message_iter_get_basic(&iter, &property);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &sub);
+	if (dbus_message_iter_get_arg_type(&sub) !=3D DBUS_TYPE_ARRAY) {
+		g_print("Unexpected signature in emulator manager"
+					" PropertyChanged signal");
+		return TRUE;
+	}
+	dbus_message_iter_recurse(&sub, &array);
+	while (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_INVALID) {
+		dbus_message_iter_get_basic(&array, &emu_obj_path);
+		if (emu_obj_path) {
+			g_print("Emulator path %s\n", emu_obj_path);
+			emu_list =3D g_slist_prepend(emu_list,
+							g_strdup(emu_obj_path));
+		}
+		dbus_message_iter_next(&array);
+	}
+
+	if (g_slist_length(emu_list) =3D=3D 0) {
+		g_print("All emulators destroyed. Quit.\n");
+		g_slist_free(emu_list);
+		server_cleanup();
+
+		return TRUE;
+	}
+
+	g_slist_foreach(emu_list, (GFunc) g_free, NULL);
+	g_slist_free(emu_list);
+
+	return TRUE;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, signal_source;
+	int type =3D 0;
+	DBusError error;
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
+	emulator_manager_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+					OFONO_EMULATOR_MANAGER_INTERFACE,
+					"PropertyChanged",
+					emulator_manager_property_changed,
+					NULL, NULL);
+	if (!emulator_manager_watch)
+		exit(1);
+
+	send_method_call_with_block(OFONO_SERVICE, "/", OFONO_MANAGER_INTERFACE,
+					"GetProperties", get_properties_cb,
+					NULL, DBUS_TYPE_INVALID);
+
+	if (!test_emulator(type)) {
+		g_free(modem_path);
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


--===============8312465699543015430==--

