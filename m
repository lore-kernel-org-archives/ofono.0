Content-Type: multipart/mixed; boundary="===============1462794970783792727=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: change MTU on TUN device when MRU option received
Date: Thu, 22 Apr 2010 14:15:11 -0700
Message-ID: <1271970911-9645-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1462794970783792727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp_net.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index c1f2eb4..fc1f9fb 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -50,10 +50,26 @@ struct ppp_net {
 =

 void ppp_net_set_mtu(struct ppp_net *net, guint16 mtu)
 {
+	struct ifreq ifr;
+	int sock;
+
 	if (net =3D=3D NULL)
 		return;
 =

 	net->mtu =3D mtu;
+
+	sock =3D socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return;
+
+	memset(&ifr, 0, sizeof(ifr));
+
+	strncpy(ifr.ifr_name, net->if_name, sizeof(ifr.ifr_name));
+	ifr.ifr_mtu =3D mtu;
+	if (ioctl(sock, SIOCSIFMTU, (caddr_t) &ifr) < 0)
+		g_printerr("Unable to change MTU\n");
+
+	close(sock);
 }
 =

 void ppp_net_process_packet(struct ppp_net *net, guint8 *packet)
-- =

1.6.6.1


--===============1462794970783792727==--

