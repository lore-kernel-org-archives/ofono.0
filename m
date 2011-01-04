Content-Type: multipart/mixed; boundary="===============7697849146494362861=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Tue, 04 Jan 2011 10:54:34 +0200
Message-ID: <201101041054.34324.remi.denis-courmont@nokia.com>
In-Reply-To: <1294087656.5852.22.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7697849146494362861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This discussion is completely ridiculous at this point.

On Monday 03 January 2011 22:47:36 ext Marcel Holtmann, you wrote:
> > > So the idea of having an oFono D-Bus API to export time information is
> > > just wrong from my point of view. The plugin inside oFono should tell
> > > the time daemon about this.
> > =

> > That would be race-prone by design. For all we know, the time daemon
> > might be started after oFono (or restarted). It's pretty basic design to
> > have a getter and a change signal for any kind of value.
> =

> there is no race here. The timed plugin inside oFono can just keep the
> time and only send it out when timed starts. You can easily monitor
> deamons lifetime with D-Bus.

You just said that you did not want oFono to keep the time reference value. =

This is self-contradictory. Now you admit that oFono does need to keep it.

But then it is far simpler to have a D-Bus getter and a D-Bus signal by any =

sane measure of complexity.

> > Besides, I find hard-coding The One time daemon in the oFono plugin
> > rather silly. It's really nothing but an arbitrary design limitation
> > that would be overcome with a clean D-Bus API like we proposed several
> > times.
> =

> It is a plugin that monitors the existence of such a daemon. So we can
> have multiple plugins for each daemon. And we can even have them all
> active at the same time. So where do you see a problem here?

So that is far more complicated, inextensible and it consumes more CPU (mor=
e =

D-Bus interactions). This makes absolutely no sense.

> > > And not the time daemon go out and bother
> > > with additional sources etc.
> > =

> > Last time I checked, NTP clients "go out and bother" to ask the
> > configured NTP server, not the other way around. I fail to see reason
> > why oFono should work the other way around. I do see several reasons why
> > it should not.
> =

> You need to tell NTP client (or the ntpd running) the time servers to
> use. Check how we do that in ConnMan. we tell ntpd about time servers
> and not the other way around.

That's the point: the one who wants to learn the time (the NTP client, or t=
he =

time daemon) is the one ASKING for it from the one who knows (the NTP serve=
r =

or oFono). The other direction is just totally backward design.

> > > And if you take the normalized time based on a monotonic clock, such a
> > > plugin that just send a D-Bus message to a time daemon is actually a
> > > lot simpler than exposing a full blown D-Bus interface.
> > =

> > It's very marginally simpler: one signal against one signal plus one
> > getter that will share much marshalling code with the signal. But that's
> > irrelevant. It actually works. The sole signal design is broken.
> =

> I was talking about a method call to timed and not a signal.

It's largelly irrelevant. There's no functional difference between a method =

call without response and a signal.

> > > So the plugin just has to store the normalized time in memory. And if=
 a
> > > time daemon is present, then send out an update if needed, otherwise
> > > don't bother.

> > Oh? That would actualy be far more complicated, as the plugin would then
> > need to track down the presence of the time daemon. I see some
> > contradiction here.
> =

> And that is a problem with D-Bus how? With g_dbus_add_service_watch this
> is dead simple actually. Simpler than providing a D-Bus interface.

I never said this was not feasible. I said this was more complicated and =

disingenuous.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============7697849146494362861==--

