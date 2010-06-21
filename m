Content-Type: multipart/mixed; boundary="===============8920136168792664204=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/5] gatppp: Add PPP server extension
Date: Mon, 21 Jun 2010 17:47:58 +0800
Message-ID: <1277113682-17510-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8920136168792664204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

1. Add interface to set PPP server info by g_at_ppp_set_server_info.
2. Pass local and peer address through IPCP handshaking.
---
 gatchat/gatppp.c   |   13 +++-
 gatchat/gatppp.h   |    7 ++-
 gatchat/ppp.h      |    6 ++-
 gatchat/ppp_ipcp.c |  177 +++++++++++++++++++++++++++++++++++++++++++-----=
---
 4 files changed, 171 insertions(+), 32 deletions(-)

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
index a1eacdf..bf30803 100644
--- a/gatchat/ppp_ipcp.c
+++ b/gatchat/ppp_ipcp.c
@@ -67,46 +67,49 @@ struct ipcp_data {
 	guint8 options[MAX_CONFIG_OPTION_SIZE];
 	guint16 options_len;
 	guint8 req_options;
-	guint32 ipaddr;
+	guint32 local_addr;
+	guint32 peer_addr;
 	guint32 dns1;
 	guint32 dns2;
 	guint32 nbns1;
 	guint32 nbns2;
+	gboolean is_server;
 };
 =

-#define FILL_IP(req, type, var) 				\
-	if (req) {						\
-		ipcp->options[len] =3D type;			\
-		ipcp->options[len + 1] =3D 6;			\
-		memcpy(ipcp->options + len + 2, var, 4);	\
-								\
-		len +=3D 6;					\
-	}							\
+#define FILL_IP(options, req, type, var) 		\
+	if (req) {					\
+		options[len] =3D type;			\
+		options[len + 1] =3D 6;			\
+		memcpy(options + len + 2, var, 4);	\
+							\
+		len +=3D 6;				\
+	}						\
 =

 static void ipcp_generate_config_options(struct ipcp_data *ipcp)
 {
 	guint16 len =3D 0;
 =

-	FILL_IP(ipcp->req_options & REQ_OPTION_IPADDR,
-					IP_ADDRESS, &ipcp->ipaddr);
-	FILL_IP(ipcp->req_options & REQ_OPTION_DNS1,
+	FILL_IP(ipcp->options, ipcp->req_options & REQ_OPTION_IPADDR,
+					IP_ADDRESS, &ipcp->local_addr);
+	FILL_IP(ipcp->options, ipcp->req_options & REQ_OPTION_DNS1,
 					PRIMARY_DNS_SERVER, &ipcp->dns1);
-	FILL_IP(ipcp->req_options & REQ_OPTION_DNS2,
+	FILL_IP(ipcp->options, ipcp->req_options & REQ_OPTION_DNS2,
 					SECONDARY_DNS_SERVER, &ipcp->dns2);
-	FILL_IP(ipcp->req_options & REQ_OPTION_NBNS1,
+	FILL_IP(ipcp->options, ipcp->req_options & REQ_OPTION_NBNS1,
 					PRIMARY_NBNS_SERVER, &ipcp->nbns1);
-	FILL_IP(ipcp->req_options & REQ_OPTION_NBNS2,
+	FILL_IP(ipcp->options, ipcp->req_options & REQ_OPTION_NBNS2,
 					SECONDARY_NBNS_SERVER, &ipcp->nbns2);
 =

 	ipcp->options_len =3D len;
 }
 =

-static void ipcp_reset_config_options(struct ipcp_data *ipcp)
+static void ipcp_reset_client_config_options(struct ipcp_data *ipcp)
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
@@ -115,17 +118,49 @@ static void ipcp_reset_config_options(struct ipcp_dat=
a *ipcp)
 	ipcp_generate_config_options(ipcp);
 }
 =

+static void ipcp_reset_server_config_options(struct ipcp_data *ipcp)
+{
+	ipcp->req_options =3D REQ_OPTION_IPADDR;
+
+	ipcp_generate_config_options(ipcp);
+}
+
+void ipcp_set_server_info(struct pppcp_data *pppcp, guint32 local_addr,
+				guint32 peer_addr,
+				guint32 dns1, guint32 dns2,
+				guint32 nbns1, guint32 nbns2)
+{
+	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
+
+	ipcp->req_options =3D REQ_OPTION_IPADDR;
+	ipcp->local_addr =3D local_addr;
+	ipcp->peer_addr =3D peer_addr;
+	ipcp->dns1 =3D dns1;
+	ipcp->dns2 =3D dns2;
+	ipcp->nbns1 =3D nbns1;
+	ipcp->nbns2 =3D nbns2;
+	ipcp->is_server =3D TRUE;
+
+	ipcp_generate_config_options(ipcp);
+	pppcp_set_local_options(pppcp, ipcp->options, ipcp->options_len);
+}
+
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
@@ -135,7 +170,8 @@ static void ipcp_up(struct pppcp_data *pppcp)
 	addr.s_addr =3D ipcp->dns2;
 	inet_ntop(AF_INET, &addr, dns2, INET_ADDRSTRLEN);
 =

-	ppp_ipcp_up_notify(pppcp_get_ppp(pppcp), ip[0] ? ip : NULL,
+	ppp_ipcp_up_notify(pppcp_get_ppp(pppcp), local[0] ? local : NULL,
+					peer[0] ? peer : NULL,
 					dns1[0] ? dns1 : NULL,
 					dns2[0] ? dns2 : NULL);
 }
@@ -144,7 +180,11 @@ static void ipcp_down(struct pppcp_data *pppcp)
 {
 	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
 =

-	ipcp_reset_config_options(ipcp);
+	if (ipcp->is_server)
+		ipcp_reset_server_config_options(ipcp);
+	else
+		ipcp_reset_client_config_options(ipcp);
+
 	pppcp_set_local_options(pppcp, ipcp->options, ipcp->options_len);
 	ppp_ipcp_down_notify(pppcp_get_ppp(pppcp));
 }
@@ -167,7 +207,7 @@ static void ipcp_rca(struct pppcp_data *pppcp,
 =

 		switch (ppp_option_iter_get_type(&iter)) {
 		case IP_ADDRESS:
-			memcpy(&ipcp->ipaddr, data, 4);
+			memcpy(&ipcp->local_addr, data, 4);
 			break;
 		case PRIMARY_DNS_SERVER:
 			memcpy(&ipcp->dns1, data, 4);
@@ -204,7 +244,7 @@ static void ipcp_rcn_nak(struct pppcp_data *pppcp,
 		case IP_ADDRESS:
 			g_print("Setting suggested ip addr\n");
 			ipcp->req_options |=3D REQ_OPTION_IPADDR;
-			memcpy(&ipcp->ipaddr, data, 4);
+			memcpy(&ipcp->local_addr, data, 4);
 			break;
 		case PRIMARY_DNS_SERVER:
 			g_print("Setting suggested dns1\n");
@@ -269,17 +309,98 @@ static void ipcp_rcn_rej(struct pppcp_data *pppcp,
 	pppcp_set_local_options(pppcp, ipcp->options, ipcp->options_len);
 }
 =

+static guint8 *ipcp_generate_peer_config_options(struct ipcp_data *ipcp,
+							guint16 *new_len)
+{
+	guint8 *options;
+	guint16 len =3D 0;
+
+	options =3D g_try_new0(guint8, MAX_CONFIG_OPTION_SIZE);
+	if (!options)
+		return NULL;
+
+	FILL_IP(options, TRUE, IP_ADDRESS, &ipcp->peer_addr);
+	FILL_IP(options, TRUE, PRIMARY_DNS_SERVER, &ipcp->dns1);
+	FILL_IP(options, TRUE, SECONDARY_DNS_SERVER, &ipcp->dns2);
+	FILL_IP(options, TRUE, PRIMARY_NBNS_SERVER, &ipcp->nbns1);
+	FILL_IP(options, TRUE, SECONDARY_NBNS_SERVER, &ipcp->nbns2);
+
+	*new_len =3D MAX_CONFIG_OPTION_SIZE;
+
+	return options;
+}
+
 static enum rcr_result ipcp_rcr(struct pppcp_data *pppcp,
 					const struct pppcp_packet *packet,
 					guint8 **new_options, guint16 *new_len)
 {
 	struct ppp_option_iter iter;
+	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
+	guint32 peer_addr =3D 0;
+	guint32 dns1 =3D 0;
+	guint32 dns2 =3D 0;
+	guint32 nbns1 =3D 0;
+	guint32 nbns2 =3D 0;
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
+		case PRIMARY_NBNS_SERVER:
+			memcpy(&nbns1, data, 4);
+			break;
+		case SECONDARY_NBNS_SERVER:
+			memcpy(&nbns2, data, 4);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (peer_addr) {
+		if (ipcp->peer_addr =3D=3D 0) {
+			/* RFC 1332 section 3.3
+			 * As client, accept the server IP as peer's address
+			 */
+			ipcp->peer_addr =3D peer_addr;
+
+			return RCR_ACCEPT;
+		} else if (ipcp->peer_addr =3D=3D peer_addr && ipcp->dns1 =3D=3D dns1
+				&& ipcp->nbns1 =3D=3D nbns1 && ipcp->nbns2 =3D=3D nbns2)
+			/* As server, verify the client's info and then send
+			 * acknowledgement back
+			 */
+			return RCR_ACCEPT;
+	} else {
+		/* Client requests server to send IP/DNS/NBNS information in the
+		 * config options
+		 */
+		if (ipcp->peer_addr) {
+			guint8 *options;
+			guint16 len;
+
+			options =3D ipcp_generate_peer_config_options(ipcp, &len);
+			if (!options)
+				goto reject;
+
+			*new_len =3D len;
+			*new_options =3D options;
+			return RCR_NAK;
+		}
+	}
 =

+reject:
 	/* Reject all options */
 	*new_len =3D packet->length - sizeof(*packet);
 	*new_options =3D g_memdup(packet->data, *new_len);
@@ -317,7 +438,7 @@ struct pppcp_data *ipcp_new(GAtPPP *ppp)
 	}
 =

 	pppcp_set_data(pppcp, ipcp);
-	ipcp_reset_config_options(ipcp);
+	ipcp_reset_client_config_options(ipcp);
 	pppcp_set_local_options(pppcp, ipcp->options, ipcp->options_len);
 =

 	return pppcp;
-- =

1.6.3.3


--===============8920136168792664204==--

