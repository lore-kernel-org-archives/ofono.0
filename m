Content-Type: multipart/mixed; boundary="===============6640643162254277419=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Motorola motmdm support
Date: Sun, 30 Dec 2018 23:33:30 +0100
Message-ID: <20181230223330.GA31362@amd>
In-Reply-To: <5950f965-effa-25ca-3533-de1b95923aa5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6640643162254277419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >>How are you handling data connections?  PPP? Or is there some other pro=
tocol
> >>to transfer packets back and forth?
> >
> >All the data connections in this case are done using QMI over USB.
> >
> >And that probably explains why I have not seen any data related
> >stuff on ts 27.010.
> =

> Ew.  So is everything related to packet services is running over QMI?
> =

> When Pavel explained that he wanted to use the weird squiggly AT commands=
, I
> assumed you wanted to run the packet services over AT as well.

No idea about packet data for now. I currently run them over
qmi... which means increased power consumption, I guess that's ok if
data are active.


> >>>>- GNSS/GPS is intended to be handled via oFono LocationReporting API.=
  I
> >>>>would recommend integrating this as intended...
> >>>
> >>>We have a standard kernel GNSS API now :) And we have /dev/gnss0
> >>>already working for droid 4.
> >>
> >>That's great.  But I think my recommendation still stands.  You want GPS
> >>state to be synchronized with the overall modem state, etc...
> >
> >Hmm sounds like ofono would benefit from using /dev/gnss0 in the
> >long run though. I guess the situation is similar to having
> >multiple computer mouse drivers earlier with their own interfaces
> >vs standard /dev/input :)
> =

> Yep, agreed.  I already tried to nudge Pavel to propose something.

?

I believe that kernel doing the multiplexing and "normal" /dev/gnss0
being available to userspace is actually very nice solution.

> >Oh, I think I forgot to answer your question regarding PM,
> >there's nothing that the user space needs to except to avoid
> >polling the /dev/motmdm* devices unnecessarily. And to type
> >AT+SCRN=3D0 on /dev/motmdm1 when no notifications for signal
> >strength and network status are needed.
> >
> =

> Right, but since /dev/motmdm1 would in theory belong exclusively to oFono,
> you probably still need some way of sending the screen 'off' command.  So=
 in
> effect you're integrating power management with the telephony stack.

I don't understand. Display power management should be separate from
ofono?

Tony: are there expected to be differences between motmdm1 and other
ttys? It does not gatchat seems to work ok with ttyUSB4, but does not
quite behave with motmdm1. Are the settings like ctsrts and baudrates
used for something?

Plus, it seems has its own subsystem, so
this is needed:

+       udev_enumerate_add_match_subsystem(enumerate, "motmdm");

Best regards,

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============6640643162254277419==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd3BSN29BQ2drUU1PZndhcFhiK3ZKNnpnQ2VKVUxRYThKNFltZzhWNHZxN1UzeS8wYUgK
N3lJQW4zdUlWMUJPK2RxM0hkTkxFOG1CSXJPdVh2dG0KPWVSSHUKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============6640643162254277419==--

