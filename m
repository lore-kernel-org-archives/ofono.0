Content-Type: multipart/mixed; boundary="===============1022232364205636027=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 2/6] Generic PPP control protocol
Date: Wed, 17 Mar 2010 00:06:34 -0700
Message-ID: <1268809594.2700.101.camel@localhost.localdomain>
In-Reply-To: <20100316171311.6c9fef14@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1022232364205636027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

>  Makefile.am               |    3 =

>  gatchat/gatppp_internal.h |    2 =

>  gatchat/gatpppcp.c        | 1509 +++++++++++++++++++++++++++++++++++++++=
+++++++
>  gatchat/gatpppcp.h        |  133 ++++
>  4 files changed, 1646 insertions(+), 1 deletion(-)

please call them gatchat/ppp_cp.[ch].

> +static gboolean pppcp_timeout(gpointer user);
> +static void pppcp_handle_event(gpointer user);
> +static gint is_option(struct ppp_option *o, gpointer user);

In general we dislike forward declarations and only allow them if the
are really really needed. Are they?

> +const char *pppcp_state_strings[] =3D
> +	{"INITIAL", "STARTING", "CLOSED", "STOPPED", "CLOSING", "STOPPING",
> +	"REQSENT", "ACKRCVD", "ACKSENT", "OPENED" };
> +
> +#ifdef DEBUG
> +#define pppcp_trace(p) \
> +	(g_print("%s: current state %d:%s\n", __FUNCTION__, \
> +		p->state, pppcp_state_strings[p->state]))
> +#else
> +#define pppcp_trace(p)
> +#endif

Should the pppcp_state_strings variable be inside the ifdef DEBUG?

> +enum {
> +	INITIAL_RESTART_TIMEOUT	=3D 3000,
> +	MAX_TERMINATE		=3D 2,
> +	MAX_CONFIGURE		=3D 10,
> +	MAX_FAILURE		=3D 5,
> +	CP_HEADER_SZ		=3D 4,
> +
> +	/* states */
> +	INITIAL =3D 0,
> +	STARTING	=3D 1,
> +	CLOSED		=3D 2,
> +	STOPPED		=3D 3,
> +	CLOSING		=3D 4,
> +	STOPPING	=3D 5,
> +	REQSENT		=3D 6,
> +	ACKRCVD		=3D 7,
> +	ACKSENT		=3D 8,
> +	OPENED		=3D 9,
> +};

Please make it two enums with separate comments what they are. For the
top ones I would prefer defines actually.

> +static struct pppcp_packet * pppcp_packet_new(struct pppcp_data *data,
> +						guint type, guint bufferlen)
> +{

This is pppcp_packet *pppcp_packet_new() actually. Same as with
variables. No difference here.

> +	struct pppcp_header *packet;
> +	guint8 *ppp_packet;
> +
> +	ppp_packet =3D g_try_malloc0(bufferlen + sizeof(*packet) + 2);
> +	if (!ppp_packet)
> +		return NULL;
> +
> +	/* add our protocol information */
> +	*((guint16 *)ppp_packet) =3D htons(data->proto);

You can not do this. It will break on non-x86 platforms where unaligned
access needs special handling.

> +	/* advance past protocol to add CP header information */
> +	packet =3D (struct pppcp_header *) (ppp_packet + 2);
> +
> +	packet->length =3D htons((guint16)(bufferlen + sizeof(*packet)));
> +	packet->code =3D type;
> +	return ((struct pppcp_packet *)packet);
> +}

At little bit too much nasty casting for my taste.

Also if you cast don't forget the extra whitespace. It is *) packet.

> +static gboolean pppcp_timeout(gpointer user)
> +{
> +	struct pppcp_data *data =3D user;

It is better to use user_data as variable name here. User is pretty much
confusing. It applies to other locations as well.

> +	event =3D g_malloc(sizeof(struct pppcp_event) + len);
> +	if (!event)
> +		return NULL;

Seems you meant g_try_malloc here.

> +/* what about locking, do we need to worry about that here */

As long as we are single-thread and mainloop driven, we don't have to
worry here.

> +static void pppcp_transition_state(int new_state, struct pppcp_data *dat=
a)
> +{
> +	/*
> +	 * if switching from a state where
> +	 * TO events occur, to one where they
> +	 * may not, shut off the timer
> +	 */
> +	switch(new_state) {

It is switch (new_state) btw.

> +	case INITIAL:
> +	case STARTING:
> +	case CLOSED:
> +	case STOPPED:
> +	case OPENED:
> +		/* if timer is running, stop it */
> +		if (pppcp_timer_is_running(data))
> +			pppcp_stop_timer(data);
> +		break;
> +	default:
> +		break;
> +		/* do nothing */
> +	}

Please don't use the default statement. See my explanation in the other
email why we don't want it. Let the compiler be a safe-guard.

> +static void pppcp_up_event(struct pppcp_data *data, guint8 *packet, guin=
t len)
> +{
> +	pppcp_trace(data);
> +	switch(data->state) {
> +	case INITIAL:
> +		/* switch state to CLOSED */
> +		pppcp_transition_state(CLOSED, data);
> +		break;
> +	case STARTING:
> +		/* irc, scr/6 */
> +		pppcp_initialize_restart_count(data, data->max_configure);
> +		pppcp_send_configure_request(data);
> +		pppcp_transition_state(REQSENT, data);
> +		break;
> +	default:
> +		/* all other are illegal */
> +		pppcp_illegal_event(data->state, UP);

Same here. Please spell the illegal ones out. I know it looks like more
work, but it is important to make it explicit. Please check all of
these.

> +	}
> +
> +}

Remove the extra empty line before the function end.

> +static void verify_config_option(gpointer elem, gpointer user)
> +{
> +	struct ppp_option *config =3D elem;
> +	struct pppcp_data *data =3D user;
> +	GList *list =3D NULL;
> +	struct ppp_option *option;
> +
> +	/*
> +	 * determine whether this config option is in the
> +	 * acceptable options list
> +	 */
> +	if (g_list_length(data->acceptable_options))
> +		list =3D g_list_find_custom(data->acceptable_options,
> +				GUINT_TO_POINTER(config->type),
> +				(GCompareFunc) is_option);

Don't do this GCompareFunc casting. It is a dead-trap. Please use create
is_option with proper parameters and assign the void pointers inside the
callback to right types.

We have seen way too many mistakes with wrong function prototypes that
changed over time. Not casting makes the compiler warn us at least if we
screwed up.

> +static void remove_config_option(gpointer elem, gpointer user)
> +{
> +	struct ppp_option *config =3D elem;
> +	struct pppcp_data *data =3D user;
> +	GList *list =3D NULL;
> +
> +	/*
> +	 * determine whether this config option is in the
> +	 * applied options list
> +	 */
> +	if (g_list_length(data->config_options)) {
> +		list =3D g_list_find_custom(data->config_options,
> +				GUINT_TO_POINTER(config->type),
> +				(GCompareFunc) is_option);
> +		if (list)
> +			data->config_options =3D
> +				g_list_delete_link(data->config_options, list);
> +	}
> +}

Why us list =3D NULL assigned? I don't see the need for it. If it is not
needed, then please don't do it.

> +	/* make sure all required config options were included */
> +	g_list_foreach(data->config_options, verify_config_option, data);
> +
> +	if (g_list_length(data->unacceptable_options) ||
> +		g_list_length(data->rejected_options))
> +		return RCR_MINUS;

You need a double indentation for the second g_list_length() here.
Otherwise it might look like code that suppose to be part of the block
that gets executed. What out for these. While the compiler understands
them, the human brain might get puzzled.

> +#ifndef __PPPCP_H
> +#define __PPPCP_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +

Both are not needed.

> +struct pppcp_data;

Why is this needed?

> +
> +/* PPPCP CODE FIELD */
> +enum PPPCP_CODE {
> +	CONFIGURE_REQUEST =3D 1,
> +	CONFIGURE_ACK,
> +	CONFIGURE_NAK,
> +	CONFIGURE_REJECT,
> +	TERMINATE_REQUEST,
> +	TERMINATE_ACK,
> +	CODE_REJECT,
> +	PROTOCOL_REJECT,
> +	ECHO_REQUEST,
> +	ECHO_REPLY,
> +	DISCARD_REQUEST
> +};

The comment is not really adding any value here. Make it more
descriptive or just leave it out.

Regards

Marcel



--===============1022232364205636027==--

