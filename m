Content-Type: multipart/mixed; boundary="===============6296640178942707523=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: change where we alloc/dealloc TUN device
Date: Mon, 12 Apr 2010 07:39:29 -0700
Message-ID: <1271083169-13799-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6296640178942707523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Don't bother opening the TUN device till IPCP is up.  And close
it when IPCP goes down.  Have LCP tell IPCP when it is down.
---
 gatchat/gatppp.c   |   27 ++++++++++++++++++++++-----
 gatchat/ppp.h      |    3 +++
 gatchat/ppp_cp.c   |    5 +++++
 gatchat/ppp_cp.h   |    1 +
 gatchat/ppp_ipcp.c |   18 ++++++++++++------
 gatchat/ppp_lcp.c  |    6 ++++--
 6 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index b98ab14..115dec0 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -104,6 +104,14 @@ void ppp_connect_cb(GAtPPP *ppp, GAtPPPConnectStatus s=
uccess,
 				ip, dns1, dns2,  ppp->connect_data);
 }
 =

+void ppp_disconnect_cb(GAtPPP *ppp)
+{
+	if (ppp->disconnect_cb =3D=3D NULL)
+		return;
+
+	ppp->disconnect_cb(ppp->disconnect_data);
+}
+
 #define PPPINITFCS16    0xffff  /* Initial FCS value */
 #define PPPGOODFCS16    0xf0b8  /* Good final FCS value */
 =

@@ -352,10 +360,6 @@ static void ppp_dead(GAtPPP *ppp)
 	if (ppp->write_watch)
 		return;
 =

-	/* notify interested parties */
-	if (ppp->disconnect_cb)
-		ppp->disconnect_cb(ppp->disconnect_data);
-
 	if (g_atomic_int_get(&ppp->ref_count))
 		return;
 =

@@ -396,6 +400,10 @@ static void ppp_transition_phase(GAtPPP *ppp, enum ppp=
_phase phase)
 		/* otherwise we need to wait for the peer to send us a challenge */
 		break;
 	case PPP_TERMINATION:
+		/*
+		 * we don't actually need to terminate IPCP, it's enough
+		 * to just terminate LCP.
+		 */
 		lcp_terminate(ppp->lcp);
 		break;
 	case PPP_DEAD:
@@ -403,7 +411,6 @@ static void ppp_transition_phase(GAtPPP *ppp, enum ppp_=
phase phase)
 		break;
 	case PPP_NETWORK:
 		/* bring network phase up */
-		ppp_net_open(ppp->net);
 		pppcp_signal_open(ppp->ipcp);
 		break;
 	}
@@ -444,6 +451,16 @@ void ppp_generate_event(GAtPPP *ppp, enum ppp_event ev=
ent)
 	}
 }
 =

+struct pppcp_data *ppp_get_ipcp(GAtPPP *ppp)
+{
+	return ppp->ipcp;
+}
+
+struct ppp_net_data *ppp_get_net(GAtPPP *ppp)
+{
+	return ppp->net;
+}
+
 void ppp_set_auth(GAtPPP *ppp, const guint8* auth_data)
 {
 	guint16 proto =3D get_host_short(auth_data);
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 0354050..5738db3 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -91,6 +91,7 @@ struct ppp_net_data {
 =

 void ppp_debug(GAtPPP *ppp, const char *str);
 void ppp_generate_event(GAtPPP *ppp, enum ppp_event event);
+struct pppcp_data *ppp_get_ipcp(GAtPPP *ppp);
 void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen);
 void ppp_set_auth(GAtPPP *ppp, const guint8 *auth_data);
 void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
@@ -120,3 +121,5 @@ struct pppcp_data *ipcp_new(GAtPPP *ppp);
 void ipcp_free(struct pppcp_data *data);
 void ppp_connect_cb(GAtPPP *ppp, GAtPPPConnectStatus success,
 			const char *ip, const char *dns1, const char *dns2);
+struct ppp_net_data *ppp_get_net(GAtPPP *ppp);
+void ppp_disconnect_cb(GAtPPP *ppp);
diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 5ac0196..245af32 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -703,6 +703,11 @@ void pppcp_signal_up(struct pppcp_data *data)
 	pppcp_generate_event(data, UP, NULL, 0);
 }
 =

+void pppcp_signal_down(struct pppcp_data *data)
+{
+	pppcp_generate_event(data, DOWN, NULL, 0);
+}
+
 static guint8 pppcp_process_configure_request(struct pppcp_data *pppcp,
 					struct pppcp_packet *packet)
 {
diff --git a/gatchat/ppp_cp.h b/gatchat/ppp_cp.h
index 2f99144..519a4a0 100644
--- a/gatchat/ppp_cp.h
+++ b/gatchat/ppp_cp.h
@@ -120,3 +120,4 @@ void pppcp_send_protocol_reject(struct pppcp_data *data,
 void pppcp_signal_open(struct pppcp_data *data);
 void pppcp_signal_close(struct pppcp_data *data);
 void pppcp_signal_up(struct pppcp_data *data);
+void pppcp_signal_down(struct pppcp_data *data);
diff --git a/gatchat/ppp_ipcp.c b/gatchat/ppp_ipcp.c
index 4cb6006..2fc83ac 100644
--- a/gatchat/ppp_ipcp.c
+++ b/gatchat/ppp_ipcp.c
@@ -104,11 +104,15 @@ static void ipcp_generate_config_options(struct ipcp_=
data *ipcp)
 static void ipcp_up(struct pppcp_data *pppcp)
 {
 	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
+	GAtPPP *ppp =3D pppcp_get_ppp(pppcp);
 	char ip[INET_ADDRSTRLEN];
 	char dns1[INET_ADDRSTRLEN];
 	char dns2[INET_ADDRSTRLEN];
 	struct in_addr addr;
 =

+	/* open and create the TUN device */
+	ppp_net_open(ppp_get_net(ppp));
+
 	memset(ip, 0, sizeof(ip));
 	addr.s_addr =3D ipcp->ipaddr;
 	inet_ntop(AF_INET, &addr, ip, INET_ADDRSTRLEN);
@@ -121,17 +125,19 @@ static void ipcp_up(struct pppcp_data *pppcp)
 	addr.s_addr =3D ipcp->dns2;
 	inet_ntop(AF_INET, &addr, dns2, INET_ADDRSTRLEN);
 =

-	ppp_connect_cb(pppcp_get_ppp(pppcp), G_AT_PPP_CONNECT_SUCCESS,
-					ip[0] ? ip : NULL,
-					dns1[0] ? dns1 : NULL,
-					dns2[0] ? dns2 : NULL);
+	ppp_connect_cb(ppp, G_AT_PPP_CONNECT_SUCCESS, ip[0] ? ip : NULL,
+			dns1[0] ? dns1 : NULL, dns2[0] ? dns2 : NULL);
 }
 =

 static void ipcp_down(struct pppcp_data *data)
 {
-	g_print("ipcp down\n");
+	GAtPPP *ppp =3D pppcp_get_ppp(data);
+
+	/* inform that we have dropped our connection */
+	ppp_disconnect_cb(ppp);
 =

-	/* re-add what default config options we want negotiated */
+	/* close the TUN device */
+	ppp_net_close(ppp_get_net(ppp));
 }
 =

 /*
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index a384a0d..4bf4159 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -91,7 +91,7 @@ static void lcp_generate_config_options(struct lcp_data *=
lcp)
 }
 =

 /*
- * signal the Up event to the NCP
+ * Tell PPP we are up
  */
 static void lcp_up(struct pppcp_data *pppcp)
 {
@@ -103,7 +103,9 @@ static void lcp_up(struct pppcp_data *pppcp)
  */
 static void lcp_down(struct pppcp_data *pppcp)
 {
-	/* XXX should implement a way to signal NCP */
+	GAtPPP *ppp =3D pppcp_get_ppp(pppcp);
+
+	pppcp_signal_down(ppp_get_ipcp(ppp));
 }
 =

 /*
-- =

1.6.6.1


--===============6296640178942707523==--

