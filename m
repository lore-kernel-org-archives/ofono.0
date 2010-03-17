Content-Type: multipart/mixed; boundary="===============6509797667877989451=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 5/6] IP support for PPP
Date: Tue, 16 Mar 2010 23:38:33 -0700
Message-ID: <1268807913.2700.80.camel@localhost.localdomain>
In-Reply-To: <20100316171324.75e1155d@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6509797667877989451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> Signed-off-by:  Kristen Carlson Accardi <kristen@linux.intel.com>

we don't do signed-off-by statements inside oFono. So please skip these
and fix your .gitconfig.

> Implement IPCP support.  Creates a tun interface to pass IP traffic.

Also even if we would be doing signed-off-by statements, you messed them
up and have it in the wrong order ;)

> =

> ---
>  Makefile.am               |    2 =

>  gatchat/gatppp.c          |    2 =

>  gatchat/gatppp_internal.h |   12 +
>  gatchat/gatpppnet.c       |  369 +++++++++++++++++++++++++++++++++++++++=
+++++++
>  4 files changed, 384 insertions(+), 1 deletion(-)

Use gatchat/ppp_net.c here.

> +struct net_data {
> +	GAtPPP *ppp;
> +	char *if_name;
> +	GIOChannel *channel;
> +	struct pppcp_data *ipcp;
> +};
> +

I would prefer if you use struct ppp_net.

> +struct net_data *net_new(GAtPPP *ppp);
> +void net_open(struct net_data *data);
> +void net_free(struct net_data *data);
> +void net_close(struct net_data *data);

These are better ppp_net_new() etc.

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ ofono/gatchat/gatpppnet.c	2010-03-16 16:22:10.237864764 -0700
> @@ -0,0 +1,369 @@
> +/*
> + *
> + *  AT chat library with GLib integration
> + *
> + *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.

Now I have to be picky with the copyright headers. Please make sure they
are in sync.

> +/****** IPCP support ****************/
> +enum {
> +	/* supported codes */
> +	IPCP_SUPPORTED_CODES	=3D (1 << CONFIGURE_REQUEST) |
> +				  (1 << CONFIGURE_ACK) |
> +				  (1 << CONFIGURE_NAK) |
> +				  (1 << CONFIGURE_REJECT) |
> +				  (1 << TERMINATE_REQUEST) |
> +				  (1 << TERMINATE_ACK) |
> +				  (1 << CODE_REJECT),
> +
> +	IPCP_PROTO		=3D 0x8021,
> +
> +	/* option types */
> +	IP_ADDRESSES		=3D 1,
> +	IP_COMPRESSION_PROTO	=3D 2,
> +	IP_ADDRESS		=3D 3,
> +	PRIMARY_DNS_SERVER	=3D 129,
> +	SECONDARY_DNS_SERVER	=3D 131,
> +};

As mentioned before. If you wanna keep enums, please split them into
multiple with comments in front of them. It should be clear that they
represent different things.

> +static guint32 bytes_to_32(guint8 *bytes)
> +{
> +	union addr {
> +		guint8 bytes[4];
> +		guint32 word;
> +	} a;
> +
> +	memcpy(a.bytes, bytes, 4);
> +	return(ntohl(a.word));
> +}

This works, but is pretty ugly.

Doesn't GLib has functions to ensure retrieve unaligned data? BlueZ has
the GCC magic that is required to do this right.

Regards

Marcel



--===============6509797667877989451==--

