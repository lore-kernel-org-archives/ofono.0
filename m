Content-Type: multipart/mixed; boundary="===============3660099910306143392=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Wed, 05 Jan 2011 10:29:40 +0200
Message-ID: <201101051029.40894.remi.denis-courmont@nokia.com>
In-Reply-To: <1294177770.5852.109.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3660099910306143392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 04 January 2011 23:49:30 ext Marcel Holtmann, you wrote:
> Hi Aki,
> =

> > > > But then it is far simpler to have a D-Bus getter and a D-Bus signal
> > > > by any sane measure of complexity.
> > > =

> > > So you did consider the complexity on both sides, ofonod and timed? A=
nd
> > > not just looked at one side of picture?
> > =

> > Timed also needs to follow the registration status, namely the MNC/MCC
> > of the registered network.  This information it needs to be able to find
> > the correct timezone, as the UTC offset alone only indicates the
> > geographic longitude for the timezone.
> > =

> > Factor that in to the equation, and timed already needs to enumerate
> > available modems, call GetProperties, and listen to the
> > NetworkRegistration interface's PropertyChanged signals.
> > =

> > However, if we refactor the time plugin to also send the MNC/MCC pair --
> > or better yet, the ISO country code based on MCC or even the actual
> > timezone from matching zone.tab entry -- then following netreg is no
> > longer needed.
> > =

> > *Then* I agree a method call is actually a lot simpler from timed point
> > of view; all it needs to do is implement a single method on some
> > org.ofono.NetworkTimeConsumer interface and not worry about enumerating
> > modems via ModemManager or listening on any signals.
> =

> we are doing the country alpha2 matching to MCC already in ConnMan for
> the WiFi regulatory enforcement update. I am not sure that I wanna copy
> these tables around all the time.

Mapping MCC should be in oFono if only so not every oFono-using application=
s =

reinvents the same table. This is perhaps not so relevant for network time, =

but I think oFono should provide the country code for network registration =
and =

for the SIM card. As an example, this can be used to guess the default loca=
le =

settings when the SIM is first inserted into a device.

In the case of network time, we really want to map the (MCC, UTC offset, DS=
T) =

tuple to a time zone. We do not necessarily have to use any ISO code.

There are some ambiguities though, for instance Honolulu and Unalaska have =
the =

same offset to UTC (in winter), same country code but are in different time =

zones. Note that this is the only case I know, and it only affects under 10=
,000 =

people.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============3660099910306143392==--

