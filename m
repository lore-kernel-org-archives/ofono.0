Content-Type: multipart/mixed; boundary="===============6567298302798920889=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 4/6] CHAP with MD5 authentication support
Date: Mon, 22 Mar 2010 17:05:59 -0700
Message-ID: <1269302761-20125-5-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269302761-20125-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6567298302798920889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Authentication support with CHAP and MD5
---
 Makefile.am        |    3 +-
 gatchat/gatppp.c   |   11 +++-
 gatchat/gatppp.h   |    2 +
 gatchat/ppp.c      |    1 +
 gatchat/ppp.h      |   15 ++++
 gatchat/ppp_auth.c |  229 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 6 files changed, 259 insertions(+), 2 deletions(-)
 create mode 100644 gatchat/ppp_auth.c

diff --git a/Makefile.am b/Makefile.am
index 1a444ca..df89ef5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -58,7 +58,8 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 				gatchat/gatserver.h gatchat/gatserver.c \
 				gatchat/gatppp.c gatchat/gatppp.h \
 				gatchat/ppp.c gatchat/ppp.h gatchat/ppp_cp.h \
-				gatchat/ppp_cp.c gatchat/ppp_lcp.c
+				gatchat/ppp_cp.c gatchat/ppp_lcp.c \
+				gatchat/ppp_auth.c
 =

 udev_files =3D plugins/ofono.rules
 =

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index f083842..2b682f8 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -43,6 +43,12 @@ void g_at_ppp_open(GAtPPP *ppp)
 	lcp_open(ppp->lcp);
 }
 =

+void g_at_ppp_set_credentials(GAtPPP *ppp, const char *username,
+				const char *passwd)
+{
+	auth_set_credentials(ppp->auth, username, passwd);
+}
+
 void g_at_ppp_set_connect_function(GAtPPP *ppp,
 			       GAtPPPConnectFunc callback, gpointer user_data)
 {
@@ -73,6 +79,9 @@ void g_at_ppp_shutdown(GAtPPP *ppp)
 =

 	/* remove lcp */
 	lcp_free(ppp->lcp);
+
+	/* remove auth */
+	auth_free(ppp->auth);
 }
 =

 void g_at_ppp_ref(GAtPPP *ppp)
@@ -124,7 +133,7 @@ GAtPPP *g_at_ppp_new(GIOChannel *modem)
 	ppp->lcp =3D lcp_new(ppp);
 =

 	/* initialize the autentication state */
-
+	ppp->auth =3D auth_new(ppp);
 =

 	/* intialize the network state */
 =

diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index 0d5d5cc..8db26c9 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -51,6 +51,8 @@ void g_at_ppp_set_disconnect_function(GAtPPP *ppp,
 void g_at_ppp_shutdown(GAtPPP *ppp);
 void g_at_ppp_ref(GAtPPP *ppp);
 void g_at_ppp_unref(GAtPPP *ppp);
+void g_at_ppp_set_credentials(GAtPPP *ppp, const char *username,
+				const char *passwd);
 #ifdef __cplusplus
 }
 #endif
diff --git a/gatchat/ppp.c b/gatchat/ppp.c
index 2399ed4..0b3221b 100644
--- a/gatchat/ppp.c
+++ b/gatchat/ppp.c
@@ -463,6 +463,7 @@ void ppp_set_auth(GAtPPP *ppp, guint8* auth_data)
 	switch (proto) {
 	case CHAP_PROTOCOL:
 		/* get the algorithm */
+		auth_set_proto(ppp->auth, proto, auth_data[2]);
 		break;
 	default:
 		g_printerr("unknown authentication proto\n");
diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 7753a39..53d5274 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -95,10 +95,20 @@ static inline guint16 __get_unaligned_short(const gpoin=
ter p)
 #define ppp_proto(packet) \
 	(get_host_short(packet + 2))
 =

+struct auth_data {
+	guint16 proto;
+	gpointer proto_data;
+	void (*process_packet)(struct auth_data *data, guint8 *packet);
+	char *username;
+	char *passwd;
+	GAtPPP *ppp;
+};
+
 struct _GAtPPP {
 	gint ref_count;
 	enum ppp_phase phase;
 	struct pppcp_data *lcp;
+	struct auth_data *auth;
 	guint8 buffer[BUFFERSZ];
 	int index;
 	gint mru;
@@ -137,3 +147,8 @@ void lcp_open(struct pppcp_data *data);
 void lcp_close(struct pppcp_data *data);
 void lcp_establish(struct pppcp_data *data);
 void lcp_terminate(struct pppcp_data *data);
+void auth_set_credentials(struct auth_data *data, const char *username,
+				const char *passwd);
+void auth_set_proto(struct auth_data *data, guint16 proto, guint8 method);
+struct auth_data *auth_new(GAtPPP *ppp);
+void auth_free(struct auth_data *auth);
diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
new file mode 100644
index 0000000..c23d9ad
--- /dev/null
+++ b/gatchat/ppp_auth.c
@@ -0,0 +1,229 @@
+/*
+ *
+ *  PPP library with GLib integration
+ *
+ *  Copyright (C) 2009-2010  Intel Corporation. All rights reserved.
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
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <termios.h>
+#include <arpa/inet.h>
+
+#include <glib.h>
+
+#include "gatppp.h"
+#include "ppp.h"
+
+struct chap_header {
+	guint8 code;
+	guint8 identifier;
+	guint16 length;
+	guint8 data[0];
+} __attribute__((packed));
+
+struct chap_data {
+	guint8 method;
+	struct auth_data *auth;
+};
+
+enum chap_code {
+	CHALLENGE=3D1,
+	RESPONSE,
+	SUCCESS,
+	FAILURE
+};
+
+void auth_set_credentials(struct auth_data *data, const char *username,
+				const char *passwd)
+{
+	if (data =3D=3D NULL)
+		return;
+
+	if (data->username)
+		g_free(data->username);
+	if (data->passwd)
+		g_free(data->passwd);
+
+	data->username =3D g_strdup(username);
+	data->passwd =3D g_strdup(passwd);
+}
+
+static void chap_process_challenge(struct auth_data *auth, guint8 *packet)
+{
+	struct chap_header *header =3D (struct chap_header *) packet;
+	struct chap_header *response;
+	struct chap_data *data =3D auth->proto_data;
+	GChecksum *checksum;
+	gchar *secret =3D data->auth->passwd;
+	guint16 response_length;
+	struct ppp_header *ppp_packet;
+	gsize digest_len;
+
+	/* create a checksum over id, secret, and challenge */
+	checksum =3D g_checksum_new(data->method);
+	if (!checksum)
+		return;
+	g_checksum_update(checksum, &header->identifier, 1);
+	g_checksum_update(checksum, (guchar *) secret, strlen(secret));
+	g_checksum_update(checksum, &header->data[1], header->data[0]);
+
+	/* transmit a response packet */
+	/*
+	 * allocate space for the header, the checksum, and the ppp header,
+	 * and the value size byte
+	 */
+	digest_len =3D g_checksum_type_get_length(data->method);
+	response_length =3D digest_len + sizeof(*header) + 1;
+	ppp_packet =3D g_try_malloc0(response_length + 2);
+	if (!ppp_packet)
+		goto challenge_out;
+
+	/* add our protocol information */
+	ppp_packet->proto =3D htons(CHAP_PROTOCOL);
+	response =3D (struct chap_header *) &ppp_packet->info;
+	if (response) {
+		response->code =3D RESPONSE;
+		response->identifier =3D header->identifier;
+		response->length =3D htons(response_length);
+		response->data[0] =3D digest_len;
+		g_checksum_get_digest(checksum, &response->data[1],
+					(gsize *) &response->data[0]);
+		/* leave the name empty? */
+	}
+
+	/* transmit the packet */
+	ppp_transmit(auth->ppp, (guint8 *) ppp_packet, response_length);
+
+challenge_out:
+	g_checksum_free(checksum);
+}
+
+static void chap_process_success(struct auth_data *data, guint8 *packet)
+{
+	ppp_generate_event(data->ppp, PPP_SUCCESS);
+}
+
+static void chap_process_failure(struct auth_data *data, guint8 *packet)
+{
+	struct chap_header *header =3D (struct chap_header *) packet;
+
+	g_print("Failed to authenticate, message %s\n", header->data);
+}
+
+/*
+ * parse the packet
+ */
+static void chap_process_packet(gpointer priv, guint8 *new_packet)
+{
+	struct auth_data *data =3D priv;
+	guint8 code =3D new_packet[0];
+
+	switch (code) {
+	case CHALLENGE:
+		chap_process_challenge(data, new_packet);
+		break;
+	case RESPONSE:
+		g_print("Oops, received RESPONSE, but I've not implemented\n");
+		break;
+	case SUCCESS:
+		chap_process_success(data, new_packet);
+		break;
+	case FAILURE:
+		chap_process_failure(data, new_packet);
+		break;
+	default:
+		g_print("unknown auth code\n");
+		break;
+	}
+}
+
+struct ppp_packet_handler chap_packet_handler =3D {
+	.proto =3D CHAP_PROTOCOL,
+	.handler =3D chap_process_packet,
+};
+
+static void chap_free(struct auth_data *auth)
+{
+	/* TBD unregister protocol handler */
+
+	g_free(auth->proto_data);
+}
+
+static struct chap_data *chap_new(struct auth_data *auth, guint8 method)
+{
+	struct chap_data *data;
+
+	data =3D g_try_malloc0(sizeof(*data));
+	if (!data)
+		return NULL;
+
+	data->auth =3D auth;
+	switch (method) {
+	case MD5:
+		data->method =3D G_CHECKSUM_MD5;
+		break;
+	default:
+		g_print("Unknown method\n");
+	}
+
+	/* register packet handler for CHAP protocol */
+	chap_packet_handler.priv =3D auth;
+	ppp_register_packet_handler(&chap_packet_handler);
+	return data;
+}
+
+void auth_set_proto(struct auth_data *data, guint16 proto, guint8 method)
+{
+	if (data =3D=3D NULL)
+		return;
+
+	switch (proto) {
+	case CHAP_PROTOCOL:
+		data->proto_data =3D (gpointer) chap_new(data, method);
+		break;
+	default:
+		g_print("Unknown auth protocol 0x%x\n", proto);
+	}
+}
+
+void auth_free(struct auth_data *data)
+{
+	if (data =3D=3D NULL)
+		return;
+
+	chap_free(data);
+	g_free(data);
+}
+
+struct auth_data *auth_new(GAtPPP *ppp)
+{
+	struct auth_data *data;
+
+	data =3D g_try_malloc0(sizeof(*data));
+	if (!data)
+		return NULL;
+
+	data->ppp =3D ppp;
+	return data;
+}
-- =

1.6.6.1


--===============6567298302798920889==--

