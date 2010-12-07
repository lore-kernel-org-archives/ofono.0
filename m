Content-Type: multipart/mixed; boundary="===============2204460666267208949=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Tue, 07 Dec 2010 09:58:37 +0100
Message-ID: <1291712317.4795.131.camel@aeonflux>
In-Reply-To: <201012070156.06941.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2204460666267208949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > > where is this timed running? I prefer the plugin just send a D-Bus
> > > > message to the timed directly instead of a Get/Changed API kind of
> > > > thing.
> > > =

> > > AFAIK, Get/Changed is the simplest functional way to avoid races, whe=
re
> > > say oFono would receive the time before timed can process it. The get=
ter
> > > also enables implementing trivial a tool =C3=A0 la ntpdate.
> > =

> > then please answer my questions from my other email. If we receive the
> > time before timed (or any other time daemon) is running, who does ensure
> > the current timestamp of this received time and what it correlates to.
> =

> The answer is in the patch. It makes me wonder if you even read it? When =
we =

> receive NITZ from the modem, we take a timestamp from the monotonic clock.
> =

> From there, we have plenty of options, mostly boiling down to:
> =

> (1) Give an estimate of the current wall time:
>    nitz + (now(CLOCK_MONOTONIC) - timestamp)
> This induces avoidable imprecision, but it is easiest to understand.
> =

> (2) Give both the NITZ time and the monotonic timestamp, and let the time =

> daemon do all the maths. IIRC, that's what timed would like, although I f=
ind it =

> needlessly complicated.
> =

> (3) Give an estimate of the time of day of the monotonic clock origin, wh=
ich =

> is to say the time of day of the system boot:
>   nitz - timestamp.
> The time daemon can then add the current monotonic time. This is a bit mo=
re =

> precise than (1), and a bit simpler than (2), which is why I was suggesti=
ng =

> that.
> =

> > If no time daemon is running it is safer to just set this time as system
> > time right away and then let the time daemon adjust it later.
> =

> Either oFono maintains the time (may be a configuration option), or it do=
es =

> not. I would really hate to have oFono set the system time depending on t=
he =

> effect of the phase of moon on the ordering of the boot sequence.
> =

> > But just
> > handing out a random time from a random time before is not helping. And
> > oFono is not suppose to track time and it corelation to it.
> =

> Antti's patch returns an extrapolation of the _current_ wall time by addi=
ng =

> the time since the NITZ was received to the NITZ. This is not at all rand=
om. =

> Obviously, we need a working monotonic clock - but I think a mobile devic=
e =

> without a working timer is about as useful as a brick.

I have seen a bunch of devices where we have not a proper clock value to
begin with. And in that case there is nothing really useful we can do
with it, except just set the system clock right away.

So the other problem with the timestamp and NITZ and the time daemon not
running is that we have no idea what happens in between. While this
might be short time and could potentially work, I still don't see this
as a good solution at all.

Right now, I still think that either we set the system clock right away
if no time daemon is running and if time daemon is running, then we send
a D-Bus method to that time daemon. And we can easily track this D-Bus
name owner notifications.

Regards

Marcel




--===============2204460666267208949==--

