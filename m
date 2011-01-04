Content-Type: multipart/mixed; boundary="===============3406725981913137565=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Tue, 04 Jan 2011 01:41:17 -0800
Message-ID: <1294134077.5852.91.camel@aeonflux>
In-Reply-To: <201101041054.34324.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3406725981913137565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > > So the idea of having an oFono D-Bus API to export time information=
 is
> > > > just wrong from my point of view. The plugin inside oFono should te=
ll
> > > > the time daemon about this.
> > > =

> > > That would be race-prone by design. For all we know, the time daemon
> > > might be started after oFono (or restarted). It's pretty basic design=
 to
> > > have a getter and a change signal for any kind of value.
> > =

> > there is no race here. The timed plugin inside oFono can just keep the
> > time and only send it out when timed starts. You can easily monitor
> > deamons lifetime with D-Bus.
> =

> You just said that you did not want oFono to keep the time reference valu=
e. =

> This is self-contradictory. Now you admit that oFono does need to keep it.

I said that 3-4 emails early already. It is either that or you just go
ahead and set the system if timed is not running.

> But then it is far simpler to have a D-Bus getter and a D-Bus signal by a=
ny =

> sane measure of complexity.

So you did consider the complexity on both sides, ofonod and timed? And
not just looked at one side of picture?

> > > Besides, I find hard-coding The One time daemon in the oFono plugin
> > > rather silly. It's really nothing but an arbitrary design limitation
> > > that would be overcome with a clean D-Bus API like we proposed several
> > > times.
> > =

> > It is a plugin that monitors the existence of such a daemon. So we can
> > have multiple plugins for each daemon. And we can even have them all
> > active at the same time. So where do you see a problem here?
> =

> So that is far more complicated, inextensible and it consumes more CPU (m=
ore =

> D-Bus interactions). This makes absolutely no sense.

Are you kidding me here? Where is the more D-Bus interaction going to
happen. It would be nice if you actually start counting both sides of
the equation here.

So you really want timed to monitor the oFono manager interface with
their modems and then the method calls and signals from the time
interface. Please count again what consumes more D-Bus interactions.

> > > > And not the time daemon go out and bother
> > > > with additional sources etc.
> > > =

> > > Last time I checked, NTP clients "go out and bother" to ask the
> > > configured NTP server, not the other way around. I fail to see reason
> > > why oFono should work the other way around. I do see several reasons =
why
> > > it should not.
> > =

> > You need to tell NTP client (or the ntpd running) the time servers to
> > use. Check how we do that in ConnMan. we tell ntpd about time servers
> > and not the other way around.
> =

> That's the point: the one who wants to learn the time (the NTP client, or=
 the =

> time daemon) is the one ASKING for it from the one who knows (the NTP ser=
ver =

> or oFono). The other direction is just totally backward design.

Who is telling NTP client where the servers are? Or is the NTP client
just going out fishing for NTP servers.

Maybe we should just turn ofonod into an NTP time source and then let
ntpd just always use that one. Problem solved and nicely integrated with
the desktop world as well.

> > > > And if you take the normalized time based on a monotonic clock, suc=
h a
> > > > plugin that just send a D-Bus message to a time daemon is actually a
> > > > lot simpler than exposing a full blown D-Bus interface.
> > > =

> > > It's very marginally simpler: one signal against one signal plus one
> > > getter that will share much marshalling code with the signal. But tha=
t's
> > > irrelevant. It actually works. The sole signal design is broken.
> > =

> > I was talking about a method call to timed and not a signal.
> =

> It's largelly irrelevant. There's no functional difference between a meth=
od =

> call without response and a signal.

There is a big difference when you look at potential wakeups of other
processes. A method call is always directed, a signal is broadcasted.

> > > > So the plugin just has to store the normalized time in memory. And =
if a
> > > > time daemon is present, then send out an update if needed, otherwise
> > > > don't bother.
> =

> > > Oh? That would actualy be far more complicated, as the plugin would t=
hen
> > > need to track down the presence of the time daemon. I see some
> > > contradiction here.
> > =

> > And that is a problem with D-Bus how? With g_dbus_add_service_watch this
> > is dead simple actually. Simpler than providing a D-Bus interface.
> =

> I never said this was not feasible. I said this was more complicated and =

> disingenuous.

I actually said that it is a lot simpler. If you don't believe me, why
don't you just code both versions of the plugin and then compare them.

And it is also a lot simpler for timed to integrate with this.

Regards

Marcel



--===============3406725981913137565==--

