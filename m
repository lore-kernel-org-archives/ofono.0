Content-Type: multipart/mixed; boundary="===============6040627685247339681=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 4/6] test-server: Add IPv6 CP options
Date: Tue, 08 Nov 2011 14:46:56 +0200
Message-ID: <1320756418-30890-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1320756418-30890-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6040627685247339681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/test-server.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 6f1d06d..cd14da7 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -58,6 +58,9 @@ static int modem_creg =3D 0;
 static int modem_cgreg =3D 0;
 static int network_status =3D 4;
 static int network_attach =3D 0;
+static gboolean ipv6cp =3D FALSE;
+static const char *ipv6_local_addr =3D NULL;
+static const char *ipv6_peer_addr =3D NULL;
 =

 struct sock_server{
 	int server_sock;
@@ -176,6 +179,10 @@ static gboolean setup_ppp(GAtServer *server)
 	g_at_ppp_set_server_info(ppp, "192.168.1.2",
 					"10.10.10.10", "10.10.10.11");
 =

+	if (ipv6cp)
+		g_at_ppp_set_ipv6cp_info(ppp, TRUE, ipv6_local_addr,
+							ipv6_peer_addr);
+
 	return TRUE;
 }
 =

@@ -1118,11 +1125,14 @@ static void usage(void)
 {
 	g_print("test-server - AT Server testing\n"
 		"Usage:\n");
-	g_print("\ttest-server [-t type]\n");
+	g_print("\ttest-server [-t type] [-6] [-l addr] [-p addr]\n");
 	g_print("Types:\n"
 		"\t0: Pseudo TTY port (default)\n"
 		"\t1: TCP sock at port 12346)\n"
 		"\t2: Unix sock at ./server_sock\n");
+	g_print("-6\tEnable IPv6 CP\n");
+	g_print("-l\tSpecify local IPv6 address\n");
+	g_print("-p\tSpecify peer IPv6 address\n");
 }
 =

 int main(int argc, char **argv)
@@ -1130,11 +1140,20 @@ int main(int argc, char **argv)
 	int opt, signal_source;
 	int type =3D 0;
 =

-	while ((opt =3D getopt(argc, argv, "ht:")) !=3D EOF) {
+	while ((opt =3D getopt(argc, argv, "h6l:p:t:")) !=3D EOF) {
 		switch (opt) {
 		case 't':
 			type =3D atoi(optarg);
 			break;
+		case '6':
+			ipv6cp =3D TRUE;
+			break;
+		case 'l':
+			ipv6_local_addr =3D optarg;
+			break;
+		case 'p':
+			ipv6_peer_addr =3D optarg;
+			break;
 		case 'h':
 			usage();
 			exit(1);
-- =

1.7.5.4


--===============6040627685247339681==--

