Content-Type: multipart/mixed; boundary="===============1548541158142355787=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Tue, 07 Dec 2010 01:56:06 +0200
Message-ID: <201012070156.06941.remi.denis-courmont@nokia.com>
In-Reply-To: <1291678174.4795.124.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1548541158142355787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 December 2010 01:29:34 ext Marcel Holtmann, you wrote:
> > > where is this timed running? I prefer the plugin just send a D-Bus
> > > message to the timed directly instead of a Get/Changed API kind of
> > > thing.
> > =

> > AFAIK, Get/Changed is the simplest functional way to avoid races, where
> > say oFono would receive the time before timed can process it. The getter
> > also enables implementing trivial a tool =C3=A0 la ntpdate.
> =

> then please answer my questions from my other email. If we receive the
> time before timed (or any other time daemon) is running, who does ensure
> the current timestamp of this received time and what it correlates to.

The answer is in the patch. It makes me wonder if you even read it? When we =

receive NITZ from the modem, we take a timestamp from the monotonic clock.

From there, we have plenty of options, mostly boiling down to:

(1) Give an estimate of the current wall time:
   nitz + (now(CLOCK_MONOTONIC) - timestamp)
This induces avoidable imprecision, but it is easiest to understand.

(2) Give both the NITZ time and the monotonic timestamp, and let the time =

daemon do all the maths. IIRC, that's what timed would like, although I fin=
d it =

needlessly complicated.

(3) Give an estimate of the time of day of the monotonic clock origin, whic=
h =

is to say the time of day of the system boot:
  nitz - timestamp.
The time daemon can then add the current monotonic time. This is a bit more =

precise than (1), and a bit simpler than (2), which is why I was suggesting =

that.

> If no time daemon is running it is safer to just set this time as system
> time right away and then let the time daemon adjust it later.

Either oFono maintains the time (may be a configuration option), or it does =

not. I would really hate to have oFono set the system time depending on the =

effect of the phase of moon on the ordering of the boot sequence.

> But just
> handing out a random time from a random time before is not helping. And
> oFono is not suppose to track time and it corelation to it.

Antti's patch returns an extrapolation of the _current_ wall time by adding =

the time since the NITZ was received to the NITZ. This is not at all random=
. =

Obviously, we need a working monotonic clock - but I think a mobile device =

without a working timer is about as useful as a brick.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============1548541158142355787==--

