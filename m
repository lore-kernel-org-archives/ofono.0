Content-Type: multipart/mixed; boundary="===============6823793775722948279=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Andr=C3=A9?= Draszik <git@andred.net>
Subject: Re: telit modem NW DETACH
Date: Tue, 21 Feb 2017 08:56:12 +0000
Message-ID: <1487667372.2824.23.camel@andred.net>
In-Reply-To: <1486631706.12234.7.camel@andred.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6823793775722948279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-02-09 at 09:15 +0000, Andr=C3=A9 Draszik wrote:
> Thanks Denis for your advise,
> =

> On Tue, 2017-02-07 at 11:22 -0600, Denis Kenzior wrote:
> > =

> > [...]
> > =

> > Generally the network shouldn't just detach you if you deactivated a=C2=
=A0
> > context, so my first guess would be that the modem firmware is doing=C2=
=A0
> > something silly.=C2=A0=C2=A0Do you have another modem to test by any ch=
ance?
> =

> No... Are you saying it could (in theory) actually be the network itself
> indeed (i.e. not the modem (firmware))?
> =

> > > I can get around that by disabling/re-enabling the modem, but I would
> > > like
> > > to avoid that...
> > > =

> > > As a further point, whenever the modem reports that it has been
> > > disconnected
> > > but then the CellID changes, it magically reconnects, so I believe I
> > > should
> > =

> > Even more evidence that seems to indicate a firmware issue.=C2=A0=C2=A0=
But who
> > knows.
> =

> I got my hands on a more recent firmware version, once I get a chance to
> update my modem I will report back.

The most recent firmware available didn't make any difference to the
behaviour, neither did changing the mobile provider.

A colleague of mine is looking to implement something now that will
hopefully be upstreamable.


Cheers,
Andre'


--===============6823793775722948279==--

