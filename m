Content-Type: multipart/mixed; boundary="===============6736512551441533841=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 6/6] gsmdial: Add IPv6 CP connect hook
Date: Tue, 08 Nov 2011 14:46:58 +0200
Message-ID: <1320756418-30890-7-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1320756418-30890-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6736512551441533841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index b4b2015..8031245 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -344,6 +344,44 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user_data)
 	g_at_chat_resume(modem);
 }
 =

+static void ppp_ipv6_connect(const char *iface, const char *local,
+				const char *peer, gpointer user_data)
+{
+	struct in6_addr in6_local, in6_peer;
+	char local_addr[INET6_ADDRSTRLEN], peer_addr[INET6_ADDRSTRLEN];
+	char buf[512];
+
+	/* Add IPv6 link-local prefix */
+
+	inet_pton(AF_INET6, local, &in6_local);
+	in6_local.s6_addr16[0] =3D htons(0xfe80);
+	inet_ntop(AF_INET6, &in6_local, local_addr, INET6_ADDRSTRLEN);
+
+	inet_pton(AF_INET6, peer, &in6_peer);
+	in6_peer.s6_addr16[0] =3D htons(0xfe80);
+	inet_ntop(AF_INET6, &in6_peer, peer_addr, INET6_ADDRSTRLEN);
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
 static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	GAtIO *io;
@@ -373,8 +411,12 @@ static void connect_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	if (option_pppdump)
 		g_at_ppp_set_recording(ppp, option_pppdump);
 =

-	if (option_ipv6cp)
+	if (option_ipv6cp) {
 		g_at_ppp_set_ipv6cp_info(ppp, FALSE, NULL, NULL);
+		g_at_ppp_set_ipv6_connect_function(ppp, ppp_ipv6_connect, NULL);
+		g_at_ppp_set_ipv6_disconnect_function(ppp, ppp_disconnect,
+							NULL);
+	}
 =

 	g_at_ppp_set_credentials(ppp, option_username, option_password);
 =

-- =

1.7.5.4


--===============6736512551441533841==--

