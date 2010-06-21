Content-Type: multipart/mixed; boundary="===============6285177555413676806=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/5] test-server: Add PPP server support
Date: Mon, 21 Jun 2010 17:48:00 +0800
Message-ID: <1277113682-17510-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1277113682-17510-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6285177555413676806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that gsmdial and wvdial could talk to test-server and establish PPP
connection.
---
 gatchat/test-server.c |  131 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 123 insertions(+), 8 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 5c1cfa4..68371c2 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -35,6 +35,7 @@
 #include <arpa/inet.h>
 #include <signal.h>
 #include <sys/signalfd.h>
+#include <errno.h>
 =

 #include <glib.h>
 #include <utmp.h>
@@ -44,6 +45,7 @@
 #include <sys/stat.h>
 =

 #include "gatserver.h"
+#include "gatppp.h"
 #include "ringbuffer.h"
 =

 #define DEFAULT_TCP_PORT 12346
@@ -61,6 +63,7 @@ struct sock_server{
 =

 static GMainLoop *mainloop;
 static GAtServer *server;
+static GAtPPP *ppp;
 unsigned int server_watch;
 =

 static gboolean server_cleanup()
@@ -68,6 +71,11 @@ static gboolean server_cleanup()
 	if (server_watch)
 		g_source_remove(server_watch);
 =

+	if (ppp) {
+		g_at_ppp_unref(ppp);
+		ppp =3D NULL;
+	}
+
 	g_at_server_unref(server);
 	server =3D NULL;
 =

@@ -83,6 +91,81 @@ static void server_debug(const char *str, void *data)
 	g_print("%s: %s\n", (char *) data, str);
 }
 =

+static void ppp_connect(const char *iface, const char *local, const char *=
peer,
+			const char *dns1, const char *dns2,
+			gpointer user)
+{
+	g_print("Network Device: %s\n", iface);
+	g_print("IP Address: %s\n", local);
+	g_print("Peer IP Address: %s\n", peer);
+	g_print("Primary DNS Server: %s\n", dns1);
+	g_print("Secondary DNS Server: %s\n", dns2);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user)
+{
+	GAtServer *server =3D user;
+
+	g_print("PPP Link down: %d\n", reason);
+
+	g_at_ppp_unref(ppp);
+	ppp =3D NULL;
+
+	g_at_server_resume(server);
+	g_at_server_set_debug(server, server_debug, "Server");
+}
+
+static gboolean update_ppp(gpointer user)
+{
+	GAtPPP *ppp =3D user;
+	char local_ip[INET_ADDRSTRLEN] =3D "192.168.1.1";
+	char remote_ip[INET_ADDRSTRLEN] =3D "192.168.1.2";
+	char dns1[INET_ADDRSTRLEN] =3D "10.10.10.0";
+	char dns2[INET_ADDRSTRLEN] =3D "127.0.0.1";
+	guint32 l, r, d1, d2;
+
+	inet_pton(AF_INET, local_ip, &l);
+	inet_pton(AF_INET, remote_ip, &r);
+	inet_pton(AF_INET, dns1, &d1);
+	inet_pton(AF_INET, dns2, &d2);
+
+	g_at_ppp_set_server_info(ppp, l, r, d1, d2, 0, 0);
+
+	return FALSE;
+}
+
+static gboolean setup_ppp(gpointer user)
+{
+	GAtServer *server =3D user;
+	GAtIO *io;
+
+	io =3D g_at_server_get_io(server);
+
+	g_at_server_suspend(server);
+
+	/* open ppp */
+	ppp =3D g_at_ppp_new_from_io(io);
+	if (ppp =3D=3D NULL) {
+		g_at_server_resume(server);
+		return FALSE;
+	}
+
+	g_at_ppp_set_debug(ppp, server_debug, "PPP");
+
+	g_at_ppp_set_credentials(ppp, "", "");
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(ppp, ppp_connect, server);
+	g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, server);
+
+	/* open the ppp connection */
+	g_at_ppp_open(ppp);
+
+	g_idle_add(update_ppp, ppp);
+
+	return FALSE;
+}
+
 static void cgmi_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
 {
 	GAtServer *server =3D user;
@@ -468,6 +551,7 @@ static void cgdata_cb(GAtServerRequestType type, GAtRes=
ult *cmd, gpointer user)
 		break;
 	case G_AT_SERVER_REQUEST_TYPE_SET:
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_CONNECT);
+		g_idle_add(setup_ppp, server);
 		break;
 	default:
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
@@ -671,6 +755,40 @@ static void cpbs_cb(GAtServerRequestType type, GAtResu=
lt *cmd, gpointer user)
 	}
 }
 =

+static void dial_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
+{
+	GAtServer *server =3D user;
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtResultIter iter;
+	const char *dial_str;
+	char c;
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
+		goto error;
+
+	g_at_result_iter_init(&iter, cmd);
+
+	if (!g_at_result_iter_next(&iter, "D"))
+		goto error;
+
+	dial_str =3D g_at_result_iter_raw_line(&iter);
+	if (!dial_str)
+		goto error;
+
+	g_print("dial call %s\n", dial_str);
+
+	c =3D *dial_str;
+	if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_CONNECT);
+		g_idle_add(setup_ppp, server);
+	}
+
+	return;
+
+error:
+	g_at_server_send_final(server, res);
+}
+
 static void add_handler(GAtServer *server)
 {
 	g_at_server_set_debug(server, server_debug, "Server");
@@ -695,6 +813,7 @@ static void add_handler(GAtServer *server)
 	g_at_server_register(server, "+CSCS",    cscs_cb,    server, NULL);
 	g_at_server_register(server, "+CMGL",    cmgl_cb,    server, NULL);
 	g_at_server_register(server, "+CPBS",    cpbs_cb,    server, NULL);
+	g_at_server_register(server, "D",        dial_cb,    server, NULL);
 }
 =

 static void server_destroy(gpointer user)
@@ -706,15 +825,11 @@ static void server_destroy(gpointer user)
 =

 static void set_raw_mode(int fd)
 {
-	struct termios options;
-
-	tcgetattr(fd, &options);
-
-	/* Set TTY as raw mode to disable echo back of input characters
-	 * when they are received from Modem to avoid feedback loop */
-	options.c_lflag &=3D ~(ICANON | ECHO | ECHOE | ISIG);
+	struct termios ti;
 =

-	tcsetattr(fd, TCSANOW, &options);
+	tcflush(fd, TCIOFLUSH);
+	cfmakeraw(&ti);
+	tcsetattr(fd, TCSANOW, &ti);
 }
 =

 static gboolean create_tty(const char *modem_path)
-- =

1.6.3.3


--===============6285177555413676806==--

