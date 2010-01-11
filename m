Content-Type: multipart/mixed; boundary="===============3394502675016532758=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/4] Add test-server test application for GAtServer
Date: Mon, 11 Jan 2010 18:53:50 +0800
Message-ID: <1263207230-22036-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1263207230-22036-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3394502675016532758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add test-server application to showcase how to use GAtServer. It
supports TTY, tcp, unix socket to talk with client application.
---
 Makefile.am           |    6 +-
 gatchat/test-server.c |  402 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 407 insertions(+), 1 deletions(-)
 create mode 100644 gatchat/test-server.c

diff --git a/Makefile.am b/Makefile.am
index 50dabca..8ab62ca 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -299,12 +299,16 @@ unit_test_idmap_SOURCES =3D unit/test-idmap.c src/idm=
ap.c
 unit_test_idmap_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_idmap_OBJECTS)
 =

-noinst_PROGRAMS +=3D gatchat/gsmdial
+noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server
 =

 gatchat_gsmdial_SOURCES =3D gatchat/gsmdial.c $(gatchat_sources)
 =

 gatchat_gsmdial_LDADD =3D @GLIB_LIBS@
 =

+gatchat_test_server_SOURCES =3D gatchat/test-server.c $(gatchat_sources)
+
+gatchat_test_server_LDADD =3D @GLIB_LIBS@ -lutil
+
 =

 DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles
 =

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
new file mode 100644
index 0000000..68ddfc4
--- /dev/null
+++ b/gatchat/test-server.c
@@ -0,0 +1,402 @@
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
+#include <glib.h>
+#include <pty.h>
+
+#include "gatserver.h"
+#include "ringbuffer.h"
+
+#define DEFAULT_TCP_PORT 12346
+#define DEFAULT_SOCK_PATH "./server_sock"
+
+struct sock_server{
+	int server_sock;
+	const char *modem_path;
+};
+
+static GMainLoop *mainloop;
+static GAtServer *server;
+unsigned int server_watch;
+
+static gboolean server_cleanup()
+{
+	if (server_watch)
+		g_source_remove(server_watch);
+
+	g_at_server_unref(server);
+	server =3D NULL;
+
+	unlink(DEFAULT_SOCK_PATH);
+
+	g_main_loop_quit(mainloop);
+
+	return FALSE;
+}
+
+static void server_debug(const char *str, void *data)
+{
+	g_print("%s: %s\n", (char *) data, str);
+}
+
+static void add_handler(GAtServer *server)
+{
+	g_at_server_set_debug(server, server_debug, "Server");
+}
+
+static void server_destroy(gpointer user)
+{
+	struct sock_server *data =3D user;
+
+	if (data)
+		g_free(data);
+}
+
+static GAtServer *create_tty(const char *modem_path)
+{
+	int master, slave;
+	char pty_name[256];
+	GIOChannel *io;
+
+	if (!modem_path)
+		return NULL;
+
+	if (openpty(&master, &slave, pty_name, NULL, NULL) < 0)
+		return NULL;
+
+	io =3D g_io_channel_unix_new(master);
+
+	g_print("new tty is created@%s\n", pty_name);
+
+	server =3D g_at_server_new(io, modem_path);
+
+	if (!server) {
+		g_io_channel_shutdown(io, FALSE, NULL);
+		g_io_channel_unref(io);
+
+		return NULL;
+	}
+
+	add_handler(server);
+
+	return server;
+}
+
+static gboolean on_socket_connected(GIOChannel *chan, GIOCondition cond,
+							gpointer user)
+{
+	struct sockaddr saddr;
+	unsigned int len =3D sizeof(saddr);
+	int fd;
+	GIOChannel *client_io =3D NULL;
+	struct sock_server *data =3D user;
+
+	if (cond !=3D G_IO_IN)
+		goto error;
+
+	fd =3D accept(data->server_sock, &saddr, &len);
+	if (fd =3D=3D -1)
+		goto error;
+
+	client_io =3D g_io_channel_unix_new(fd);
+
+	server =3D g_at_server_new(client_io, data->modem_path);
+
+	if (!server) {
+		g_io_channel_shutdown(client_io, FALSE, NULL);
+		g_io_channel_unref(client_io);
+
+		goto error;
+	}
+
+	add_handler(server);
+
+	return TRUE;
+
+error:
+	if (data)
+		g_free(data);
+
+	return FALSE;
+}
+
+static struct sock_server *socket_common(int sk, struct sockaddr *addr,
+						const char *modem_path)
+{
+	struct sock_server *sock;
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
+	sock->modem_path =3D g_strdup(modem_path);
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
+		g_print("Can't create tcp/ip socket: %s (%d)",
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
+		g_print("Can't create unix socket: %s (%d)",
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
+static void test_server(int type)
+{
+	switch (type) {
+	case 0:
+		server =3D create_tty("/phonesim1");
+
+		add_handler(server);
+		break;
+	case 1:
+		if (!create_tcp("/phonesim1", DEFAULT_TCP_PORT))
+			exit(-1);
+		break;
+	case 2:
+		if (!create_unix("/phonesim1", DEFAULT_SOCK_PATH))
+			exit(-1);
+		break;
+	}
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
+	g_print("test-server - AT Server testing\n"
+		"Usage:\n");
+	g_print("\ttest-server [-t type]\n");
+	g_print("Types:\n"
+		"\t0: Pseudo TTY port (default)\n"
+		"\t1: TCP sock at port 12346)\n"
+		"\t2: Unix sock@./server_sock\n");
+}
+
+int main(int argc, char **argv)
+{
+	int opt, signal_source;
+	int type =3D 0;
+
+	while ((opt =3D getopt(argc, argv, "ht:")) !=3D EOF) {
+		switch (opt) {
+		case 't':
+			type =3D atoi(optarg);
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
+	test_server(type);
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


--===============3394502675016532758==--

