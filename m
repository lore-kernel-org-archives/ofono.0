Content-Type: multipart/mixed; boundary="===============1420559428844687037=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 17/20] stkutil: Add the Event Download envelope builder
Date: Wed, 09 Jun 2010 18:19:52 -0700
Message-ID: <1276132792.2182.76.camel@localhost.localdomain>
In-Reply-To: <201006092006.01114.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1420559428844687037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >  		/* Network Byte Order */
> > -		unsigned int ipv4;
> > +		guint32 ipv4;
> =

> Why?

actually unsigned int on 64-bit has a different size than on 32-bit.
However I prefer we use uint32_t and not the guint32 types.

Regards

Marcel



--===============1420559428844687037==--

