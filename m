Content-Type: multipart/mixed; boundary="===============3854618347708223641=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: RFC: API for Neighbouring Cell Info
Date: Sun, 31 Jan 2010 08:04:04 -0800
Message-ID: <1264953844.5591.321.camel@localhost.localdomain>
In-Reply-To: <4B656545.1020509@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3854618347708223641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

> >> Honestly I don't like either approach, the Agent pattern would be a
> >> much better fit here.  This would allow us to specify =

> >> the polling/update interval and stop neighbor cell updates when no one
> >> is interested in them.
> > =

> > In my experience, the positioning guys don't need periodic updates at
> > all. The data needs to be fetched on demand. Like whenever the user
> > starts up a location-aware application.
> =

> I'm willing to bet this is a chicken-egg problem: Why design software =

> that uses periodic location updates if they aren't available?
> =

> Only exposing plain polling is fine if it makes sense in a powersaving =

> (and api simplicity) sense: a version of periodic updating can always be =

> implemented at the position service (geoclue) level if it seems useful.

there is no problem in polling the hardware if we have to. However if
that is the case, then we obviously should only poll when we have a
user/client asking for the information. And we should poll in an
interval that the user/client needs this information.

As Denis mentioned, if we have a D-Bus API for retrieving these
information then we need to able to handle multiple users in a smart way
without wasting system resources or blocking each other.

I consider this similar to usage statistics. And in ConnMan I went for
an agent concept to solve this. The similar approach seems to fit here
perfectly if we wanna expose these information over D-Bus. That is the
only way, we have control over clients. If nothing has changed there is
not point in waking up more processes and let the determine noting has
changed to only go back to sleep afterwards. If these clients actually
have UI components that redraw, it is even worse.

Regards

Marcel



--===============3854618347708223641==--

