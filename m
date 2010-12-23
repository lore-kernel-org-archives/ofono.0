Content-Type: multipart/mixed; boundary="===============4182225633548777760=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Wed, 22 Dec 2010 18:44:52 -0800
Message-ID: <1293072292.9439.8.camel@aeonflux>
In-Reply-To: <AANLkTimQrZf18yYMcwUiYV1Akr+rBChX_tatW9CKajhB@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4182225633548777760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> There is no problem. If you still think there is a problem, you need
> to continue the previous thread on this subject and prove your point.
> =

> > And in case timed is not running it should just
> > set the current time directly.
> =

> You're welcome to write such a plugin -- this is why nettime is a
> plugin API after all. It might make sense in some platforms,
> especially those that don't have a working monotonic clock...

actually I spent time thinking about this and the whole time daemon idea
and what are potential input sources.

So the idea of having an oFono D-Bus API to export time information is
just wrong from my point of view. The plugin inside oFono should tell
the time daemon about this. And not the time daemon go out and bother
with additional sources etc.

And if you take the normalized time based on a monotonic clock, such a
plugin that just send a D-Bus message to a time daemon is actually a lot
simpler than exposing a full blown D-Bus interface.

So the plugin just has to store the normalized time in memory. And if a
time daemon is present, then send out an update if needed, otherwise
don't bother.

I really like to see it implemented this way. It is simpler and makes a
lot more sense than sending out D-Bus signals to everybody for time
changes.

In addition there will be more source for time and/or timezone
information. For example the GeoIP country information returned by
ConnMan portal service. We are not exposing a Getter/Changed D-Bus API
from ConnMan for this either. We just will sending these information to
interested parties.

Regards

Marcel



--===============4182225633548777760==--

