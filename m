Content-Type: multipart/mixed; boundary="===============8031430008920532484=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 1/1] gatchat: Add IPv6 CP support
Date: Wed, 26 Oct 2011 17:20:32 +0300
Message-ID: <1319638832-22487-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1319638832-22487-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8031430008920532484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    2 +-
 gatchat/gatppp.c      |   58 +++++++++-
 gatchat/gatppp.h      |    2 +
 gatchat/gsmdial.c     |    6 +
 gatchat/ppp.h         |   23 ++++
 gatchat/ppp_ipv6cp.c  |  306 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 gatchat/test-server.c |   17 +++-
 7 files changed, 410 insertions(+), 4 deletions(-)
 create mode 100644 gatchat/ppp_ipv6cp.c

diff --git a/Makefile.am b/Makefile.am
index 83b7737..44fdfff 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -76,7 +76,7 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 				gatchat/ppp.h gatchat/ppp_cp.h \
 				gatchat/ppp_cp.c gatchat/ppp_lcp.c \
 				gatchat/ppp_auth.c gatchat/ppp_net.c \
-				gatchat/ppp_ipcp.c
+				gatchat/ppp_ipcp.c gatchat/ppp_ipv6cp.c
 =

 gisi_sources =3D gisi/client.c gisi/client.h gisi/common.h \
 				gisi/iter.c gisi/iter.h \
diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index f767f4a..41f9dff 100644
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
@@ -381,6 +387,13 @@ void ppp_auth_notify(GAtPPP *ppp, gboolean success)
 =

 	ppp_enter_phase(ppp, PPP_PHASE_NETWORK);
 =

+	/* Send UP & OPEN events to the IPv6 CP */
+	if (ppp->ipv6cp) {
+		pppcp_signal_open(ppp->ipv6cp);
+		pppcp_signal_up(ppp->ipv6cp);
+		return;
+	}
+
 	/* Send UP & OPEN events to the IPCP layer */
 	pppcp_signal_open(ppp->ipcp);
 	pppcp_signal_up(ppp->ipcp);
@@ -435,6 +448,28 @@ void ppp_ipcp_finished_notify(GAtPPP *ppp)
 	pppcp_signal_close(ppp->lcp);
 }
 =

+void ppp_ipv6cp_up_notify(GAtPPP *ppp, const char *local, const char *peer)
+{
+	DBG(ppp, "local: %s, peer: %s", local, peer);
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
+	pppcp_signal_close(ppp->lcp);
+}
+
 void ppp_lcp_up_notify(GAtPPP *ppp)
 {
 	/* Wait for the peer to send us a challenge if we expect auth */
@@ -732,6 +767,8 @@ void g_at_ppp_unref(GAtPPP *ppp)
 =

 	lcp_free(ppp->lcp);
 	ipcp_free(ppp->ipcp);
+	if (ppp->ipv6cp)
+		ipv6cp_free(ppp->ipv6cp);
 =

 	if (ppp->ppp_dead_source) {
 		g_source_remove(ppp->ppp_dead_source);
@@ -772,6 +809,25 @@ void g_at_ppp_set_pfc_enabled(GAtPPP *ppp, gboolean en=
abled)
 	lcp_set_pfc_enabled(ppp->lcp, enabled);
 }
 =

+void g_at_ppp_set_ipv6cp_info(GAtPPP *ppp, const char *local, const char *=
peer)
+{
+	struct in6_addr local_addr;
+	struct in6_addr peer_addr;
+
+	if (local)
+		inet_pton(AF_INET6, local, &local_addr);
+	else
+		memset(&local_addr, 0, sizeof(local_addr));
+
+	if (peer)
+		inet_pton(AF_INET6, peer, &peer_addr);
+	else
+		memset(&peer_addr, 0, sizeof(peer_addr));
+
+	ppp->ipv6cp =3D ipv6cp_new(ppp, (void *) &local_addr.s6_addr[8],
+						(void *) &peer_addr.s6_addr[8]);
+}
+
 static GAtPPP *ppp_init_common(gboolean is_server, guint32 ip)
 {
 	GAtPPP *ppp;
diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index b5a2234..9099d6b 100644
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
@@ -81,6 +82,7 @@ void g_at_ppp_set_server_info(GAtPPP *ppp, const char *re=
mote_ip,
 =

 void g_at_ppp_set_acfc_enabled(GAtPPP *ppp, gboolean enabled);
 void g_at_ppp_set_pfc_enabled(GAtPPP *ppp, gboolean enabled);
+void g_at_ppp_set_ipv6cp_info(GAtPPP *ppp, const char *local, const char *=
peer);
 =

 #ifdef __cplusplus
 }
diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index be159eb..8f30309 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -59,6 +59,7 @@ static gchar *option_pppdump =3D NULL;
 static gboolean option_bluetooth =3D FALSE;
 static gboolean option_acfc =3D FALSE;
 static gboolean option_pfc =3D FALSE;
+static gchar *option_ipv6 =3D NULL;
 =

 static GAtPPP *ppp;
 static GAtChat *control;
@@ -372,6 +373,9 @@ static void connect_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	if (option_pppdump)
 		g_at_ppp_set_recording(ppp, option_pppdump);
 =

+	if (option_ipv6)
+		g_at_ppp_set_ipv6cp_info(ppp, option_ipv6, NULL);
+
 	g_at_ppp_set_credentials(ppp, option_username, option_password);
 =

 	g_at_ppp_set_acfc_enabled(ppp, option_acfc);
@@ -687,6 +691,8 @@ static GOptionEntry options[] =3D {
 				"Use Protocol Field Compression" },
 	{ "acfc", 0, 0, G_OPTION_ARG_NONE, &option_acfc,
 				"Use Address & Control Field Compression" },
+	{ "ipv6", '6', 0, G_OPTION_ARG_STRING, &option_ipv6,
+				"Specify IPv6 address" },
 	{ NULL },
 };
 =

diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index a20fe85..5cb79f8 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -24,7 +24,9 @@
 #define LCP_PROTOCOL	0xc021
 #define CHAP_PROTOCOL	0xc223
 #define IPCP_PROTO	0x8021
+#define IPV6CP_PROTO	0x8057
 #define PPP_IP_PROTO	0x0021
+#define PPP_IPV6_PROTO	0x0057
 #define MD5		5
 =

 #define DBG(p, fmt, arg...) do {				\
@@ -44,6 +46,19 @@ struct ppp_header {
 	guint8 info[0];
 } __attribute__((packed));
 =

+struct eui64 {
+	union {
+		guint8 __e8[8];
+		guint16 __e16[4];
+		guint32 __e32[2];
+	} __u;
+#define e6_addr		__u.__e8
+#define e6_addr16	__u.__e16
+#define e6_addr32	__u.__e32
+};
+
+#define EUI64_ANY_INIT { { { 0, 0, 0, 0, 0, 0, 0, 0 } } }
+
 struct packed_short {
 	guint16 s;
 } __attribute__((packed));
@@ -95,6 +110,11 @@ void ipcp_free(struct pppcp_data *data);
 void ipcp_set_server_info(struct pppcp_data *ipcp, guint32 peer_addr,
 				guint32 dns1, guint32 dns2);
 =

+/* IPv6 CP related functions */
+struct pppcp_data *ipv6cp_new(GAtPPP *ppp, const struct eui64 *local_addr,
+				const struct eui64 *peer_addr);
+void ipv6cp_free(struct pppcp_data *data);
+
 /* CHAP related functions */
 struct ppp_chap *ppp_chap_new(GAtPPP *ppp, guint8 method);
 void ppp_chap_free(struct ppp_chap *chap);
@@ -120,6 +140,9 @@ void ppp_ipcp_up_notify(GAtPPP *ppp, const char *local,=
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
new file mode 100644
index 0000000..b30d38a
--- /dev/null
+++ b/gatchat/ppp_ipv6cp.c
@@ -0,0 +1,306 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2011  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <arpa/inet.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include <string.h>
+
+#include <glib.h>
+
+#include "gatppp.h"
+#include "ppp.h"
+
+#define IPV6CP_SUPPORTED_CODES	((1 << PPPCP_CODE_TYPE_CONFIGURE_REQUEST) |=
 \
+				(1 << PPPCP_CODE_TYPE_CONFIGURE_ACK) | \
+				(1 << PPPCP_CODE_TYPE_CONFIGURE_NAK) | \
+				(1 << PPPCP_CODE_TYPE_CONFIGURE_REJECT) | \
+				(1 << PPPCP_CODE_TYPE_TERMINATE_REQUEST) | \
+				(1 << PPPCP_CODE_TYPE_TERMINATE_ACK) | \
+				(1 << PPPCP_CODE_TYPE_CODE_REJECT))
+
+enum ipv6cp_option_types {
+	IPV6CP_INTERFACE_ID		=3D 1,
+	IPV6CP_COMPRESSION_PROTO	=3D 2,
+};
+
+#define OPTIONS_COPY(_options, _len, _req, _type, _var, _opt_len)	\
+	if (_req) {							\
+		_options[_len] =3D _type;					\
+		_options[_len + 1] =3D _opt_len + 2;			\
+		memcpy(_options + _len + 2, _var, _opt_len);		\
+		_len +=3D _opt_len + 2;					\
+	}
+
+/* We request only IPv6 Interface Id */
+#define MAX_IPV6CP_CONFIG_OPTION_SIZE	10
+#define MAX_IPV6CP_FAILURE		3
+
+struct ipv6cp_data {
+	guint8 options[MAX_IPV6CP_CONFIG_OPTION_SIZE];
+	guint16 options_len;
+	guint8 req_options;
+	struct eui64 local_addr;
+	struct eui64 peer_addr;
+};
+
+static const struct eui64 eui64_any =3D EUI64_ANY_INIT;
+
+static void ipv6cp_generate_config_options(struct ipv6cp_data *ipv6cp)
+{
+	guint16 len =3D 0;
+
+	OPTIONS_COPY(ipv6cp->options, len,
+			ipv6cp->req_options & IPV6CP_INTERFACE_ID,
+			IPV6CP_INTERFACE_ID, &ipv6cp->local_addr,
+			sizeof(ipv6cp->local_addr));
+
+	ipv6cp->options_len =3D len;
+}
+
+static void ipv6cp_reset_config_options(struct ipv6cp_data *ipv6cp)
+{
+	ipv6cp->req_options =3D IPV6CP_INTERFACE_ID;
+
+	ipv6cp_generate_config_options(ipv6cp);
+}
+
+static void ipv6cp_up(struct pppcp_data *pppcp)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+	struct in6_addr local_addr, peer_addr;
+	char local[INET6_ADDRSTRLEN], peer[INET6_ADDRSTRLEN];
+
+	memset(&local_addr, 0, sizeof(local_addr));
+	memcpy(&local_addr.s6_addr[8], &ipv6cp->local_addr,
+					sizeof(ipv6cp->local_addr));
+	memset(&peer_addr, 0, sizeof(peer_addr));
+	memcpy(&peer_addr.s6_addr[8], &ipv6cp->peer_addr,
+					sizeof(ipv6cp->peer_addr));
+	ppp_ipv6cp_up_notify(pppcp_get_ppp(pppcp),
+		inet_ntop(AF_INET6, &local_addr, local, INET6_ADDRSTRLEN),
+		inet_ntop(AF_INET6, &peer_addr, peer, INET6_ADDRSTRLEN));
+}
+
+static void ipv6cp_down(struct pppcp_data *pppcp)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+
+	ipv6cp_reset_config_options(ipv6cp);
+
+	pppcp_set_local_options(pppcp, ipv6cp->options, ipv6cp->options_len);
+	ppp_ipv6cp_down_notify(pppcp_get_ppp(pppcp));
+}
+
+static void ipv6cp_finished(struct pppcp_data *pppcp)
+{
+	ppp_ipv6cp_finished_notify(pppcp_get_ppp(pppcp));
+}
+
+static enum rcr_result ipv6cp_peer_addr_check(struct ipv6cp_data *ipv6cp,
+						const void *data)
+{
+	if (memcmp(&eui64_any, data, sizeof(eui64_any)) =3D=3D 0)
+		return RCR_NAK;
+
+	return RCR_ACCEPT;
+}
+
+static enum rcr_result ipv6cp_rcr(struct pppcp_data *pppcp,
+					const struct pppcp_packet *packet,
+					guint8 **new_options, guint16 *new_len)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+	struct ppp_option_iter iter;
+	enum rcr_result result =3D RCR_ACCEPT;
+	guint16 len =3D 0, max_len =3D ntohs(packet->length) - 4;
+	guint8 *options =3D g_new0(guint8, max_len);
+	gboolean copy =3D TRUE;
+
+	ppp_option_iter_init(&iter, packet);
+
+	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
+		guint8 type =3D ppp_option_iter_get_type(&iter);
+		const guint8 *data =3D ppp_option_iter_get_data(&iter);
+
+		switch (type) {
+		case IPV6CP_INTERFACE_ID:
+			if (result =3D=3D RCR_ACCEPT) {
+
+				result =3D ipv6cp_peer_addr_check(ipv6cp, data);
+
+				if (result =3D=3D RCR_ACCEPT)
+					memcpy(&ipv6cp->peer_addr, data,
+						sizeof(ipv6cp->peer_addr));
+				else
+					data =3D ipv6cp->peer_addr.e6_addr;
+			}
+			break;
+		default:
+			if (result =3D=3D RCR_NAK) {
+				copy =3D FALSE;
+			} else if (result !=3D RCR_REJECT) {
+				result =3D RCR_REJECT;
+				len =3D 0;
+			}
+			break;
+		}
+
+		OPTIONS_COPY(options, len, TRUE, type, data,
+					ppp_option_iter_get_length(&iter));
+	}
+
+	if (!len) {
+		g_free(options);
+		options =3D NULL;
+	}
+
+	*new_len =3D len;
+	*new_options =3D options;
+
+	return result;
+}
+
+static void ipv6cp_rca(struct pppcp_data *pppcp,
+					const struct pppcp_packet *packet)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+	struct ppp_option_iter iter;
+
+	ppp_option_iter_init(&iter, packet);
+
+	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
+		const guint8 *data =3D ppp_option_iter_get_data(&iter);
+
+		switch (ppp_option_iter_get_type(&iter)) {
+		case IPV6CP_INTERFACE_ID:
+			if (memcmp(&ipv6cp->local_addr, data,
+					sizeof(ipv6cp->local_addr)))
+				DBG(pppcp_get_ppp(pppcp), "");
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void ipv6cp_rcn_nak(struct pppcp_data *pppcp,
+				const struct pppcp_packet *packet)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+	struct ppp_option_iter iter;
+
+	ppp_option_iter_init(&iter, packet);
+
+	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
+		const guint8 *data =3D ppp_option_iter_get_data(&iter);
+
+		switch (ppp_option_iter_get_type(&iter)) {
+		case IPV6CP_INTERFACE_ID:
+			memcpy(&ipv6cp->local_addr, data,
+				sizeof(ipv6cp->local_addr));
+			break;
+		default:
+			break;
+		}
+	}
+
+	ipv6cp_generate_config_options(ipv6cp);
+	pppcp_set_local_options(pppcp, ipv6cp->options, ipv6cp->options_len);
+}
+
+static void ipv6cp_rcn_rej(struct pppcp_data *pppcp,
+				const struct pppcp_packet *packet)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+	struct ppp_option_iter iter;
+
+	ppp_option_iter_init(&iter, packet);
+
+	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
+		switch (ppp_option_iter_get_type(&iter)) {
+		case IPV6CP_INTERFACE_ID:
+			ipv6cp->req_options &=3D ~IPV6CP_INTERFACE_ID;
+			memset(&ipv6cp->local_addr, 0,
+				sizeof(ipv6cp->local_addr));
+			break;
+		default:
+			break;
+		}
+	}
+
+	ipv6cp_generate_config_options(ipv6cp);
+	pppcp_set_local_options(pppcp, ipv6cp->options, ipv6cp->options_len);
+}
+
+struct pppcp_proto ipv6cp_proto =3D {
+	.proto			=3D IPV6CP_PROTO,
+	.name			=3D "ipv6cp",
+	.supported_codes	=3D IPV6CP_SUPPORTED_CODES,
+	.this_layer_up		=3D ipv6cp_up,
+	.this_layer_down	=3D ipv6cp_down,
+	.this_layer_finished	=3D ipv6cp_finished,
+	.rca			=3D ipv6cp_rca,
+	.rcn_nak		=3D ipv6cp_rcn_nak,
+	.rcn_rej		=3D ipv6cp_rcn_rej,
+	.rcr			=3D ipv6cp_rcr,
+};
+
+struct pppcp_data *ipv6cp_new(GAtPPP *ppp, const struct eui64 *local_addr,
+						const struct eui64 *peer_addr)
+{
+	struct ipv6cp_data *ipv6cp;
+	struct pppcp_data *pppcp;
+
+	ipv6cp =3D g_try_new0(struct ipv6cp_data, 1);
+	if (ipv6cp =3D=3D NULL)
+		return NULL;
+
+	pppcp =3D pppcp_new(ppp, &ipv6cp_proto, FALSE, MAX_IPV6CP_FAILURE);
+	if (pppcp =3D=3D NULL) {
+		g_free(ipv6cp);
+		return NULL;
+	}
+
+	memcpy(&ipv6cp->local_addr, local_addr, sizeof(ipv6cp->local_addr));
+	memcpy(&ipv6cp->peer_addr, peer_addr, sizeof(ipv6cp->peer_addr));
+
+	pppcp_set_data(pppcp, ipv6cp);
+
+	ipv6cp_reset_config_options(ipv6cp);
+
+	pppcp_set_local_options(pppcp, ipv6cp->options, ipv6cp->options_len);
+
+	return pppcp;
+}
+
+void ipv6cp_free(struct pppcp_data *data)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(data);
+
+	g_free(ipv6cp);
+	pppcp_free(data);
+}
diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 6f1d06d..59bbbe1 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -58,6 +58,8 @@ static int modem_creg =3D 0;
 static int modem_cgreg =3D 0;
 static int network_status =3D 4;
 static int network_attach =3D 0;
+static const char *ipv6_local_addr =3D NULL;
+static const char *ipv6_peer_addr =3D NULL;
 =

 struct sock_server{
 	int server_sock;
@@ -176,6 +178,9 @@ static gboolean setup_ppp(GAtServer *server)
 	g_at_ppp_set_server_info(ppp, "192.168.1.2",
 					"10.10.10.10", "10.10.10.11");
 =

+	if (ipv6_local_addr || ipv6_peer_addr)
+		g_at_ppp_set_ipv6cp_info(ppp, ipv6_local_addr, ipv6_peer_addr);
+
 	return TRUE;
 }
 =

@@ -1118,11 +1123,13 @@ static void usage(void)
 {
 	g_print("test-server - AT Server testing\n"
 		"Usage:\n");
-	g_print("\ttest-server [-t type]\n");
+	g_print("\ttest-server [-t type] [-6 addr]\n");
 	g_print("Types:\n"
 		"\t0: Pseudo TTY port (default)\n"
 		"\t1: TCP sock at port 12346)\n"
 		"\t2: Unix sock at ./server_sock\n");
+	g_print("-l\tSpecify local IPv6 address\n");
+	g_print("-p\tSpecify peer IPv6 address\n");
 }
 =

 int main(int argc, char **argv)
@@ -1130,11 +1137,17 @@ int main(int argc, char **argv)
 	int opt, signal_source;
 	int type =3D 0;
 =

-	while ((opt =3D getopt(argc, argv, "ht:")) !=3D EOF) {
+	while ((opt =3D getopt(argc, argv, "hl:p:t:")) !=3D EOF) {
 		switch (opt) {
 		case 't':
 			type =3D atoi(optarg);
 			break;
+		case 'l':
+			ipv6_local_addr =3D optarg;
+			break;
+		case 'p':
+			ipv6_peer_addr =3D optarg;
+			break;
 		case 'h':
 			usage();
 			exit(1);
-- =

1.7.4.1


--===============8031430008920532484==--

