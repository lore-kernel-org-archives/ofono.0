Content-Type: multipart/mixed; boundary="===============5661941850927134419=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 1/6] gatchat: Add IPv6 Control Protocol
Date: Tue, 08 Nov 2011 14:46:53 +0200
Message-ID: <1320756418-30890-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1320756418-30890-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5661941850927134419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    2 +-
 gatchat/ppp.h        |    8 +
 gatchat/ppp_ipv6cp.c |  377 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 386 insertions(+), 1 deletions(-)
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
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index a20fe85..718575b 100644
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
@@ -95,6 +97,12 @@ void ipcp_free(struct pppcp_data *data);
 void ipcp_set_server_info(struct pppcp_data *ipcp, guint32 peer_addr,
 				guint32 dns1, guint32 dns2);
 =

+/* IPv6 CP related functions */
+struct pppcp_data *ipv6cp_new(GAtPPP *ppp, gboolean is_server,
+					const char *local, const char *peer,
+					GError **error);
+void ipv6cp_free(struct pppcp_data *data);
+
 /* CHAP related functions */
 struct ppp_chap *ppp_chap_new(GAtPPP *ppp, guint8 method);
 void ppp_chap_free(struct ppp_chap *chap);
diff --git a/gatchat/ppp_ipv6cp.c b/gatchat/ppp_ipv6cp.c
new file mode 100644
index 0000000..ec89fb7
--- /dev/null
+++ b/gatchat/ppp_ipv6cp.c
@@ -0,0 +1,377 @@
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
+#include <errno.h>
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
+#define OPTION_COPY(_options, _len, _req, _type, _var, _opt_len)	\
+	if (_req) {							\
+		_options[_len] =3D _type;					\
+		_options[_len + 1] =3D _opt_len + 2;			\
+		memcpy(_options + _len + 2, _var, _opt_len);		\
+		_len +=3D _opt_len + 2;					\
+	}
+
+/* We request only IPv6 Interface Id */
+#define IPV6CP_MAX_CONFIG_OPTION_SIZE	10
+#define IPV6CP_MAX_FAILURE		3
+#define IPV6CP_ERROR ipv6cp_error_quark()
+
+enum ipv6cp_option_types {
+	IPV6CP_INTERFACE_ID =3D 1,
+};
+
+struct ipv6cp_data {
+	guint8 options[IPV6CP_MAX_CONFIG_OPTION_SIZE];
+	guint16 options_len;
+	guint8 req_options;
+	guint64 local_addr;
+	guint64 peer_addr;
+	gboolean is_server;
+};
+
+static GQuark ipv6cp_error_quark(void)
+{
+	return g_quark_from_static_string("ipv6cp");
+}
+
+static void ipv6cp_generate_config_options(struct ipv6cp_data *ipv6cp)
+{
+	guint16 len =3D 0;
+
+	OPTION_COPY(ipv6cp->options, len,
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
+
+}
+
+static void ipv6cp_down(struct pppcp_data *pppcp)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+
+	ipv6cp_reset_config_options(ipv6cp);
+
+	pppcp_set_local_options(pppcp, ipv6cp->options, ipv6cp->options_len);
+}
+
+static void ipv6cp_finished(struct pppcp_data *pppcp)
+{
+
+}
+
+static enum rcr_result ipv6cp_server_rcr(struct ipv6cp_data *ipv6cp,
+					const struct pppcp_packet *packet,
+					guint8 **new_options, guint16 *new_len)
+{
+	struct ppp_option_iter iter;
+	guint8 nak_options[IPV6CP_MAX_CONFIG_OPTION_SIZE];
+	guint16 len =3D 0;
+	guint8 *rej_options =3D NULL;
+	guint16 rej_len =3D 0;
+	guint64 addr;
+
+	ppp_option_iter_init(&iter, packet);
+
+	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
+		guint8 type =3D ppp_option_iter_get_type(&iter);
+		const void *data =3D ppp_option_iter_get_data(&iter);
+
+		switch (type) {
+		case IPV6CP_INTERFACE_ID:
+			memcpy(&addr, data, sizeof(addr));
+
+			OPTION_COPY(nak_options, len,
+					addr !=3D ipv6cp->peer_addr || addr =3D=3D 0,
+					type, &ipv6cp->peer_addr,
+					ppp_option_iter_get_length(&iter));
+			break;
+		default:
+			if (rej_options =3D=3D NULL) {
+				guint16 max_len =3D ntohs(packet->length) - 4;
+				rej_options =3D g_new0(guint8, max_len);
+			}
+
+			OPTION_COPY(rej_options, rej_len, rej_options !=3D NULL,
+					type, data,
+					ppp_option_iter_get_length(&iter));
+			break;
+		}
+	}
+
+	if (rej_len > 0) {
+		*new_len =3D rej_len;
+		*new_options =3D rej_options;
+
+		return RCR_REJECT;
+	}
+
+	if (len > 0) {
+		*new_len =3D len;
+		*new_options =3D g_memdup(nak_options, len);
+
+		return RCR_NAK;
+	}
+
+	return RCR_ACCEPT;
+}
+
+static enum rcr_result ipv6cp_client_rcr(struct ipv6cp_data *ipv6cp,
+					const struct pppcp_packet *packet,
+					guint8 **new_options, guint16 *new_len)
+{
+	struct ppp_option_iter iter;
+	guint8 *options =3D NULL;
+	guint8 len =3D 0;
+
+	ppp_option_iter_init(&iter, packet);
+
+	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
+		guint8 type =3D ppp_option_iter_get_type(&iter);
+		const void *data =3D ppp_option_iter_get_data(&iter);
+
+		switch (type) {
+		case IPV6CP_INTERFACE_ID:
+			memcpy(&ipv6cp->peer_addr, data,
+					sizeof(ipv6cp->peer_addr));
+			if (ipv6cp->peer_addr !=3D 0)
+				break;
+			/*
+			 * Fall through, reject zero Interface ID
+			 */
+			break;
+		default:
+			if (options =3D=3D NULL) {
+				guint16 max_len =3D ntohs(packet->length) - 4;
+				options =3D g_new0(guint8, max_len);
+			}
+
+			OPTION_COPY(options, len, options !=3D NULL,
+					type, data,
+					ppp_option_iter_get_length(&iter));
+			break;
+		}
+	}
+
+	if (len > 0) {
+		*new_len =3D len;
+		*new_options =3D options;
+
+		return RCR_REJECT;
+	}
+
+	return RCR_ACCEPT;
+}
+
+static enum rcr_result ipv6cp_rcr(struct pppcp_data *pppcp,
+					const struct pppcp_packet *packet,
+					guint8 **new_options, guint16 *new_len)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+
+	if (ipv6cp->is_server)
+		return ipv6cp_server_rcr(ipv6cp, packet, new_options, new_len);
+	else
+		return ipv6cp_client_rcr(ipv6cp, packet, new_options, new_len);
+}
+
+static void ipv6cp_rca(struct pppcp_data *pppcp,
+					const struct pppcp_packet *packet)
+{
+	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
+	struct ppp_option_iter iter;
+
+	if (ipv6cp->is_server)
+		return;
+
+	ppp_option_iter_init(&iter, packet);
+
+	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
+		const guint8 *data =3D ppp_option_iter_get_data(&iter);
+
+		switch (ppp_option_iter_get_type(&iter)) {
+		case IPV6CP_INTERFACE_ID:
+			memcpy(&ipv6cp->local_addr, data,
+					sizeof(ipv6cp->local_addr));
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
+	if (ipv6cp->is_server)
+		return;
+
+	ppp_option_iter_init(&iter, packet);
+
+	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
+		const guint8 *data =3D ppp_option_iter_get_data(&iter);
+
+		switch (ppp_option_iter_get_type(&iter)) {
+		case IPV6CP_INTERFACE_ID:
+			ipv6cp->req_options |=3D IPV6CP_INTERFACE_ID;
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
+struct pppcp_data *ipv6cp_new(GAtPPP *ppp, gboolean is_server,
+					const char *local, const char *peer,
+					GError **error)
+{
+	struct ipv6cp_data *ipv6cp;
+	struct pppcp_data *pppcp;
+	struct in6_addr local_addr;
+	struct in6_addr peer_addr;
+
+	if (local =3D=3D NULL)
+		memset(&local_addr, 0, sizeof(local_addr));
+	else if (inet_pton(AF_INET6, local, &local_addr) !=3D 1) {
+		g_set_error(error, IPV6CP_ERROR, errno,
+				"Unable to set local Interface ID: %s",
+				strerror(errno));
+		return NULL;
+	}
+
+	if (peer =3D=3D NULL)
+		memset(&peer_addr, 0, sizeof(peer_addr));
+	else if (inet_pton(AF_INET6, peer, &peer_addr) !=3D 1) {
+		g_set_error(error, IPV6CP_ERROR, errno,
+				"Unable to set peer Interface ID: %s",
+				g_strerror(errno));
+		return NULL;
+	}
+
+	ipv6cp =3D g_try_new0(struct ipv6cp_data, 1);
+	if (ipv6cp =3D=3D NULL)
+		return NULL;
+
+	pppcp =3D pppcp_new(ppp, &ipv6cp_proto, FALSE, IPV6CP_MAX_FAILURE);
+	if (pppcp =3D=3D NULL) {
+		g_free(ipv6cp);
+		return NULL;
+	}
+
+	memcpy(&ipv6cp->local_addr, &local_addr.s6_addr[8],
+						sizeof(ipv6cp->local_addr));
+	memcpy(&ipv6cp->peer_addr, &peer_addr.s6_addr[8],
+						sizeof(ipv6cp->peer_addr));
+	ipv6cp->is_server =3D is_server;
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
-- =

1.7.5.4


--===============5661941850927134419==--

