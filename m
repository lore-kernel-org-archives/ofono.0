Content-Type: multipart/mixed; boundary="===============5146279692133839563=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 03/11] gatppp: Add PPP server extension
Date: Sat, 12 Jun 2010 13:50:42 +0800
Message-ID: <1276321850-13307-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1276321850-13307-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5146279692133839563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

1. Add interface to set PPP server info by g_at_ppp_set_server_info.
2. Pass local and peer address through IPCP handshaking.
---
 gatchat/gatppp.c   |   13 +++++-
 gatchat/gatppp.h   |    7 +++-
 gatchat/ppp.h      |    6 ++-
 gatchat/ppp_ipcp.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++--=
---
 4 files changed, 124 insertions(+), 16 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index e92fe5d..05136e0 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -246,7 +246,7 @@ void ppp_auth_notify(GAtPPP *ppp, gboolean success)
 	pppcp_signal_up(ppp->ipcp);
 }
 =

-void ppp_ipcp_up_notify(GAtPPP *ppp, const char *ip,
+void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local, const char *peer,
 					const char *dns1, const char *dns2)
 {
 	ppp->net =3D ppp_net_new(ppp);
@@ -264,7 +264,8 @@ void ppp_ipcp_up_notify(GAtPPP *ppp, const char *ip,
 =

 	if (ppp->connect_cb)
 		ppp->connect_cb(ppp_net_get_interface(ppp->net),
-					ip, dns1, dns2, ppp->connect_data);
+					local, peer, dns1, dns2,
+					ppp->connect_data);
 }
 =

 void ppp_ipcp_down_notify(GAtPPP *ppp)
@@ -464,6 +465,14 @@ void g_at_ppp_unref(GAtPPP *ppp)
 	g_free(ppp);
 }
 =

+void g_at_ppp_set_server_info(GAtPPP *ppp, guint32 local, guint32 peer,
+				guint32 dns1, guint32 dns2,
+				guint32 nbns1, guint32 nbns2)
+{
+	ipcp_set_server_info(ppp->ipcp, local, peer, dns1, dns2,
+				nbns1, nbns2);
+}
+
 static GAtPPP *ppp_init_common(GAtHDLC *hdlc)
 {
 	GAtPPP *ppp;
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index 438b952..86b3081 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -43,7 +43,8 @@ typedef enum _GAtPPPDisconnectReason {
 	G_AT_PPP_REASON_LOCAL_CLOSE,	/* Normal user close */
 } GAtPPPDisconnectReason;
 =

-typedef void (*GAtPPPConnectFunc)(const char *iface, const char *ip,
+typedef void (*GAtPPPConnectFunc)(const char *iface, const char *local,
+					const char *peer,
 					const char *dns1, const char *dns2,
 					gpointer user_data);
 typedef void (*GAtPPPDisconnectFunc)(GAtPPPDisconnectReason reason,
@@ -68,6 +69,10 @@ const char *g_at_ppp_get_password(GAtPPP *ppp);
 =

 void g_at_ppp_set_recording(GAtPPP *ppp, const char *filename);
 =

+void g_at_ppp_set_server_info(GAtPPP *ppp, guint32 local, guint32 peer,
+				guint32 dns1, guint32 dns2,
+				guint32 nbns1, guint32 nbns2);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index b6c5f4a..56da8a9 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -86,6 +86,10 @@ void lcp_protocol_reject(struct pppcp_data *lcp, guint8 =
*packet, gsize len);
 /* IPCP related functions */
 struct pppcp_data *ipcp_new(GAtPPP *ppp);
 void ipcp_free(struct pppcp_data *data);
+void ipcp_set_server_info(struct pppcp_data *ipcp, guint32 local_addr,
+				guint32 peer_addr,
+				guint32 dns1, guint32 dns2,
+				guint32 nbns1, guint32 nbns2);
 =

 /* CHAP related functions */
 struct ppp_chap *ppp_chap_new(GAtPPP *ppp, guint8 method);
@@ -104,7 +108,7 @@ void ppp_debug(GAtPPP *ppp, const char *str);
 void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen);
 void ppp_set_auth(GAtPPP *ppp, const guint8 *auth_data);
 void ppp_auth_notify(GAtPPP *ppp, gboolean success);
-void ppp_ipcp_up_notify(GAtPPP *ppp, const char *ip,
+void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local, const char *peer,
 					const char *dns1, const char *dns2);
 void ppp_ipcp_down_notify(GAtPPP *ppp);
 void ppp_ipcp_finished_notify(GAtPPP *ppp);
diff --git a/gatchat/ppp_ipcp.c b/gatchat/ppp_ipcp.c
index a1eacdf..8f13d85 100644
--- a/gatchat/ppp_ipcp.c
+++ b/gatchat/ppp_ipcp.c
@@ -67,7 +67,8 @@ struct ipcp_data {
 	guint8 options[MAX_CONFIG_OPTION_SIZE];
 	guint16 options_len;
 	guint8 req_options;
-	guint32 ipaddr;
+	guint32 local_addr;
+	guint32 peer_addr;
 	guint32 dns1;
 	guint32 dns2;
 	guint32 nbns1;
@@ -88,7 +89,7 @@ static void ipcp_generate_config_options(struct ipcp_data=
 *ipcp)
 	guint16 len =3D 0;
 =

 	FILL_IP(ipcp->req_options & REQ_OPTION_IPADDR,
-					IP_ADDRESS, &ipcp->ipaddr);
+					IP_ADDRESS, &ipcp->local_addr);
 	FILL_IP(ipcp->req_options & REQ_OPTION_DNS1,
 					PRIMARY_DNS_SERVER, &ipcp->dns1);
 	FILL_IP(ipcp->req_options & REQ_OPTION_DNS2,
@@ -101,12 +102,52 @@ static void ipcp_generate_config_options(struct ipcp_=
data *ipcp)
 	ipcp->options_len =3D len;
 }
 =

+static void ipcp_generate_peer_config_options(struct ipcp_data *ipcp)
+{
+	guint16 len =3D 0;
+
+	FILL_IP(ipcp->req_options & REQ_OPTION_IPADDR,
+					IP_ADDRESS, &ipcp->peer_addr);
+	FILL_IP(ipcp->req_options & REQ_OPTION_DNS1,
+					PRIMARY_DNS_SERVER, &ipcp->dns1);
+	FILL_IP(ipcp->req_options & REQ_OPTION_DNS2,
+					SECONDARY_DNS_SERVER, &ipcp->dns2);
+	FILL_IP(ipcp->req_options & REQ_OPTION_NBNS1,
+					PRIMARY_NBNS_SERVER, &ipcp->nbns1);
+	FILL_IP(ipcp->req_options & REQ_OPTION_NBNS2,
+					SECONDARY_NBNS_SERVER, &ipcp->nbns2);
+
+	ipcp->options_len =3D len;
+}
+
+void ipcp_set_server_info(struct pppcp_data *pppcp, guint32 local_addr,
+				guint32 peer_addr,
+				guint32 dns1, guint32 dns2,
+				guint32 nbns1, guint32 nbns2)
+{
+	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
+
+	ipcp->req_options =3D REQ_OPTION_IPADDR | REQ_OPTION_DNS1 |
+				REQ_OPTION_DNS2 | REQ_OPTION_NBNS1 |
+				REQ_OPTION_NBNS2;
+
+	ipcp->local_addr =3D local_addr;
+	ipcp->peer_addr =3D peer_addr;
+	ipcp->dns1 =3D dns1;
+	ipcp->dns2 =3D dns2;
+	ipcp->nbns1 =3D nbns1;
+	ipcp->nbns2 =3D nbns2;
+
+	ipcp_generate_config_options(ipcp);
+}
+
 static void ipcp_reset_config_options(struct ipcp_data *ipcp)
 {
 	ipcp->req_options =3D REQ_OPTION_IPADDR | REQ_OPTION_DNS1 |
 				REQ_OPTION_DNS2 | REQ_OPTION_NBNS1 |
 				REQ_OPTION_NBNS2;
-	ipcp->ipaddr =3D 0;
+	ipcp->local_addr =3D 0;
+	ipcp->peer_addr =3D 0;
 	ipcp->dns1 =3D 0;
 	ipcp->dns2 =3D 0;
 	ipcp->nbns1 =3D 0;
@@ -118,14 +159,19 @@ static void ipcp_reset_config_options(struct ipcp_dat=
a *ipcp)
 static void ipcp_up(struct pppcp_data *pppcp)
 {
 	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
-	char ip[INET_ADDRSTRLEN];
+	char local[INET_ADDRSTRLEN];
+	char peer[INET_ADDRSTRLEN];
 	char dns1[INET_ADDRSTRLEN];
 	char dns2[INET_ADDRSTRLEN];
 	struct in_addr addr;
 =

-	memset(ip, 0, sizeof(ip));
-	addr.s_addr =3D ipcp->ipaddr;
-	inet_ntop(AF_INET, &addr, ip, INET_ADDRSTRLEN);
+	memset(local, 0, sizeof(local));
+	addr.s_addr =3D ipcp->local_addr;
+	inet_ntop(AF_INET, &addr, local, INET_ADDRSTRLEN);
+
+	memset(peer, 0, sizeof(peer));
+	addr.s_addr =3D ipcp->peer_addr;
+	inet_ntop(AF_INET, &addr, peer, INET_ADDRSTRLEN);
 =

 	memset(dns1, 0, sizeof(dns1));
 	addr.s_addr =3D ipcp->dns1;
@@ -135,7 +181,8 @@ static void ipcp_up(struct pppcp_data *pppcp)
 	addr.s_addr =3D ipcp->dns2;
 	inet_ntop(AF_INET, &addr, dns2, INET_ADDRSTRLEN);
 =

-	ppp_ipcp_up_notify(pppcp_get_ppp(pppcp), ip[0] ? ip : NULL,
+	ppp_ipcp_up_notify(pppcp_get_ppp(pppcp), local[0] ? local : NULL,
+					peer[0] ? peer : NULL,
 					dns1[0] ? dns1 : NULL,
 					dns2[0] ? dns2 : NULL);
 }
@@ -167,7 +214,7 @@ static void ipcp_rca(struct pppcp_data *pppcp,
 =

 		switch (ppp_option_iter_get_type(&iter)) {
 		case IP_ADDRESS:
-			memcpy(&ipcp->ipaddr, data, 4);
+			memcpy(&ipcp->local_addr, data, 4);
 			break;
 		case PRIMARY_DNS_SERVER:
 			memcpy(&ipcp->dns1, data, 4);
@@ -204,7 +251,7 @@ static void ipcp_rcn_nak(struct pppcp_data *pppcp,
 		case IP_ADDRESS:
 			g_print("Setting suggested ip addr\n");
 			ipcp->req_options |=3D REQ_OPTION_IPADDR;
-			memcpy(&ipcp->ipaddr, data, 4);
+			memcpy(&ipcp->local_addr, data, 4);
 			break;
 		case PRIMARY_DNS_SERVER:
 			g_print("Setting suggested dns1\n");
@@ -274,11 +321,54 @@ static enum rcr_result ipcp_rcr(struct pppcp_data *pp=
pcp,
 					guint8 **new_options, guint16 *new_len)
 {
 	struct ppp_option_iter iter;
+	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
+	guint32 peer_addr;
+	guint32 dns1;
+	guint32 dns2;
 =

 	ppp_option_iter_init(&iter, packet);
 =

-	if (ppp_option_iter_next(&iter) =3D=3D FALSE)
-		return RCR_ACCEPT;
+	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
+		const guint8 *data =3D ppp_option_iter_get_data(&iter);
+
+		switch (ppp_option_iter_get_type(&iter)) {
+		case IP_ADDRESS:
+			memcpy(&peer_addr, data, 4);
+			break;
+		case PRIMARY_DNS_SERVER:
+			memcpy(&dns1, data, 4);
+			break;
+		case SECONDARY_DNS_SERVER:
+			memcpy(&dns2, data, 4);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (peer_addr && dns1 && dns2) {
+		if (ipcp->peer_addr =3D=3D 0) {
+			/* RFC 1332 Section 3.3
+			 * Accept the value of IP address as peer IP address
+			 */
+			ipcp->peer_addr =3D peer_addr;
+
+			return RCR_ACCEPT;
+		} else if (ipcp->peer_addr =3D=3D peer_addr)
+			return RCR_ACCEPT;
+	} else {
+		/* Peer requests us to send ip address in config options */
+		if (ipcp->peer_addr) {
+			struct ipcp_data *peer;
+
+			peer =3D g_memdup(ipcp, sizeof(struct ipcp_data));
+			ipcp_generate_peer_config_options(peer);
+
+			*new_len =3D peer->options_len;
+			*new_options =3D peer->options;
+			return RCR_NAK;
+		}
+	}
 =

 	/* Reject all options */
 	*new_len =3D packet->length - sizeof(*packet);
-- =

1.6.3.3


--===============5146279692133839563==--

