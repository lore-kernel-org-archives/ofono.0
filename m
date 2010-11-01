Content-Type: multipart/mixed; boundary="===============5821023941090830663=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] stemodem: Add RTNL functionality for CAIF Netw
 Interface.
Date: Mon, 01 Nov 2010 17:59:22 +0100
Message-ID: <1288630762.3322.120.camel@aeonflux>
In-Reply-To: <1288274641-4216-2-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5821023941090830663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Add file rtnl.c for creating and deleting CAIF network
> interfaces using the RTNL protocol. The interface is
> asynchronous.
> =

> Only RTNL NEWLINK and DELLINK commands are implemented.
> CAIF requires NEWLINK to contain channel-id and ip-type
> (ipv4/ipv6) as arguments.
> =

> ---
>  drivers/stemodem/rtnl.c |  365 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 365 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/stemodem/rtnl.c

I have no problems with the file names. It does make sense to keep them
simple. However if this is CAIF related, then using caif_rtnl.[ch] might
be a good idea.

And you can combine the patches for the header file, for the actual code
and the Makefile.am into one. That is fine.

<snip>

And I have not looked through the whole patch yet.

> +int rtnl_init(void)
> +{
> +	struct sockaddr_nl addr;
> +	int sk, ret;
> +
> +	sk =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
> +	if (sk < 0)
> +		return sk;
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.nl_family =3D AF_NETLINK;
> +	addr.nl_groups =3D RTMGRP_LINK | RTMGRP_IPV4_IFADDR | RTMGRP_IPV4_ROUTE;
> +
> +	ret =3D bind(sk, (struct sockaddr *) &addr, sizeof(addr));
> +	if (ret < 0) {
> +		close(sk);
> +		return ret;
> +	}
> +
> +	channel =3D g_io_channel_unix_new(sk);
> +	g_io_channel_set_close_on_unref(channel, TRUE);
> +	rtnl_watch =3D g_io_add_watch(channel,
> +				G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
> +				netlink_event, NULL);
> +
> +	return 0;
> +}
> +
> +void rtnl_exit(void)
> +{
> +	GSList *list;
> +
> +	if (rtnl_watch > 0)
> +		g_source_remove(rtnl_watch);
> +
> +	for (list =3D pending_requests; list; list =3D list->next) {
> +		struct iplink_req *req =3D list->data;
> +		g_free(req);
> +		list->data =3D NULL;
> +	}
> +
> +	g_slist_free(pending_requests);
> +	pending_requests =3D NULL;
> +
> +	g_io_channel_shutdown(channel, TRUE, NULL);
> +	g_io_channel_unref(channel);
> +
> +	channel =3D NULL;
> +}

Using global function names like rtnl_init and rtnl_exit is not gonna
cut it. This code is CAIF specific and you need at least prefix the
public functions properly.

I am not sure what is best here. Use caif_rtnl_ or ste_rtnl_ or maybe
just skip the keyword rtnl and just prefix it with caif_ only.

Regards

Marcel



--===============5821023941090830663==--

