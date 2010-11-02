Content-Type: multipart/mixed; boundary="===============7942482697517130809=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCHv2 1/2] stemodem: Add RTNL functionality managing CAIF
 Network Interfaces.
Date: Tue, 02 Nov 2010 06:03:26 +0100
Message-ID: <1288674206.3322.165.camel@aeonflux>
In-Reply-To: <81C3A93C17462B4BBD7E272753C105791945A4F406@EXDCVYMBSTM005.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7942482697517130809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > You don't really have to play this append/remove game. You can just
> > append it after send_rtnl_req succeed. The read goes via the mainloop
> > anyway and we are a single threaded program. So the order is
> > guaranteed.
> =

> I'm not sure about this. I need to keep track of what
> connection-id I assign to the CAIF Interface in the request and what =

> interface name and interface index I get for that connection id
> in the RTNL response.
> This mapping between network interface and connection id is used =

> when PDP Contexts are activated. The append/remove game provides me
> with the request-response mapping. =


I know what you are trying to protect here, but what I am saying is that
just appending the struct to the list after you send it (and evaluated
its error code) is just fine.

You don't need to append it first, send the message, check error and in
case of an error remove it again.

The nature of single-thread application using a mainloop and where input
is driven by that mainloop, ensures that you will only receive the reply
to your message after you added it to the list. Even if that is done
after you send it.

So while it is fine to append the structure to the list for further
tracking, you should just do it after you send the message and it
succeeded and be done with it.

And while we are at it. Essentially you also need to use asynchronous
and non-blocking watch driven sending of your message in the first
place. I did forget to check if you open the RTNL socket non-blocking,
but you should be doing that.

> > > +struct rtnl_rsp_param {
> > > +	int result;
> > > +	gpointer user_data;
> > > +	char ifname[IF_NAMESIZE];
> > > +	int  ifindex;
> > > +};
> > > +
> > > +struct rtnl_req_param {
> > > +	void (*callback)(struct rtnl_rsp_param *param);
> > > +	gpointer user_data;
> > > +	int type;
> > > +	int conn_id;
> > > +	gboolean loop_enabled;
> > > +};
> > > +
> > > +extern int caif_rtnl_create_interface(struct rtnl_req_param *req);
> > > +extern int caif_rtnl_delete_interface(int ifid);
> > =

> > I am not really sold on this param stuct thingy btw. Why do you need
> > them? Just proper input params and output params for the callback
> > handler would do them same. Won't they?
> =

> Yes, I could do that. But in that case I would prefer to typedef the =

> response function to simplify create function's signature. Otherwise
> I think the create function's signature gets too complex.

typedef for function callbacks are just fine. I have no problem with
that at all.

I am not set in stone here, but for something this simple, it seems to
me that the two structs is a bit of overhead and complexity that we
could avoid.

Regards

Marcel



--===============7942482697517130809==--

