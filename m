Content-Type: multipart/mixed; boundary="===============4466680112654166869=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [patch 3/6] LCP support
Date: Tue, 16 Mar 2010 17:13:15 -0700
Message-ID: <20100316171315.08b8ff09@kcaccard-MOBL3>
In-Reply-To: <20100317000824.420232401@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4466680112654166869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by:  Kristen Carlson Accardi <kristen@linux.intel.com>

Implement LCP support for the PPP protocol

---
 Makefile.am               |    6 -
 gatchat/gatppp.c          |   53 +++++++++
 gatchat/gatppp_internal.h |    8 +
 gatchat/gatppplcp.c       |  244 +++++++++++++++++++++++++++++++++++++++++=
+++++
 4 files changed, 307 insertions(+), 4 deletions(-)

Index: ofono/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/Makefile.am	2010-03-16 15:35:47.655623887 -0700
+++ ofono/Makefile.am	2010-03-16 15:42:51.131596138 -0700
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
--- ofono.orig/gatchat/gatppp.c	2010-03-16 15:34:30.492565338 -0700
+++ ofono/gatchat/gatppp.c	2010-03-16 15:42:51.132600246 -0700
@@ -350,22 +350,26 @@
 static void ppp_close(GAtPPP *ppp)
 {
 	/* send a CLOSE event to the lcp layer */
+	lcp_close(ppp->lcp);
 }
 =

 /* Administrative Open */
 void g_at_ppp_open(GAtPPP *ppp)
 {
 	/* send an OPEN event to the lcp layer */
+	lcp_open(ppp->lcp);
 }
 =

 static void ppp_ppp_establishment(GAtPPP *ppp)
 {
 	/* signal UP event to LCP */
+	lcp_establish(ppp->lcp);
 }
 =

 static void ppp_terminate(GAtPPP *ppp)
 {
 	/* signal DOWN event to LCP */
+	lcp_terminate(ppp->lcp);
 }
 =

 static void ppp_authenticate(GAtPPP *ppp)
@@ -483,6 +487,9 @@
 	/* cleanup modem channel */
 	g_source_remove(ppp->modem_watch);
 	g_io_channel_unref(ppp->modem);
+
+	/* remove lcp */
+	lcp_free(ppp->lcp);
 }
 =

 void g_at_ppp_ref(GAtPPP *ppp)
@@ -501,6 +508,50 @@
 	}
 }
 =

+void __ppp_set_auth(GAtPPP *ppp, guint8* auth_data)
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
+void __ppp_set_recv_accm(GAtPPP *ppp, guint32 accm)
+{
+	ppp->recv_accm =3D accm;
+}
+
+guint32 __ppp_get_xmit_accm(GAtPPP *ppp)
+{
+	return ppp->xmit_accm[0];
+}
+
+void __ppp_set_pfc(GAtPPP *ppp, gboolean pfc)
+{
+	ppp->pfc =3D pfc;
+}
+
+gboolean __ppp_get_pfc(GAtPPP *ppp)
+{
+	return ppp->pfc;
+}
+
+void __ppp_set_acfc(GAtPPP *ppp, gboolean acfc)
+{
+	ppp->acfc =3D acfc;
+}
+
+gboolean __ppp_get_acfc(GAtPPP *ppp)
+{
+	return ppp->acfc;
+}
+
 GAtPPP *g_at_ppp_new(GIOChannel *modem)
 {
 	GAtPPP *ppp;
@@ -536,7 +587,7 @@
 	ppp->index =3D 0;
 =

 	/* initialize the lcp state */
-
+	ppp->lcp =3D lcp_new(ppp);
 =

 	/* initialize the autentication state */
 =

Index: ofono/gatchat/gatppp_internal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp_internal.h	2010-03-16 15:35:47.660623616 -0700
+++ ofono/gatchat/gatppp_internal.h	2010-03-16 15:42:51.132600246 -0700
@@ -67,6 +67,7 @@
 struct _GAtPPP {
 	gint ref_count;
 	GAtPPPPhase phase;
+	struct pppcp_data *lcp;
 	guint8 buffer[BUFFERSZ];
 	int index;
 	gint mru;
@@ -97,3 +98,10 @@
 gboolean __ppp_get_pfc(GAtPPP *ppp);
 void __ppp_set_acfc(GAtPPP *ppp, gboolean acfc);
 gboolean __ppp_get_acfc(GAtPPP *ppp);
+struct pppcp_data * lcp_new(GAtPPP *ppp);
+void lcp_free(struct pppcp_data *lcp);
+void lcp_open(struct pppcp_data *data);
+void lcp_close(struct pppcp_data *data);
+void lcp_establish(struct pppcp_data *data);
+void lcp_terminate(struct pppcp_data *data);
+
Index: ofono/gatchat/gatppplcp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ofono/gatchat/gatppplcp.c	2010-03-16 15:44:11.312569716 -0700
@@ -0,0 +1,244 @@
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
+	__ppp_generate_event(pppcp->ppp, PPP_OPENED);
+}
+
+/*
+ * signal the Down event to the NCP
+ */
+static void lcp_down(struct pppcp_data *pppcp)
+{
+	__ppp_generate_event(pppcp->ppp, PPP_DOWN);
+}
+
+/*
+ * Indicate that the lower layer is now needed
+ * Should trigger Up event
+ */
+static void lcp_started(struct pppcp_data *pppcp)
+{
+	__ppp_generate_event(pppcp->ppp, PPP_UP);
+}
+
+/*
+ * Indicate that the lower layer is not needed
+ * Should trigger Down event
+ */
+static void lcp_finished(struct pppcp_data *pppcp)
+{
+	__ppp_generate_event(pppcp->ppp, PPP_CLOSING);
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
+	struct ppp_option *option =3D data;
+	struct pppcp_data *pppcp =3D user;
+	GAtPPP *ppp =3D pppcp->ppp;
+	guint32 *val32;
+	guint32 magic;
+
+	switch(option->type) {
+	case ACCM:
+		val32 =3D (guint32 *)option->data;
+		__ppp_set_recv_accm(ppp, ntohl(*val32));
+		break;
+	case AUTH_PROTO:
+		__ppp_set_auth(ppp, option->data);
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
+		__ppp_set_pfc(ppp, TRUE);
+		break;
+	case ACFC:
+		__ppp_set_acfc(ppp, TRUE);
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
+	if (data =3D=3D NULL)
+		return;
+
+	/* send an open event to the lcp layer */
+	pppcp_generate_event(data, OPEN, NULL, 0);
+}
+
+void lcp_close(struct pppcp_data *data)
+{
+	if (data =3D=3D NULL)
+		return;
+
+	/* send a CLOSE  event to the lcp layer */
+	pppcp_generate_event(data, CLOSE, NULL, 0);
+}
+
+void lcp_establish(struct pppcp_data *data)
+{
+	if (data =3D=3D NULL)
+		return;
+
+	/* send an UP event to the lcp layer */
+	pppcp_generate_event(data, UP, NULL, 0);
+}
+
+void lcp_terminate(struct pppcp_data *data)
+{
+	if (data =3D=3D NULL)
+		return;
+
+	/* send a DOWN event to the lcp layer */
+	pppcp_generate_event(data, DOWN, NULL, 0);
+}
+
+void lcp_free(struct pppcp_data *lcp)
+{
+	if (lcp =3D=3D NULL)
+		return;
+
+	/* TBD unregister packet handler */
+
+	pppcp_free(lcp);
+}
+
+struct pppcp_data * lcp_new(GAtPPP *ppp)
+{
+	struct pppcp_data *pppcp;
+	struct ppp_option *option;
+	guint16 codes =3D LCP_SUPPORTED_CODES;
+
+	pppcp =3D pppcp_new(ppp, LCP_PROTOCOL, NULL);
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
+	option =3D g_try_malloc0(6);
+	if (option =3D=3D NULL) {
+		pppcp_free(pppcp);
+		return NULL;
+	}
+	option->type =3D ACCM;
+	option->length=3D 6;
+	pppcp_add_config_option(pppcp, option);
+
+	/* register packet handler for LCP protocol */
+	lcp_packet_handler.priv =3D pppcp;
+	__ppp_register_packet_handler(&lcp_packet_handler);
+	return pppcp;
+}


--===============4466680112654166869==--

