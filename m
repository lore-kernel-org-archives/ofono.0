Content-Type: multipart/mixed; boundary="===============2692548214123447573=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [patch 5/6] IP support for PPP
Date: Tue, 16 Mar 2010 15:53:44 -0700
Message-ID: <20100316155344.5d0dd744@kcaccard-MOBL3>
In-Reply-To: <1268598157.3897.34.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2692548214123447573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Mar 2010 13:22:37 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:
> > +/****** IPCP support ****************/
> > +enum {
> > +	/* supported codes */
> > +	IPCP_SUPPORTED_CODES	=3D (1 << CONFIGURE_REQUEST) |
> > +				  (1 << CONFIGURE_ACK) |
> > +				  (1 << CONFIGURE_NAK) |
> > +				  (1 << CONFIGURE_REJECT) |
> > +				  (1 << TERMINATE_REQUEST) |
> > +				  (1 << TERMINATE_ACK) |
> > +				  (1 << CODE_REJECT),
> > +
> > +	IPCP_PROTO		=3D 0x8021,
> > +
> > +	/* option types */
> > +	IP_ADDRESSES		=3D 1,
> > +	IP_COMPRESSION_PROTO	=3D 2,
> > +	IP_ADDRESS		=3D 3,
> > +	PRIMARY_DNS_SERVER	=3D 129,
> > +	SECONDARY_DNS_SERVER	=3D 131,
> > +};
> =

> I don't think enum is the right way for this. I can see it for the
> option types, but for IPCP_PROTO and IPCP_SUPPORTED_CODES. I would say
> just using simple defines is way better.
> =

> Feel free to convince me other way or show me what I have missed here.

It's mostly just a habit, but in general there are advantages to
using enum vs. a define.  You are assured that the scope is kept local,
even if you are uncreative with your name choices, whereas with a macro =

it is not.  Also it's sometimes easier to debug with an enum vs. a macro.  =

I can certainly change it if you really want me too.


--===============2692548214123447573==--

