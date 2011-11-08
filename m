Content-Type: multipart/mixed; boundary="===============0730185284761854300=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 2/6] gatppp: Add IPv6 CP hooks
Date: Tue, 08 Nov 2011 14:46:54 +0200
Message-ID: <1320756418-30890-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1320756418-30890-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0730185284761854300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c     |   61 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 gatchat/gatppp.h     |    3 ++
 gatchat/ppp.h        |    3 ++
 gatchat/ppp_ipv6cp.c |   17 ++++++++++++-
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index f767f4a..c425eae 100644
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
@@ -157,7 +158,8 @@ static inline gboolean ppp_drop_packet(GAtPPP *ppp, gui=
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
@@ -222,6 +224,10 @@ static void ppp_receive(const unsigned char *buf, gsiz=
e len, void *data)
 	case IPCP_PROTO:
 		pppcp_process_packet(ppp->ipcp, packet, len - offset);
 		break;
+	case IPV6CP_PROTO:
+		if (ppp->ipv6cp)
+			pppcp_process_packet(ppp->ipv6cp, packet, len - offset);
+		break;
 	case CHAP_PROTOCOL:
 		if (ppp->chap) {
 			ppp_chap_process_packet(ppp->chap, packet,
@@ -381,6 +387,12 @@ void ppp_auth_notify(GAtPPP *ppp, gboolean success)
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
 	pppcp_signal_open(ppp->ipcp);
 	pppcp_signal_up(ppp->ipcp);
@@ -431,6 +443,34 @@ void ppp_ipcp_finished_notify(GAtPPP *ppp)
 =

 	/* Our IPCP parameter negotiation failed */
 	ppp->disconnect_reason =3D G_AT_PPP_REASON_IPCP_FAIL;
+
+	if (ppp->ipv6cp)
+		pppcp_signal_close(ppp->ipv6cp);
+	pppcp_signal_close(ppp->ipcp);
+	pppcp_signal_close(ppp->lcp);
+}
+
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
+	pppcp_signal_close(ppp->ipv6cp);
 	pppcp_signal_close(ppp->ipcp);
 	pppcp_signal_close(ppp->lcp);
 }
@@ -732,6 +772,8 @@ void g_at_ppp_unref(GAtPPP *ppp)
 =

 	lcp_free(ppp->lcp);
 	ipcp_free(ppp->ipcp);
+	if (ppp->ipv6cp)
+		ipv6cp_free(ppp->ipv6cp);
 =

 	if (ppp->ppp_dead_source) {
 		g_source_remove(ppp->ppp_dead_source);
@@ -772,6 +814,23 @@ void g_at_ppp_set_pfc_enabled(GAtPPP *ppp, gboolean en=
abled)
 	lcp_set_pfc_enabled(ppp->lcp, enabled);
 }
 =

+gboolean g_at_ppp_set_ipv6cp_info(GAtPPP *ppp, gboolean is_server,
+					const char *local, const char *peer)
+{
+	GError *error =3D NULL;
+
+	ppp->ipv6cp =3D ipv6cp_new(ppp, is_server, local, peer, &error);
+	if (ppp->ipv6cp =3D=3D NULL) {
+		if (error !=3D NULL) {
+			DBG(ppp, "%s", error->message);
+			g_error_free(error);
+		}
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static GAtPPP *ppp_init_common(gboolean is_server, guint32 ip)
 {
 	GAtPPP *ppp;
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index b5a2234..a41bf08 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -37,6 +37,7 @@ typedef enum _GAtPPPDisconnectReason {
 	G_AT_PPP_REASON_UNKNOWN,
 	G_AT_PPP_REASON_AUTH_FAIL,	/* Failed to authenticate */
 	G_AT_PPP_REASON_IPCP_FAIL,	/* Failed to negotiate IPCP */
+	G_AT_PPP_REASON_IPV6CP_FAIL,	/* Failed to negotiate IPV6CP */
 	G_AT_PPP_REASON_NET_FAIL,	/* Failed to create tun */
 	G_AT_PPP_REASON_PEER_CLOSED,	/* Peer initiated a close */
 	G_AT_PPP_REASON_LINK_DEAD,	/* Link to the peer died */
@@ -81,6 +82,8 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const char *re=
mote_ip,
 =

 void g_at_ppp_set_acfc_enabled(GAtPPP *ppp, gboolean enabled);
 void g_at_ppp_set_pfc_enabled(GAtPPP *ppp, gboolean enabled);
+gboolean g_at_ppp_set_ipv6cp_info(GAtPPP *ppp, gboolean is_server,
+					const char *local, const char *peer);
 =

 #ifdef __cplusplus
 }
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 718575b..a21ebbc 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -128,6 +128,9 @@ void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local,=
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
index ec89fb7..75ce8f2 100644
--- a/gatchat/ppp_ipv6cp.c
+++ b/gatchat/ppp_ipv6cp.c
@@ -95,7 +95,19 @@ static void ipv6cp_reset_config_options(struct ipv6cp_da=
ta *ipv6cp)
 =

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
@@ -105,11 +117,12 @@ static void ipv6cp_down(struct pppcp_data *pppcp)
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
-- =

1.7.5.4


--===============0730185284761854300==--

