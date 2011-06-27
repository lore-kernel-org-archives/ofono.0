Content-Type: multipart/mixed; boundary="===============3033478559341929028=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/2] GAtPPP: Add PFC option support
Date: Mon, 27 Jun 2011 18:15:30 +0200
Message-ID: <1309191330-5462-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1309191330-5462-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3033478559341929028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c  |   68 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 gatchat/gatppp.h  |    1 +
 gatchat/ppp.h     |    4 +++
 gatchat/ppp_lcp.c |   27 ++++++++++++++++++--
 4 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 2640985..2a0159f 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -84,7 +84,9 @@ struct _GAtPPP {
 	guint guard_timeout_source;
 	gboolean suspended;
 	gboolean force_acfc_off;
+	gboolean force_pfc_off;
 	gboolean acfc;
+	gboolean pfc;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -173,6 +175,7 @@ static void ppp_receive(const unsigned char *buf, gsize=
 len, void *data)
 	struct ppp_header *header =3D (struct ppp_header *) buf;
 	gboolean acfc_frame =3D (header->address !=3D PPP_ADDR_FIELD
 			|| header->control !=3D PPP_CTRL);
+	gboolean pfc_frame =3D FALSE;
 	guint16 protocol;
 	const guint8 *packet;
 =

@@ -184,6 +187,20 @@ static void ppp_receive(const unsigned char *buf, gsiz=
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

@@ -268,6 +285,32 @@ static void ppp_send_acfc_frame(GAtPPP *ppp, guint8 *p=
acket,
 		offset =3D 2;
 	else
 		offset =3D 0;
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
+	if (ppp->acfc && ppp->pfc)
+		offset =3D 3;
+	else if (ppp->acfc)
+		offset =3D 2;
+	else if (ppp->pfc) {
+		/*
+		 * We remove only the 1st byte that is 0x00 of protocol field.
+		 */
+		packet[2] =3D packet[1];
+		packet[1] =3D packet[0];
+		offset =3D 1;
+	} else
+		offset =3D 0;
 =

 	if (g_at_hdlc_send(ppp->hdlc, packet + offset,
 				infolen + sizeof(*header) - offset)
@@ -286,13 +329,22 @@ void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint =
infolen)
 =

 	switch (proto) {
 	case LCP_PROTOCOL:
+		/* Don't use any compression for LCP packets */
 		ppp_send_common_frame(ppp, packet, infolen, TRUE);
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
 	}
 }
 =

@@ -443,6 +495,14 @@ void ppp_set_acfc_enabled(GAtPPP *ppp, gboolean acfc)
 		ppp->acfc =3D acfc;
 }
 =

+void ppp_set_pfc_enabled(GAtPPP *ppp, gboolean pfc)
+{
+	if (ppp->force_pfc_off)
+		ppp->pfc =3D FALSE;
+	else
+		ppp->pfc =3D pfc;
+}
+
 static void io_disconnect(gpointer user_data)
 {
 	GAtPPP *ppp =3D user_data;
@@ -717,6 +777,12 @@ void g_at_ppp_force_acfc_off(GAtPPP *ppp, gboolean off)
 	lcp_turn_off_acfc(ppp->lcp);
 }
 =

+void g_at_ppp_force_pfc_off(GAtPPP *ppp, gboolean off)
+{
+	ppp->force_acfc_off =3D off;
+	lcp_turn_off_pfc(ppp->lcp);
+}
+
 static GAtPPP *ppp_init_common(gboolean is_server, guint32 ip)
 {
 	GAtPPP *ppp;
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index d0231fc..b7933d3 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -80,6 +80,7 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const char *re=
mote_ip,
 				const char *dns1, const char *dns2);
 =

 void g_at_ppp_force_acfc_off(GAtPPP *ppp, gboolean off);
+void g_at_ppp_force_pfc_off(GAtPPP *ppp, gboolean off);
 =

 #ifdef __cplusplus
 }
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 116b5db..3a0b2bf 100644
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
 void lcp_turn_off_acfc(struct pppcp_data *pppcp);
+void lcp_turn_off_pfc(struct pppcp_data *pppcp);
 =

 /* IPCP related functions */
 struct pppcp_data *ipcp_new(GAtPPP *ppp, gboolean is_server, guint32 ip);
@@ -133,4 +136,5 @@ void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_mtu(GAtPPP *ppp, const guint8 *data);
 void ppp_set_acfc_enabled(GAtPPP *ppp, gboolean acfc);
+void ppp_set_pfc_enabled(GAtPPP *ppp, gboolean acfc);
 struct ppp_header *ppp_packet_new(gsize infolen, guint16 protocol);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 3814ddf..18dfea4 100644
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

@@ -115,6 +123,7 @@ static void lcp_reset_config_options(struct lcp_data *l=
cp)
 {
 	/* Using the default ACCM */
 	lcp->req_options |=3D REQ_OPTION_ACFC;
+	lcp->req_options |=3D REQ_OPTION_PFC;
 	lcp_generate_config_options(lcp);
 }
 =

@@ -293,9 +302,11 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppc=
p,
 			ppp_set_mtu(ppp, ppp_option_iter_get_data(&iter));
 			break;
 		case MAGIC_NUMBER:
-		case PFC:
 			/* don't care */
 			break;
+		case PFC:
+			ppp_set_pfc_enabled(ppp, TRUE);
+			break;
 		case ACFC:
 			ppp_set_acfc_enabled(ppp, TRUE);
 			break;
@@ -358,3 +369,13 @@ void lcp_turn_off_acfc(struct pppcp_data *pppcp)
 =

 	pppcp_set_local_options(pppcp, lcp->options, lcp->options_len);
 }
+
+void lcp_turn_off_pfc(struct pppcp_data *pppcp)
+{
+	struct lcp_data *lcp =3D pppcp_get_data(pppcp);
+
+	lcp->req_options &=3D ~REQ_OPTION_PFC;
+	lcp_generate_config_options(lcp);
+
+	pppcp_set_local_options(pppcp, lcp->options, lcp->options_len);
+}
-- =

1.7.1


--===============3033478559341929028==--

