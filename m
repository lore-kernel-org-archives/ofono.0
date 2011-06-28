Content-Type: multipart/mixed; boundary="===============1554561646070903977=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 2/4] GAtPPP: Add PFC option support
Date: Tue, 28 Jun 2011 12:03:45 +0200
Message-ID: <1309255427-10308-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1309255427-10308-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1554561646070903977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c  |   63 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 gatchat/gatppp.h  |    1 +
 gatchat/ppp.h     |    4 +++
 gatchat/ppp_lcp.c |   30 ++++++++++++++++++++++--
 4 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index fe34ea1..01446d1 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -84,6 +84,7 @@ struct _GAtPPP {
 	guint guard_timeout_source;
 	gboolean suspended;
 	gboolean xmit_acfc;
+	gboolean xmit_pfc;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -172,6 +173,7 @@ static void ppp_receive(const unsigned char *buf, gsize=
 len, void *data)
 	struct ppp_header *header =3D (struct ppp_header *) buf;
 	gboolean acfc_frame =3D (header->address !=3D PPP_ADDR_FIELD
 			|| header->control !=3D PPP_CTRL);
+	gboolean pfc_frame =3D FALSE;
 	guint16 protocol;
 	const guint8 *packet;
 =

@@ -183,6 +185,20 @@ static void ppp_receive(const unsigned char *buf, gsiz=
e len, void *data)
 		packet =3D ppp_info(buf);
 	}
 =

+	pfc_frame =3D (protocol !=3D LCP_PROTOCOL && protocol !=3D CHAP_PROTOCOL =
&&
+			protocol !=3D IPCP_PROTO && protocol !=3D PPP_IP_PROTO);
+
+	if (pfc_frame) {
+		guint8 proto =3D (protocol >> 8) & 0xFF ;
+		packet =3D packet - 1;
+		/*
+		 * The only protocol that can be compressed is PPP_IP_PROTO
+		 * because first byte is 0x00.
+		 */
+		if (proto =3D=3D PPP_IP_COMPRESSED_PROTO)
+			protocol =3D PPP_IP_PROTO;
+	}
+
 	if (ppp_drop_packet(ppp, protocol))
 		return;
 =

@@ -264,6 +280,32 @@ static void ppp_send_acfc_frame(GAtPPP *ppp, guint8 *p=
acket,
 	if (ppp->xmit_acfc)
 		offset =3D 2;
 =

+	/* We remove the only address and control field */
+	if (g_at_hdlc_send(ppp->hdlc, packet + offset,
+				infolen + sizeof(*header) - offset)
+			=3D=3D FALSE)
+		DBG(ppp, "Failed to send a frame\n");
+}
+
+static void ppp_send_acfc_pfc_frame(GAtPPP *ppp, guint8 *packet,
+					guint infolen)
+{
+	struct ppp_header *header =3D (struct ppp_header *) packet;
+	guint offset =3D 0;
+
+	if (ppp->xmit_acfc && ppp->xmit_pfc)
+		offset =3D 3;
+	else if (ppp->xmit_acfc)
+		offset =3D 2;
+	else if (ppp->xmit_pfc) {
+		/*
+		 * We remove only the 1st byte that is 0x00 of protocol field.
+		 */
+		packet[2] =3D packet[1];
+		packet[1] =3D packet[0];
+		offset =3D 1;
+	}
+
 	if (g_at_hdlc_send(ppp->hdlc, packet + offset,
 				infolen + sizeof(*header) - offset)
 			=3D=3D FALSE)
@@ -285,9 +327,18 @@ void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint i=
nfolen)
 		break;
 	case CHAP_PROTOCOL:
 	case IPCP_PROTO:
-	case PPP_IP_PROTO:
+		/*
+		 * We can't use PFC option because first byte of CHAP_PROTOCOL
+		 * and IPCP_PROTO is not equal to 0x00
+		 */
 		ppp_send_acfc_frame(ppp, packet, infolen);
 		break;
+	case PPP_IP_PROTO:
+		/*
+		 * We can't use both compression options if they are negotiated
+		 */
+		ppp_send_acfc_pfc_frame(ppp, packet, infolen);
+		break;
 	}
 }
 =

@@ -435,6 +486,11 @@ void ppp_set_xmit_acfc(GAtPPP *ppp, gboolean acfc)
 	ppp->xmit_acfc =3D acfc;
 }
 =

+void ppp_set_xmit_pfc(GAtPPP *ppp, gboolean pfc)
+{
+	ppp->xmit_pfc =3D pfc;
+}
+
 static void io_disconnect(gpointer user_data)
 {
 	GAtPPP *ppp =3D user_data;
@@ -708,6 +764,11 @@ void g_at_ppp_set_acfc_enabled(GAtPPP *ppp)
 	lcp_turn_on_acfc(ppp->lcp);
 }
 =

+void g_at_ppp_set_pfc_enabled(GAtPPP *ppp)
+{
+	lcp_turn_on_pfc(ppp->lcp);
+}
+
 static GAtPPP *ppp_init_common(gboolean is_server, guint32 ip)
 {
 	GAtPPP *ppp;
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index 428f08f..57185b5 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -80,6 +80,7 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const char *re=
mote_ip,
 				const char *dns1, const char *dns2);
 =

 void g_at_ppp_set_acfc_enabled(GAtPPP *ppp);
+void g_at_ppp_set_pfc_enabled(GAtPPP *ppp);
 =

 #ifdef __cplusplus
 }
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 9d118b0..8ab031b 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -27,6 +27,8 @@
 #define PPP_IP_PROTO	0x0021
 #define MD5		5
 =

+#define PPP_IP_COMPRESSED_PROTO 0x21
+
 #define DBG(p, fmt, arg...) do {				\
 	char *str =3D g_strdup_printf("%s:%s() " fmt, __FILE__,	\
 					__FUNCTION__ , ## arg); \
@@ -96,6 +98,7 @@ struct pppcp_data *lcp_new(GAtPPP *ppp, gboolean dormant);
 void lcp_free(struct pppcp_data *lcp);
 void lcp_protocol_reject(struct pppcp_data *lcp, guint8 *packet, gsize len=
);
 void lcp_turn_on_acfc(struct pppcp_data *pppcp);
+void lcp_turn_on_pfc(struct pppcp_data *pppcp);
 =

 /* IPCP related functions */
 struct pppcp_data *ipcp_new(GAtPPP *ppp, gboolean is_server, guint32 ip);
@@ -133,4 +136,5 @@ void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_mtu(GAtPPP *ppp, const guint8 *data);
 void ppp_set_xmit_acfc(GAtPPP *ppp, gboolean acfc);
+void ppp_set_xmit_pfc(GAtPPP *ppp, gboolean pfc);
 struct ppp_header *ppp_packet_new(gsize infolen, guint16 protocol);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 9dfd534..40375d9 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -58,12 +58,13 @@ enum lcp_options {
 	ACFC			=3D 8,
 };
 =

-/* Maximum size of all options, we only ever request ACCM, MRU and ACFC */
-#define MAX_CONFIG_OPTION_SIZE 12
+/* Maximum size of all options, we only ever request ACCM, MRU, ACFC and P=
FC */
+#define MAX_CONFIG_OPTION_SIZE 14
 =

 #define REQ_OPTION_ACCM	0x1
 #define REQ_OPTION_MRU	0x2
 #define REQ_OPTION_ACFC	0x4
+#define REQ_OPTION_PFC	0x8
 =

 struct lcp_data {
 	guint8 options[MAX_CONFIG_OPTION_SIZE];
@@ -108,6 +109,13 @@ static void lcp_generate_config_options(struct lcp_dat=
a *lcp)
 		len +=3D 2;
 	}
 =

+	if (lcp->req_options & REQ_OPTION_PFC) {
+		lcp->options[len] =3D PFC;
+		lcp->options[len + 1] =3D 2;
+
+		len +=3D 2;
+	}
+
 	lcp->options_len =3D len;
 }
 =

@@ -292,9 +300,15 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppc=
p,
 			ppp_set_mtu(ppp, ppp_option_iter_get_data(&iter));
 			break;
 		case MAGIC_NUMBER:
-		case PFC:
 			/* don't care */
 			break;
+		case PFC:
+		{
+			struct lcp_data *lcp =3D pppcp_get_data(pppcp);
+			if (lcp->req_options & REQ_OPTION_PFC)
+				ppp_set_xmit_pfc(ppp, TRUE);
+			break;
+		}
 		case ACFC:
 		{
 			struct lcp_data *lcp =3D pppcp_get_data(pppcp);
@@ -361,3 +375,13 @@ void lcp_turn_on_acfc(struct pppcp_data *pppcp)
 =

 	pppcp_set_local_options(pppcp, lcp->options, lcp->options_len);
 }
+
+void lcp_turn_on_pfc(struct pppcp_data *pppcp)
+{
+	struct lcp_data *lcp =3D pppcp_get_data(pppcp);
+
+	lcp->req_options |=3D REQ_OPTION_PFC;
+	lcp_generate_config_options(lcp);
+
+	pppcp_set_local_options(pppcp, lcp->options, lcp->options_len);
+}
-- =

1.7.1


--===============1554561646070903977==--

