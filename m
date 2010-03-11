Content-Type: multipart/mixed; boundary="===============8564857747682126288=="
MIME-Version: 1.0
From: kristen@linux.intel.com
Subject: [patch 4/6] CHAP with MD5 authentication
Date: Thu, 11 Mar 2010 14:00:42 -0800
Message-ID: <20100311140042.7d605d1f@kcaccard-MOBL3>
In-Reply-To: <20100311214022.838696145@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8564857747682126288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement authentication support with CHAP and MD5 digest
Index: ofono/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/Makefile.am	2010-03-10 17:01:56.687955124 -0800
+++ ofono/Makefile.am	2010-03-10 17:03:01.695955140 -0800
@@ -58,7 +58,8 @@
 				gatchat/gatserver.h gatchat/gatserver.c \
 				gatchat/gatppp_internal.h gatchat/gatpppcp.c \
 				gatchat/gatpppcp.h gatchat/gatppp.c \
-				gatchat/gatppplcp.c gatchat/gatppp.h
+				gatchat/gatppplcp.c gatchat/gatpppauth.c \
+				gatchat/gatppp.h
 =

 udev_files =3D plugins/ofono.rules
 =

Index: ofono/gatchat/gatppp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp.c	2010-03-10 17:01:56.687955124 -0800
+++ ofono/gatchat/gatppp.c	2010-03-10 17:03:01.696955547 -0800
@@ -390,6 +390,7 @@
 static void ppp_network(struct ppp_link *link)
 {
 	/* bring network phase up */
+	net_open(link->net);
 }
 =

 static void ppp_transition_phase(struct ppp_link *link, guint phase)
@@ -492,6 +493,9 @@
 =

 	/* remove lcp */
 	lcp_free(link->lcp);
+
+	/* remove auth */
+	auth_free(link->auth);
 }
 =

 void g_at_ppp_ref(struct ppp_link *link)
@@ -510,6 +514,12 @@
 	}
 }
 =

+void g_at_ppp_set_credentials(struct ppp_link *link, gchar *username,
+				gchar *passwd)
+{
+	auth_set_credentials(link->auth, username, passwd);
+}
+
 void __ppp_set_auth(struct ppp_link *link, guint8* auth_data)
 {
 	guint16 proto =3D ntohs(*(guint16 *)auth_data);
@@ -517,6 +527,7 @@
 	switch(proto) {
 	case CHAP_PROTOCOL:
 		/* get the algorithm */
+		auth_set_proto(link->auth, proto, auth_data[2]);
 		break;
 	default:
 		g_printerr("unknown authentication proto\n");
@@ -594,9 +605,10 @@
 	link->lcp =3D lcp_new(link);
 =

 	/* initialize the autentication state */
-
+	link->auth =3D auth_new(link);
 =

 	/* intialize the network state */
+	link->net =3D net_new(link);
 =

 	/* start listening for packets from the modem */
 	signal_source =3D g_io_add_watch(modem,
Index: ofono/gatchat/gatppp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp.h	2010-03-10 17:01:56.688955112 -0800
+++ ofono/gatchat/gatppp.h	2010-03-10 17:03:01.696955547 -0800
@@ -27,6 +27,7 @@
 #endif
 =

 struct ppp_link;
+struct auth_data;
 =

 enum PPP_CONNECT_STATUS {
 	PPP_CONNECT_SUCCESS,
@@ -44,6 +45,7 @@
 	gint ref_count;
 	guint phase;
 	struct pppcp_data *lcp;
+	struct auth_data *auth;
 	guint8 *buffer;
 	int index;
 	gint mru;
@@ -74,6 +76,8 @@
 void g_at_ppp_shutdown(struct ppp_link *link);
 void g_at_ppp_ref(struct ppp_link *link);
 void g_at_ppp_unref(struct ppp_link *link);
+void g_at_ppp_set_credentials(struct ppp_link *link, gchar *username,
+				gchar *passwd);
 #ifdef __cplusplus
 }
 #endif
Index: ofono/gatchat/gatppp_internal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp_internal.h	2010-03-10 17:01:56.688955112 -0800
+++ ofono/gatchat/gatppp_internal.h	2010-03-10 17:03:01.697955395 -0800
@@ -66,6 +66,15 @@
 	gpointer priv;
 };
 =

+struct auth_data {
+	guint16 proto;
+	gpointer proto_data;
+	void (*process_packet)(struct auth_data *data, guint8 *packet);
+	struct ppp_link *link;
+	gchar *username;
+	gchar *passwd;
+};
+
 #define ppp_generate_event(l, e) \
 	__ppp_generate_event(l, e)
 =

@@ -97,6 +106,11 @@
 void lcp_close(struct pppcp_data *data);
 void lcp_establish(struct pppcp_data *data);
 void lcp_terminate(struct pppcp_data *data);
+void auth_set_credentials(struct auth_data *data, gchar *username,
+				gchar *passwd);
+void auth_set_proto(struct auth_data *data, guint16 proto, guint8 method);
+struct auth_data *auth_new(struct ppp_link *link);
+void auth_free(struct auth_data *auth);
 #ifdef __cplusplus
 }
 #endif
Index: ofono/gatchat/gatpppauth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ofono/gatchat/gatpppauth.c	2010-03-10 17:03:01.697955395 -0800
@@ -0,0 +1,219 @@
+/*
+ *
+ *  PPP library with GLib integration
+ *
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
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
+#include "gatppp_internal.h"
+
+struct chap_header {
+	guint8 code;
+	guint8 identifier;
+	guint16 length;
+	guint8 data[0];
+};
+
+struct chap_data {
+	guint8 method;
+	struct auth_data *auth;
+};
+
+enum CHAP_CODE {
+	CHALLENGE=3D1,
+	RESPONSE,
+	SUCCESS,
+	FAILURE
+};
+
+void auth_set_credentials(struct auth_data *data, gchar *username,
+				gchar *passwd)
+{
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
+	struct chap_header *header =3D (struct chap_header *)packet;
+	struct chap_header *response;
+	struct chap_data *data =3D auth->proto_data;
+	GChecksum *checksum;
+	gchar *secret =3D data->auth->passwd;
+	guint16 response_length;
+	guint8 *ppp_packet;
+	gsize digest_len;
+
+	/* create a checksum over id, secret, and challenge */
+	checksum =3D g_checksum_new(data->method);
+	if (!checksum)
+		return;
+	g_checksum_update(checksum, &header->identifier, 1);
+	g_checksum_update(checksum, (guchar *)secret, strlen(secret));
+	g_checksum_update(checksum, &header->data[1], header->data[0]);
+
+	/* transmit a response packet */
+	/*
+	 * allocate space for the header, the checksum, and the ppp header,
+	 * and the value size byte
+	 */
+	digest_len =3D g_checksum_type_get_length(data->method);
+	response_length =3D digest_len + sizeof(*header) + 1;
+	ppp_packet =3D g_malloc0(response_length + 2);
+	if (!ppp_packet)
+		goto challenge_out;
+
+	/* add our protocol information */
+	*((guint16 *)ppp_packet) =3D htons(CHAP_PROTOCOL);
+	response =3D (struct chap_header *)(ppp_packet+2);
+	if (response) {
+		response->code =3D RESPONSE;
+		response->identifier =3D header->identifier;
+		response->length =3D htons(response_length);
+		response->data[0] =3D digest_len;
+		g_checksum_get_digest(checksum, &response->data[1],
+					(gsize *)&response->data[0]);
+		/* leave the name empty? */
+	}
+
+	/* transmit the packet */
+	ppp_transmit(auth->link, ppp_packet, response_length);
+
+challenge_out:
+	g_checksum_free(checksum);
+}
+
+static void chap_process_success(struct auth_data *data, guint8 *packet)
+{
+	ppp_generate_event(data->link, PPP_SUCCESS);
+}
+
+static void chap_process_failure(struct auth_data *data, guint8 *packet)
+{
+	struct chap_header *header =3D (struct chap_header *)packet;
+
+	g_print("Failed to authenticate, message %s\n", header->data);
+}
+
+/*
+ * parse the packet
+ */
+static void chap_process_packet(gpointer priv, guint8 *new_packet)
+{
+	struct auth_data *data =3D (struct auth_data *)priv;
+	guint8 code =3D new_packet[0];
+
+	switch(code) {
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
+	data =3D g_malloc0(sizeof(*data));
+
+	if (data) {
+		data->auth =3D auth;
+		switch(method) {
+		case MD5:
+			data->method =3D G_CHECKSUM_MD5;
+			break;
+		default:
+			g_print("Unknown method\n");
+		}
+
+		/* register packet handler for CHAP protocol */
+		chap_packet_handler.priv =3D auth;
+		ppp_register_packet_handler(&chap_packet_handler);
+	}
+	return data;
+}
+
+void auth_set_proto(struct auth_data *data, guint16 proto, guint8 method)
+{
+	switch(proto) {
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
+	chap_free(data);
+	g_free(data);
+}
+
+struct auth_data *auth_new(struct ppp_link *link)
+{
+	struct auth_data *data;
+
+	data =3D g_malloc0(sizeof(*data));
+	if (data)
+		data->link =3D link;
+	return data;
+}
+


--===============8564857747682126288==--

