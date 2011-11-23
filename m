Content-Type: multipart/mixed; boundary="===============0035689254981132085=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 1/6] gatppp: Add IPv6 CP hooks
Date: Wed, 23 Nov 2011 14:57:47 +0200
Message-ID: <1322053072-20252-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322053072-20252-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0035689254981132085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c     |  189 ++++++++++++++++++++++++++++++++++++++++++++--=
---
 gatchat/gatppp.h     |   17 +++++
 gatchat/ppp.h        |    8 ++-
 gatchat/ppp_ipv6cp.c |   54 ++++++++++-----
 4 files changed, 229 insertions(+), 39 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index f767f4a..be90e81 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -62,6 +62,7 @@ struct _GAtPPP {
 	enum ppp_phase phase;
 	struct pppcp_data *lcp;
 	struct pppcp_data *ipcp;
+	struct pppcp_data *ipv6cp;
 	struct ppp_net *net;
 	struct ppp_chap *chap;
 	GAtHDLC *hdlc;
@@ -85,6 +86,7 @@ struct _GAtPPP {
 	gboolean suspended;
 	gboolean xmit_acfc;
 	gboolean xmit_pfc;
+	guint8 proto;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -157,7 +159,8 @@ static inline gboolean ppp_drop_packet(GAtPPP *ppp, gui=
nt16 protocol)
 		return TRUE;
 	case PPP_PHASE_NETWORK:
 		if (protocol !=3D LCP_PROTOCOL && protocol !=3D CHAP_PROTOCOL &&
-					protocol !=3D IPCP_PROTO)
+						protocol !=3D IPCP_PROTO &&
+						protocol !=3D IPV6CP_PROTO)
 			return TRUE;
 		break;
 	case PPP_PHASE_LINK_UP:
@@ -220,19 +223,31 @@ static void ppp_receive(const unsigned char *buf, gsi=
ze len, void *data)
 		pppcp_process_packet(ppp->lcp, packet, len - offset);
 		break;
 	case IPCP_PROTO:
+		if (ppp->ipcp =3D=3D NULL)
+			goto reject;
+
 		pppcp_process_packet(ppp->ipcp, packet, len - offset);
 		break;
+	case IPV6CP_PROTO:
+		if (ppp->ipv6cp =3D=3D NULL)
+			goto reject;
+
+		pppcp_process_packet(ppp->ipv6cp, packet, len - offset);
+		break;
 	case CHAP_PROTOCOL:
-		if (ppp->chap) {
-			ppp_chap_process_packet(ppp->chap, packet,
-							len - offset);
-			break;
-		}
-		/* fall through */
+		if (ppp->chap =3D=3D NULL)
+			goto reject;
+
+		ppp_chap_process_packet(ppp->chap, packet, len - offset);
+		break;
 	default:
-		pppcp_send_protocol_reject(ppp->lcp, buf, len);
 		break;
 	};
+
+	return;
+
+reject:
+	pppcp_send_protocol_reject(ppp->lcp, buf, len);
 }
 =

 static void ppp_send_lcp_frame(GAtPPP *ppp, guint8 *packet, guint infolen)
@@ -381,9 +396,17 @@ void ppp_auth_notify(GAtPPP *ppp, gboolean success)
 =

 	ppp_enter_phase(ppp, PPP_PHASE_NETWORK);
 =

+	/* Send UP & OPEN events to the IPv6 CP */
+	if (ppp->ipv6cp) {
+		pppcp_signal_open(ppp->ipv6cp);
+		pppcp_signal_up(ppp->ipv6cp);
+	}
+
 	/* Send UP & OPEN events to the IPCP layer */
-	pppcp_signal_open(ppp->ipcp);
-	pppcp_signal_up(ppp->ipcp);
+	if (ppp->ipcp) {
+		pppcp_signal_open(ppp->ipcp);
+		pppcp_signal_up(ppp->ipcp);
+	}
 }
 =

 void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local, const char *peer,
@@ -431,10 +454,42 @@ void ppp_ipcp_finished_notify(GAtPPP *ppp)
 =

 	/* Our IPCP parameter negotiation failed */
 	ppp->disconnect_reason =3D G_AT_PPP_REASON_IPCP_FAIL;
+
+	if (ppp->ipv6cp)
+		pppcp_signal_close(ppp->ipv6cp);
+
 	pppcp_signal_close(ppp->ipcp);
 	pppcp_signal_close(ppp->lcp);
 }
 =

+void ppp_ipv6cp_up_notify(GAtPPP *ppp, const char *local, const char *peer)
+{
+	DBG(ppp, "local: %s, peer: %s", local, peer);
+
+	ppp_enter_phase(ppp, PPP_PHASE_LINK_UP);
+}
+
+void ppp_ipv6cp_down_notify(GAtPPP *ppp)
+{
+	DBG(ppp, "");
+}
+
+void ppp_ipv6cp_finished_notify(GAtPPP *ppp)
+{
+	DBG(ppp, "");
+
+	if (ppp->phase !=3D PPP_PHASE_NETWORK)
+		return;
+
+	ppp->disconnect_reason =3D G_AT_PPP_REASON_IPV6CP_FAIL;
+
+	if (ppp->ipcp)
+		pppcp_signal_close(ppp->ipcp);
+
+	pppcp_signal_close(ppp->ipv6cp);
+	pppcp_signal_close(ppp->lcp);
+}
+
 void ppp_lcp_up_notify(GAtPPP *ppp)
 {
 	/* Wait for the peer to send us a challenge if we expect auth */
@@ -449,8 +504,14 @@ void ppp_lcp_up_notify(GAtPPP *ppp)
 =

 void ppp_lcp_down_notify(GAtPPP *ppp)
 {
-	if (ppp->phase =3D=3D PPP_PHASE_NETWORK || ppp->phase =3D=3D PPP_PHASE_LI=
NK_UP)
-		pppcp_signal_down(ppp->ipcp);
+	if (ppp->phase =3D=3D PPP_PHASE_NETWORK ||
+				ppp->phase =3D=3D PPP_PHASE_LINK_UP) {
+		if (ppp->ipcp)
+			pppcp_signal_down(ppp->ipcp);
+
+		if (ppp->ipv6cp)
+			pppcp_signal_down(ppp->ipv6cp);
+	}
 =

 	if (ppp->disconnect_reason =3D=3D G_AT_PPP_REASON_UNKNOWN)
 		ppp->disconnect_reason =3D G_AT_PPP_REASON_PEER_CLOSED;
@@ -588,6 +649,11 @@ const char *g_at_ppp_get_password(GAtPPP *ppp)
 	return ppp->password;
 }
 =

+guint8 g_at_ppp_get_proto(GAtPPP *ppp)
+{
+	return ppp->proto;
+}
+
 void g_at_ppp_set_recording(GAtPPP *ppp, const char *filename)
 {
 	if (ppp =3D=3D NULL)
@@ -731,7 +797,12 @@ void g_at_ppp_unref(GAtPPP *ppp)
 		ppp_chap_free(ppp->chap);
 =

 	lcp_free(ppp->lcp);
-	ipcp_free(ppp->ipcp);
+
+	if (ppp->ipcp)
+		ipcp_free(ppp->ipcp);
+
+	if (ppp->ipv6cp)
+		ipv6cp_free(ppp->ipv6cp);
 =

 	if (ppp->ppp_dead_source) {
 		g_source_remove(ppp->ppp_dead_source);
@@ -772,9 +843,11 @@ void g_at_ppp_set_pfc_enabled(GAtPPP *ppp, gboolean en=
abled)
 	lcp_set_pfc_enabled(ppp->lcp, enabled);
 }
 =

-static GAtPPP *ppp_init_common(gboolean is_server, guint32 ip)
+static GAtPPP *ppp_init_common(guint proto, gboolean is_server, guint32 ip,
+						const char *local_prefix)
 {
 	GAtPPP *ppp;
+	GError *error =3D NULL;
 =

 	ppp =3D g_try_malloc0(sizeof(GAtPPP));
 	if (ppp =3D=3D NULL)
@@ -783,6 +856,7 @@ static GAtPPP *ppp_init_common(gboolean is_server, guin=
t32 ip)
 	ppp->ref_count =3D 1;
 	ppp->suspended =3D TRUE;
 	ppp->fd =3D -1;
+	ppp->proto =3D proto;
 =

 	/* set options to defaults */
 	ppp->mru =3D DEFAULT_MRU;
@@ -791,15 +865,27 @@ static GAtPPP *ppp_init_common(gboolean is_server, gu=
int32 ip)
 	/* initialize the lcp state */
 	ppp->lcp =3D lcp_new(ppp, is_server);
 =

-	/* initialize IPCP state */
-	ppp->ipcp =3D ipcp_new(ppp, is_server, ip);
+	if (ppp->proto & G_AT_PPP_PROTO_IP)
+		ppp->ipcp =3D ipcp_new(ppp, is_server, ip);
+
+	if (ppp->proto & G_AT_PPP_PROTO_IPV6) {
+		ppp->ipv6cp =3D ipv6cp_new(ppp, FALSE, local_prefix, &error);
+		if (ppp->ipv6cp =3D=3D NULL) {
+			if (error !=3D NULL) {
+				DBG(ppp, "%s", error->message);
+				g_error_free(error);
+			}
+			g_at_ppp_unref(ppp);
+			return NULL;
+		}
+	}
 =

 	return ppp;
 }
 =

 GAtPPP *g_at_ppp_new(void)
 {
-	return ppp_init_common(FALSE, 0);
+	return ppp_init_common(G_AT_PPP_PROTO_IP, FALSE, 0, NULL);
 }
 =

 GAtPPP *g_at_ppp_server_new_full(const char *local, int fd)
@@ -812,10 +898,11 @@ GAtPPP *g_at_ppp_server_new_full(const char *local, i=
nt fd)
 	else if (inet_pton(AF_INET, local, &ip) !=3D 1)
 		return NULL;
 =

-	ppp =3D ppp_init_common(TRUE, ip);
+	ppp =3D ppp_init_common(G_AT_PPP_PROTO_IP, TRUE, ip, NULL);
+	if (ppp =3D=3D NULL)
+		return NULL;
 =

-	if (ppp !=3D NULL)
-		ppp->fd =3D fd;
+	ppp->fd =3D fd;
 =

 	return ppp;
 }
@@ -824,3 +911,65 @@ GAtPPP *g_at_ppp_server_new(const char *local)
 {
 	return g_at_ppp_server_new_full(local, -1);
 }
+
+GAtPPP *g_at_ppp_ipv6_new(const char *local_prefix)
+{
+	return ppp_init_common(G_AT_PPP_PROTO_IPV6, FALSE, 0, local_prefix);
+}
+
+GAtPPP *g_at_ppp_ipv4v6_new(const char *local_prefix)
+{
+	return ppp_init_common(G_AT_PPP_PROTO_IPV4V6, FALSE, 0, local_prefix);
+}
+
+GAtPPP *g_at_ppp_ipv6_server_new_full(const char *local_prefix, int fd)
+{
+	return ppp_init_common(G_AT_PPP_PROTO_IPV6, TRUE, 0, local_prefix);
+}
+
+GAtPPP *g_at_ppp_ipv6_server_new(const char *local_prefix)
+{
+	return g_at_ppp_ipv6_server_new_full(local_prefix, -1);
+}
+
+GAtPPP *g_at_ppp_ipv4v6_server_new_full(const char *local_ip,
+					const char *local_prefix, int fd)
+{
+	GAtPPP *ppp;
+	guint32 ip;
+
+	if (local_ip =3D=3D NULL)
+		ip =3D 0;
+	else if (inet_pton(AF_INET, local_ip, &ip) !=3D 1)
+		return NULL;
+
+	ppp =3D ppp_init_common(G_AT_PPP_PROTO_IPV4V6, TRUE, ip, local_prefix);
+	if (ppp =3D=3D NULL)
+		return NULL;
+
+	ppp->fd =3D fd;
+
+	return ppp;
+}
+
+GAtPPP *g_at_ppp_ipv4v6_server_new(const char *local_ip,
+						const char *local_prefix)
+{
+	return g_at_ppp_ipv4v6_server_new_full(local_ip, local_prefix, -1);
+}
+
+gboolean g_at_ppp_set_ipv6_server_info(GAtPPP *ppp, const char *remote_pre=
fix)
+{
+	GError *error =3D NULL;
+
+	if (ipv6cp_set_server_info(ppp->ipv6cp, remote_prefix, &error) =3D=3D
+			FALSE) {
+		if (error !=3D NULL) {
+			DBG(ppp, "%s", error->message);
+			g_error_free(error);
+		}
+		return FALSE;
+	}
+
+	return TRUE;
+}
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index b5a2234..b6eb40d 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -31,12 +31,17 @@ extern "C" {
 =

 struct _GAtPPP;
 =

+#define G_AT_PPP_PROTO_IP	0x1
+#define G_AT_PPP_PROTO_IPV6	0x2
+#define G_AT_PPP_PROTO_IPV4V6	(G_AT_PPP_PROTO_IP | G_AT_PPP_PROTO_IPV6)
+
 typedef struct _GAtPPP GAtPPP;
 =

 typedef enum _GAtPPPDisconnectReason {
 	G_AT_PPP_REASON_UNKNOWN,
 	G_AT_PPP_REASON_AUTH_FAIL,	/* Failed to authenticate */
 	G_AT_PPP_REASON_IPCP_FAIL,	/* Failed to negotiate IPCP */
+	G_AT_PPP_REASON_IPV6CP_FAIL,	/* Failed to negotiate IPV6CP */
 	G_AT_PPP_REASON_NET_FAIL,	/* Failed to create tun */
 	G_AT_PPP_REASON_PEER_CLOSED,	/* Peer initiated a close */
 	G_AT_PPP_REASON_LINK_DEAD,	/* Link to the peer died */
@@ -51,8 +56,17 @@ typedef void (*GAtPPPDisconnectFunc)(GAtPPPDisconnectRea=
son reason,
 					gpointer user_data);
 =

 GAtPPP *g_at_ppp_new(void);
+GAtPPP *g_at_ppp_ipv6_new(const char *local_prefix);
+GAtPPP *g_at_ppp_ipv4v6_new(const char *local_prefix);
+
 GAtPPP *g_at_ppp_server_new(const char *local);
 GAtPPP *g_at_ppp_server_new_full(const char *local, int fd);
+GAtPPP *g_at_ppp_ipv6_server_new(const char *local_prefix);
+GAtPPP *g_at_ppp_ipv6_server_new_full(const char *local_prefix, int fd);
+GAtPPP *g_at_ppp_ipv4v6_server_new(const char *local_ip,
+					const char *local_prefix);
+GAtPPP *g_at_ppp_ipv4v6_server_new_full(const char *local_ip,
+					const char *local_prefix, int fd);
 =

 gboolean g_at_ppp_open(GAtPPP *ppp, GAtIO *io);
 gboolean g_at_ppp_listen(GAtPPP *ppp, GAtIO *io);
@@ -74,10 +88,13 @@ gboolean g_at_ppp_set_credentials(GAtPPP *ppp, const ch=
ar *username,
 const char *g_at_ppp_get_username(GAtPPP *ppp);
 const char *g_at_ppp_get_password(GAtPPP *ppp);
 =

+guint8 g_at_ppp_get_proto(GAtPPP *ppp);
+
 void g_at_ppp_set_recording(GAtPPP *ppp, const char *filename);
 =

 void g_at_ppp_set_server_info(GAtPPP *ppp, const char *remote_ip,
 				const char *dns1, const char *dns2);
+gboolean g_at_ppp_set_ipv6_server_info(GAtPPP *ppp, const char *remote_pre=
fix);
 =

 void g_at_ppp_set_acfc_enabled(GAtPPP *ppp, gboolean enabled);
 void g_at_ppp_set_pfc_enabled(GAtPPP *ppp, gboolean enabled);
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 718575b..fa36816 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -99,9 +99,10 @@ void ipcp_set_server_info(struct pppcp_data *ipcp, guint=
32 peer_addr,
 =

 /* IPv6 CP related functions */
 struct pppcp_data *ipv6cp_new(GAtPPP *ppp, gboolean is_server,
-					const char *local, const char *peer,
-					GError **error);
+					const char *local, GError **error);
 void ipv6cp_free(struct pppcp_data *data);
+gboolean ipv6cp_set_server_info(struct pppcp_data *pppcp, const char *peer,
+				GError **error);
 =

 /* CHAP related functions */
 struct ppp_chap *ppp_chap_new(GAtPPP *ppp, guint8 method);
@@ -128,6 +129,9 @@ void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local,=
 const char *peer,
 					const char *dns1, const char *dns2);
 void ppp_ipcp_down_notify(GAtPPP *ppp);
 void ppp_ipcp_finished_notify(GAtPPP *ppp);
+void ppp_ipv6cp_up_notify(GAtPPP *ppp, const char *local, const char *peer=
);
+void ppp_ipv6cp_down_notify(GAtPPP *ppp);
+void ppp_ipv6cp_finished_notify(GAtPPP *ppp);
 void ppp_lcp_up_notify(GAtPPP *ppp);
 void ppp_lcp_down_notify(GAtPPP *ppp);
 void ppp_lcp_finished_notify(GAtPPP *ppp);
diff --git a/gatchat/ppp_ipv6cp.c b/gatchat/ppp_ipv6cp.c
index ecfd570..4d0926e 100644
--- a/gatchat/ppp_ipv6cp.c
+++ b/gatchat/ppp_ipv6cp.c
@@ -93,9 +93,43 @@ static void ipv6cp_reset_config_options(struct ipv6cp_da=
ta *ipv6cp)
 	ipv6cp_generate_config_options(ipv6cp);
 }
 =

+gboolean ipv6cp_set_server_info(struct pppcp_data *pppcp, const char *peer,
+				GError **error)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+	struct in6_addr peer_addr;
+
+	if (peer =3D=3D NULL)
+		memset(&peer_addr, 0, sizeof(peer_addr));
+	else if (inet_pton(AF_INET6, peer, &peer_addr) !=3D 1) {
+		g_set_error(error, IPV6CP_ERROR, errno,
+				"Unable to set peer Interface ID: %s",
+				g_strerror(errno));
+		return FALSE;
+	}
+
+	ipv6cp->is_server =3D TRUE;
+
+	memcpy(&ipv6cp->peer_addr, &peer_addr.s6_addr[8],
+						sizeof(ipv6cp->peer_addr));
+	return TRUE;
+}
+
 static void ipv6cp_up(struct pppcp_data *pppcp)
 {
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+	struct in6_addr local_addr, peer_addr;
+	char local[INET6_ADDRSTRLEN], peer[INET6_ADDRSTRLEN];
 =

+	memset(&local_addr, 0, sizeof(local_addr));
+	memcpy(&local_addr.s6_addr[8], &ipv6cp->local_addr,
+					sizeof(ipv6cp->local_addr));
+	memset(&peer_addr, 0, sizeof(peer_addr));
+	memcpy(&peer_addr.s6_addr[8], &ipv6cp->peer_addr,
+					sizeof(ipv6cp->peer_addr));
+	ppp_ipv6cp_up_notify(pppcp_get_ppp(pppcp),
+		inet_ntop(AF_INET6, &local_addr, local, INET6_ADDRSTRLEN),
+		inet_ntop(AF_INET6, &peer_addr, peer, INET6_ADDRSTRLEN));
 }
 =

 static void ipv6cp_down(struct pppcp_data *pppcp)
@@ -105,11 +139,12 @@ static void ipv6cp_down(struct pppcp_data *pppcp)
 	ipv6cp_reset_config_options(ipv6cp);
 =

 	pppcp_set_local_options(pppcp, ipv6cp->options, ipv6cp->options_len);
+	ppp_ipv6cp_down_notify(pppcp_get_ppp(pppcp));
 }
 =

 static void ipv6cp_finished(struct pppcp_data *pppcp)
 {
-
+	ppp_ipv6cp_finished_notify(pppcp_get_ppp(pppcp));
 }
 =

 static enum rcr_result ipv6cp_server_rcr(struct ipv6cp_data *ipv6cp,
@@ -317,13 +352,11 @@ struct pppcp_proto ipv6cp_proto =3D {
 };
 =

 struct pppcp_data *ipv6cp_new(GAtPPP *ppp, gboolean is_server,
-					const char *local, const char *peer,
-					GError **error)
+					const char *local, GError **error)
 {
 	struct ipv6cp_data *ipv6cp;
 	struct pppcp_data *pppcp;
 	struct in6_addr local_addr;
-	struct in6_addr peer_addr;
 =

 	if (local =3D=3D NULL)
 		memset(&local_addr, 0, sizeof(local_addr));
@@ -334,15 +367,6 @@ struct pppcp_data *ipv6cp_new(GAtPPP *ppp, gboolean is=
_server,
 		return NULL;
 	}
 =

-	if (peer =3D=3D NULL)
-		memset(&peer_addr, 0, sizeof(peer_addr));
-	else if (inet_pton(AF_INET6, peer, &peer_addr) !=3D 1) {
-		g_set_error(error, IPV6CP_ERROR, errno,
-				"Unable to set peer Interface ID: %s",
-				g_strerror(errno));
-		return NULL;
-	}
-
 	ipv6cp =3D g_try_new0(struct ipv6cp_data, 1);
 	if (ipv6cp =3D=3D NULL)
 		return NULL;
@@ -355,10 +379,6 @@ struct pppcp_data *ipv6cp_new(GAtPPP *ppp, gboolean is=
_server,
 =

 	memcpy(&ipv6cp->local_addr, &local_addr.s6_addr[8],
 						sizeof(ipv6cp->local_addr));
-	memcpy(&ipv6cp->peer_addr, &peer_addr.s6_addr[8],
-						sizeof(ipv6cp->peer_addr));
-	ipv6cp->is_server =3D is_server;
-
 	pppcp_set_data(pppcp, ipv6cp);
 =

 	ipv6cp_reset_config_options(ipv6cp);
-- =

1.7.5.4


--===============0035689254981132085==--

