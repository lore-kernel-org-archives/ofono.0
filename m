Content-Type: multipart/mixed; boundary="===============8018480882604989906=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 1/6] Add PPP protocol support with HDLC framing
Date: Tue, 16 Mar 2010 23:28:44 -0700
Message-ID: <1268807324.2700.70.camel@localhost.localdomain>
In-Reply-To: <20100316171303.1553b444@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8018480882604989906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> This patch implements the basic PPP protocol.  LCP, NCP etc. are handled =
in a
> different patch.
> =

> ---
>  Makefile.am               |    4 =

>  gatchat/gatppp.c          |  552 +++++++++++++++++++++++++++++++++++++++=
+++++++
>  gatchat/gatppp.h          |   59 ++++
>  gatchat/gatppp_internal.h |   97 ++++++++
>  4 files changed, 711 insertions(+), 1 deletion(-)

so before we merge this patch and then continue development in the oFono
tree, we have some renaming to do.

Denis and I talked about it on IRC. And what we actually want is
something like this:

	gatchat/gatppp.h	Public include file
	gatchat/gatppp.c	Implementation of PPP API
	gatchat/ppp.h		Internal header file
	gatchat/ppp.c		Generic PPP stuff (maybe not needed)
	gatchat/ppp_<proto>.c	Protocol specific extensions

This makes it similar to what we do with gsm7010.[ch] and
ringbuffer.[ch]. So this means for internal structures and functions the
prefix should be ppp_*. Similar to what we do with GSM 70.10 and the
ring buffer implementation.

We might have mislead you with parts of the previous review. I apologize
for that. The more we are looking at your patches it becomes clearer
which direction we wanna take.

> +
> +typedef enum _GAtPPPPhase {
> +	DEAD =3D 0,
> +	ESTABLISHMENT,
> +	AUTHENTICATION,
> +	NETWORK,
> +	TERMINATION,
> +} GAtPPPPhase;
> +
> +typedef enum _GAtPPPEvents {
> +	PPP_UP =3D 1,
> +	PPP_OPENED,
> +	PPP_SUCCESS,
> +	PPP_NONE,
> +	PPP_CLOSING,
> +	PPP_FAIL,
> +	PPP_DOWN
> +} GAtPPPEvents;

If we don't expose them in public headers, then typedefs are not needed.
We actually dislike typedefs. The only reason for having them in public
GAtChat headers is to confirm with GLib style.

> +struct ppp_packet_handler {
> +	guint16 proto;
> +	void (*handler)(gpointer priv, guint8 *packet);
> +	gpointer priv;
> +};
> +
> +#define ppp_info(packet) \
> +	(packet+4)
> +
> +#define ppp_proto(packet) \
> +	(ntohs(*((guint16*)(packet+2))))

Arithmetic operations requires spaces. Even in defines. So it packet + 4
etc.

When you cast don't forget whitepaces. So (guint16 *) (packet...

> +struct _GAtPPP {
> +	gint ref_count;
> +	GAtPPPPhase phase;
> +	guint8 buffer[BUFFERSZ];
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
> +	gpointer connect_data;
> +	GAtPPPDisconnectFunc disconnect_cb;
> +	gpointer disconnect_data;
> +	gint modem_watch;
> +};
> +
> +void __ppp_generate_event(GAtPPP *ppp, GAtPPPEvents event);
> +void __ppp_register_packet_handler(struct ppp_packet_handler *handler);
> +void __ppp_transmit(GAtPPP *ppp, guint8 *packet, guint infolen);
> +void __ppp_set_auth(GAtPPP *ppp, guint8 *auth_data);
> +void __ppp_set_recv_accm(GAtPPP *ppp, guint32 accm);
> +guint32 __ppp_get_xmit_accm(GAtPPP *ppp);
> +void __ppp_set_pfc(GAtPPP *ppp, gboolean pfc);
> +gboolean __ppp_get_pfc(GAtPPP *ppp);
> +void __ppp_set_acfc(GAtPPP *ppp, gboolean acfc);
> +gboolean __ppp_get_acfc(GAtPPP *ppp);

Just use ppp_* here and forget about __ppp_*. I will add autofoo magic
to ensure we are not accidentally exporting these. It is not your
concern.

> + *  PPP library with GLib integration
> + *
> + *  Copyright (C) 2010  Intel Corporation. All rights reserved.

Nitpick here. Copyright is 2009-2010. Applies to all new files you are
adding.

> +	/*
> +	 * do the octet stuffing.  Add 2 bytes to the infolen to
> +	 * include the protocol field.
> +	 */
> +	frame =3D ppp_encode(ppp, packet, infolen+2, &framelen);
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
> +	status =3D g_io_channel_write_chars(ppp->modem, (gchar *) frame,
> +                                          framelen, &bytes_written, &err=
or);
> +
> +	g_free(frame);
> +
> +}

Look out for unneeded empty lines at the end of functions. We don't want
them.

> +static void ppp_transition_phase(GAtPPP *ppp, guint phase)
> +{
> +	/* don't do anything if we're already there */
> +	if (ppp->phase =3D=3D phase)
> +		return;
> +
> +	/* set new phase */
> +	ppp->phase =3D phase;
> +
> +	switch(phase) {
> +	case ESTABLISHMENT:
> +		ppp_ppp_establishment(ppp);
> +		break;
> +	case AUTHENTICATION:
> +		ppp_authenticate(ppp);
> +		break;
> +	case TERMINATION:
> +		ppp_terminate(ppp);
> +		break;
> +	case DEAD:
> +		ppp_dead(ppp);
> +		break;
> +	case NETWORK:
> +		ppp_network(ppp);
> +		break;
> +	default:
> +		break;
> +	}

Since this is an enum anyway. Please skip the default statement and just
ensure you handle all states. For the ones that don't apply, add just
empty statements.

That way the compiler will warn you if you add a new state to the enum
later on. And you accidentally forget to add code for handling that
state.

And I do prefer having a prefix here. So PPP_DEAD, PPP_NETWORK etc.

> +void g_at_ppp_unref(GAtPPP *ppp)
> +{
> +	gboolean last;
> +
> +	last =3D g_atomic_int_dec_and_test(&ppp->ref_count);
> +	if (last) {
> +		g_at_ppp_shutdown(ppp);
> +		g_free(ppp);
> +	}
> +}

Not using the last variable here is better. You really want this to be
atomic. Just check the return value of the function directly.

> +	/* think I still need to do this */
> +	g_io_channel_set_buffered(modem, FALSE);

I have sounds really picky now ;)

Comment should be either with FIXME if it is something that is unclear.
Or better at least in third person.

> +	ppp->ref_count =3D 1;
> +
> +	/* set options to defaults */
> +	ppp->mru =3D DEFAULT_MRU;
> +	ppp->recv_accm =3D DEFAULT_ACCM;
> +	ppp->xmit_accm[0] =3D DEFAULT_ACCM;
> +	ppp->xmit_accm[3] =3D 0x60000000; /* 0x7d, 0x7e */
> +	ppp->pfc =3D FALSE;
> +	ppp->acfc =3D FALSE;
> +
> +	/* allocate the queues */
> +	ppp->event_queue =3D g_queue_new();
> +	ppp->recv_queue =3D g_queue_new();
> +
> +	ppp->index =3D 0;
> +
> +	/* initialize the lcp state */
> +
> +
> +	/* initialize the autentication state */
> +
> +
> +	/* intialize the network state */

I know that your other patches are going to add this code later one.
However having these prefixed with FIXME would be better. Not that it is
a big thing if we see the patch series as a whole, but would be better
for future things like this.

Regards

Marcel



--===============8018480882604989906==--

