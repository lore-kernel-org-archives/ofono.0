Content-Type: multipart/mixed; boundary="===============4200757556804256885=="
MIME-Version: 1.0
From: kristen@linux.intel.com
Subject: [patch 3/6] LCP support
Date: Thu, 11 Mar 2010 14:00:38 -0800
Message-ID: <20100311140038.21b8ac14@kcaccard-MOBL3>
In-Reply-To: <20100311214022.838696145@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4200757556804256885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement LCP support for the PPP protocol

Index: ofono/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/Makefile.am	2010-03-10 17:00:34.037087986 -0800
+++ ofono/Makefile.am	2010-03-10 17:01:56.687955124 -0800
@@ -56,9 +56,9 @@
 				gatchat/gatutil.h gatchat/gatutil.c \
 				gatchat/gat.h \
 				gatchat/gatserver.h gatchat/gatserver.c \
-				gatchat/gatppp.c gatchat/gatppp.h \
-				gatchat/gatppp_internal.h gatchat/gatpppcp.c
-				gatchat/gatpppcp.h
+				gatchat/gatppp_internal.h gatchat/gatpppcp.c \
+				gatchat/gatpppcp.h gatchat/gatppp.c \
+				gatchat/gatppplcp.c gatchat/gatppp.h
 =

 udev_files =3D plugins/ofono.rules
 =

Index: ofono/gatchat/gatppp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp.c	2010-03-10 16:58:12.039961039 -0800
+++ ofono/gatchat/gatppp.c	2010-03-10 17:01:56.687955124 -0800
@@ -352,22 +352,26 @@
 static void ppp_close(struct ppp_link *link)
 {
 	/* send a CLOSE event to the lcp layer */
+	lcp_close(link->lcp);
 }
 =

 /* Administrative Open */
 void g_at_ppp_open(struct ppp_link *link)
 {
 	/* send an OPEN event to the lcp layer */
+	lcp_open(link->lcp);
 }
 =

 static void ppp_link_establishment(struct ppp_link *link)
 {
 	/* signal UP event to LCP */
+	lcp_establish(link->lcp);
 }
 =

 static void ppp_terminate(struct ppp_link *link)
 {
 	/* signal DOWN event to LCP */
+	lcp_terminate(link->lcp);
 }
 =

 static void ppp_authenticate(struct ppp_link *link)
@@ -485,6 +489,9 @@
 	/* cleanup modem channel */
 	g_source_remove(link->modem_watch);
 	g_io_channel_unref(link->modem);
+
+	/* remove lcp */
+	lcp_free(link->lcp);
 }
 =

 void g_at_ppp_ref(struct ppp_link *link)
@@ -503,6 +510,50 @@
 	}
 }
 =

+void __ppp_set_auth(struct ppp_link *link, guint8* auth_data)
+{
+	guint16 proto =3D ntohs(*(guint16 *)auth_data);
+
+	switch(proto) {
+	case CHAP_PROTOCOL:
+		/* get the algorithm */
+		break;
+	default:
+		g_printerr("unknown authentication proto\n");
+		break;
+	}
+}
+
+void __ppp_set_recv_accm(struct ppp_link *link, guint32 accm)
+{
+	link->recv_accm =3D accm;
+}
+
+guint32 __ppp_get_xmit_accm(struct ppp_link *link)
+{
+	return link->xmit_accm[0];
+}
+
+void __ppp_set_pfc(struct ppp_link *link, gboolean pfc)
+{
+	link->pfc =3D pfc;
+}
+
+gboolean __ppp_get_pfc(struct ppp_link *link)
+{
+	return link->pfc;
+}
+
+void __ppp_set_acfc(struct ppp_link *link, gboolean acfc)
+{
+	link->acfc =3D acfc;
+}
+
+gboolean __ppp_get_acfc(struct ppp_link *link)
+{
+	return link->acfc;
+}
+
 struct ppp_link * g_at_ppp_new(GIOChannel *modem)
 {
 	struct ppp_link *link;
@@ -540,7 +591,7 @@
 	g_io_channel_set_buffered(modem, FALSE);
 =

 	/* initialize the lcp state */
-
+	link->lcp =3D lcp_new(link);
 =

 	/* initialize the autentication state */
 =

Index: ofono/gatchat/gatppp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp.h	2010-03-10 16:58:12.040979395 -0800
+++ ofono/gatchat/gatppp.h	2010-03-10 17:01:56.688955112 -0800
@@ -43,6 +43,7 @@
 struct ppp_link {
 	gint ref_count;
 	guint phase;
+	struct pppcp_data *lcp;
 	guint8 *buffer;
 	int index;
 	gint mru;
Index: ofono/gatchat/gatppp_internal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp_internal.h	2010-03-10 17:00:34.040101010 -0800
+++ ofono/gatchat/gatppp_internal.h	2010-03-10 17:01:56.688955112 -0800
@@ -91,6 +91,12 @@
 gboolean __ppp_get_pfc(struct ppp_link *link);
 void __ppp_set_acfc(struct ppp_link *link, gboolean acfc);
 gboolean __ppp_get_acfc(struct ppp_link *link);
+struct pppcp_data * lcp_new(struct ppp_link *link);
+void lcp_free(struct pppcp_data *lcp);
+void lcp_open(struct pppcp_data *data);
+void lcp_close(struct pppcp_data *data);
+void lcp_establish(struct pppcp_data *data);
+void lcp_terminate(struct pppcp_data *data);
 #ifdef __cplusplus
 }
 #endif
Index: ofono/gatchat/gatppplcp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ofono/gatchat/gatppplcp.c	2010-03-10 17:01:56.688955112 -0800
@@ -0,0 +1,225 @@
+/*
+ *
+ *  AT chat library with GLib integration
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
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
+#include <glib.h>
+#include <arpa/inet.h>
+#include "gatppp.h"
+#include "gatppp_internal.h"
+
+enum {
+	/* options */
+	RESERVED 	=3D 0,
+	MRU		=3D 1,
+	ACCM		=3D 2,
+	AUTH_PROTO	=3D 3,
+	QUAL_PROTO	=3D 4,
+	MAGIC_NUMBER	=3D 5,
+	DEPRECATED_QUAL_PROTO	=3D 6,
+	PFC			=3D 7,
+	ACFC			=3D 8,
+
+	LCP_SUPPORTED_CODES	=3D (1 << CONFIGURE_REQUEST) |
+				(1 << CONFIGURE_ACK) |
+				(1 << CONFIGURE_NAK) |
+				(1 << CONFIGURE_REJECT) |
+				(1 << TERMINATE_REQUEST) |
+				(1 << TERMINATE_ACK) |
+				(1 << CODE_REJECT) |
+				(1 << PROTOCOL_REJECT) |
+				(1 << ECHO_REQUEST) |
+				(1 << ECHO_REPLY) |
+				(1 << DISCARD_REQUEST),
+};
+
+/*
+ * signal the Up event to the NCP
+ */
+static void lcp_up(struct pppcp_data *pppcp)
+{
+	ppp_generate_event(pppcp->link, PPP_OPENED);
+}
+
+/*
+ * signal the Down event to the NCP
+ */
+static void lcp_down(struct pppcp_data *pppcp)
+{
+	ppp_generate_event(pppcp->link, PPP_DOWN);
+}
+
+/*
+ * Indicate that the lower layer is now needed
+ * Should trigger Up event
+ */
+static void lcp_started(struct pppcp_data *pppcp)
+{
+	ppp_generate_event(pppcp->link, PPP_UP);
+}
+
+/*
+ * Indicate that the lower layer is not needed
+ * Should trigger Down event
+ */
+static void lcp_finished(struct pppcp_data *pppcp)
+{
+	ppp_generate_event(pppcp->link, PPP_CLOSING);
+}
+
+/*
+ * Scan the option to see if it is acceptable, unacceptable, or rejected
+ */
+static guint lcp_option_scan(struct ppp_option *option, gpointer user)
+{
+	switch(option->type) {
+	case ACCM:
+	case AUTH_PROTO:
+		/* XXX check to make sure it's a proto we recognize */
+	case MAGIC_NUMBER:
+	case PFC:
+	case ACFC:
+		return OPTION_ACCEPT;
+	default:
+		g_print("Unknown lcp option type %d\n", option->type);
+		return OPTION_REJECT;
+	}
+}
+
+/*
+ * act on an acceptable option
+ */
+static void lcp_option_process(gpointer data, gpointer user)
+{
+	struct ppp_option *option =3D (struct ppp_option *)data;
+	struct pppcp_data *pppcp =3D (struct pppcp_data *)user;
+	struct ppp_link *link =3D pppcp->link;
+	guint32 *val32;
+	guint32 magic;
+
+	switch(option->type) {
+	case ACCM:
+		val32 =3D (guint32 *)option->data;
+		__ppp_set_recv_accm(link, ntohl(*val32));
+		break;
+	case AUTH_PROTO:
+		__ppp_set_auth(link, option->data);
+		break;
+	case MAGIC_NUMBER:
+		/* XXX handle loopback */
+		val32 =3D (guint32 *)option->data;
+		magic =3D ntohl(*val32);
+		if (magic !=3D pppcp->magic_number)
+			pppcp->magic_number =3D magic;
+		else
+			g_print("looped back? I should do something\n");
+		break;
+	case PFC:
+		__ppp_set_pfc(link, TRUE);
+		break;
+	case ACFC:
+		__ppp_set_acfc(link, TRUE);
+		break;
+	default:
+		g_print("unhandled option %d\n", option->type);
+	}
+}
+
+struct ppp_packet_handler lcp_packet_handler =3D {
+	.proto =3D LCP_PROTOCOL,
+	.handler =3D pppcp_process_packet,
+};
+
+struct pppcp_action lcp_action =3D {
+	.this_layer_up =3D	lcp_up,
+	.this_layer_down =3D 	lcp_down,
+	.this_layer_started =3D 	lcp_started,
+	.this_layer_finished =3D	lcp_finished,
+	.option_scan =3D 		lcp_option_scan,
+	.option_process =3D 	lcp_option_process,
+};
+
+void lcp_open(struct pppcp_data *data)
+{
+	/* send an open event to the lcp layer */
+	pppcp_generate_event(data, OPEN, NULL, 0);
+}
+
+void lcp_close(struct pppcp_data *data)
+{
+	/* send a CLOSE  event to the lcp layer */
+	pppcp_generate_event(data, CLOSE, NULL, 0);
+}
+
+void lcp_establish(struct pppcp_data *data)
+{
+	/* send an UP event to the lcp layer */
+	pppcp_generate_event(data, UP, NULL, 0);
+}
+
+void lcp_terminate(struct pppcp_data *data)
+{
+	/* send a DOWN event to the lcp layer */
+	pppcp_generate_event(data, DOWN, NULL, 0);
+}
+
+void lcp_free(struct pppcp_data *lcp)
+{
+	/* TBD unregister packet handler */
+
+	pppcp_free(lcp);
+}
+
+struct pppcp_data * lcp_new(struct ppp_link *link)
+{
+	struct pppcp_data *pppcp;
+	struct ppp_option *option;
+	guint16 codes =3D LCP_SUPPORTED_CODES;
+
+	pppcp =3D pppcp_new(link, LCP_PROTOCOL, NULL);
+	if (!pppcp) {
+		g_print("Failed to allocate PPPCP struct\n");
+		return NULL;
+	}
+	pppcp_set_valid_codes(pppcp, codes);
+	pppcp->priv =3D pppcp;
+
+	/* set the actions */
+	pppcp->action =3D &lcp_action;
+
+	/* add the default config options */
+	option =3D g_malloc0(6);
+	option->type =3D ACCM;
+	option->length=3D 6;
+	pppcp_add_config_option(pppcp, option);
+
+	/* register packet handler for LCP protocol */
+	lcp_packet_handler.priv =3D pppcp;
+	ppp_register_packet_handler(&lcp_packet_handler);
+	return pppcp;
+}


--===============4200757556804256885==--

