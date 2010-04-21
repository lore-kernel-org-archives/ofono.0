Content-Type: multipart/mixed; boundary="===============5427567026427259081=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: implement MRU option
Date: Wed, 21 Apr 2010 15:26:30 -0700
Message-ID: <1271888790-5046-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5427567026427259081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the peer requests a MRU option, set the mtu for the network
phase.  When we are in link establishment phase, we should
continue to behave as if no option has been set and the peer
should use the default MRU.

This option is required for the Huawei E160G modem.
---
 gatchat/gatppp.c  |   16 ++++++++++++++++
 gatchat/ppp.h     |    2 ++
 gatchat/ppp_lcp.c |    4 ++++
 gatchat/ppp_net.c |   13 +++++++++++--
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index e1e49e6..b7834e3 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -40,6 +40,7 @@
 #include "ppp.h"
 =

 #define DEFAULT_MRU	1500
+#define DEFAULT_MTU	1500
 =

 #define BUFFERSZ	(DEFAULT_MRU * 2)
 =

@@ -58,6 +59,7 @@ struct _GAtPPP {
 	guint8 buffer[BUFFERSZ];
 	int index;
 	gint mru;
+	gint mtu;
 	char username[256];
 	char password[256];
 	guint32 xmit_accm[8];
@@ -407,6 +409,8 @@ void ppp_net_up_notify(GAtPPP *ppp, const char *ip,
 {
 	ppp->net =3D ppp_net_new(ppp);
 =

+	ppp_net_set_mtu(ppp->net, ppp->mtu);
+
 	if (ppp->connect_cb =3D=3D NULL)
 		return;
 =

@@ -435,6 +439,17 @@ void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm)
 	ppp->xmit_accm[0] =3D accm;
 }
 =

+/*
+ * The only time we use other than default MTU is when we are in
+ * the network phase.
+ */
+void ppp_set_mtu(GAtPPP *ppp, const guint8 *data)
+{
+	guint16 mtu =3D get_host_short(data);
+
+	ppp->mtu =3D mtu;
+}
+
 /* Administrative Open */
 void g_at_ppp_open(GAtPPP *ppp)
 {
@@ -576,6 +591,7 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem)
 =

 	/* set options to defaults */
 	ppp->mru =3D DEFAULT_MRU;
+	ppp->mtu =3D DEFAULT_MTU;
 	ppp->recv_accm =3D ~0U;
 	ppp->xmit_accm[0] =3D ~0U;
 	ppp->xmit_accm[3] =3D 0x60000000; /* 0x7d, 0x7e */
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index a8a0486..07483a9 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -103,6 +103,7 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp);
 const char *ppp_net_get_interface(struct ppp_net *net);
 void ppp_net_process_packet(struct ppp_net *net, guint8 *packet);
 void ppp_net_free(struct ppp_net *net);
+void ppp_net_set_mtu(struct ppp_net *net, guint16 mtu);
 =

 /* PPP functions related to main GAtPPP object */
 void ppp_debug(GAtPPP *ppp, const char *str);
@@ -115,3 +116,4 @@ void ppp_net_up_notify(GAtPPP *ppp, const char *ip,
 void ppp_net_down_notify(GAtPPP *ppp);
 void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
+void ppp_set_mtu(GAtPPP *ppp, const guint8 *data);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 5cf5656..8639c6c 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -197,6 +197,7 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 		case ACCM:
 		case PFC:
 		case ACFC:
+		case MRU:
 			break;
 =

 		case MAGIC_NUMBER:
@@ -226,6 +227,9 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
 		case AUTH_PROTO:
 			ppp_set_auth(ppp, ppp_option_iter_get_data(&iter));
 			break;
+		case MRU:
+			ppp_set_mtu(ppp, ppp_option_iter_get_data(&iter));
+			break;
 		case MAGIC_NUMBER:
 		case PFC:
 		case ACFC:
diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 325e859..c1f2eb4 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -38,7 +38,6 @@
 #include "gatppp.h"
 #include "ppp.h"
 =

-/* XXX should be maximum IP Packet size */
 #define MAX_PACKET 1500
 =

 struct ppp_net {
@@ -46,8 +45,17 @@ struct ppp_net {
 	char *if_name;
 	GIOChannel *channel;
 	gint watch;
+	gint mtu;
 };
 =

+void ppp_net_set_mtu(struct ppp_net *net, guint16 mtu)
+{
+	if (net =3D=3D NULL)
+		return;
+
+	net->mtu =3D mtu;
+}
+
 void ppp_net_process_packet(struct ppp_net *net, guint8 *packet)
 {
 	GError *error =3D NULL;
@@ -80,7 +88,7 @@ static gboolean ppp_net_callback(GIOChannel *channel, GIO=
Condition cond,
 =

 	if (cond & G_IO_IN) {
 		/* leave space to add PPP protocol field */
-		status =3D g_io_channel_read_chars(channel, buf + 2, MAX_PACKET,
+		status =3D g_io_channel_read_chars(channel, buf + 2, net->mtu,
 				&bytes_read, &error);
 		if (bytes_read > 0) {
 			ppp->proto =3D htons(PPP_IP_PROTO);
@@ -140,6 +148,7 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp)
 			ppp_net_callback, net);
 	net->ppp =3D ppp;
 =

+	net->mtu =3D MAX_PACKET;
 	return net;
 =

 error:
-- =

1.6.6.1


--===============5427567026427259081==--

