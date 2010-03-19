Content-Type: multipart/mixed; boundary="===============4514013577817658763=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [patch 5/6] IP support for PPP
Date: Fri, 19 Mar 2010 12:46:27 -0700
Message-ID: <20100319124627.3ad97214@kcaccard-MOBL3>
In-Reply-To: <20100319194705.214150215@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4514013577817658763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement IPCP support.  Creates a tun interface to pass IP traffic.

---
 Makefile.am       |    2 =

 gatchat/gatppp.c  |    1 =

 gatchat/ppp.c     |    1 =

 gatchat/ppp.h     |   12 +
 gatchat/ppp_net.c |  356 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 5 files changed, 371 insertions(+), 1 deletion(-)

Index: ofono/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/Makefile.am	2010-03-19 12:32:03.238468917 -0700
+++ ofono/Makefile.am	2010-03-19 12:35:43.583469121 -0700
@@ -59,7 +59,7 @@
 				gatchat/gatppp.c gatchat/gatppp.h \
 				gatchat/ppp.c gatchat/ppp.h gatchat/ppp_cp.h \
 				gatchat/ppp_cp.c gatchat/ppp_lcp.c \
-				gatchat/ppp_auth.c
+				gatchat/ppp_auth.c gatchat/ppp_net.c
 =

 udev_files =3D plugins/ofono.rules
 =

Index: ofono/gatchat/ppp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/ppp.h	2010-03-19 12:32:03.239469324 -0700
+++ ofono/gatchat/ppp.h	2010-03-19 12:35:43.584469248 -0700
@@ -104,11 +104,19 @@
 	GAtPPP *ppp;
 };
 =

+struct ppp_net_data {
+	GAtPPP *ppp;
+	char *if_name;
+	GIOChannel *channel;
+	struct pppcp_data *ipcp;
+};
+
 struct _GAtPPP {
 	gint ref_count;
 	enum ppp_phase phase;
 	struct pppcp_data *lcp;
 	struct auth_data *auth;
+	struct ppp_net_data *net;
 	guint8 buffer[BUFFERSZ];
 	int index;
 	gint mru;
@@ -152,4 +160,8 @@
 void auth_set_proto(struct auth_data *data, guint16 proto, guint8 method);
 struct auth_data *auth_new(GAtPPP *ppp);
 void auth_free(struct auth_data *auth);
+struct ppp_net_data *ppp_net_new(GAtPPP *ppp);
+void ppp_net_open(struct ppp_net_data *data);
+void ppp_net_free(struct ppp_net_data *data);
+void ppp_net_close(struct ppp_net_data *data);
 =

Index: ofono/gatchat/ppp_net.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ofono/gatchat/ppp_net.c	2010-03-19 12:39:52.668471727 -0700
@@ -0,0 +1,356 @@
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
+#include <net/if.h>
+#include <linux/if_tun.h>
+#include <sys/ioctl.h>
+#include <glib.h>
+
+#include "gatutil.h"
+#include "gatppp.h"
+#include "ppp.h"
+
+static void ipcp_free(struct pppcp_data *data);
+
+/* XXX should be maximum IP Packet size */
+#define MAX_PACKET 1500
+#define PPP_IP_PROTO	0x0021
+
+struct ipcp_data {
+	guint8 ip_address[4];
+	guint8 primary_dns[4];
+	guint8 secondary_dns[4];
+	struct pppcp_data *pppcp;
+};
+
+static struct pppcp_data *ipcp_new(GAtPPP *ppp);
+static void ipcp_option_process(gpointer data, gpointer user);
+static guint ipcp_option_scan(struct ppp_option *option, gpointer user);
+
+static void ip_process_packet(gpointer priv, guint8 *packet)
+{
+	struct ppp_net_data *data =3D priv;
+	GError *error =3D NULL;
+	GIOStatus status;
+	gsize bytes_written;
+	guint16 len;
+
+	/*
+	 * since ppp_net_open can fail, we need to make sure
+	 * channel is valid
+	 */
+	if (data->channel =3D=3D NULL)
+		return;
+
+	/* find the length of the packet to transmit */
+	len =3D get_host_short(&packet[2]);
+	status =3D g_io_channel_write_chars(data->channel, (gchar *) packet,
+                                          len, &bytes_written, &error);
+}
+
+/*
+ * packets received by the tun interface need to be written to
+ * the modem.  So, just read a packet, write out to the modem
+ *
+ * TBD - how do we know we have a full packet?  Do we care?
+ */
+static gboolean ppp_net_callback(GIOChannel *channel, GIOCondition cond,
+				gpointer userdata)
+{
+	GIOStatus status;
+	gchar buf[MAX_PACKET + 2];
+	gsize bytes_read;
+	GError *error =3D NULL;
+	struct ppp_header *ppp =3D (struct ppp_header *) buf;
+	struct ppp_net_data *data =3D (struct ppp_net_data *) userdata;
+
+	if (cond & G_IO_IN) {
+		/* leave space to add PPP protocol field */
+		status =3D g_io_channel_read_chars(channel, buf + 2, MAX_PACKET,
+				&bytes_read, &error);
+		if (bytes_read > 0) {
+			ppp->proto =3D htons(PPP_IP_PROTO);
+			ppp_transmit(data->ppp, (guint8 *) buf, bytes_read);
+		}
+		if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
+			return FALSE;
+	}
+	return TRUE;
+}
+
+void ppp_net_close(struct ppp_net_data *data)
+{
+	/* Not Implemented Yet */
+}
+
+void ppp_net_open(struct ppp_net_data *data)
+{
+	int fd;
+	struct ifreq ifr;
+	GIOChannel *channel;
+	int signal_source;
+	int err;
+
+	if (data =3D=3D NULL)
+		return;
+
+	/* open a tun interface */
+	fd =3D open("/dev/net/tun", O_RDWR);
+	if (fd < 0) {
+		g_printerr("error opening tun\n");
+		return;
+	}
+
+	memset(&ifr, 0, sizeof(ifr));
+	ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
+	err =3D ioctl(fd, TUNSETIFF, (void *)&ifr);
+	if (err < 0) {
+		g_printerr("error %d setting ifr\n", err);
+		close(fd);
+		return;
+	}
+	data->if_name =3D strdup(ifr.ifr_name);
+
+	/* create a channel for reading and writing to this interface */
+	channel =3D g_io_channel_unix_new(fd);
+	if (!channel) {
+		g_printerr("Error creating I/O Channel to TUN device\n");
+		close(fd);
+		return;
+	}
+	if (!g_at_util_setup_io(channel, G_IO_FLAG_NONBLOCK)) {
+		g_io_channel_unref(channel);
+		return;
+	}
+	data->channel =3D channel;
+	g_io_channel_set_buffered(channel, FALSE);
+	signal_source =3D g_io_add_watch(channel,
+			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			ppp_net_callback, (gpointer) data);
+
+	pppcp_generate_event(data->ipcp, OPEN, NULL, 0);
+
+}
+
+struct ppp_packet_handler ip_packet_handler =3D {
+	.proto =3D PPP_IP_PROTO,
+	.handler =3D ip_process_packet,
+};
+
+void ppp_net_free(struct ppp_net_data *data)
+{
+	/* TBD unregister packet handler */
+
+	/* cleanup tun interface */
+	ppp_net_close(data);
+
+	/* free ipcp data */
+	ipcp_free(data->ipcp);
+
+	/* free self */
+	g_free(data);
+}
+
+struct ppp_net_data *ppp_net_new(GAtPPP *ppp)
+{
+	struct ppp_net_data *data;
+
+	data =3D g_try_malloc0(sizeof(*data));
+	if (!data)
+		return NULL;
+
+	data->ppp =3D ppp;
+	data->ipcp =3D ipcp_new(ppp);
+
+	/* register packet handler for IP protocol */
+	ip_packet_handler.priv =3D data;
+	ppp_register_packet_handler(&ip_packet_handler);
+	return data;
+}
+
+/****** IPCP support ****************/
+#define IPCP_SUPPORTED_CODES	  ((1 << CONFIGURE_REQUEST) | \
+				  (1 << CONFIGURE_ACK) | \
+				  (1 << CONFIGURE_NAK) | \
+				  (1 << CONFIGURE_REJECT) | \
+				  (1 << TERMINATE_REQUEST) | \
+				  (1 << TERMINATE_ACK) | \
+				  (1 << CODE_REJECT))
+
+#define IPCP_PROTO		0x8021
+
+enum ipcp_option_types {
+	IP_ADDRESSES		=3D 1,
+	IP_COMPRESSION_PROTO	=3D 2,
+	IP_ADDRESS		=3D 3,
+	PRIMARY_DNS_SERVER	=3D 129,
+	SECONDARY_DNS_SERVER	=3D 131,
+};
+
+static void ipcp_up(struct pppcp_data *pppcp)
+{
+	struct ipcp_data *data =3D pppcp->priv;
+	GAtPPP *ppp =3D pppcp->ppp;
+
+	/* call the connect function */
+	if (ppp->connect_cb)
+		ppp->connect_cb(ppp, G_AT_PPP_CONNECT_SUCCESS,
+				__get_unaligned_long(data->ip_address),
+				__get_unaligned_long(data->primary_dns),
+				__get_unaligned_long(data->secondary_dns),
+				ppp->connect_data);
+}
+
+static void ipcp_down(struct pppcp_data *data)
+{
+	g_print("ipcp down\n");
+
+	/* re-add what default config options we want negotiated */
+}
+
+/*
+ * Tell the protocol to start the handshake
+ */
+static void ipcp_started(struct pppcp_data *data)
+{
+	pppcp_generate_event(data, UP, NULL, 0);
+}
+
+static void ipcp_finished(struct pppcp_data *data)
+{
+	g_print("ipcp finished\n");
+}
+
+struct pppcp_action ipcp_action =3D {
+	.this_layer_up =3D	ipcp_up,
+	.this_layer_down =3D 	ipcp_down,
+	.this_layer_started =3D 	ipcp_started,
+	.this_layer_finished =3D	ipcp_finished,
+	.option_scan =3D 		ipcp_option_scan,
+	.option_process =3D 	ipcp_option_process,
+};
+
+struct ppp_packet_handler ipcp_packet_handler =3D {
+	.proto =3D IPCP_PROTO,
+	.handler =3D pppcp_process_packet,
+};
+
+/*
+ * Scan the option to see if it is acceptable, unacceptable, or rejected
+ */
+static guint ipcp_option_scan(struct ppp_option *option, gpointer user)
+{
+	switch (option->type) {
+	case IP_ADDRESS:
+	case PRIMARY_DNS_SERVER:
+	case SECONDARY_DNS_SERVER:
+		return OPTION_ACCEPT;
+	default:
+		g_printerr("Unknown ipcp option type %d\n", option->type);
+		return OPTION_REJECT;
+	}
+}
+
+/*
+ * act on an acceptable option
+ */
+static void ipcp_option_process(gpointer data, gpointer user)
+{
+	struct ppp_option *option =3D data;
+	struct ipcp_data *ipcp =3D user;
+
+	switch (option->type) {
+	case IP_ADDRESS:
+		memcpy(ipcp->ip_address, option->data, 4);
+		break;
+	case PRIMARY_DNS_SERVER:
+		memcpy(ipcp->primary_dns, option->data, 4);
+		break;
+	case SECONDARY_DNS_SERVER:
+		memcpy(ipcp->secondary_dns, option->data, 4);
+		break;
+	default:
+		g_printerr("Unable to process unknown option %d\n", option->type);
+		break;
+	}
+}
+
+static void ipcp_free(struct pppcp_data *data)
+{
+	struct ipcp_data *ipcp =3D data->priv;
+
+	/* TBD unregister IPCP packet handler */
+
+	/* free ipcp */
+	g_free(ipcp);
+
+	/* free pppcp */
+	pppcp_free(data);
+}
+
+static struct pppcp_data * ipcp_new(GAtPPP *ppp)
+{
+	struct ipcp_data *data;
+	struct pppcp_data *pppcp;
+	struct ppp_option *ipcp_option;
+
+	data =3D g_try_malloc0(sizeof(*data));
+	if (!data)
+		return NULL;
+
+	pppcp =3D pppcp_new(ppp, IPCP_PROTO, data);
+	if (!pppcp) {
+		g_printerr("Failed to allocate PPPCP struct\n");
+		g_free(data);
+		return NULL;
+	}
+	pppcp_set_valid_codes(pppcp, IPCP_SUPPORTED_CODES);
+	pppcp->priv =3D data;
+
+	/* set the actions */
+	pppcp->action =3D &ipcp_action;
+
+	/* add the default config options */
+	ipcp_option =3D g_try_malloc0(6);
+	if (!ipcp_option) {
+		pppcp_free(pppcp);
+		g_free(data);
+		return NULL;
+	}
+	ipcp_option->type =3D IP_ADDRESS;
+	ipcp_option->length=3D 6;
+	pppcp_add_config_option(pppcp, ipcp_option);
+
+	/* register packet handler for IPCP protocol */
+	ipcp_packet_handler.priv =3D pppcp;
+	ppp_register_packet_handler(&ipcp_packet_handler);
+	return pppcp;
+}
Index: ofono/gatchat/gatppp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp.c	2010-03-19 12:32:03.239469324 -0700
+++ ofono/gatchat/gatppp.c	2010-03-19 12:35:43.584469248 -0700
@@ -136,6 +136,7 @@
 	ppp->auth =3D auth_new(ppp);
 =

 	/* intialize the network state */
+	ppp->net =3D ppp_net_new(ppp);
 =

 	/* start listening for packets from the modem */
 	ppp->modem_watch =3D g_io_add_watch(modem,
Index: ofono/gatchat/ppp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/ppp.c	2010-03-19 12:32:03.240469032 -0700
+++ ofono/gatchat/ppp.c	2010-03-19 12:35:43.585469096 -0700
@@ -381,6 +381,7 @@
 static void ppp_network(GAtPPP *ppp)
 {
 	/* bring network phase up */
+	ppp_net_open(ppp->net);
 }
 =

 static void ppp_transition_phase(GAtPPP *ppp, enum ppp_phase phase)


--===============4514013577817658763==--

