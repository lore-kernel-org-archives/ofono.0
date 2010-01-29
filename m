Content-Type: multipart/mixed; boundary="===============2839042978682011115=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: API for Neighbouring Cell Info
Date: Fri, 29 Jan 2010 09:56:59 -0600
Message-ID: <201001290957.00346.denkenz@gmail.com>
In-Reply-To: <1264752250.19283.773.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2839042978682011115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > Your feedback is highly appreciated, especially from those who plan to
> > use this information for location purposes.
> =

> I think the pattern you use here is wrong. This needs to be a method
> call; a signal won't work. The measurement data is constantly changing,
> and you don't want a constant stream of PropertyChanged() signals.
> =

> So I think something like this instead:
> =

> GetNeighborCells() -> a{sv}, aa{sv}

How is this information obtained from the modem? Is the modem polled? Does =
it =

signal this data as it changes?  Honestly I don't like either approach, the =

Agent pattern would be a much better fit here.  This would allow us to spec=
ify =

the polling/update interval and stop neighbor cell updates when no one is =

interested in them.

> > Once there is agreement on the API we can discuss whether it makes
> > sense to add some skeleton support in the oFono core or leave it to
> > each individual modem plugin to implement the DBUS service in its
> > entire.
> =

> I think it's reasonable to assume that most modems support this. There
> is a standard to follow, and at least isimodem will have a driver for
> it. So I would make it a proper atom from the beginning.

I'd like to see the low level driver API proposal first.  The Nokia isimode=
m =

interface is actually quite sane, AT command modems are usually not so...  =
If =

we make this into a proper atom we have to make this work for all hardware =

from the beginning.

> Other comments on the interface:
> > Properties boolean Enabled [readwrite]
> >
> > 			Boolean representing whether the interface provides
> > 			neighbouring cell information.
> =

> This is useless. If a modem driver doesn't support neighbor cell info,
> it won't registered a driver and the interface just doesn't show up.

Being able to turn this capability off is useful.  If there are no consumer=
s, =

then these types of notifications should be turned off to save power / wake=
ups.

Regards,
-Denis

--===============2839042978682011115==--

