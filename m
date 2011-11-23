Content-Type: multipart/mixed; boundary="===============1721422575682079152=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 6/6] gsmdial: Add IPv6 CP connect hook
Date: Wed, 23 Nov 2011 14:57:52 +0200
Message-ID: <1322053072-20252-7-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322053072-20252-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1721422575682079152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 87541d1..90cd342 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -344,6 +344,51 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user_data)
 	g_at_chat_resume(modem);
 }
 =

+static const char *ipv6_link_local(const char *addr, char *dst)
+{
+	struct in6_addr in6_addr;
+
+	/* Add IPv6 link-local prefix */
+
+	inet_pton(AF_INET6, addr, &in6_addr);
+	in6_addr.s6_addr16[0] =3D htons(0xfe80);
+	inet_ntop(AF_INET6, &in6_addr, dst, INET6_ADDRSTRLEN);
+
+	return dst;
+}
+
+static void ppp_ipv6_connect(const char *iface, const char *local,
+				const char *peer, gpointer user_data)
+{
+	char local_addr[INET6_ADDRSTRLEN], peer_addr[INET6_ADDRSTRLEN];
+	char buf[512];
+
+	g_print("PPP IPv6 up\n");
+
+	ipv6_link_local(local, local_addr);
+	ipv6_link_local(peer, peer_addr);
+
+	g_print("Network Device: %s\n", iface);
+	g_print("IPv6 Local Address: %s\n", local_addr);
+	g_print("IPv6 Peer Address: %s\n", peer_addr);
+
+	if (getuid() !=3D 0) {
+		g_print("Need root privilege to config PPP interface\n");
+		return;
+	}
+
+	snprintf(buf, sizeof(buf), "%s %s up", IFCONFIG_PATH, iface);
+	execute(buf);
+
+	snprintf(buf, sizeof(buf), "%s %s inet6 add %s", IFCONFIG_PATH,
+			iface, local_addr);
+	execute(buf);
+
+	snprintf(buf, sizeof(buf), "ip -6 route add %s dev %s", peer_addr,
+								iface);
+	execute(buf);
+}
+
 static GAtPPP *ppp_new(gchar **type)
 {
 	gboolean ipv4 =3D FALSE;
@@ -401,9 +446,16 @@ static void connect_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 =

 		/* set connect and disconnect callbacks */
 		g_at_ppp_set_connect_function(ppp, ppp_connect, NULL);
-		g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
 	}
 =

+	if (g_at_ppp_get_proto(ppp) & G_AT_PPP_PROTO_IPV6)
+		g_at_ppp_set_ipv6_connect_function(ppp, ppp_ipv6_connect, NULL);
+
+	/* set common IPv4 and IPv6 disconnect callback */
+	if (g_at_ppp_get_proto(ppp) & G_AT_PPP_PROTO_IP ||
+			g_at_ppp_get_proto(ppp) & G_AT_PPP_PROTO_IPV6)
+		g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, NULL);
+
 	/* open the ppp connection */
 	g_at_ppp_open(ppp, io);
 }
-- =

1.7.5.4


--===============1721422575682079152==--

