Content-Type: multipart/mixed; boundary="===============3107082996641854702=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: RFC: API for Neighbouring Cell Info
Date: Fri, 29 Jan 2010 18:29:23 +0200
Message-ID: <1264782563.19283.825.camel@phoenix.elisa-laajakaista.fi>
In-Reply-To: <201001290957.00346.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3107082996641854702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

pe, 2010-01-29 kello 16:56 +0100, ext Denis Kenzior kirjoitti:
> > > Your feedback is highly appreciated, especially from those who plan to
> > > use this information for location purposes.
> > =

> > I think the pattern you use here is wrong. This needs to be a method
> > call; a signal won't work. The measurement data is constantly changing,
> > and you don't want a constant stream of PropertyChanged() signals.
> > =

> > So I think something like this instead:
> > =

> > GetNeighborCells() -> a{sv}, aa{sv}
> =

> How is this information obtained from the modem? Is the modem polled? Doe=
s it =

> signal this data as it changes?

It is polled, by design.

> Honestly I don't like either approach, the Agent pattern would be a
> much better fit here.  This would allow us to specify =

> the polling/update interval and stop neighbor cell updates when no one
> is interested in them.

In my experience, the positioning guys don't need periodic updates at
all. The data needs to be fetched on demand. Like whenever the user
starts up a location-aware application.

> > > Once there is agreement on the API we can discuss whether it makes
> > > sense to add some skeleton support in the oFono core or leave it to
> > > each individual modem plugin to implement the DBUS service in its
> > > entire.
> > =

> > I think it's reasonable to assume that most modems support this. There
> > is a standard to follow, and at least isimodem will have a driver for
> > it. So I would make it a proper atom from the beginning.
> =

> I'd like to see the low level driver API proposal first.  The Nokia isimo=
dem =

> interface is actually quite sane, AT command modems are usually not so...=
  If =

> we make this into a proper atom we have to make this work for all hardwar=
e =

> from the beginning.

Right, we perhaps need a datapoint from an AT modem to know for sure,
but the fact that OMA SUPL standardizes this, and the ISI interface is
close to that standard already, makes me think the AT modems can't be
that far off.

I could take a stab at a driver API for this as soon as I clear up some
space on my todo list.

Cheers,
Aki


--===============3107082996641854702==--

