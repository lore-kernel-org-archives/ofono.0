Content-Type: multipart/mixed; boundary="===============6607180603515592481=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] TODO: SMS Validity Period
Date: Wed, 02 Feb 2011 07:52:24 +0100
Message-ID: <1296629544.1520.296.camel@aeonflux>
In-Reply-To: <1296591582.2619.54.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6607180603515592481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > > > How does a normal user actually know what this means for him and the
> > > > network he is using? Is the network actually honoring these values =
at
> > > > all these days?
> > > =

> > > These are not clear to me either, so I don't see the point in exposing
> > > this setting over the D-Bus interface. I would, however, err on the
> > > side of flexibility here, and make this a configuration option in
> > > main.conf (once that support is available in oFono).
> > =

> > we did talk a bit about expected operator defaults especially in the
> > context of default character set etc. I think Portugal is such an
> > exception where you have to start out with a proper character set if
> > your SIM card is originated from there.
> > =

> > Maybe this is another one case where just picking a proper operator
> > default is better than actually providing any option to change it.
> =

> Yes, some of these language variants are mandated by certain regulators,
> some by operators. So certainly the default SMS alphabet should be a
> main.conf item.

I don't think that main.conf is really what you want here. If I
understand this requirement correctly, then the defaults have to be
picked based on the SIM card you put into the device. You don't really
wanna build country or operator specific main.conf and ship different
software core software to every single operator.

So I think we need to approach this a little bit different to make it
easy to handle and also easy to update if needed while still having the
same distribution running on every device no matter what country it
actually got manufactured for. And with GSM we are in the lucky position
that every single SIM card has its MCC and MNC. My idea is that we go
with sensible operator defaults here.

My idea is to have /usr/lib/ofono/defaults/ directory where we can store
a set of proper default values with operator variants. So any builtin
default could be easily overwritten this way. An example would be to
have a sms.conf file here.

[bearer]
default=3Dcs-preferred
262=3Dps-preferred
26202=3Dps-only

[charset]
...

This way the atom could come in and read this file for a new SIM card
and automatically set sensible defaults. And if not present we just use
the hardcoded builtin defaults.

And we can keep this minimal since there will be only so many exceptions
to the default here. The other advantage is that this can actually be
maintained outside of oFono by the device manufacturer. In the end these
might be all so trivial that we can just ship them with oFono directly.

Regards

Marcel



--===============6607180603515592481==--

