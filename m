Content-Type: multipart/mixed; boundary="===============6201995874838022092=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/1] ppp: Add MAX_IPCP_FAILURE to avoid timeout quickly
Date: Fri, 09 Jul 2010 16:40:35 +0800
Message-ID: <1278664835-21295-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278664835-21295-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6201995874838022092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We use IPCP NAK response to stall the progress of acquiring the client
IP address from DHCP server. So we need to increase the max failure of
NAKs in IPCP handshaking.
---
 gatchat/ppp_cp.c   |    8 ++++++--
 gatchat/ppp_cp.h   |    2 +-
 gatchat/ppp_ipcp.c |   10 +++++++++-
 gatchat/ppp_lcp.c  |    2 +-
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 647e241..e013283 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -997,7 +997,7 @@ void pppcp_set_local_options(struct pppcp_data *pppcp,
 }
 =

 struct pppcp_data *pppcp_new(GAtPPP *ppp, const struct pppcp_proto *proto,
-				gboolean dormant)
+				gboolean dormant, int max_failure)
 {
 	struct pppcp_data *data;
 =

@@ -1016,7 +1016,11 @@ struct pppcp_data *pppcp_new(GAtPPP *ppp, const stru=
ct pppcp_proto *proto,
 	data->terminate_timer_data.max_counter =3D MAX_TERMINATE;
 	data->config_timer_data.data =3D data;
 	data->terminate_timer_data.data =3D data;
-	data->max_failure =3D MAX_FAILURE;
+
+	if (max_failure)
+		data->max_failure =3D max_failure;
+	else
+		data->max_failure =3D MAX_FAILURE;
 =

 	data->ppp =3D ppp;
 	data->driver =3D proto;
diff --git a/gatchat/ppp_cp.h b/gatchat/ppp_cp.h
index 56a20e0..1e69562 100644
--- a/gatchat/ppp_cp.h
+++ b/gatchat/ppp_cp.h
@@ -104,7 +104,7 @@ guint8 ppp_option_iter_get_length(struct ppp_option_ite=
r *iter);
 const guint8 *ppp_option_iter_get_data(struct ppp_option_iter *iter);
 =

 struct pppcp_data *pppcp_new(GAtPPP *ppp, const struct pppcp_proto *proto,
-				gboolean dormant);
+				gboolean dormant, int max_failure);
 void pppcp_free(struct pppcp_data *data);
 =

 void pppcp_set_data(struct pppcp_data *pppcp, gpointer data);
diff --git a/gatchat/ppp_ipcp.c b/gatchat/ppp_ipcp.c
index d64bded..3aa9eec 100644
--- a/gatchat/ppp_ipcp.c
+++ b/gatchat/ppp_ipcp.c
@@ -63,6 +63,8 @@ enum ipcp_option_types {
 #define REQ_OPTION_NBNS1	0x08
 #define REQ_OPTION_NBNS2	0x10
 =

+#define MAX_IPCP_FAILURE	100
+
 struct ipcp_data {
 	guint8 options[MAX_CONFIG_OPTION_SIZE];
 	guint16 options_len;
@@ -472,7 +474,13 @@ struct pppcp_data *ipcp_new(GAtPPP *ppp, gboolean is_s=
erver, guint32 ip)
 	if (!ipcp)
 		return NULL;
 =

-	pppcp =3D pppcp_new(ppp, &ipcp_proto, FALSE);
+	/*
+	 * Some 3G modems use repeated IPCP NAKs as the way of stalling
+	 * util sending us the client IP address. So we increase the
+	 * default number of NAKs we accept before start treating them
+	 * as rejects.
+	 */
+	pppcp =3D pppcp_new(ppp, &ipcp_proto, FALSE, MAX_IPCP_FAILURE);
 	if (!pppcp) {
 		g_printerr("Failed to allocate PPPCP struct\n");
 		g_free(ipcp);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 3cfab5c..5838ebd 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -313,7 +313,7 @@ struct pppcp_data *lcp_new(GAtPPP *ppp, gboolean is_ser=
ver)
 	if (!lcp)
 		return NULL;
 =

-	pppcp =3D pppcp_new(ppp, &lcp_proto, is_server);
+	pppcp =3D pppcp_new(ppp, &lcp_proto, is_server, 0);
 	if (!pppcp) {
 		g_free(lcp);
 		return NULL;
-- =

1.6.3.3


--===============6201995874838022092==--

