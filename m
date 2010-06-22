Content-Type: multipart/mixed; boundary="===============4522050917683776427=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/11] gatppp: Add PPP server extension
Date: Mon, 21 Jun 2010 23:26:34 -0500
Message-ID: <201006212326.35035.denkenz@gmail.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B351F543DFF@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4522050917683776427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> >> +void ipcp_set_server_info(struct pppcp_data *pppcp, guint32
> >> local_addr, +				guint32 peer_addr, +				guint32 dns1, guint32 dns2,
> >> +				guint32 nbns1, guint32 nbns2)
> >> +{
> >> +	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
> >> +
> >> +	ipcp->req_options =3D REQ_OPTION_IPADDR | REQ_OPTION_DNS1 |
> >> +				REQ_OPTION_DNS2 | REQ_OPTION_NBNS1 |
> >> +				REQ_OPTION_NBNS2;
> >> +
> >> +	ipcp->local_addr =3D local_addr;
> >> +	ipcp->peer_addr =3D peer_addr;
> >> +	ipcp->dns1 =3D dns1;
> >> +	ipcp->dns2 =3D dns2;
> >> +	ipcp->nbns1 =3D nbns1;
> >> +	ipcp->nbns2 =3D nbns2;
> >> +
> >> +	ipcp_generate_config_options(ipcp);
> >
> > Please note that this function is currently having no effect,
> > you're missing a
> > call to pppcp_set_local_options.  However, in the case of a server, we
> > actually do not want to request DNS or NBNS, and we should
> > only send our local
> > address to the peer if it is non-zero.  Please note that all
> > PPP modems we
> > have encountered so far, do not send their local IP address in
> > a Configure-
> > Request.  Thus calling ipcp_set_server_info should end up
> > generating an empty
> > Configure-Request or with only the local IP address present.
> =

> It's confused me a little. Please correct me if I am wrong. I think PPP
>  modem should send their local IP address to peer in a Configure-Request.
>  So client could accept the peer address in ipcp_rcr.

This is correct if the PPP server wants to do so, it is perfectly OK for th=
e =

server not to send its IP address (e.g. if it doesn't have one.)  This is w=
hat =

we observe on most PPP modems.

> =

> In the case of a server, ipcp_set_server_info() should set local, peer, D=
NS
>  and NBNS info and call pppcp_set_local_options(). And server only send o=
ur
>  local address to peer in a Configure-Request.

I'd modify this slightly.  If ipcp_set_server_info is called with server's =

local address as 0, then don't even send IP-Address in a configure Request.=
  =

This wouldn't make sense, in effect the server is asking the client to prov=
ide =

its IP address. Otherwise, go ahead and send it (as the client will simply =

ack).

> =

> >> +}
> >> +
> >>  static void ipcp_reset_config_options(struct ipcp_data *ipcp)  {
> >>  	ipcp->req_options =3D REQ_OPTION_IPADDR | REQ_OPTION_DNS1 |
> >>  				REQ_OPTION_DNS2 | REQ_OPTION_NBNS1 |
> >>  				REQ_OPTION_NBNS2;
> >> -	ipcp->ipaddr =3D 0;
> >> +	ipcp->local_addr =3D 0;
> >
> > In the case of a server, the local_address should not be reset.
> =

> It seems we need to add a flag in ipcp_data to indicate whether it's serv=
er
>  or not. Does it make sense?

Might be a good idea.

Regards,
-Denis

--===============4522050917683776427==--

