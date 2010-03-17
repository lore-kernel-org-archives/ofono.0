Content-Type: multipart/mixed; boundary="===============8377696177828327107=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [patch 5/6] IP support for PPP
Date: Tue, 16 Mar 2010 17:13:24 -0700
Message-ID: <20100316171324.75e1155d@kcaccard-MOBL3>
In-Reply-To: <20100317000824.420232401@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8377696177828327107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by:  Kristen Carlson Accardi <kristen@linux.intel.com>

Implement IPCP support.  Creates a tun interface to pass IP traffic.

---
 Makefile.am               |    2 =

 gatchat/gatppp.c          |    2 =

 gatchat/gatppp_internal.h |   12 +
 gatchat/gatpppnet.c       |  369 +++++++++++++++++++++++++++++++++++++++++=
+++++
 4 files changed, 384 insertions(+), 1 deletion(-)

Index: ofono/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/Makefile.am	2010-03-16 16:17:51.218477010 -0700
+++ ofono/Makefile.am	2010-03-16 16:17:53.660593790 -0700
@@ -59,7 +59,7 @@
 				gatchat/gatppp_internal.h gatchat/gatpppcp.c \
 				gatchat/gatpppcp.h gatchat/gatppp.c \
 				gatchat/gatppplcp.c gatchat/gatpppauth.c \
-				gatchat/gatppp.h
+				gatchat/gatpppnet.c gatchat/gatppp.h
 =

 udev_files =3D plugins/ofono.rules
 =

Index: ofono/gatchat/gatppp_internal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp_internal.h	2010-03-16 16:17:51.219488382 -0700
+++ ofono/gatchat/gatppp_internal.h	2010-03-16 16:17:53.660593790 -0700
@@ -73,11 +73,19 @@
 	gchar *passwd;
 };
 =

+struct net_data {
+	GAtPPP *ppp;
+	char *if_name;
+	GIOChannel *channel;
+	struct pppcp_data *ipcp;
+};
+
 struct _GAtPPP {
 	gint ref_count;
 	GAtPPPPhase phase;
 	struct pppcp_data *lcp;
 	struct auth_data *auth;
+	struct net_data *net;
 	guint8 buffer[BUFFERSZ];
 	int index;
 	gint mru;
@@ -119,4 +127,8 @@
 void auth_set_proto(struct auth_data *data, guint16 proto, guint8 method);
 struct auth_data *auth_new(GAtPPP *ppp);
 void auth_free(struct auth_data *auth);
+struct net_data *net_new(GAtPPP *ppp);
+void net_open(struct net_data *data);
+void net_free(struct net_data *data);
+void net_close(struct net_data *data);
 =

Index: ofono/gatchat/gatpppnet.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ofono/gatchat/gatpppnet.c	2010-03-16 16:22:10.237864764 -0700
@@ -0,0 +1,369 @@
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
+#include <arpa/inet.h>
+#include <net/if.h>
+#include <linux/if_tun.h>
+#include <sys/ioctl.h>
+#include <glib.h>
+
+#include "gatppp.h"
+#include "gatppp_internal.h"
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
+static struct pppcp_data * ipcp_new(GAtPPP *ppp);
+static void ipcp_option_process(gpointer data, gpointer user);
+static guint ipcp_option_scan(struct ppp_option *option, gpointer user);
+
+static void ip_process_packet(gpointer priv, guint8 *packet)
+{
+	struct net_data *data =3D priv;
+	GError *error =3D NULL;
+	GIOStatus status;
+	gsize bytes_written;
+	guint16 len;
+
+	/*
+	 * since net_open can fail, we need to make sure
+	 * channel is valid
+	 */
+	if (data->channel =3D=3D NULL)
+		return;
+
+	/* find the length of the packet to transmit */
+	len =3D ntohs(*(guint16 *)&packet[2]);
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
+static gboolean net_callback(GIOChannel *channel, GIOCondition cond,
+				gpointer userdata)
+{
+	GIOStatus status;
+	gchar buf[MAX_PACKET+2];
+	gsize bytes_read;
+	GError *error =3D NULL;
+	guint16 *proto =3D (guint16 *)buf;
+	struct net_data *data =3D (struct net_data *) userdata;
+
+	if (cond & G_IO_IN) {
+		/* leave space to add PPP protocol field */
+		status =3D g_io_channel_read_chars(channel, buf+2, MAX_PACKET,
+				&bytes_read, &error);
+		if (bytes_read > 0) {
+			/* I assume we are pointing to the protocol? */
+			*proto =3D htons(PPP_IP_PROTO);
+			__ppp_transmit(data->ppp, (guint8 *)buf, bytes_read);
+		}
+		if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAIN)
+			return FALSE;
+	}
+	return TRUE;
+}
+
+void net_close(struct net_data *data)
+{
+	/* Not Implemented Yet */
+}
+
+void net_open(struct net_data *data)
+{
+	int fd;
+	struct ifreq ifr;
+	GIOChannel *channel;
+	GIOFlags flags;
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
+	data->channel =3D channel;
+	flags =3D g_io_channel_get_flags(channel) | G_IO_FLAG_NONBLOCK;
+	g_io_channel_set_flags(channel, flags, NULL);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+	signal_source =3D g_io_add_watch(channel,
+			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			net_callback, (gpointer) data);
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
+void net_free(struct net_data *data)
+{
+	/* TBD unregister packet handler */
+
+	/* cleanup tun interface */
+	net_close(data);
+
+	/* free ipcp data */
+	ipcp_free(data->ipcp);
+
+	/* free self */
+	g_free(data);
+}
+
+struct net_data *net_new(GAtPPP *ppp)
+{
+	struct net_data *data;
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
+	__ppp_register_packet_handler(&ip_packet_handler);
+	return data;
+}
+
+/****** IPCP support ****************/
+enum {
+	/* supported codes */
+	IPCP_SUPPORTED_CODES	=3D (1 << CONFIGURE_REQUEST) |
+				  (1 << CONFIGURE_ACK) |
+				  (1 << CONFIGURE_NAK) |
+				  (1 << CONFIGURE_REJECT) |
+				  (1 << TERMINATE_REQUEST) |
+				  (1 << TERMINATE_ACK) |
+				  (1 << CODE_REJECT),
+
+	IPCP_PROTO		=3D 0x8021,
+
+	/* option types */
+	IP_ADDRESSES		=3D 1,
+	IP_COMPRESSION_PROTO	=3D 2,
+	IP_ADDRESS		=3D 3,
+	PRIMARY_DNS_SERVER	=3D 129,
+	SECONDARY_DNS_SERVER	=3D 131,
+};
+
+static guint32 bytes_to_32(guint8 *bytes)
+{
+	union addr {
+		guint8 bytes[4];
+		guint32 word;
+	} a;
+
+	memcpy(a.bytes, bytes, 4);
+	return(ntohl(a.word));
+}
+
+static void ipcp_up(struct pppcp_data *pppcp)
+{
+	struct ipcp_data *data =3D pppcp->priv;
+	GAtPPP *ppp =3D pppcp->ppp;
+
+	/* call the connect function */
+	if (ppp->connect_cb)
+		ppp->connect_cb(ppp, G_AT_PPP_CONNECT_SUCCESS,
+				bytes_to_32(data->ip_address),
+				bytes_to_32(data->primary_dns),
+				bytes_to_32(data->secondary_dns),
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
+	switch(option->type) {
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
+	switch(option->type) {
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
+	__ppp_register_packet_handler(&ipcp_packet_handler);
+	return pppcp;
+}
Index: ofono/gatchat/gatppp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp.c	2010-03-16 16:17:51.219488382 -0700
+++ ofono/gatchat/gatppp.c	2010-03-16 16:17:53.661593988 -0700
@@ -388,6 +388,7 @@
 static void ppp_network(GAtPPP *ppp)
 {
 	/* bring network phase up */
+	net_open(ppp->net);
 }
 =

 static void ppp_transition_phase(GAtPPP *ppp, guint phase)
@@ -603,6 +604,7 @@
 	ppp->auth =3D auth_new(ppp);
 =

 	/* intialize the network state */
+	ppp->net =3D net_new(ppp);
 =

 	/* start listening for packets from the modem */
 	ppp->modem_watch =3D g_io_add_watch(modem,


--===============8377696177828327107==--

