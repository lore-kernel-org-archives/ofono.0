Content-Type: multipart/mixed; boundary="===============0566777632007050786=="
MIME-Version: 1.0
From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [PATCHv2 1/2] stemodem: Add RTNL functionality managing CAIF
 Network Interfaces.
Date: Wed, 03 Nov 2010 11:55:30 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C105791945AAD37C@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <1288674206.3322.165.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0566777632007050786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

> > +static GSList *pending_requests;
> > +static GIOChannel *channel;
> > +static guint32 rtnl_seqnr;
> > +static guint  rtnl_watch;
> =

> To be fair, you don't need both, the GIOChannel and the watch. You can
> just add the watch and then unref the GIOChannel and set it to close on
> unref. That way when the watch gets removed or you remove it, the
> GIOChannel and the underlaying socket will be automatically closed as
> well.
....
> As described above. Just unref the GIOChannel and forget about it. And
> then you can make the GIOChannel a local variable.

I think I have to keep the channel, because I do need the
file descriptor derived from the channel when doing sendto.

> > > You don't really have to play this append/remove game. You can just
> > > append it after send_rtnl_req succeed. The read goes via the
> mainloop
> > > anyway and we are a single threaded program. So the order is
> > > guaranteed.
...
> You don't need to append it first, send the message, check error and in
> case of an error remove it again.

OK, thanks - now I get what your after. I completely misunderstood your =

previous comment, my bad.

> And while we are at it. Essentially you also need to use asynchronous
> and non-blocking watch driven sending of your message in the first
> place. I did forget to check if you open the RTNL socket non-blocking,
> but you should be doing that.

So I'll add something like this then:
	fl =3D fcntl(sk, F_GETFL);
	fcntl(sk, F_SETFL, fl | O_NONBLOCK);


> > +	}
> > +
> > +	g_slist_free(pending_requests);
> > +	pending_requests =3D NULL;
> =

> No need to set pending_requests to NULL here.

But I will have to move this to the caif_rtnl_init function then,
I think pending_requests needs to be NULL before using it.

> > > I am not really sold on this param stuct thingy btw. Why do you
> need
> > > them? Just proper input params and output params for the callback
> > > handler would do them same. Won't they?
> >
> > Yes, I could do that. But in that case I would prefer to typedef the
> > response function to simplify create function's signature. Otherwise
> > I think the create function's signature gets too complex.
> =

> typedef for function callbacks are just fine. I have no problem with
> that at all.

I got rid of the structs and typedef'ed response function - I agree this be=
tter.

<snip>
typedef void (*rtnl_create_cb_t) (int result, gpointer user_data,
		char *ifname, int ifindex);

extern int caif_rtnl_create_interface(gpointer user_data, int type, int con=
nid,
		gboolean loop, rtnl_create_cb_t cb);


Hoping to get the next patch out later today.

Regards,
Sjur

--===============0566777632007050786==--

