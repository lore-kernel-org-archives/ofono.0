Content-Type: multipart/mixed; boundary="===============0173925159150317187=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Tue, 07 Dec 2010 13:00:09 +0200
Message-ID: <1291719609.3613.48.camel@apaila-ThinkPad-T410>
In-Reply-To: <1291712317.4795.131.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0173925159150317187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> I have seen a bunch of devices where we have not a proper clock value to
> begin with. And in that case there is nothing really useful we can do
> with it, except just set the system clock right away.

We are not using any absolute time value from any clock, but instead we
use relative elapsed time from monotonic clock. The reference point is
the monotonic clock time, when the network time indication arrived to
modem. I believe every device that takes ofono into use have a monotonic
time source.

> So the other problem with the timestamp and NITZ and the time daemon not
> running is that we have no idea what happens in between. While this
> might be short time and could potentially work, I still don't see this
> as a good solution at all.

That is why the nettime plugin implements both notification signal and a
polling method call. If timed is running it will receive the DBUS
notification about the network time. Otherwise timed can poll the time
from ofono as it becomes active. One should also notice that the NITZ
feature is optional both from terminal and network point of view, so
anything too fatal should not happen even if timed is not up when
nettime indication is sent. =


> Right now, I still think that either we set the system clock right away
> if no time daemon is running and if time daemon is running, then we send
> a D-Bus method to that time daemon. And we can easily track this D-Bus
> name owner notifications.

Architecturally I prefer that the system time is altered by one entity
alone, being timed. As we can have many modems active simultaneously, I
would not like if they all are allowed to directly alter the system
time. Timed should have a way to decide what is the proper time.

-Antti =




--===============0173925159150317187==--

