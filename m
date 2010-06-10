Content-Type: multipart/mixed; boundary="===============9210087784063755732=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 17/20] stkutil: Add the Event Download envelope builder
Date: Wed, 09 Jun 2010 20:37:18 -0500
Message-ID: <201006092037.19116.denkenz@gmail.com>
In-Reply-To: <1276132792.2182.76.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9210087784063755732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> Hi Denis,
> =

> > >  		/* Network Byte Order */
> > > -		unsigned int ipv4;
> > > +		guint32 ipv4;
> >
> > Why?
> =

> actually unsigned int on 64-bit has a different size than on 32-bit.
> However I prefer we use uint32_t and not the guint32 types.

Err, no it doesn't.  You must be thinking of long ints.

While theoretically 8-byte ints are allowed by the standard, no such platfo=
rm =

exists that I know of.  Using uint32_t is preferable though.

Regards,
-Denis

--===============9210087784063755732==--

