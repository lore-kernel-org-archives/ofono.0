Content-Type: multipart/mixed; boundary="===============6013761881409025045=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Mon, 03 Jan 2011 12:47:36 -0800
Message-ID: <1294087656.5852.22.camel@aeonflux>
In-Reply-To: <201101031700.17266.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6013761881409025045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > So the idea of having an oFono D-Bus API to export time information is
> > just wrong from my point of view. The plugin inside oFono should tell
> > the time daemon about this.
> =

> That would be race-prone by design. For all we know, the time daemon migh=
t be =

> started after oFono (or restarted). It's pretty basic design to have a ge=
tter =

> and a change signal for any kind of value.

there is no race here. The timed plugin inside oFono can just keep the
time and only send it out when timed starts. You can easily monitor
deamons lifetime with D-Bus.

> Besides, I find hard-coding The One time daemon in the oFono plugin rathe=
r =

> silly. It's really nothing but an arbitrary design limitation that would =
be =

> overcome with a clean D-Bus API like we proposed several times.

It is a plugin that monitors the existence of such a daemon. So we can
have multiple plugins for each daemon. And we can even have them all
active at the same time. So where do you see a problem here?

> > And not the time daemon go out and bother
> > with additional sources etc.
> =

> Last time I checked, NTP clients "go out and bother" to ask the configure=
d NTP =

> server, not the other way around. I fail to see reason why oFono should w=
ork =

> the other way around. I do see several reasons why it should not.

You need to tell NTP client (or the ntpd running) the time servers to
use. Check how we do that in ConnMan. we tell ntpd about time servers
and not the other way around.

> > And if you take the normalized time based on a monotonic clock, such a
> > plugin that just send a D-Bus message to a time daemon is actually a lot
> > simpler than exposing a full blown D-Bus interface.
> =

> It's very marginally simpler: one signal against one signal plus one gett=
er =

> that will share much marshalling code with the signal. But that's irrelev=
ant. =

> It actually works. The sole signal design is broken.

I was talking about a method call to timed and not a signal.

> > So the plugin just has to store the normalized time in memory. And if a
> > time daemon is present, then send out an update if needed, otherwise
> > don't bother.
> =

> Oh? That would actualy be far more complicated, as the plugin would then =
need =

> to track down the presence of the time daemon. I see some contradiction h=
ere.

And that is a problem with D-Bus how? With g_dbus_add_service_watch this
is dead simple actually. Simpler than providing a D-Bus interface.

Regards

Marcel



--===============6013761881409025045==--

