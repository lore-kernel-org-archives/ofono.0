Content-Type: multipart/mixed; boundary="===============4096081650628302351=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 3/6] test-server: Add IPv6 CP options
Date: Wed, 23 Nov 2011 14:57:49 +0200
Message-ID: <1322053072-20252-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322053072-20252-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4096081650628302351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/test-server.c |   52 ++++++++++++++++++++++++++++++++++++++++-----=
---
 1 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 6f1d06d..d41c197 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -58,6 +58,10 @@ static int modem_creg =3D 0;
 static int modem_cgreg =3D 0;
 static int network_status =3D 4;
 static int network_attach =3D 0;
+static gboolean ipv4 =3D FALSE;
+static gboolean ipv6 =3D FALSE;
+static const char *ipv6_local_prefix =3D NULL;
+static const char *ipv6_peer_prefix =3D NULL;
 =

 struct sock_server{
 	int server_sock;
@@ -161,8 +165,13 @@ static void open_ppp(gpointer user)
 =

 static gboolean setup_ppp(GAtServer *server)
 {
-	/* open ppp */
-	ppp =3D g_at_ppp_server_new("192.168.1.1");
+	if (ipv4 && ipv6)
+		ppp =3D g_at_ppp_ipv4v6_server_new("192.168.1.1",
+							ipv6_local_prefix);
+	else if (ipv6)
+		ppp =3D g_at_ppp_ipv6_server_new(ipv6_local_prefix);
+	else
+		ppp =3D g_at_ppp_server_new("192.168.1.1");
 	if (ppp =3D=3D NULL)
 		return FALSE;
 =

@@ -171,10 +180,19 @@ static gboolean setup_ppp(GAtServer *server)
 	g_at_ppp_set_credentials(ppp, "", "");
 =

 	/* set connect and disconnect callbacks */
-	g_at_ppp_set_connect_function(ppp, ppp_connect, server);
-	g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, server);
-	g_at_ppp_set_server_info(ppp, "192.168.1.2",
-					"10.10.10.10", "10.10.10.11");
+	if (g_at_ppp_get_proto(ppp) & G_AT_PPP_PROTO_IP) {
+		g_at_ppp_set_connect_function(ppp, ppp_connect, server);
+		g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, server);
+		g_at_ppp_set_server_info(ppp, "192.168.1.2",
+						"10.10.10.10", "10.10.10.11");
+	}
+
+	if (g_at_ppp_get_proto(ppp) & G_AT_PPP_PROTO_IPV6 &&
+			g_at_ppp_set_ipv6_server_info(ppp, ipv6_peer_prefix)
+				=3D=3D FALSE) {
+		g_at_ppp_unref(ppp);
+		return FALSE;
+	}
 =

 	return TRUE;
 }
@@ -1118,11 +1136,15 @@ static void usage(void)
 {
 	g_print("test-server - AT Server testing\n"
 		"Usage:\n");
-	g_print("\ttest-server [-t type]\n");
+	g_print("\ttest-server [-t type] [-4] [-6] [-l prefix] [-p prefix]\n");
 	g_print("Types:\n"
 		"\t0: Pseudo TTY port (default)\n"
 		"\t1: TCP sock at port 12346)\n"
-		"\t2: Unix sock at ./server_sock\n");
+		"\t2: Unix sock at ./server_sock\n\n");
+	g_print(" -4\tEnable IPv4 (default)\n");
+	g_print(" -6\tEnable IPv6\n");
+	g_print(" -l\tSpecify local IPv6 prefix\n");
+	g_print(" -p\tSpecify peer IPv6 prefix\n\n");
 }
 =

 int main(int argc, char **argv)
@@ -1130,11 +1152,23 @@ int main(int argc, char **argv)
 	int opt, signal_source;
 	int type =3D 0;
 =

-	while ((opt =3D getopt(argc, argv, "ht:")) !=3D EOF) {
+	while ((opt =3D getopt(argc, argv, "h46l:p:t:")) !=3D EOF) {
 		switch (opt) {
 		case 't':
 			type =3D atoi(optarg);
 			break;
+		case '4':
+			ipv4 =3D TRUE;
+			break;
+		case '6':
+			ipv6 =3D TRUE;
+			break;
+		case 'l':
+			ipv6_local_prefix =3D optarg;
+			break;
+		case 'p':
+			ipv6_peer_prefix =3D optarg;
+			break;
 		case 'h':
 			usage();
 			exit(1);
-- =

1.7.5.4


--===============4096081650628302351==--

