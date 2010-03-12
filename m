Content-Type: multipart/mixed; boundary="===============6581907241637706196=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 1/6] Add PPP protocol support with HDLC framing
Date: Thu, 11 Mar 2010 20:17:49 -0600
Message-ID: <201003112017.50004.denkenz@gmail.com>
In-Reply-To: <20100311140030.0ce0b25f@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6581907241637706196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> This patch implements the basic PPP protocol.  LCP, NCP etc. are handled =
in
>  a different patch.
> =

> Index: ofono/Makefile.am
> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ofono.orig/Makefile.am	2010-03-10 16:58:09.915955860 -0800
> +++ ofono/Makefile.am	2010-03-10 16:58:12.039961039 -0800
> @@ -55,7 +55,9 @@
>  				gatchat/gattty.h gatchat/gattty.c \
>  				gatchat/gatutil.h gatchat/gatutil.c \
>  				gatchat/gat.h \
> -				gatchat/gatserver.h gatchat/gatserver.c
> +				gatchat/gatserver.h gatchat/gatserver.c \
> +				gatchat/gatppp.c gatchat/gatppp.h \
> +				gatchat/gatppp_internal.h
> =

>  udev_files =3D plugins/ofono.rules
> =

> Index: ofono/gatchat/gatppp_internal.h
> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ ofono/gatchat/gatppp_internal.h	2010-03-10 16:58:12.039961039 -0800
> @@ -0,0 +1,97 @@
> +/*
> + *
> + *  PPP library with GLib integration
> + *
> + *  Copyright (C) 2010  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1 =

>  USA + *
> + */
> +
> +#ifndef __G_AT_PPP_INTERNAL_H
> +#define __G_AT_PPP_INTERNAL_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#define DEFAULT_MRU	1500
> +#define BUFFERSZ	DEFAULT_MRU*2
> +#define DEFAULT_ACCM	0x00000000
> +#define PPP_ESC		0x7d
> +#define PPP_FLAG_SEQ 	0x7e
> +#define PPP_ADDR_FIELD	0xff
> +#define PPP_CTRL	0x03
> +#define LCP_PROTOCOL	0xc021
> +#define CHAP_PROTOCOL	0xc223
> +#define PPP_HEADROOM	2
> +#define HDLC_HEADROOM	3
> +#define HDLC_TAIL	3
> +#define MD5		5
> +
> +enum PPP_PHASE {
> +	DEAD =3D 0,
> +	ESTABLISHMENT,
> +	AUTHENTICATION,
> +	NETWORK,
> +	TERMINATION,
> +};
> +
> +enum PPP_EVENTS {
> +	PPP_UP =3D 1,
> +	PPP_OPENED,
> +	PPP_SUCCESS,
> +	PPP_NONE,
> +	PPP_CLOSING,
> +	PPP_FAIL,
> +	PPP_DOWN
> +};
> +
> +struct ppp_packet_handler {
> +	guint16 proto;
> +	void (*handler)(gpointer priv, guint8 *packet);
> +	gpointer priv;
> +};
> +
> +#define ppp_generate_event(l, e) \
> +	__ppp_generate_event(l, e)

Why do we need this define?

> +
> +#define ppp_transmit(l, p, i) \
> +	__ppp_transmit(l, p, i)
> +

and this?

> +#define ppp_register_packet_handler(h) \
> +	__ppp_register_packet_handler(h)

or this?

> +
> +#define ppp_info(packet) \
> +	(packet+4)
> +
> +#define ppp_proto(packet) \
> +	(ntohs(*((guint16*)(packet+2))))
> +
> +void __ppp_generate_event(struct ppp_link *link, guint event);
> +void __ppp_register_packet_handler(struct ppp_packet_handler *handler);
> +void __ppp_transmit(struct ppp_link *link, guint8 *packet, guint infolen=
);
> +void __ppp_set_auth(struct ppp_link *link, guint8 *auth_data);
> +void __ppp_set_recv_accm(struct ppp_link *link, guint32 accm);
> +guint32 __ppp_get_xmit_accm(struct ppp_link *link);
> +void __ppp_set_pfc(struct ppp_link *link, gboolean pfc);
> +gboolean __ppp_get_pfc(struct ppp_link *link);
> +void __ppp_set_acfc(struct ppp_link *link, gboolean acfc);
> +gboolean __ppp_get_acfc(struct ppp_link *link);
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __G_AT_PPP_INTERNAL_H */
> +
> Index: ofono/gatchat/gatppp.c
> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ ofono/gatchat/gatppp.c	2010-03-10 16:58:12.039961039 -0800
> @@ -0,0 +1,557 @@
> +/*
> + *
> + *  PPP library with GLib integration
> + *
> + *  Copyright (C) 2010  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1 =

>  USA + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <termios.h>
> +#include <arpa/inet.h>
> +
> +#include <glib.h>
> +
> +#include "gatppp.h"
> +#include "gatppp_internal.h"
> +
> +#define PPPINITFCS16    0xffff  /* Initial FCS value */
> +#define PPPGOODFCS16    0xf0b8  /* Good final FCS value */
> +
> +static GList *packet_handlers =3D NULL;
> +
> +void __ppp_register_packet_handler(struct ppp_packet_handler *handler)
> +{
> +	packet_handlers =3D g_list_append(packet_handlers, handler);
> +}
> +
> +/*
> + * FCS lookup table copied from rfc1662.
> + */
> +static guint16 fcstab[256] =3D {
> +	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
> +	0x8c48, 0x9dc1, 0xaf5a, 0xbed3, 0xca6c, 0xdbe5, 0xe97e, 0xf8f7,
> +	0x1081, 0x0108, 0x3393, 0x221a, 0x56a5, 0x472c, 0x75b7, 0x643e,
> +	0x9cc9, 0x8d40, 0xbfdb, 0xae52, 0xdaed, 0xcb64, 0xf9ff, 0xe876,
> +	0x2102, 0x308b, 0x0210, 0x1399, 0x6726, 0x76af, 0x4434, 0x55bd,
> +	0xad4a, 0xbcc3, 0x8e58, 0x9fd1, 0xeb6e, 0xfae7, 0xc87c, 0xd9f5,
> +	0x3183, 0x200a, 0x1291, 0x0318, 0x77a7, 0x662e, 0x54b5, 0x453c,
> +	0xbdcb, 0xac42, 0x9ed9, 0x8f50, 0xfbef, 0xea66, 0xd8fd, 0xc974,
> +	0x4204, 0x538d, 0x6116, 0x709f, 0x0420, 0x15a9, 0x2732, 0x36bb,
> +	0xce4c, 0xdfc5, 0xed5e, 0xfcd7, 0x8868, 0x99e1, 0xab7a, 0xbaf3,
> +	0x5285, 0x430c, 0x7197, 0x601e, 0x14a1, 0x0528, 0x37b3, 0x263a,
> +	0xdecd, 0xcf44, 0xfddf, 0xec56, 0x98e9, 0x8960, 0xbbfb, 0xaa72,
> +	0x6306, 0x728f, 0x4014, 0x519d, 0x2522, 0x34ab, 0x0630, 0x17b9,
> +	0xef4e, 0xfec7, 0xcc5c, 0xddd5, 0xa96a, 0xb8e3, 0x8a78, 0x9bf1,
> +	0x7387, 0x620e, 0x5095, 0x411c, 0x35a3, 0x242a, 0x16b1, 0x0738,
> +	0xffcf, 0xee46, 0xdcdd, 0xcd54, 0xb9eb, 0xa862, 0x9af9, 0x8b70,
> +	0x8408, 0x9581, 0xa71a, 0xb693, 0xc22c, 0xd3a5, 0xe13e, 0xf0b7,
> +	0x0840, 0x19c9, 0x2b52, 0x3adb, 0x4e64, 0x5fed, 0x6d76, 0x7cff,
> +	0x9489, 0x8500, 0xb79b, 0xa612, 0xd2ad, 0xc324, 0xf1bf, 0xe036,
> +	0x18c1, 0x0948, 0x3bd3, 0x2a5a, 0x5ee5, 0x4f6c, 0x7df7, 0x6c7e,
> +	0xa50a, 0xb483, 0x8618, 0x9791, 0xe32e, 0xf2a7, 0xc03c, 0xd1b5,
> +	0x2942, 0x38cb, 0x0a50, 0x1bd9, 0x6f66, 0x7eef, 0x4c74, 0x5dfd,
> +	0xb58b, 0xa402, 0x9699, 0x8710, 0xf3af, 0xe226, 0xd0bd, 0xc134,
> +	0x39c3, 0x284a, 0x1ad1, 0x0b58, 0x7fe7, 0x6e6e, 0x5cf5, 0x4d7c,
> +	0xc60c, 0xd785, 0xe51e, 0xf497, 0x8028, 0x91a1, 0xa33a, 0xb2b3,
> +	0x4a44, 0x5bcd, 0x6956, 0x78df, 0x0c60, 0x1de9, 0x2f72, 0x3efb,
> +	0xd68d, 0xc704, 0xf59f, 0xe416, 0x90a9, 0x8120, 0xb3bb, 0xa232,
> +	0x5ac5, 0x4b4c, 0x79d7, 0x685e, 0x1ce1, 0x0d68, 0x3ff3, 0x2e7a,
> +	0xe70e, 0xf687, 0xc41c, 0xd595, 0xa12a, 0xb0a3, 0x8238, 0x93b1,
> +	0x6b46, 0x7acf, 0x4854, 0x59dd, 0x2d62, 0x3ceb, 0x0e70, 0x1ff9,
> +	0xf78f, 0xe606, 0xd49d, 0xc514, 0xb1ab, 0xa022, 0x92b9, 0x8330,
> +	0x7bc7, 0x6a4e, 0x58d5, 0x495c, 0x3de3, 0x2c6a, 0x1ef1, 0x0f78
> +};
> +
> +/*
> + * Calculate a new fcs given the current fcs and the new data.
> + * copied from rfc1662
> + *
> + *     The FCS field is calculated over all bits of the Address, Control,
> + *     Protocol, Information and Padding fields, not including any start
> + *     and stop bits (asynchronous) nor any bits (synchronous) or octets
> + *     (asynchronous or synchronous) inserted for transparency.  This
> + *     also does not include the Flag Sequences nor the FCS field itself.
> + */
> +static guint16 ppp_fcs(guint16 fcs, guint8 c)
> +{
> +	guint16 new_fcs;
> +
> +	new_fcs =3D (fcs >> 8) ^ fcstab[(fcs ^ c) & 0xff];
> +	return new_fcs;
> +}
> +
> +/*
> + * escape any chars less than 0x20, and check the transmit accm table to
> + * see if this character should be escaped.
> + */
> +static gboolean ppp_escape(struct ppp_link *link, guint8 c, gboolean lcp)
> +{
> +	if ((lcp && c < 0x20) || (link->xmit_accm[c >> 5] & (1 << (c & 0x1f))))
> +		return TRUE;
> +	return FALSE;
> +}
> +
> +static void ppp_put(struct ppp_link *link, guint8 *buf, int *pos,
> +			guint8 c, gboolean lcp)
> +{
> +	int i =3D *pos;
> +
> +	/* escape characters if needed,  copy into buf, increment pos */
> +	if (ppp_escape(link, c, lcp)) {
> +		buf[i++] =3D PPP_ESC;
> +		buf[i++] =3D c ^ 0x20;
> +	} else
> +		buf[i++] =3D c;
> +	*pos =3D i;
> +}
> +
> +/* XXX implement PFC and ACFC */
> +static guint8 *ppp_encode(struct ppp_link *link, guint8 *data, int len,
> +				guint *newlen)
> +{
> +	guint8 *frame =3D g_malloc0(BUFFERSZ);
> +	int pos =3D 0;
> +	int i =3D 0;
> +	guint16 fcs =3D PPPINITFCS16;
> +	guint16 proto =3D ntohs(*(guint16 *)data);
> +	gboolean lcp =3D (proto =3D=3D LCP_PROTOCOL);
> +	if (!frame)
> +		return NULL;
> +
> +	/* copy in the HDLC framing */
> +	frame[pos++] =3D PPP_FLAG_SEQ;
> +
> +	/* from here till end flag, calculate FCS over each character */
> +	fcs =3D ppp_fcs(fcs, PPP_ADDR_FIELD);
> +	ppp_put(link, frame, &pos, PPP_ADDR_FIELD, lcp);
> +	fcs =3D ppp_fcs(fcs, PPP_CTRL);
> +	ppp_put(link, frame, &pos, PPP_CTRL, lcp);
> +
> +	/*
> +	 * for each byte, first calculate FCS, then do escaping if
> +	 * neccessary
> +	 */
> +	while (len--) {
> +		fcs =3D ppp_fcs(fcs, data[i]);
> +		ppp_put(link, frame, &pos, data[i++], lcp);
> +	}
> +
> +	/* add FCS */
> +	fcs ^=3D 0xffff;                 /* complement */
> +	ppp_put(link, frame, &pos, (guint8)(fcs & 0x00ff), lcp);
> +	ppp_put(link, frame, &pos, (guint8)((fcs >> 8) & 0x00ff), lcp);
> +
> +	/* add flag */
> +	frame[pos++] =3D PPP_FLAG_SEQ;
> +
> +	*newlen =3D pos;
> +	return frame;
> +}
> +
> +static gint is_proto_handler(struct ppp_packet_handler *h, gpointer user)
> +{
> +	guint16 proto =3D (guint16) GPOINTER_TO_UINT(user);
> +
> +	if (h->proto =3D=3D proto)
> +		return 0;
> +	else
> +		return -1;
> +}
> +
> +/* called when we have received a complete ppp frame */
> +static void ppp_recv(struct ppp_link *link)
> +{
> +	guint16 protocol;
> +	guint8 *frame, *packet;
> +	GList *list;
> +	struct ppp_packet_handler *h;
> +
> +	/* pop frames off of receive queue */
> +	while ((frame =3D g_queue_pop_head(link->recv_queue))) {
> +		protocol =3D ppp_proto(frame);
> +		packet =3D ppp_info(frame);
> +
> +		/*
> +		 * check to see if we have a protocol handler
> +		 * registered for this packet
> +		 */
> +		list =3D g_list_find_custom(packet_handlers,
> +				GUINT_TO_POINTER(protocol),
> +				(GCompareFunc) is_proto_handler);
> +		if (list) {
> +			h =3D list->data;
> +			h->handler(h->priv, packet);
> +		}
> +		g_free(frame);
> +	}
> +}
> +
> +/* XXX - Implement PFC and ACFC */
> +static guint8 * ppp_decode(struct ppp_link *link, guint8 *frame)
> +{
> +	guint8 *data;
> +	guint pos =3D 0;
> +	int i =3D 0;
> +	int len;
> +	guint16 fcs;
> +
> +	data =3D g_malloc0(link->mru + 10);
> +
> +	/* skip the first flag char */
> +	pos++;
> +
> +	/* TBD - how to deal with recv_accm */
> +	while (frame[pos] !=3D PPP_FLAG_SEQ) {
> +		/* scan for escape character */
> +		if (frame[pos] =3D=3D PPP_ESC) {
> +			/* skip that char */
> +			pos++;
> +			data[i] =3D frame[pos] ^ 0x20;
> +		} else
> +			data[i] =3D frame[pos];
> +		i++; pos++;
> +	}
> +
> +	len =3D i;
> +
> +	/* see if we have a good FCS */
> +	fcs =3D PPPINITFCS16;
> +	for (i =3D 0; i < len; i++)
> +		fcs =3D ppp_fcs(fcs, data[i]);
> +
> +	if (fcs !=3D PPPGOODFCS16) {
> +		g_free(data);
> +		return NULL;
> +	}
> +	return data;
> +}
> +
> +static void ppp_feed(struct ppp_link *link, guint8 *data, gsize len)
> +{
> +	guint pos =3D 0;
> +	guint8 *frame;
> +
> +	/* collect bytes until we detect we have received a complete frame */
> +	/* examine the data.  If we are at the beginning of a new frame,
> +	 * allocate memory to buffer the frame.
> +	 */
> +	for (pos =3D 0; pos < len; pos++) {
> +		if (data[pos] =3D=3D PPP_FLAG_SEQ) {
> +			if (link->buffer =3D=3D NULL) {
> +				link->buffer =3D g_malloc0(BUFFERSZ);
> +				link->index =3D 0;

So my question is why do we keep allocating / freeing this buffer.  Seems l=
ike =

a waste of time..?

> +			} else {
> +				/* store last flag character */
> +				link->buffer[link->index++] =3D data[pos];
> +				frame =3D ppp_decode(link, link->buffer);

This function along with ppp_decode do almost exactly the same thing as =

gsm0710_advanced_extract_frame in gsm0710.c.  They both do HDLC frame =

decoding, and the only difference I can see is in the fcs table.  Can we =

combine these somehow?

> +				/* push decoded frame onto receive queue */
> +				if (frame)
> +					g_queue_push_tail(link->recv_queue,
> +								frame);
> +
> +				/* free and reintialize buffer */
> +				g_free(link->buffer);
> +				link->buffer =3D NULL;
> +				link->index =3D 0;
> +				continue;
> +			}
> +		}
> +		/* copy byte to buffer */
> +		if (link->buffer)
> +			link->buffer[link->index++] =3D data[pos];

What concerns me here is that we don't check for buffer overflow here.

> +		else
> +			g_printerr("oops, no buffer, no start of frame\n");
> +
> +	}
> +	/* process receive queue */
> +	ppp_recv(link);
> +}
> +
> +/*
> + * transmit out through the lower layer interface
> + *
> + * infolen - length of the information part of the packet
> + */
> +void __ppp_transmit(struct ppp_link *link, guint8 *packet, guint infolen)
> +{
> +	guint8 *frame;
> +	guint framelen;
> +        GError *error =3D NULL;
> +        GIOStatus status;
> +        gsize bytes_written;
> +
> +	/*
> +	 * do the octet stuffing.  Add 2 bytes to the infolen to
> +	 * include the protocol field.
> +	 */
> +	frame =3D ppp_encode(link, packet, infolen+2, &framelen);
> +	if (!frame) {
> +		g_printerr("Failed to encode packet to transmit\n");
> +		return;
> +	}
> +
> +	/* transmit through the lower layer interface */
> +	/*
> +	 * TBD - should we just put this on a queue and transmit when
> +	 * we won't block, or allow ourselves to block here?
> +	 */
> +	status =3D g_io_channel_write_chars(link->modem, (gchar *) frame,
> +                                          framelen, &bytes_written,
>  &error); +
> +	g_free(frame);

You set the underlying IO channel to be non-blocking below.  Strictly speak=
ing =

what you have here will not work out, you cannot assume that the entire fra=
me =

will be written.

You will need to add some sort of tx_queue and start a G_IO_OUT channel wat=
ch =

to handle this properly.  However I'm fine fixing this later...

> +
> +}
> +
> +static gboolean ppp_cb(GIOChannel *channel, GIOCondition cond, gpointer
>  data) +{
> +	struct ppp_link *ppp =3D (struct ppp_link *) data;
> +	GIOStatus status;
> +	gchar buf[256];
> +	gsize bytes_read;
> +	GError *error =3D NULL;
> +
> +	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
> +		g_print("G_IO_NVAL | G_IO_ERR");
> +		return FALSE;
> +	}
> +
> +	if (cond & G_IO_IN) {
> +		status =3D g_io_channel_read_chars(channel, buf, 256,
> +				&bytes_read, &error);
> +		if (bytes_read > 0)
> +			ppp_feed(ppp, (guint8 *)buf, bytes_read);
> +        	if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_A=
GAIN)
> +                	return FALSE;
> +	}
> +
> +	return TRUE;
> +}
> +
> +/* Administrative Close */
> +static void ppp_close(struct ppp_link *link)
> +{
> +	/* send a CLOSE event to the lcp layer */
> +}
> +
> +/* Administrative Open */
> +void g_at_ppp_open(struct ppp_link *link)
> +{
> +	/* send an OPEN event to the lcp layer */
> +}
> +
> +static void ppp_link_establishment(struct ppp_link *link)
> +{
> +	/* signal UP event to LCP */
> +}
> +
> +static void ppp_terminate(struct ppp_link *link)
> +{
> +	/* signal DOWN event to LCP */
> +}
> +
> +static void ppp_authenticate(struct ppp_link *link)
> +{
> +	/* we don't do authentication right now, so send NONE */
> +	if (!link->auth_proto)
> +		ppp_generate_event(link, PPP_NONE);
> +	/* otherwise we need to wait for the peer to send us a challenge */
> +}
> +
> +static void ppp_dead(struct ppp_link *link)
> +{
> +	/* re-initialize everything */
> +}
> +
> +static void ppp_network(struct ppp_link *link)
> +{
> +	/* bring network phase up */
> +}
> +
> +static void ppp_transition_phase(struct ppp_link *link, guint phase)
> +{
> +	/* don't do anything if we're already there */
> +	if (link->phase =3D=3D phase)
> +		return;
> +
> +	/* set new phase */
> +	link->phase =3D phase;
> +
> +	switch(phase) {
> +	case ESTABLISHMENT:
> +		ppp_link_establishment(link);
> +		break;
> +	case AUTHENTICATION:
> +		ppp_authenticate(link);
> +		break;
> +	case TERMINATION:
> +		ppp_terminate(link);
> +		break;
> +	case DEAD:
> +		ppp_dead(link);
> +		break;
> +	case NETWORK:
> +		ppp_network(link);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +}
> +
> +static void ppp_handle_event(struct ppp_link *link)
> +{
> +	guint event;
> +
> +	while ((event =3D GPOINTER_TO_UINT(g_queue_pop_head(link->event_queue))=
)){
> +		switch(event) {
> +		case PPP_UP:
> +			/* causes transition to link establishment */
> +			ppp_transition_phase(link, ESTABLISHMENT);
> +			break;
> +		case PPP_OPENED:
> +			ppp_transition_phase(link, AUTHENTICATION);
> +			break;
> +		case PPP_CLOSING:
> +			/* causes transition to termination phase */
> +			ppp_transition_phase(link, TERMINATION);
> +			break;
> +		case PPP_DOWN:
> +			/* cases transition to dead phase */
> +			ppp_transition_phase(link, DEAD);
> +			break;
> +		case PPP_NONE:
> +		case PPP_SUCCESS:
> +			/* causes transition to network phase */
> +			ppp_transition_phase(link, NETWORK);
> +			break;
> +		}
> +	}
> +}
> +
> +/*
> + * send the event handler a new event to process
> + */
> +void __ppp_generate_event(struct ppp_link *link, guint event)
> +{
> +	g_queue_push_tail(link->event_queue, GUINT_TO_POINTER(event));
> +	ppp_handle_event(link);
> +}
> +
> +void g_at_ppp_set_connect_function(struct ppp_link *link,
> +			       GAtPPPConnectFunc callback, gpointer user_data)
> +{
> +	link->connect_cb =3D callback;
> +	link->connect_priv =3D user_data;
> +}
> +
> +void g_at_ppp_set_disconnect_function(struct ppp_link *link,
> +				  GAtPPPDisconnectFunc callback,
> +				  gpointer user_data)
> +{
> +	link->disconnect_cb =3D callback;
> +	link->disconnect_priv =3D user_data;
> +}
> +
> +void g_at_ppp_shutdown(struct ppp_link *link)
> +{
> +	/* close the link */
> +	ppp_close(link);
> +
> +	/* clean up all the queues */
> +	g_queue_free(link->event_queue);
> +	g_queue_free(link->recv_queue);
> +
> +	/* cleanup modem channel */
> +	g_source_remove(link->modem_watch);
> +	g_io_channel_unref(link->modem);
> +}
> +
> +void g_at_ppp_ref(struct ppp_link *link)
> +{
> +	g_atomic_int_inc(&link->ref_count);
> +}
> +
> +void g_at_ppp_unref(struct ppp_link *link)
> +{
> +	gboolean last;
> +
> +	last =3D g_atomic_int_dec_and_test(&link->ref_count);
> +	if (last) {
> +		g_at_ppp_shutdown(link);
> +		g_free(link);
> +	}
> +}
> +
> +struct ppp_link * g_at_ppp_new(GIOChannel *modem)
> +{
> +	struct ppp_link *link;
> +	GIOFlags flags;
> +	int signal_source;
> +
> +	link =3D g_malloc0(sizeof(struct ppp_link));

I suggest using g_try_new0 instead of g_malloc0

> +	if (!link)
> +		return NULL;
> +
> +	link->ref_count =3D 1;
> +
> +	/* set options to defaults */
> +	link->mru =3D DEFAULT_MRU;
> +	link->recv_accm =3D DEFAULT_ACCM;
> +	link->xmit_accm[0] =3D DEFAULT_ACCM;
> +	link->xmit_accm[3] =3D 0x60000000; /* 0x7d, 0x7e */
> +	link->pfc =3D FALSE;
> +	link->acfc =3D FALSE;
> +
> +	/* allocate the queues */
> +	link->event_queue =3D g_queue_new();
> +	link->recv_queue =3D g_queue_new();
> +
> +	link->buffer =3D NULL;
> +	link->index =3D 0;
> +
> +	/* setup the watch functions for the modem */
> +	link->modem =3D g_io_channel_ref(modem);
> +
> +	flags =3D g_io_channel_get_flags(modem) | G_IO_FLAG_NONBLOCK;
> +	g_io_channel_set_flags(modem, flags, NULL);
> +
> +	g_io_channel_set_encoding(modem, NULL, NULL);
> +	g_io_channel_set_buffered(modem, FALSE);

g_at_util_setup_io does the above four operations for you.  Might be a good =

idea to use that instead.

> +
> +	/* initialize the lcp state */
> +
> +
> +	/* initialize the autentication state */
> +
> +
> +	/* intialize the network state */
> +
> +	/* start listening for packets from the modem */
> +	signal_source =3D g_io_add_watch(modem,
> +			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +			ppp_cb, link);
> +	link->modem_watch =3D signal_source;

Shouldn't we assign this directly and avoid the signal_source variable =

altogether?

> +
> +	return link;
> +}
> Index: ofono/gatchat/gatppp.h
> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ ofono/gatchat/gatppp.h	2010-03-10 16:58:12.040979395 -0800
> @@ -0,0 +1,81 @@
> +/*
> + *
> + *  PPP library with GLib integration
> + *
> + *  Copyright (C) 2010  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1 =

>  USA + *
> + */
> +
> +#ifndef __G_AT_PPP_H
> +#define __G_AT_PPP_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +struct ppp_link;

For consistency this should be typedefed to GAtPpp, similar to how GAtChat =
is =

typedefed.

> +
> +enum PPP_CONNECT_STATUS {
> +	PPP_CONNECT_SUCCESS,
> +	PPP_CONNECT_FAIL
> +};
> +

The enum names should be prefixed by G_AT.  e.g. G_AT_PPP_RESULT_OK, =

G_AT_PPP_RESULT_UNSPECIFIED_ERROR, G_AT_PPP_RESULT_AUTH_ERROR, etc.  Keep t=
he =

enum definition itself camel-case, e.g. enum _GAtPppResult, typedef to =

GAtPppResult

> +typedef void (*GAtPPPConnectFunc)(struct ppp_link *link, gint success,
> +				 guint32 ip_address,
> +				 guint32 dns1, guint32 dns2,
> +				 gpointer user_data);
> =


I suggest that the gint success be changed to use the enum defined above.

> +
> +typedef void (*GAtPPPDisconnectFunc)(struct ppp_link *link, gpointer
>  user_data); +
> +struct ppp_link {
> +	gint ref_count;
> +	guint phase;

I suggest you use the enum directly here instead of the guint.

> +	guint8 *buffer;
> +	int index;
> +	gint mru;
> +	guint16 auth_proto;
> +	char user_name[256];
> +	char passwd[256];
> +	gboolean pfc;
> +	gboolean acfc;
> +	guint32 xmit_accm[8];
> +	guint32 recv_accm;
> +	GIOChannel *modem;
> +	GQueue *event_queue;
> +	GQueue *recv_queue;
> +	GAtPPPConnectFunc connect_cb;
> +	gpointer connect_priv;

The suffix 'data' is preferred over 'priv'

> +	GAtPPPDisconnectFunc disconnect_cb;
> +	gpointer disconnect_priv;

As above

> +	gint modem_watch;
> +};
> +

If possible, I would suggest that you hide the struct implementation in the=
 .c =

file instead of exposing it here.

> +struct ppp_link * g_at_ppp_new(GIOChannel *modem);
> +void g_at_ppp_open(struct ppp_link *link);
> +void g_at_ppp_set_connect_function(struct ppp_link *link,
> +			       GAtPPPConnectFunc callback, gpointer user_data);
> +void g_at_ppp_set_disconnect_function(struct ppp_link *link,
> +				  GAtPPPDisconnectFunc callback,
> +				  gpointer user_data);
> +void g_at_ppp_shutdown(struct ppp_link *link);
> +void g_at_ppp_ref(struct ppp_link *link);
> +void g_at_ppp_unref(struct ppp_link *link);
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __G_AT_PPP_H */
> +
> =


Regards,
-Denis

--===============6581907241637706196==--

