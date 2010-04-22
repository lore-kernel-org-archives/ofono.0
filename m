Content-Type: multipart/mixed; boundary="===============6727402421119953210=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: alert ipcp when lcp is down
Date: Thu, 22 Apr 2010 12:55:02 -0700
Message-ID: <1271966102-8857-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6727402421119953210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This cleanly shuts down the network interface
---
 gatchat/gatppp.c  |    5 +++++
 gatchat/ppp.h     |    1 +
 gatchat/ppp_lcp.c |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index b7834e3..4f49404 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -429,6 +429,11 @@ void ppp_net_down_notify(GAtPPP *ppp)
 	ppp->net =3D NULL;
 }
 =

+void ppp_lcp_down_notify(GAtPPP *ppp)
+{
+	pppcp_signal_down(ppp->ipcp);
+}
+
 void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm)
 {
 	ppp->recv_accm =3D accm;
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 07483a9..e60bd23 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -117,3 +117,4 @@ void ppp_net_down_notify(GAtPPP *ppp);
 void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_mtu(GAtPPP *ppp, const guint8 *data);
+void ppp_lcp_down_notify(GAtPPP *ppp);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 8639c6c..5a9750d 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -114,6 +114,7 @@ static void lcp_down(struct pppcp_data *pppcp)
 =

 	lcp_reset_config_options(lcp);
 	pppcp_set_local_options(pppcp, lcp->options, lcp->options_len);
+	ppp_lcp_down_notify(pppcp_get_ppp(pppcp));
 	ppp_enter_phase(pppcp_get_ppp(pppcp), PPP_PHASE_TERMINATION);
 }
 =

-- =

1.6.6.1


--===============6727402421119953210==--

