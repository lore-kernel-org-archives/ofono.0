Content-Type: multipart/mixed; boundary="===============4125255304113786199=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: change MTU on TUN device when MRU option received
Date: Thu, 22 Apr 2010 15:49:15 -0700
Message-ID: <1271976555-10393-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4125255304113786199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c  |    3 ++-
 gatchat/ppp.h     |    2 +-
 gatchat/ppp_net.c |   23 ++++++++++++++++++++---
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 705a298..fc6769c 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -411,7 +411,8 @@ void ppp_net_up_notify(GAtPPP *ppp, const char *ip,
 {
 	ppp->net =3D ppp_net_new(ppp);
 =

-	ppp_net_set_mtu(ppp->net, ppp->mtu);
+	if (ppp_net_set_mtu(ppp->net, ppp->mtu) =3D=3D FALSE)
+		g_printerr("Unable to set MTU\n");
 =

 	if (ppp->connect_cb =3D=3D NULL)
 		return;
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 07483a9..c7e6d24 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -103,7 +103,7 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp);
 const char *ppp_net_get_interface(struct ppp_net *net);
 void ppp_net_process_packet(struct ppp_net *net, guint8 *packet);
 void ppp_net_free(struct ppp_net *net);
-void ppp_net_set_mtu(struct ppp_net *net, guint16 mtu);
+gboolean ppp_net_set_mtu(struct ppp_net *net, guint16 mtu);
 =

 /* PPP functions related to main GAtPPP object */
 void ppp_debug(GAtPPP *ppp, const char *str);
diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index c1f2eb4..b8b3355 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -48,12 +48,29 @@ struct ppp_net {
 	gint mtu;
 };
 =

-void ppp_net_set_mtu(struct ppp_net *net, guint16 mtu)
+gboolean ppp_net_set_mtu(struct ppp_net *net, guint16 mtu)
 {
-	if (net =3D=3D NULL)
-		return;
+	struct ifreq ifr;
+	int sock;
+	int rc;
+
+	if (net =3D=3D NULL || mtu >=3D MAX_PACKET)
+		return FALSE;
 =

 	net->mtu =3D mtu;
+
+	sock =3D socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return FALSE;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, net->if_name, sizeof(ifr.ifr_name));
+	ifr.ifr_mtu =3D mtu;
+
+	rc =3D ioctl(sock, SIOCSIFMTU, (caddr_t) &ifr);
+
+	close(sock);
+	return (rc < 0) ? FALSE: TRUE;
 }
 =

 void ppp_net_process_packet(struct ppp_net *net, guint8 *packet)
-- =

1.6.6.1


--===============4125255304113786199==--

