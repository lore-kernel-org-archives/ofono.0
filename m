Content-Type: multipart/mixed; boundary="===============6993562647901124797=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 07/11] test-server: Configure network interface
Date: Sat, 12 Jun 2010 13:50:46 +0800
Message-ID: <1276321850-13307-8-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1276321850-13307-7-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6993562647901124797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Require ROOT priviledge to:
1. Run external command to configure and bring up network interface.
2. Enable kernel IP forwarding.
---
 gatchat/test-server.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 68371c2..df0bab8 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -50,6 +50,7 @@
 =

 #define DEFAULT_TCP_PORT 12346
 #define DEFAULT_SOCK_PATH "./server_sock"
+#define IFCONFIG_PATH "/sbin/ifconfig"
 =

 static int modem_mode =3D 0;
 static int modem_creg =3D 0;
@@ -91,15 +92,40 @@ static void server_debug(const char *str, void *data)
 	g_print("%s: %s\n", (char *) data, str);
 }
 =

+static gboolean execute(const char *cmd)
+{
+	int status;
+
+	status =3D system(cmd);
+	if (status < 0) {
+		g_print("Failed to execute command: %s\n", strerror(errno));
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static void ppp_connect(const char *iface, const char *local, const char *=
peer,
 			const char *dns1, const char *dns2,
 			gpointer user)
 {
+	char buf[512];
+
 	g_print("Network Device: %s\n", iface);
 	g_print("IP Address: %s\n", local);
 	g_print("Peer IP Address: %s\n", peer);
 	g_print("Primary DNS Server: %s\n", dns1);
 	g_print("Secondary DNS Server: %s\n", dns2);
+
+	snprintf(buf, sizeof(buf), "%s %s up", IFCONFIG_PATH, iface);
+	execute(buf);
+
+	snprintf(buf, sizeof(buf), "%s %s %s pointopoint %s", IFCONFIG_PATH,
+				iface, local, peer);
+	execute(buf);
+
+	snprintf(buf, sizeof(buf), "echo 1 > /proc/sys/net/ipv4/ip_forward");
+	execute(buf);
 }
 =

 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user)
@@ -139,6 +165,11 @@ static gboolean setup_ppp(gpointer user)
 	GAtServer *server =3D user;
 	GAtIO *io;
 =

+	if (getuid() !=3D 0) {
+		g_print("Need root priviledge for PPP connection\n");
+		return FALSE;
+	}
+
 	io =3D g_at_server_get_io(server);
 =

 	g_at_server_suspend(server);
-- =

1.6.3.3


--===============6993562647901124797==--

