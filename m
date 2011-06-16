Content-Type: multipart/mixed; boundary="===============2553934101108011112=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/2] GAtPPP: Add ACFC option support
Date: Thu, 16 Jun 2011 13:55:20 +0200
Message-ID: <1308225321-21611-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1308225321-21611-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2553934101108011112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c  |  116 ++++++++++++++++++++++++++++++++++++++++++-------=
---
 gatchat/ppp.h     |    7 +++
 gatchat/ppp_lcp.c |   27 +++++++++++-
 3 files changed, 124 insertions(+), 26 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 5fb4146..a505db1 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -83,6 +83,9 @@ struct _GAtPPP {
 	int fd;
 	guint guard_timeout_source;
 	gboolean suspended;
+	gboolean acfc;
+	guint8 address;
+	guint8 control;
 };
 =

 void ppp_debug(GAtPPP *ppp, const char *str)
@@ -168,17 +171,39 @@ static inline gboolean ppp_drop_packet(GAtPPP *ppp, g=
uint16 protocol)
 static void ppp_receive(const unsigned char *buf, gsize len, void *data)
 {
 	GAtPPP *ppp =3D data;
-	guint16 protocol =3D ppp_proto(buf);
-	const guint8 *packet =3D ppp_info(buf);
+	struct ppp_header *header =3D (struct ppp_header *) buf;
+	gboolean acfc_frame =3D (header->address !=3D PPP_ADDR_FIELD
+			|| header->control !=3D PPP_CTRL);
+	guint16 protocol;
+	const guint8 *packet;
+
+	if (acfc_frame) {
+		protocol =3D ppp_acfc_proto(buf);
+		packet =3D ppp_acfc_info(buf);
+	} else {
+		protocol =3D ppp_proto(buf);
+		packet =3D ppp_info(buf);
+	}
 =

 	if (ppp_drop_packet(ppp, protocol))
 		return;
 =

+	/*
+	 * RFC 1661:
+	 * If we received PPP packets with Adress and Control Field Compressed
+	 * although ACFC had not been negociated, we silently discard them.
+	 */
+	if (!ppp->acfc && acfc_frame)
+		return;
+
 	switch (protocol) {
 	case PPP_IP_PROTO:
 		ppp_net_process_packet(ppp->net, packet);
 		break;
 	case LCP_PROTOCOL:
+		/* Those values will be tested while negociating ACFC option */
+		ppp->address =3D header->address;
+		ppp->control =3D header->control;
 		pppcp_process_packet(ppp->lcp, packet);
 		break;
 	case IPCP_PROTO:
@@ -196,37 +221,29 @@ static void ppp_receive(const unsigned char *buf, gsi=
ze len, void *data)
 	};
 }
 =

-/*
- * transmit out through the lower layer interface
- *
- * infolen - length of the information part of the packet
- */
-void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen)
+static void ppp_send_lcp_frame(GAtPPP *ppp, guint8 *packet, guint infolen)
 {
 	struct ppp_header *header =3D (struct ppp_header *) packet;
-	guint16 proto =3D ppp_proto(packet);
 	guint8 code;
-	gboolean lcp =3D (proto =3D=3D LCP_PROTOCOL);
 	guint32 xmit_accm =3D 0;
 	gboolean sta =3D FALSE;
+	gboolean lcp;
 =

 	/*
 	 * all LCP Link Configuration, Link Termination, and Code-Reject
 	 * packets must be sent with the default sending ACCM
 	 */
-	if (lcp) {
-		code =3D pppcp_get_code(packet);
-		lcp =3D code > 0 && code < 8;
-
-		/*
-		 * If we're going down, we try to make sure to send the final
-		 * ack before informing the upper layers via the ppp_disconnect
-		 * function.  Once we enter PPP_DEAD phase, no further packets
-		 * will be sent
-		 */
-		if (code =3D=3D PPPCP_CODE_TYPE_TERMINATE_ACK)
-			sta =3D TRUE;
-	}
+	code =3D pppcp_get_code(packet);
+	lcp =3D code > 0 && code < 8;
+
+	/*
+	 * If we're going down, we try to make sure to send the final
+	 * ack before informing the upper layers via the ppp_disconnect
+	 * function.  Once we enter PPP_DEAD phase, no further packets
+	 * will be sent
+	 */
+	if (code =3D=3D PPPCP_CODE_TYPE_TERMINATE_ACK)
+		sta =3D TRUE;
 =

 	if (lcp) {
 		xmit_accm =3D g_at_hdlc_get_xmit_accm(ppp->hdlc);
@@ -251,6 +268,42 @@ void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint i=
nfolen)
 		g_at_hdlc_set_xmit_accm(ppp->hdlc, xmit_accm);
 }
 =

+static void ppp_send_acfc_frame(GAtPPP *ppp, guint8 *packet,
+					guint infolen)
+{
+	struct ppp_header *header =3D (struct ppp_header *) packet;
+	guint offset =3D 0;
+
+	if (ppp->acfc)
+		offset =3D 2;
+
+	if (g_at_hdlc_send(ppp->hdlc, packet + offset,
+				infolen + sizeof(*header) - offset)
+			=3D=3D FALSE)
+		DBG(ppp, "Failed to send a frame\n");
+}
+
+/*
+ * transmit out through the lower layer interface
+ *
+ * infolen - length of the information part of the packet
+ */
+void ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen)
+{
+	guint16 proto =3D ppp_proto(packet);
+
+	switch (proto) {
+	case LCP_PROTOCOL:
+		ppp_send_lcp_frame(ppp, packet, infolen);
+		break;
+	case CHAP_PROTOCOL:
+	case IPCP_PROTO:
+	case PPP_IP_PROTO:
+		ppp_send_acfc_frame(ppp, packet, infolen);
+		break;
+	}
+}
+
 static inline void ppp_enter_phase(GAtPPP *ppp, enum ppp_phase phase)
 {
 	DBG(ppp, "%d", phase);
@@ -390,6 +443,23 @@ void ppp_set_mtu(GAtPPP *ppp, const guint8 *data)
 	ppp->mtu =3D mtu;
 }
 =

+gboolean ppp_set_acfc_enabled(GAtPPP *ppp, gboolean acfc)
+{
+	/*
+	 * RFC 1662:
+	 * When using the standard HDLC-like framing, the Address and Control
+	 * fields contain the hexadecimal values 0xff and 0x03 respectively.
+	 * When other Address or Control field values are in use, Address-
+	 * and-Control-Field-Compression MUST NOT be negotiated.
+	 */
+	if (ppp->address =3D=3D 0xFF && ppp->control =3D=3D 0x03)
+		ppp->acfc =3D acfc;
+	else
+		ppp->acfc =3D FALSE;
+
+	return ppp->acfc;
+}
+
 static void io_disconnect(gpointer user_data)
 {
 	GAtPPP *ppp =3D user_data;
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 023d779..3cf11f7 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -85,6 +85,12 @@ static inline void __put_unaligned_short(void *p, guint1=
6 val)
 #define ppp_proto(packet) \
 	(get_host_short(packet + 2))
 =

+#define ppp_acfc_info(packet) \
+	(packet + 2)
+
+#define ppp_acfc_proto(packet) \
+	(get_host_short(packet))
+
 /* LCP related functions */
 struct pppcp_data *lcp_new(GAtPPP *ppp, gboolean dormant);
 void lcp_free(struct pppcp_data *lcp);
@@ -125,4 +131,5 @@ void ppp_lcp_finished_notify(GAtPPP *ppp);
 void ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_xmit_accm(GAtPPP *ppp, guint32 accm);
 void ppp_set_mtu(GAtPPP *ppp, const guint8 *data);
+gboolean ppp_set_acfc_enabled(GAtPPP *ppp, gboolean acfc);
 struct ppp_header *ppp_packet_new(gsize infolen, guint16 protocol);
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index ce9dae2..24e7bae 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -58,11 +58,12 @@ enum lcp_options {
 	ACFC			=3D 8,
 };
 =

-/* Maximum size of all options, we only ever request ACCM and MRU */ =

-#define MAX_CONFIG_OPTION_SIZE 10
+/* Maximum size of all options, we only ever request ACCM, MRU and ACFC */
+#define MAX_CONFIG_OPTION_SIZE 12
 =

 #define REQ_OPTION_ACCM	0x1
 #define REQ_OPTION_MRU	0x2
+#define REQ_OPTION_ACFC	0x4
 =

 struct lcp_data {
 	guint8 options[MAX_CONFIG_OPTION_SIZE];
@@ -100,6 +101,13 @@ static void lcp_generate_config_options(struct lcp_dat=
a *lcp)
 		len +=3D 4;
 	}
 =

+	if (lcp->req_options & REQ_OPTION_ACFC) {
+		lcp->options[len] =3D ACFC;
+		lcp->options[len + 1] =3D 2;
+
+		len +=3D 2;
+	}
+
 	lcp->options_len =3D len;
 }
 =

@@ -110,6 +118,12 @@ static void lcp_reset_config_options(struct lcp_data *=
lcp)
 	lcp_generate_config_options(lcp);
 }
 =

+static void lcp_set_acfc_config_option(struct lcp_data *lcp)
+{
+	lcp->req_options |=3D REQ_OPTION_ACFC;
+	lcp_generate_config_options(lcp);
+}
+
 /*
  * signal the Up event to the NCP
  */
@@ -286,9 +300,16 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppc=
p,
 			break;
 		case MAGIC_NUMBER:
 		case PFC:
-		case ACFC:
 			/* don't care */
 			break;
+		case ACFC:
+			if (ppp_set_acfc_enabled(ppp, TRUE)) {
+				struct lcp_data *lcp =3D pppcp_get_data(pppcp);
+				lcp_set_acfc_config_option(lcp);
+				pppcp_set_local_options(pppcp, lcp->options,
+							lcp->options_len);
+			}
+			break;
 		}
 	}
 =

-- =

1.7.1


--===============2553934101108011112==--

