Content-Type: multipart/mixed; boundary="===============6534953882385669742=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 5/6] gatppp: Add IPv6 CP connect callback
Date: Wed, 23 Nov 2011 14:57:51 +0200
Message-ID: <1322053072-20252-6-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322053072-20252-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6534953882385669742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |   83 ++++++++++++++++++++++++++++++++++++--------------=
---
 gatchat/gatppp.h |    5 +++
 2 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index be90e81..ac12758 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -72,6 +72,7 @@ struct _GAtPPP {
 	char password[256];
 	GAtPPPConnectFunc connect_cb;
 	gpointer connect_data;
+	GAtPPPConnect6Func connect6_cb;
 	GAtPPPDisconnectFunc disconnect_cb;
 	gpointer disconnect_data;
 	GAtPPPDisconnectReason disconnect_reason;
@@ -369,6 +370,41 @@ static inline void ppp_enter_phase(GAtPPP *ppp, enum p=
pp_phase phase)
 		ppp->ppp_dead_source =3D g_idle_add(ppp_dead, ppp);
 }
 =

+static void ppp_net_up_notify(GAtPPP *ppp)
+{
+	if (ppp->net !=3D NULL) {
+		ppp_net_ref(ppp->net);
+		return;
+	}
+
+	ppp->net =3D ppp_net_new(ppp, ppp->fd);
+	if (ppp->net =3D=3D NULL) {
+		ppp->disconnect_reason =3D G_AT_PPP_REASON_NET_FAIL;
+		pppcp_signal_close(ppp->lcp);
+		return;
+	}
+
+	/*
+	 * ppp_net_new took control over the fd, whatever happens is out of
+	 * our hands now
+	 */
+	ppp->fd =3D -1;
+
+	if (ppp_net_set_mtu(ppp->net, ppp->mtu) =3D=3D FALSE)
+		DBG(ppp, "Unable to set MTU");
+
+	ppp_enter_phase(ppp, PPP_PHASE_LINK_UP);
+}
+
+static void ppp_net_down_notify(GAtPPP *ppp)
+{
+	/* Most likely we failed to create the interface */
+	if (ppp->net =3D=3D NULL)
+		return;
+
+	ppp_net_unref(&ppp->net);
+}
+
 void ppp_set_auth(GAtPPP *ppp, const guint8* auth_data)
 {
 	guint16 proto =3D get_host_short(auth_data);
@@ -412,39 +448,17 @@ void ppp_auth_notify(GAtPPP *ppp, gboolean success)
 void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local, const char *peer,
 					const char *dns1, const char *dns2)
 {
-	ppp->net =3D ppp_net_new(ppp, ppp->fd);
-
-	/*
-	 * ppp_net_new took control over the fd, whatever happens is out of
-	 * our hands now
-	 */
-	ppp->fd =3D -1;
-
-	if (ppp->net =3D=3D NULL) {
-		ppp->disconnect_reason =3D G_AT_PPP_REASON_NET_FAIL;
-		pppcp_signal_close(ppp->lcp);
-		return;
-	}
-
-	if (ppp_net_set_mtu(ppp->net, ppp->mtu) =3D=3D FALSE)
-		DBG(ppp, "Unable to set MTU");
-
-	ppp_enter_phase(ppp, PPP_PHASE_LINK_UP);
+	ppp_net_up_notify(ppp);
 =

 	if (ppp->connect_cb)
 		ppp->connect_cb(ppp_net_get_interface(ppp->net),
-					local, peer, dns1, dns2,
-					ppp->connect_data);
+				local, peer, dns1, dns2,
+				ppp->connect_data);
 }
 =

 void ppp_ipcp_down_notify(GAtPPP *ppp)
 {
-	/* Most likely we failed to create the interface */
-	if (ppp->net =3D=3D NULL)
-		return;
-
-	ppp_net_free(ppp->net);
-	ppp->net =3D NULL;
+	ppp_net_down_notify(ppp);
 }
 =

 void ppp_ipcp_finished_notify(GAtPPP *ppp)
@@ -466,12 +480,18 @@ void ppp_ipv6cp_up_notify(GAtPPP *ppp, const char *lo=
cal, const char *peer)
 {
 	DBG(ppp, "local: %s, peer: %s", local, peer);
 =

-	ppp_enter_phase(ppp, PPP_PHASE_LINK_UP);
+	ppp_net_up_notify(ppp);
+
+	if (ppp->connect6_cb)
+		ppp->connect6_cb(ppp_net_get_interface(ppp->net),
+					local, peer, ppp->connect_data);
 }
 =

 void ppp_ipv6cp_down_notify(GAtPPP *ppp)
 {
 	DBG(ppp, "");
+
+	ppp_net_down_notify(ppp);
 }
 =

 void ppp_ipv6cp_finished_notify(GAtPPP *ppp)
@@ -682,6 +702,15 @@ void g_at_ppp_set_disconnect_function(GAtPPP *ppp, GAt=
PPPDisconnectFunc func,
 	ppp->disconnect_data =3D user_data;
 }
 =

+void g_at_ppp_set_ipv6_connect_function(GAtPPP *ppp, GAtPPPConnect6Func fu=
nc,
+							gpointer user_data)
+{
+	if (func =3D=3D NULL)
+		return;
+
+	ppp->connect6_cb =3D func;
+}
+
 void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func, gpointer user_data)
 {
 	if (ppp =3D=3D NULL)
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index b6eb40d..ead61ca 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -54,6 +54,8 @@ typedef void (*GAtPPPConnectFunc)(const char *iface, cons=
t char *local,
 					gpointer user_data);
 typedef void (*GAtPPPDisconnectFunc)(GAtPPPDisconnectReason reason,
 					gpointer user_data);
+typedef void (*GAtPPPConnect6Func)(const char *iface, const char *local,
+					const char *peer, gpointer user_data);
 =

 GAtPPP *g_at_ppp_new(void);
 GAtPPP *g_at_ppp_ipv6_new(const char *local_prefix);
@@ -76,6 +78,9 @@ void g_at_ppp_set_disconnect_function(GAtPPP *ppp, GAtPPP=
DisconnectFunc func,
 					gpointer user_data);
 void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspendFunc func,
 					gpointer user_data);
+void g_at_ppp_set_ipv6_connect_function(GAtPPP *ppp,
+					GAtPPPConnect6Func callback,
+					gpointer user_data);
 void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func, gpointer user_data=
);
 void g_at_ppp_shutdown(GAtPPP *ppp);
 void g_at_ppp_suspend(GAtPPP *ppp);
-- =

1.7.5.4


--===============6534953882385669742==--

