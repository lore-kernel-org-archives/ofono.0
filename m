Content-Type: multipart/mixed; boundary="===============4392059176674366819=="
MIME-Version: 1.0
From: kristen@linux.intel.com
Subject: [patch 2/6] Generic PPP control protocol
Date: Thu, 11 Mar 2010 14:00:33 -0800
Message-ID: <20100311140033.3b1a1a34@kcaccard-MOBL3>
In-Reply-To: <20100311214022.838696145@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4392059176674366819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement a generic control protocol that can be shared by both LCP and NCP
implementations.

Index: ofono/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/Makefile.am	2010-03-10 16:58:12.039961039 -0800
+++ ofono/Makefile.am	2010-03-10 17:00:34.037087986 -0800
@@ -57,7 +57,8 @@
 				gatchat/gat.h \
 				gatchat/gatserver.h gatchat/gatserver.c \
 				gatchat/gatppp.c gatchat/gatppp.h \
-				gatchat/gatppp_internal.h
+				gatchat/gatppp_internal.h gatchat/gatpppcp.c
+				gatchat/gatpppcp.h
 =

 udev_files =3D plugins/ofono.rules
 =

Index: ofono/gatchat/gatpppcp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ofono/gatchat/gatpppcp.c	2010-03-10 17:00:34.039103187 -0800
@@ -0,0 +1,1492 @@
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
+static gboolean pppcp_timeout(gpointer user);
+static void pppcp_handle_event(gpointer user);
+static gint is_option(struct ppp_option *o, gpointer user);
+
+const char *pppcp_state_strings[] =3D
+	{"INITIAL", "STARTING", "CLOSED", "STOPPED", "CLOSING", "STOPPING",
+	"REQSENT", "ACKRCVD", "ACKSENT", "OPENED" };
+
+#ifdef DEBUG
+#define pppcp_trace(p) \
+	(g_print("%s: current state %d:%s\n", __FUNCTION__, \
+		p->state, pppcp_state_strings[p->state]))
+#else
+#define pppcp_trace(p)
+#endif
+
+#define pppcp_to_ppp_packet(p) \
+	(p-PPP_HEADROOM)
+
+/* CP packet header */
+struct pppcp_header {
+	guint8 code;
+	guint8 identifier;
+	guint16 length;
+};
+
+struct pppcp_event {
+	guint type;
+	gint len;
+	guint8 data[0];
+};
+
+enum {
+	INITIAL_RESTART_TIMEOUT	=3D 3000,
+	MAX_TERMINATE		=3D 2,
+	MAX_CONFIGURE		=3D 10,
+	MAX_FAILURE		=3D 5,
+	CP_HEADER_SZ		=3D 4,
+
+	/* states */
+	INITIAL =3D 0,
+	STARTING	=3D 1,
+	CLOSED		=3D 2,
+	STOPPED		=3D 3,
+	CLOSING		=3D 4,
+	STOPPING	=3D 5,
+	REQSENT		=3D 6,
+	ACKRCVD		=3D 7,
+	ACKSENT		=3D 8,
+	OPENED		=3D 9,
+};
+
+static struct pppcp_packet * pppcp_packet_new(struct pppcp_data *data,
+						guint type, guint bufferlen)
+{
+	struct pppcp_header *packet;
+	guint8 *ppp_packet;
+
+	ppp_packet =3D g_malloc0(bufferlen + sizeof(*packet) + 2);
+	if (!ppp_packet)
+		return NULL;
+
+	/* add our protocol information */
+	*((guint16 *)ppp_packet) =3D htons(data->proto);
+
+	/* advance past protocol to add CP header information */
+	packet =3D (struct pppcp_header *) (ppp_packet + 2);
+
+	packet->length =3D htons((guint16)(bufferlen + sizeof(*packet)));
+	packet->code =3D type;
+	return ((struct pppcp_packet *)packet);
+}
+
+static void pppcp_start_timer(struct pppcp_data *data)
+{
+	data->restart_timer =3D g_timeout_add(data->restart_interval,
+				pppcp_timeout, data);
+}
+
+static void pppcp_stop_timer(struct pppcp_data *data)
+{
+	if (data->restart_timer) {
+		g_source_remove(data->restart_timer);
+		data->restart_timer =3D 0;
+	}
+}
+
+static gboolean pppcp_timer_is_running(struct pppcp_data *data)
+{
+	/* determine if the restart timer is running */
+	if (data->restart_timer)
+		return TRUE;
+	return FALSE;
+}
+
+
+static gboolean pppcp_timeout(gpointer user)
+{
+	struct pppcp_data *data =3D user;
+
+	pppcp_trace(data);
+
+	data->restart_timer =3D 0;
+
+	if (data->restart_counter)
+		pppcp_generate_event(data, TO_PLUS, NULL, 0);
+	else
+		pppcp_generate_event(data, TO_MINUS, NULL, 0);
+	return FALSE;
+}
+
+struct pppcp_event * pppcp_event_new(guint type, gpointer event_data, guin=
t len)
+{
+	struct pppcp_event *event;
+	guint8 *data =3D (guint8 *)event_data;
+
+	event =3D g_malloc(sizeof(struct pppcp_event) + len);
+	if (!event)
+		return NULL;
+
+	event->type =3D type;
+	memcpy(event->data, data, len);
+	event->len =3D len;
+	return event;
+}
+
+/*
+ * send the event handler a new event to process
+ */
+void pppcp_generate_event(struct pppcp_data *data, guint event_type,
+				gpointer event_data, guint data_len)
+{
+	struct pppcp_event *event;
+
+	event =3D pppcp_event_new(event_type, event_data, data_len);
+	if (event)
+		g_queue_push_tail(data->event_queue, event);
+	pppcp_handle_event(data);
+}
+
+static struct pppcp_event * pppcp_get_event(struct pppcp_data *data)
+{
+	return g_queue_pop_head(data->event_queue);
+}
+
+/* actions */
+/* log an illegal event, but otherwise do nothing */
+static void pppcp_illegal_event(guint8 state, guint8 type)
+{
+	g_printerr("Illegal event %d while in state %d\n", type, state);
+}
+
+static void pppcp_this_layer_up(struct pppcp_data *data)
+{
+	struct pppcp_action *action =3D data->action;
+
+	if (action->this_layer_up)
+		action->this_layer_up(data);
+}
+
+static void pppcp_this_layer_down(struct pppcp_data *data)
+{
+	struct pppcp_action *action =3D data->action;
+
+	if (action->this_layer_up)
+		action->this_layer_down(data);
+}
+
+static void pppcp_this_layer_started(struct pppcp_data *data)
+{
+	struct pppcp_action *action =3D data->action;
+
+	if (action->this_layer_up)
+		action->this_layer_started(data);
+}
+
+static void pppcp_this_layer_finished(struct pppcp_data *data)
+{
+	struct pppcp_action *action =3D data->action;
+
+	if (action->this_layer_up)
+		action->this_layer_finished(data);
+}
+
+static void pppcp_free_option(gpointer data, gpointer user)
+{
+	struct ppp_option *option =3D (struct ppp_option *)data;
+	g_free(option);
+}
+
+static void pppcp_clear_options(struct pppcp_data *data)
+{
+	g_list_foreach(data->acceptable_options, pppcp_free_option, NULL);
+	g_list_foreach(data->unacceptable_options, pppcp_free_option, NULL);
+	g_list_foreach(data->rejected_options, pppcp_free_option, NULL);
+	g_list_free(data->acceptable_options);
+	g_list_free(data->unacceptable_options);
+	g_list_free(data->rejected_options);
+	data->acceptable_options =3D NULL;
+	data->unacceptable_options =3D NULL;
+	data->rejected_options =3D NULL;
+}
+
+/*
+ * set the restart counter to either max-terminate
+ * or max-configure.  The counter is decremented for
+ * each transmission, including the first.
+ */
+static void pppcp_initialize_restart_count(struct pppcp_data *data, guint =
value)
+{
+	pppcp_trace(data);
+	pppcp_clear_options(data);
+	data->restart_counter =3D value;
+}
+
+/*
+ * set restart counter to zero
+ */
+static void pppcp_zero_restart_count(struct pppcp_data *data)
+{
+	data->restart_counter =3D 0;
+}
+
+/*
+ * TBD - generate new identifier for packet
+ */
+static guint8 new_identity(struct pppcp_data *data, guint prev_identifier)
+{
+	return prev_identifier+1;
+}
+
+static void get_option_length(gpointer data, gpointer user)
+{
+	struct ppp_option *option =3D (struct ppp_option *)data;
+	guint8 *length =3D (guint8 *)user;
+
+	*length +=3D option->length;
+}
+
+static void copy_option(gpointer data, gpointer user)
+{
+	struct ppp_option *option =3D (struct ppp_option *)data;
+	guint8 **location =3D (guint8 **)user;
+	memcpy(*location, (guint8 *)option, option->length);
+	*location +=3D option->length;
+}
+
+void pppcp_add_config_option(struct pppcp_data *data, struct ppp_option *o=
ption)
+{
+	data->config_options =3D g_list_append(data->config_options, option);
+}
+
+/*
+ * transmit a Configure-Request packet
+ * start the restart timer
+ * decrement the restart counter
+ */
+static void pppcp_send_configure_request(struct pppcp_data *data)
+{
+	struct pppcp_packet *packet;
+	guint8 olength =3D 0;
+	guint8 *odata;
+
+	pppcp_trace(data);
+
+	/* figure out how much space to allocate for options */
+	g_list_foreach(data->config_options, get_option_length, &olength);
+
+	packet =3D pppcp_packet_new(data, CONFIGURE_REQUEST, olength);
+
+	/* copy config options into packet data */
+	odata =3D packet->data;
+	g_list_foreach(data->config_options, copy_option, &odata);
+
+	/*
+	 * if this is the first request, we need a new identifier.
+	 * if this is a retransmission, leave the identifier alone.
+	 */
+	if (data->restart_counter =3D=3D data->max_configure)
+		data->config_identifier =3D
+			new_identity(data, data->config_identifier);
+	packet->identifier =3D data->config_identifier;
+
+	ppp_transmit(data->link, pppcp_to_ppp_packet((guint8 *)packet),
+			ntohs(packet->length));
+
+	/* XXX don't retransmit right now */
+#if 0
+	data->restart_counter--;
+	pppcp_start_timer(data);
+#endif
+}
+
+/*
+ * transmit a Configure-Ack packet
+ */
+static void pppcp_send_configure_ack(struct pppcp_data *data,
+					guint8 *request)
+{
+	struct pppcp_packet *packet;
+	struct pppcp_packet *pppcp_header =3D (struct pppcp_packet *)request;
+	guint len;
+	guint8 *odata;
+
+	pppcp_trace(data);
+
+	/* subtract for header. */
+	len =3D ntohs(pppcp_header->length) - sizeof(*packet);
+
+	packet =3D pppcp_packet_new(data, CONFIGURE_ACK, len);
+
+	/* copy the applied options in. */
+	odata =3D packet->data;
+
+	if (g_list_length(data->acceptable_options))
+		g_list_foreach(data->acceptable_options, copy_option, &odata);
+
+	/* match identifier of the request */
+	packet->identifier =3D pppcp_header->identifier;
+
+	ppp_transmit(data->link, pppcp_to_ppp_packet((guint8 *)packet),
+			ntohs(packet->length));
+}
+
+/*
+ * transmit a Configure-Nak or Configure-Reject packet
+ */
+static void pppcp_send_configure_nak(struct pppcp_data *data,
+					guint8 *configure_packet)
+{
+	struct pppcp_packet *packet;
+	struct pppcp_packet *pppcp_header =3D
+			(struct pppcp_packet *)configure_packet;
+	guint8 olength =3D 0;
+	guint8 *odata;
+
+	/* if we have any rejected options, send a config-reject */
+	if (g_list_length(data->rejected_options)) {
+		/* figure out how much space to allocate for options */
+		g_list_foreach(data->rejected_options, get_option_length,
+				&olength);
+
+		packet =3D pppcp_packet_new(data, CONFIGURE_REJECT, olength);
+
+		/* copy the rejected options in. */
+		odata =3D packet->data;
+		g_list_foreach(data->rejected_options, copy_option,
+				&odata);
+
+		packet->identifier =3D pppcp_header->identifier;
+		ppp_transmit(data->link, pppcp_to_ppp_packet((guint8 *)packet),
+			ntohs(packet->length));
+
+	}
+	/* if we have any unacceptable options, send a config-nak */
+	if (g_list_length(data->unacceptable_options)) {
+		olength =3D 0;
+
+		/* figure out how much space to allocate for options */
+		g_list_foreach(data->unacceptable_options, get_option_length,
+				&olength);
+
+		packet =3D pppcp_packet_new(data, CONFIGURE_NAK, olength);
+
+		/* copy the unacceptable options in. */
+		odata =3D packet->data;
+		g_list_foreach(data->unacceptable_options, copy_option,
+				&odata);
+
+		packet->identifier =3D pppcp_header->identifier;
+		ppp_transmit(data->link, pppcp_to_ppp_packet((guint8 *)packet),
+				ntohs(packet->length));
+	}
+}
+
+/*
+ * transmit a Terminate-Request packet.
+ * start the restart timer.
+ * decrement the restart counter
+ */
+static void pppcp_send_terminate_request(struct pppcp_data *data)
+{
+	struct pppcp_packet *packet;
+
+	/*
+	 * the data field can be used by the sender (us).
+	 * leave this empty for now.
+	 */
+	packet =3D pppcp_packet_new(data, TERMINATE_REQUEST, 0);
+
+	/*
+	 * Is this a retransmission?  If so, do not change
+	 * the identifier.  If not, we need a fresh identity.
+	 */
+	if (data->restart_counter =3D=3D data->max_terminate)
+		data->terminate_identifier =3D
+			new_identity(data, data->terminate_identifier);
+	packet->identifier =3D data->terminate_identifier;
+	ppp_transmit(data->link, pppcp_to_ppp_packet((guint8 *)packet),
+			ntohs(packet->length));
+	data->restart_counter--;
+	pppcp_start_timer(data);
+}
+
+/*
+ * transmit a Terminate-Ack packet
+ */
+static void pppcp_send_terminate_ack(struct pppcp_data *data,
+					guint8 *request)
+{
+	struct pppcp_packet *packet;
+	struct pppcp_packet *pppcp_header =3D (struct pppcp_packet *)request;
+
+	packet =3D pppcp_packet_new(data, TERMINATE_ACK, 0);
+
+	/* match identifier of the request */
+	packet->identifier =3D pppcp_header->identifier;
+
+	ppp_transmit(data->link, pppcp_to_ppp_packet((guint8 *)packet),
+			ntohs(pppcp_header->length));
+}
+
+/*
+ * transmit a Code-Reject packet
+ *
+ * XXX this seg faults.
+ */
+static void pppcp_send_code_reject(struct pppcp_data *data,
+					guint8 *rejected_packet)
+{
+	struct pppcp_packet *packet;
+
+	packet =3D pppcp_packet_new(data, CODE_REJECT,
+			ntohs(((struct pppcp_packet *)rejected_packet)->length));
+
+	/*
+	 * Identifier must be changed for each Code-Reject sent
+	 */
+	packet->identifier =3D new_identity(data, data->reject_identifier);
+
+	/*
+	 * rejected packet should be copied in, but it should be
+	 * truncated if it needs to be to comply with mtu requirement
+	 */
+	memcpy(packet->data, rejected_packet,
+			ntohs(packet->length - CP_HEADER_SZ));
+
+	ppp_transmit(data->link, pppcp_to_ppp_packet((guint8 *)packet),
+			ntohs(packet->length));
+}
+
+/*
+ * transmit an Echo-Reply packet
+ */
+static void pppcp_send_echo_reply(struct pppcp_data *data,
+				guint8 *request)
+{
+	struct pppcp_packet *packet;
+	struct pppcp_packet *header =3D (struct pppcp_packet *)request;
+
+	/*
+	 * 0 bytes for data, 4 bytes for magic number
+	 */
+	packet =3D pppcp_packet_new(data, ECHO_REPLY, 4);
+
+	/*
+	 * match identifier of request
+	 */
+	packet->identifier =3D header->identifier;
+
+	/* magic number? */
+	ppp_transmit(data->link, pppcp_to_ppp_packet((guint8 *)packet),
+			ntohs(packet->length));
+
+}
+
+/* what about locking, do we need to worry about that here */
+static void pppcp_transition_state(int new_state, struct pppcp_data *data)
+{
+	/*
+	 * if switching from a state where
+	 * TO events occur, to one where they
+	 * may not, shut off the timer
+	 */
+	switch(new_state) {
+	case INITIAL:
+	case STARTING:
+	case CLOSED:
+	case STOPPED:
+	case OPENED:
+		/* if timer is running, stop it */
+		if (pppcp_timer_is_running(data))
+			pppcp_stop_timer(data);
+		break;
+	default:
+		break;
+		/* do nothing */
+	}
+	data->state =3D new_state;
+}
+
+static void pppcp_up_event(struct pppcp_data *data, guint8 *packet, guint =
len)
+{
+	pppcp_trace(data);
+	switch(data->state) {
+	case INITIAL:
+		/* switch state to CLOSED */
+		pppcp_transition_state(CLOSED, data);
+		break;
+	case STARTING:
+		/* irc, scr/6 */
+		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	default:
+		/* all other are illegal */
+		pppcp_illegal_event(data->state, UP);
+	}
+
+}
+
+static void pppcp_down_event(struct pppcp_data *data, guint8 *packet, guin=
t len)
+{
+	switch(data->state) {
+	case CLOSED:
+		pppcp_transition_state(INITIAL, data);
+		break;
+	case STOPPED:
+		/* tls/1 */
+		pppcp_transition_state(STARTING, data);
+		pppcp_this_layer_started(data);
+		break;
+	case CLOSING:
+		pppcp_transition_state(INITIAL, data);
+		break;
+	case STOPPING:
+	case REQSENT:
+	case ACKRCVD:
+	case ACKSENT:
+		pppcp_transition_state(STARTING, data);
+		break;
+	case OPENED:
+		pppcp_transition_state(STARTING, data);
+		pppcp_this_layer_down(data);
+	default:
+		pppcp_illegal_event(data->state, DOWN);
+		/* illegal */
+	}
+}
+
+static void pppcp_open_event(struct pppcp_data *data, guint8 *packet, guin=
t len)
+{
+	pppcp_trace(data);
+	switch(data->state) {
+	case INITIAL:
+		/* tls/1 */
+		pppcp_transition_state(STARTING, data);
+		pppcp_this_layer_started(data);
+		break;
+	case STARTING:
+		pppcp_transition_state(STARTING, data);
+		break;
+	case CLOSED:
+		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	case STOPPED:
+		/* 3r */
+		pppcp_transition_state(STOPPED, data);
+		break;
+	case CLOSING:
+	case STOPPING:
+		/* 5r */
+		pppcp_transition_state(STOPPING, data);
+		break;
+	case REQSENT:
+	case ACKRCVD:
+	case ACKSENT:
+		pppcp_transition_state(data->state, data);
+		break;
+	case OPENED:
+		/* 9r */
+		pppcp_transition_state(data->state, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, OPEN);
+	}
+}
+
+static void pppcp_close_event(struct pppcp_data *data, guint8* packet, gui=
nt len)
+{
+	switch(data->state) {
+	case INITIAL:
+		pppcp_transition_state(INITIAL, data);
+		break;
+	case STARTING:
+		pppcp_this_layer_finished(data);
+		pppcp_transition_state(INITIAL, data);
+		break;
+	case CLOSED:
+	case STOPPED:
+		pppcp_transition_state(CLOSED, data);
+		break;
+	case CLOSING:
+	case STOPPING:
+		pppcp_transition_state(CLOSING, data);
+		break;
+	case OPENED:
+		pppcp_this_layer_down(data);
+	case REQSENT:
+	case ACKRCVD:
+	case ACKSENT:
+		pppcp_initialize_restart_count(data, data->max_terminate);
+		pppcp_send_terminate_request(data);
+		pppcp_transition_state(CLOSING, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, CLOSE);
+		/* illegal */
+	}
+}
+
+static void pppcp_to_plus_event(struct pppcp_data *data, guint8 *packet, g=
uint len)
+{
+	pppcp_trace(data);
+
+	switch(data->state) {
+	case CLOSING:
+		pppcp_send_terminate_request(data);
+		pppcp_transition_state(CLOSING, data);
+		break;
+	case STOPPING:
+		pppcp_send_terminate_request(data);
+		pppcp_transition_state(STOPPING, data);
+		break;
+	case REQSENT:
+	case ACKRCVD:
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	case ACKSENT:
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(ACKSENT, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, TO_PLUS);
+	}
+}
+
+static void pppcp_to_minus_event(struct pppcp_data *data, guint8 *packet, =
guint len)
+{
+	pppcp_trace(data);
+	switch(data->state) {
+	case CLOSING:
+		pppcp_transition_state(CLOSED, data);
+		pppcp_this_layer_finished(data);
+		break;
+	case STOPPING:
+		pppcp_transition_state(STOPPED, data);
+		pppcp_this_layer_finished(data);
+		break;
+	case REQSENT:
+	case ACKRCVD:
+	case ACKSENT:
+		/* tlf/3p */
+		pppcp_transition_state(STOPPED, data);
+		pppcp_this_layer_finished(data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, TO_MINUS);
+	}
+}
+
+static void pppcp_rcr_plus_event(struct pppcp_data *data,
+				guint8 *packet, guint len)
+{
+	pppcp_trace(data);
+	switch(data->state) {
+	case CLOSED:
+		pppcp_send_terminate_ack(data, packet);
+		pppcp_transition_state(CLOSED, data);
+		break;
+	case STOPPED:
+		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_send_configure_request(data);
+		pppcp_send_configure_ack(data, packet);
+		pppcp_transition_state(ACKSENT, data);
+		break;
+	case CLOSING:
+	case STOPPING:
+		pppcp_transition_state(data->state, data);
+		break;
+	case REQSENT:
+		pppcp_send_configure_ack(data, packet);
+		pppcp_transition_state(ACKSENT, data);
+		break;
+	case ACKRCVD:
+		pppcp_send_configure_ack(data, packet);
+		pppcp_this_layer_up(data);
+		pppcp_transition_state(OPENED, data);
+		break;
+	case ACKSENT:
+		pppcp_send_configure_ack(data, packet);
+		pppcp_transition_state(ACKSENT, data);
+		break;
+	case OPENED:
+		pppcp_this_layer_down(data);
+		pppcp_send_configure_request(data);
+		pppcp_send_configure_ack(data, packet);
+		pppcp_transition_state(ACKSENT, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, RCR_PLUS);
+	}
+}
+
+static void pppcp_rcr_minus_event(struct pppcp_data *data,
+				guint8 *packet, guint len)
+{
+	pppcp_trace(data);
+
+	switch(data->state) {
+	case CLOSED:
+		pppcp_send_terminate_ack(data, packet);
+		pppcp_transition_state(CLOSED, data);
+		break;
+	case STOPPED:
+		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_send_configure_request(data);
+		pppcp_send_configure_nak(data, packet);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	case CLOSING:
+	case STOPPING:
+		pppcp_transition_state(data->state, data);
+		break;
+	case REQSENT:
+	case ACKRCVD:
+		pppcp_send_configure_nak(data, packet);
+		pppcp_transition_state(data->state, data);
+		break;
+	case ACKSENT:
+		pppcp_send_configure_nak(data, packet);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	case OPENED:
+		pppcp_this_layer_down(data);
+		pppcp_send_configure_request(data);
+		pppcp_send_configure_nak(data, packet);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, RCR_MINUS);
+	}
+}
+
+static void pppcp_rca_event(struct pppcp_data *data, guint8 *packet, guint=
 len)
+{
+	pppcp_trace(data);
+
+	switch(data->state) {
+	case CLOSED:
+	case STOPPED:
+		pppcp_send_terminate_ack(data, packet);
+	case CLOSING:
+	case STOPPING:
+		pppcp_transition_state(data->state, data);
+		break;
+	case REQSENT:
+		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_transition_state(ACKRCVD, data);
+		break;
+	case ACKRCVD:
+		/* scr/6x */
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(REQSENT, data);
+	case ACKSENT:
+		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_this_layer_up(data);
+		pppcp_transition_state(OPENED, data);
+		break;
+	case OPENED:
+		pppcp_this_layer_down(data);
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, RCA);
+	}
+}
+
+static void pppcp_rcn_event(struct pppcp_data *data, guint8 *packet, guint=
 len)
+{
+	pppcp_trace(data);
+
+	switch(data->state) {
+	case CLOSED:
+	case STOPPED:
+		pppcp_send_terminate_ack(data, packet);
+	case CLOSING:
+	case STOPPING:
+		pppcp_transition_state(data->state, data);
+	case REQSENT:
+		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	case ACKRCVD:
+		/* scr/6x */
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	case ACKSENT:
+		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(ACKSENT, data);
+		break;
+	case OPENED:
+		pppcp_this_layer_down(data);
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, RCN);
+	}
+}
+
+static void pppcp_rtr_event(struct pppcp_data *data, guint8 *packet, guint=
 len)
+{
+	pppcp_trace(data);
+
+	switch(data->state) {
+	case CLOSED:
+	case STOPPED:
+		pppcp_send_terminate_ack(data, packet);
+	case CLOSING:
+	case STOPPING:
+		break;
+	case REQSENT:
+	case ACKRCVD:
+	case ACKSENT:
+		pppcp_send_terminate_ack(data, packet);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	case OPENED:
+		pppcp_this_layer_down(data);
+		pppcp_zero_restart_count(data);
+		pppcp_send_terminate_ack(data, packet);
+		pppcp_transition_state(STOPPING, data);
+		break;
+
+	default:
+		pppcp_illegal_event(data->state, RTR);
+	}
+}
+
+static void pppcp_rta_event(struct pppcp_data *data, guint8 *packet, guint=
 len)
+{
+	pppcp_trace(data);
+
+	switch(data->state) {
+	case CLOSED:
+	case STOPPED:
+		pppcp_transition_state(data->state, data);
+		break;
+	case CLOSING:
+		pppcp_this_layer_finished(data);
+		pppcp_transition_state(CLOSED, data);
+		break;
+	case STOPPING:
+		pppcp_this_layer_finished(data);
+		pppcp_transition_state(STOPPED, data);
+		break;
+	case REQSENT:
+	case ACKRCVD:
+		pppcp_transition_state(REQSENT, data);
+		break;
+	case ACKSENT:
+		pppcp_transition_state(ACKSENT, data);
+		break;
+	case OPENED:
+		pppcp_this_layer_down(data);
+		pppcp_send_configure_request(data);
+		pppcp_transition_state(REQSENT, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, RTA);
+	}
+}
+
+static void pppcp_ruc_event(struct pppcp_data *data, guint8 *packet, guint=
 len)
+{
+	pppcp_trace(data);
+
+	switch(data->state) {
+	case CLOSED:
+	case STOPPED:
+	case CLOSING:
+	case STOPPING:
+	case REQSENT:
+	case ACKRCVD:
+	case ACKSENT:
+	case OPENED:
+		pppcp_send_code_reject(data, packet);
+		pppcp_transition_state(data->state, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, RUC);
+	}
+}
+
+static void pppcp_rxj_plus_event(struct pppcp_data *data, guint8 *packet, =
guint len)
+{
+	pppcp_trace(data);
+
+	switch(data->state) {
+	case CLOSED:
+	case STOPPED:
+	case CLOSING:
+	case STOPPING:
+		pppcp_transition_state(data->state, data);
+		break;
+	case REQSENT:
+	case ACKRCVD:
+		pppcp_transition_state(REQSENT, data);
+		break;
+	case ACKSENT:
+	case OPENED:
+		pppcp_transition_state(data->state, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, RXJ_PLUS);
+	}
+}
+
+static void pppcp_rxj_minus_event(struct pppcp_data *data,
+				guint8 *packet, guint len)
+{
+	pppcp_trace(data);
+
+	switch(data->state) {
+	case CLOSED:
+	case STOPPED:
+		pppcp_this_layer_finished(data);
+		pppcp_transition_state(data->state, data);
+		break;
+	case CLOSING:
+		pppcp_this_layer_finished(data);
+		pppcp_transition_state(CLOSED, data);
+		break;
+	case STOPPING:
+		pppcp_this_layer_finished(data);
+		pppcp_transition_state(STOPPED, data);
+		break;
+	case REQSENT:
+	case ACKRCVD:
+	case ACKSENT:
+		pppcp_this_layer_finished(data);
+		pppcp_transition_state(STOPPED, data);
+		break;
+	case OPENED:
+		pppcp_this_layer_down(data);
+		pppcp_initialize_restart_count(data, data->max_terminate);
+		pppcp_send_terminate_request(data);
+		pppcp_transition_state(STOPPING, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, RXJ_MINUS);
+	}
+}
+
+static void pppcp_rxr_event(struct pppcp_data *data, guint8 *packet, guint=
 len)
+{
+	pppcp_trace(data);
+
+	switch(data->state) {
+	case CLOSED:
+	case STOPPED:
+	case CLOSING:
+	case STOPPING:
+	case REQSENT:
+	case ACKRCVD:
+	case ACKSENT:
+		pppcp_transition_state(data->state, data);
+		break;
+	case OPENED:
+		pppcp_send_echo_reply(data, packet);
+		pppcp_transition_state(OPENED, data);
+		break;
+	default:
+		pppcp_illegal_event(data->state, RXR);
+	}
+}
+
+/*
+ * This was implemented as a separate thread which
+ * gets event messages off of an asynchronous queue.
+ *
+ * it is now just a synchronous queue to avoid the
+ * use of threads.
+ */
+static void pppcp_handle_event(gpointer user)
+{
+	struct pppcp_event *event;
+	struct pppcp_data *data =3D (struct pppcp_data *) user;
+
+	while ((event =3D pppcp_get_event(data))) {
+		if (event->type > RXR)
+			pppcp_illegal_event(data->state, event->type);
+		else
+			data->event_ops[event->type](data, event->data,
+							event->len);
+		g_free(event);
+	}
+}
+
+static void verify_config_option(gpointer elem, gpointer user)
+{
+	struct ppp_option *config =3D (struct ppp_option *)elem;
+	struct pppcp_data *data =3D (struct pppcp_data *)user;
+	GList *list =3D NULL;
+	struct ppp_option *option;
+
+	/*
+	 * determine whether this config option is in the
+	 * acceptable options list
+	 */
+	if (g_list_length(data->acceptable_options))
+		list =3D g_list_find_custom(data->acceptable_options,
+				GUINT_TO_POINTER(config->type),
+				(GCompareFunc) is_option);
+	if (!list) {
+		/*
+		 * if the option did not exist, we need to store a copy
+		 * of the option in the unacceptable_options list so it
+		 * can be nak'ed.
+		 */
+		option =3D g_malloc0(config->length);
+		option->type =3D config->type;
+		option->length =3D config->length;
+		data->unacceptable_options =3D
+			g_list_append(data->unacceptable_options, option);
+	}
+
+}
+
+static void remove_config_option(gpointer elem, gpointer user)
+{
+	struct ppp_option *config =3D (struct ppp_option *)elem;
+	struct pppcp_data *data =3D (struct pppcp_data *)user;
+	GList *list =3D NULL;
+
+	/*
+	 * determine whether this config option is in the
+	 * applied options list
+	 */
+	if (g_list_length(data->config_options)) {
+		list =3D g_list_find_custom(data->config_options,
+				GUINT_TO_POINTER(config->type),
+				(GCompareFunc) is_option);
+		if (list)
+			data->config_options =3D
+				g_list_delete_link(data->config_options, list);
+	}
+}
+
+static guint8 pppcp_process_configure_request(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	gint len;
+	int i=3D 0;
+	struct ppp_option *option;
+	guint rval =3D -1;
+	struct pppcp_action *action =3D data->action;
+
+	pppcp_trace(data);
+
+	len =3D ntohs(packet->length) - CP_HEADER_SZ;
+
+	/*
+	 * check the options.
+	 */
+	while (i < len) {
+		guint8 otype =3D packet->data[i];
+		guint8 olen =3D packet->data[i+1];
+		option =3D g_malloc0(olen);
+		option->type =3D otype;
+		option->length =3D olen;
+		memcpy(option->data, &packet->data[i+2], olen-2);
+		if (action->option_scan)
+			rval =3D action->option_scan(option, data);
+		switch(rval) {
+		case OPTION_ACCEPT:
+			data->acceptable_options =3D
+				g_list_append(data->acceptable_options, option);
+			break;
+		case OPTION_REJECT:
+			data->rejected_options =3D
+				g_list_append(data->rejected_options, option);
+			break;
+		case OPTION_NAK:
+			data->unacceptable_options =3D
+				g_list_append(data->unacceptable_options,
+						option);
+			break;
+		default:
+			g_printerr("unexpected scan_option rval %d\n", rval);
+		}
+		/* skip ahead to the next option */
+		i +=3D olen;
+	}
+
+	/* make sure all required config options were included */
+	g_list_foreach(data->config_options, verify_config_option, data);
+
+	if (g_list_length(data->unacceptable_options) ||
+		g_list_length(data->rejected_options))
+		return RCR_MINUS;
+
+	/*
+	 * all options were acceptable, so we should apply them before
+	 * sending a configure-ack
+	 *
+	 * Remove all applied options from the config_option list.  The
+	 * protocol will have to re-add them if they want them renegotiated
+	 * when the link goes down.
+	 */
+	if (action->option_process) {
+		g_list_foreach(data->acceptable_options,
+				action->option_process, data->priv);
+		g_list_foreach(data->acceptable_options, remove_config_option,
+				data);
+	}
+
+	return RCR_PLUS;
+}
+
+static guint8 pppcp_process_configure_ack(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	guint len;
+	GList *list;
+	struct ppp_option *acked_option;
+	guint i =3D 0;
+	struct pppcp_action *action =3D data->action;
+
+	pppcp_trace(data);
+
+	len =3D ntohs(packet->length) - CP_HEADER_SZ;
+
+	/* if identifiers don't match, we should silently discard */
+	if (packet->identifier !=3D data->config_identifier) {
+		g_printerr("received an ack id %d, but config id is %d\n",
+			packet->identifier, data->config_identifier);
+		return 0;
+	}
+
+	/*
+	 * check each acked option.  If it is what we requested,
+	 * then we can apply these option values.
+	 *
+	 * XXX what if it isn't?  Do this correctly -- for now
+	 * we are just going to assume that all options matched
+	 * and apply them.
+	 */
+	while (i < len) {
+		guint8 otype =3D packet->data[i];
+		guint8 olen =3D packet->data[i+1];
+		acked_option =3D g_malloc0(olen);
+		acked_option->type =3D otype;
+		acked_option->length =3D olen;
+		memcpy(acked_option->data, &packet->data[i+2], olen-2);
+		list =3D g_list_find_custom(data->config_options,
+				GUINT_TO_POINTER(acked_option->type),
+				(GCompareFunc) is_option);
+		if (list) {
+			/*
+			 * once we've applied the option, delete it from
+		 	 * the config_options list.
+			 */
+			if (action->option_process)
+				action->option_process(acked_option,
+							data->priv);
+			data->config_options =3D
+				g_list_delete_link(data->config_options, list);
+		} else
+			g_printerr("oops -- found acked option %d we didn't request\n", acked_o=
ption->type);
+		g_free(acked_option);
+
+		/* skip ahead to the next option */
+		i +=3D olen;
+	}
+	return RCA;
+}
+
+static gint is_option(struct ppp_option *o, gpointer user)
+{
+	guint8 otype =3D (guint8) GPOINTER_TO_UINT(user);
+
+	if (o->type =3D=3D otype)
+		return 0;
+	else
+		return -1;
+}
+
+static guint8 pppcp_process_configure_nak(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	guint len;
+	GList *list;
+	struct ppp_option *naked_option;
+	struct ppp_option *config_option;
+	guint i =3D 0;
+	gint rval =3D -1;
+	struct pppcp_action *action =3D data->action;
+
+	pppcp_trace(data);
+
+	len =3D ntohs(packet->length) - CP_HEADER_SZ;
+
+	/* if identifiers don't match, we should silently discard */
+	if (packet->identifier !=3D data->config_identifier)
+		return 0;
+
+	/*
+	 * check each unacceptable option.  If it is acceptable, then
+	 * we can resend the configure request with this value. we need
+	 * to check the current config options to see if we need to
+	 * modify a value there, or add a new option.
+	 */
+	while (i < len) {
+		guint8 otype =3D packet->data[i];
+		guint8 olen =3D packet->data[i+1];
+		naked_option =3D g_malloc0(olen);
+		naked_option->type =3D otype;
+		naked_option->length =3D olen;
+		memcpy(naked_option->data, &packet->data[i+2], olen-2);
+		if (action->option_scan)
+			rval =3D action->option_scan(naked_option, data);
+		if (rval =3D=3D OPTION_ACCEPT) {
+			/*
+			 * check the current config options to see if they
+			 * match.
+			 */
+			list =3D g_list_find_custom(data->config_options,
+				GUINT_TO_POINTER(otype),
+				(GCompareFunc) is_option);
+			if (list) {
+				/* modify current option value to match */
+				config_option =3D list->data;
+
+				/*
+				 * option values should match, otherwise
+				 * we need to reallocate
+				 */
+				if ((config_option->length =3D=3D
+					naked_option->length) && (olen-2)) {
+						memcpy(config_option->data,
+							naked_option->data,
+							olen-2);
+				} else {
+					/* XXX implement this */
+					g_printerr("uh oh, option value doesn't match\n");
+				}
+				g_free(naked_option);
+			} else {
+				/* add to list of config options */
+				pppcp_add_config_option(data, naked_option);
+			}
+		} else {
+			/* XXX handle this correctly */
+			g_printerr("oops, option wasn't acceptable\n");
+			g_free(naked_option);
+		}
+
+		/* skip ahead to the next option */
+		i +=3D olen;
+	}
+	return RCN;
+}
+
+static guint8 pppcp_process_configure_reject(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	/*
+	 * make sure identifier matches that of last sent configure
+	 * request
+	 */
+	if (packet->identifier =3D=3D data->config_identifier) {
+		/*
+		 * check to see which options were rejected
+		 * Rejected options must be a subset of requested
+		 * options.
+		 *
+		 * when a new configure-request is sent, we may
+		 * not request any of these options be negotiated
+		 */
+		return RCN;
+	}
+	return 0;
+}
+
+static guint8 pppcp_process_terminate_request(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	return RTR;
+}
+
+static guint8 pppcp_process_terminate_ack(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	/*
+	 * if we wind up using the data field for anything, then
+	 * we'd want to check the identifier.
+	 * even if the identifiers don't match, we still handle
+	 * a terminate ack, as it is allowed to be unelicited
+	 */
+	return RTA;
+}
+
+static guint8 pppcp_process_code_reject(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	/*
+	 * determine if the code reject is catastrophic or not.
+	 * return RXJ_PLUS if this reject is acceptable, RXJ_MINUS if
+	 * it is catastrophic.
+	 */
+	return RXJ_MINUS;
+}
+
+static guint8 pppcp_process_protocol_reject(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	/*
+	 * determine if the protocol reject is catastrophic or not.
+	 * return RXJ_PLUS if this reject is acceptable, RXJ_MINUS if
+	 * it is catastrophic.
+	 */
+	return RXJ_MINUS;
+}
+
+static guint8 pppcp_process_echo_request(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	return RXR;
+}
+
+static guint8 pppcp_process_echo_reply(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	return 0;
+}
+
+static guint8 pppcp_process_discard_request(struct pppcp_data *data,
+					struct pppcp_packet *packet)
+{
+	return 0;
+}
+
+/*
+ * parse the packet and determine which event this packet caused
+ */
+void pppcp_process_packet(gpointer priv, guint8 *new_packet)
+{
+	struct pppcp_data *data =3D (struct pppcp_data *)priv;
+	struct pppcp_packet *packet =3D (struct pppcp_packet *)new_packet;
+	guint8 event_type;
+	gpointer event_data =3D NULL;
+	guint data_len =3D 0;
+
+	/* check flags to see if we support this code */
+	if (!(data->valid_codes & (1 << packet->code))) {
+		event_type =3D RUC;
+	} else
+		event_type =3D data->packet_ops[packet->code-1](data, packet);
+	if (event_type) {
+		data_len =3D ntohs(packet->length);
+		event_data =3D packet;
+		pppcp_generate_event(data, event_type, event_data, data_len);
+	}
+}
+
+void pppcp_set_valid_codes(struct pppcp_data *data, guint16 codes)
+{
+	data->valid_codes =3D codes;
+}
+
+void pppcp_free(struct pppcp_data *data)
+{
+	/* free event queue */
+	if (!g_queue_is_empty(data->event_queue))
+		g_queue_foreach(data->event_queue, (GFunc) g_free, NULL);
+	g_queue_free(data->event_queue);
+
+	/* remove all config options */
+	pppcp_clear_options(data);
+
+	/* free self */
+	g_free(data);
+}
+
+struct pppcp_data * pppcp_new(struct ppp_link *link, guint16 proto,
+				gpointer priv)
+{
+	struct pppcp_data *data;
+
+	data =3D g_malloc0(sizeof(struct pppcp_data));
+	if (!data)
+		return NULL;
+
+	data->state =3D INITIAL;
+	data->restart_interval =3D INITIAL_RESTART_TIMEOUT;
+	data->max_terminate =3D MAX_TERMINATE;
+	data->max_configure =3D MAX_CONFIGURE;
+	data->max_failure =3D MAX_FAILURE;
+	data->event_queue =3D g_queue_new();
+	data->identifier =3D 0;
+	data->link =3D link;
+	data->proto =3D proto;
+	data->priv =3D priv;
+
+	/* setup func ptrs for processing packet by pppcp code */
+	data->packet_ops[CONFIGURE_REQUEST-1] =3D pppcp_process_configure_request;
+	data->packet_ops[CONFIGURE_ACK-1] =3D pppcp_process_configure_ack;
+	data->packet_ops[CONFIGURE_NAK-1] =3D pppcp_process_configure_nak;
+	data->packet_ops[CONFIGURE_REJECT-1] =3D pppcp_process_configure_reject;
+	data->packet_ops[TERMINATE_REQUEST-1]=3D pppcp_process_terminate_request;
+	data->packet_ops[TERMINATE_ACK-1] =3D pppcp_process_terminate_ack;
+	data->packet_ops[CODE_REJECT-1] =3D pppcp_process_code_reject;
+	data->packet_ops[PROTOCOL_REJECT-1] =3D pppcp_process_protocol_reject;
+	data->packet_ops[ECHO_REQUEST-1] =3D pppcp_process_echo_request;
+	data->packet_ops[ECHO_REPLY-1] =3D pppcp_process_echo_reply;
+	data->packet_ops[DISCARD_REQUEST-1] =3D pppcp_process_discard_request;
+
+	/* setup func ptrs for handling events by event type */
+	data->event_ops[UP] =3D pppcp_up_event;
+	data->event_ops[DOWN] =3D pppcp_down_event;
+	data->event_ops[OPEN] =3D pppcp_open_event;
+	data->event_ops[CLOSE] =3D pppcp_close_event;
+	data->event_ops[TO_PLUS] =3D pppcp_to_plus_event;
+	data->event_ops[TO_MINUS] =3D pppcp_to_minus_event;
+	data->event_ops[RCR_PLUS] =3D pppcp_rcr_plus_event;
+	data->event_ops[RCR_MINUS] =3D pppcp_rcr_minus_event;
+	data->event_ops[RCA] =3D pppcp_rca_event;
+	data->event_ops[RCN] =3D pppcp_rcn_event;
+	data->event_ops[RTR] =3D pppcp_rtr_event;
+	data->event_ops[RTA] =3D pppcp_rta_event;
+	data->event_ops[RUC] =3D pppcp_ruc_event;
+	data->event_ops[RXJ_PLUS] =3D pppcp_rxj_plus_event;
+	data->event_ops[RXJ_MINUS] =3D pppcp_rxj_minus_event;
+	data->event_ops[RXR] =3D pppcp_rxr_event;
+
+	return data;
+}
Index: ofono/gatchat/gatpppcp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ ofono/gatchat/gatpppcp.h	2010-03-10 17:00:34.039103187 -0800
@@ -0,0 +1,133 @@
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
+#ifndef __PPPCP_H
+#define __PPPCP_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct pppcp_data;
+
+/* PPPCP CODE FIELD */
+enum PPPCP_CODE {
+	CONFIGURE_REQUEST =3D 1,
+	CONFIGURE_ACK,
+	CONFIGURE_NAK,
+	CONFIGURE_REJECT,
+	TERMINATE_REQUEST,
+	TERMINATE_ACK,
+	CODE_REJECT,
+	PROTOCOL_REJECT,
+	ECHO_REQUEST,
+	ECHO_REPLY,
+	DISCARD_REQUEST
+};
+
+enum PPPCP_EVENTS {
+	UP,
+	DOWN,
+	OPEN,
+	CLOSE,
+	TO_PLUS,
+	TO_MINUS,
+	RCR_PLUS,
+	RCR_MINUS,
+	RCA,
+	RCN,
+	RTR,
+	RTA,
+	RUC,
+	RXJ_PLUS,
+	RXJ_MINUS,
+	RXR,
+};
+
+/* option format */
+struct ppp_option {
+	guint8 type;
+	guint8 length;
+	guint8 data[0];
+};
+
+enum OPTION_RVAL {
+	OPTION_ACCEPT,
+	OPTION_REJECT,
+	OPTION_NAK,
+};
+
+struct pppcp_action {
+	void (*this_layer_up)(struct pppcp_data *data);
+	void (*this_layer_down)(struct pppcp_data *data);
+	void (*this_layer_started)(struct pppcp_data *data);
+	void (*this_layer_finished)(struct pppcp_data *data);
+	guint (*option_scan)(struct ppp_option *option, gpointer user);
+	void (*option_process)(gpointer option, gpointer user);
+};
+
+struct pppcp_packet {
+	guint8 code;
+	guint8 identifier;
+	guint16 length;
+	guint8 data[0];
+};
+
+struct pppcp_data {
+	gint state;
+	guint restart_timer;
+	guint restart_counter;
+	guint restart_interval;
+	guint max_terminate;
+	guint max_configure;
+	guint max_failure;
+	guint32 magic_number;
+	GQueue *event_queue;
+	GList *config_options;
+	GList *acceptable_options;
+	GList *unacceptable_options;
+	GList *rejected_options;
+	GList *applied_options;
+	struct ppp_link *link;
+	guint8 identifier;  /* don't think I need this now */
+	guint8 config_identifier;
+	guint8 terminate_identifier;
+	guint8 reject_identifier;
+	struct pppcp_action *action;
+	guint16 valid_codes;
+	guint8 (*packet_ops[11])(struct pppcp_data *data, struct pppcp_packet *pa=
cket);
+	void (*event_ops[16])(struct pppcp_data *data, guint8 *packet,
+				guint length);
+	gpointer priv;
+	guint16 proto;
+};
+
+struct pppcp_data * pppcp_new(struct ppp_link *link, guint16 proto, gpoint=
er priv);
+void pppcp_free(struct pppcp_data *data);
+void pppcp_add_config_option(struct pppcp_data *data, struct ppp_option *o=
ption);
+void pppcp_set_valid_codes(struct pppcp_data *data, guint16 codes);
+void pppcp_generate_event(struct pppcp_data *data, guint event_type,
+				gpointer event_data, guint data_len);
+struct pppcp_event * pppcp_event_new(guint type, gpointer event_data, guin=
t len);
+void pppcp_process_packet(gpointer priv, guint8 *new_packet);
+
+
+#endif
Index: ofono/gatchat/gatppp_internal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono.orig/gatchat/gatppp_internal.h	2010-03-10 16:58:12.039961039 -0800
+++ ofono/gatchat/gatppp_internal.h	2010-03-10 17:00:34.040101010 -0800
@@ -26,6 +26,8 @@
 extern "C" {
 #endif
 =

+#include "gatpppcp.h"
+
 #define DEFAULT_MRU	1500
 #define BUFFERSZ	DEFAULT_MRU*2
 #define DEFAULT_ACCM	0x00000000


--===============4392059176674366819==--

