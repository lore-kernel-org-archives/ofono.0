Content-Type: multipart/mixed; boundary="===============6545199872113512391=="
MIME-Version: 1.0
From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [PATCHv2 1/2] stemodem: Add RTNL functionality managing CAIF
 Network Interfaces.
Date: Mon, 01 Nov 2010 23:42:29 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C105791945A4F406@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <1288645454.3322.137.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6545199872113512391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> From: Marcel Holtmann [mailto:marcel(a)holtmann.org]
> =

> just to be clear. You want to name it like this? I am just asking here
> since I made a few proposals.

No worries :-)
The file is called caif_rtnl and exported functions are prefixed caif_rtnl,
I think that makes a lot of sense.

> =

> > +#define NLMSG_TAIL(nmsg) \
> > +	((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)-
> >nlmsg_len)))
> =

> We don't have this one as part of some kernel includes?

I'll check what I can find ;-)

> =

> > +static gboolean get_ifname(struct ifinfomsg *msg, int bytes,
> > +				const char **ifname)
> > +{
> > +	struct rtattr *attr;
> > +
> > +	for (attr =3D IFLA_RTA(msg); RTA_OK(attr, bytes);
> > +			attr =3D RTA_NEXT(attr, bytes))
> > +
> > +		if (attr->rta_type =3D=3D IFLA_IFNAME &&
> > +				ifname !=3D NULL) {
> > +			*ifname =3D RTA_DATA(attr);
> > +			return TRUE;
> > +		}
> > +
> > +	return FALSE;
> > +}
> =

> After I stared long enough at it, I realized that the code is fine, but
> that was not obvious to me. In this case please use for () { } with the
> curly braces around it. It improves readability.
> =

> And I know that other times we don't do { } for single statements, but
> here is does helps my poor human brain ;)

Sure I'll add the braces ;-)

> You don't really have to play this append/remove game. You can just
> append it after send_rtnl_req succeed. The read goes via the mainloop
> anyway and we are a single threaded program. So the order is
> guaranteed.

I'm not sure about this. I need to keep track of what
connection-id I assign to the CAIF Interface in the request and what =

interface name and interface index I get for that connection id
in the RTNL response.
This mapping between network interface and connection id is used =

when PDP Contexts are activated. The append/remove game provides me
with the request-response mapping. =



> And here you should add an extra empty line.

Sorry, I don't know why I keep doing that...

> > +struct rtnl_rsp_param {
> > +	int result;
> > +	gpointer user_data;
> > +	char ifname[IF_NAMESIZE];
> > +	int  ifindex;
> > +};
> > +
> > +struct rtnl_req_param {
> > +	void (*callback)(struct rtnl_rsp_param *param);
> > +	gpointer user_data;
> > +	int type;
> > +	int conn_id;
> > +	gboolean loop_enabled;
> > +};
> > +
> > +extern int caif_rtnl_create_interface(struct rtnl_req_param *req);
> > +extern int caif_rtnl_delete_interface(int ifid);
> =

> I am not really sold on this param stuct thingy btw. Why do you need
> them? Just proper input params and output params for the callback
> handler would do them same. Won't they?

Yes, I could do that. But in that case I would prefer to typedef the =

response function to simplify create function's signature. Otherwise
I think the create function's signature gets too complex.

...
> I do need another look at the RTNL magic and casting. That always
> drives
> my crazy when I look at that. In the meantime, please address these
> details first.

Sure, and thanks for reviewing.

Regards,
Sjur

--===============6545199872113512391==--

