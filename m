Content-Type: multipart/mixed; boundary="===============8008385385902868819=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 5/6] IP support for PPP
Date: Tue, 16 Mar 2010 21:39:09 -0700
Message-ID: <1268800749.2700.34.camel@localhost.localdomain>
In-Reply-To: <20100316155344.5d0dd744@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8008385385902868819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> > > +/****** IPCP support ****************/
> > > +enum {
> > > +	/* supported codes */
> > > +	IPCP_SUPPORTED_CODES	=3D (1 << CONFIGURE_REQUEST) |
> > > +				  (1 << CONFIGURE_ACK) |
> > > +				  (1 << CONFIGURE_NAK) |
> > > +				  (1 << CONFIGURE_REJECT) |
> > > +				  (1 << TERMINATE_REQUEST) |
> > > +				  (1 << TERMINATE_ACK) |
> > > +				  (1 << CODE_REJECT),
> > > +
> > > +	IPCP_PROTO		=3D 0x8021,
> > > +
> > > +	/* option types */
> > > +	IP_ADDRESSES		=3D 1,
> > > +	IP_COMPRESSION_PROTO	=3D 2,
> > > +	IP_ADDRESS		=3D 3,
> > > +	PRIMARY_DNS_SERVER	=3D 129,
> > > +	SECONDARY_DNS_SERVER	=3D 131,
> > > +};
> > =

> > I don't think enum is the right way for this. I can see it for the
> > option types, but for IPCP_PROTO and IPCP_SUPPORTED_CODES. I would say
> > just using simple defines is way better.
> > =

> > Feel free to convince me other way or show me what I have missed here.
> =

> It's mostly just a habit, but in general there are advantages to
> using enum vs. a define.  You are assured that the scope is kept local,
> even if you are uncreative with your name choices, whereas with a macro =

> it is not.  Also it's sometimes easier to debug with an enum vs. a macro.=
  =

> I can certainly change it if you really want me too.

I have nothing against enums. I actually like them a lot if used
correctly, because gcc and gdb does make your life easier.

The thing that I dislike is clashing namespaces and scopes in just one
enum. In the example of both you mix two or more things that should at
least in different enums.

Regards

Marcel



--===============8008385385902868819==--

