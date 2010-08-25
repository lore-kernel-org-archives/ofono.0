Content-Type: multipart/mixed; boundary="===============4728831010675755847=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: About ppp_receive()
Date: Wed, 25 Aug 2010 06:12:10 +0200
Message-ID: <1282709530.6841.38.camel@localhost.localdomain>
In-Reply-To: <4C747268.3020300@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4728831010675755847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steven,

> >> In function ppp_receive, we first check the protocol type of this
> >> frame =

> >> like:
> >>
> >>   guint16 protocol =3D ppp_proto(buf);
> >>
> >> and here we assumed the length of the protocol field is 16 bits, but
> >> in =

> >> RFC 1661, the protocol field should be one or two octets.
> >>
> >> "The Protocol field is one or two octets, and its value identifies
> >> the datagram encapsulated in the Information field of the packet."
> >>
> >> why we given the assumption that protocol field is 16 bit length?
> > =

> > First I am not ppp expert. :-).
> > =

> > If you take look at pppd source code, main.c, get_input() also always f=
etch two bytes 'protocol' for struct protent as well.
> > =

> > Can you give a case we failed in our ppp stack?
> =

> If you interested in this topic, you can reference RFC 1661 Section 6.5, =

> which said
> =

> --------------
> This Configuration Option provides a method to negotiate the
> compression of the PPP Protocol field. By default, all
> implementations MUST transmit packets with two octet PPP Protocol
> fields.
> PPP Protocol field numbers are chosen such that some values may be
> compressed into a single octet form which is clearly
> distinguishable from the two octet form. This Configuration
> Option is sent to inform the peer that the implementation can
> receive such single octet Protocol fields.
> -------------
> =

> In our current source code, because we only negotiate two configuration =

> options - REQ_OPTION_MRU and REQ_OPTION_ACCM. so it's okey for our PPP =

> stack.
> =

> But some carriers, like China Telecom or Sprint Network etc, will =

> support the full configuration =

> options(Magic-Number,Protocol-Field-Compression,Address-and-Control-Field=
-Compression),
> So if PFC option is used ,our code will got wrong with ppp_receive().

in the GSM world, the PPP is between the oFono and the modem hardware.
Not between oFono and the network. So for GSM we don't even care single
bit what the networks wants since it never sees PPP.

I asked this before, CDMA talks PPP over the air to the network? That
would be rather stupid and a big waste.

> We should first check if PPP protocol field is compressed or not, and =

> then get the right protocol value to form a 16 bits protocol field, and =

>   pass this value to the rest functions.
> =

> Because of my company's security policy ,I can't provide a patch for =

> this issue. But i can provide a method for doing this. Here it is.

To be quite blunt with you, this is an open source project. If you have
an itch to scratch then we expect you to send a patch. Telling us what
we have to do or should do is not helping here.

Regards

Marcel



--===============4728831010675755847==--

