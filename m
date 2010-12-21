Content-Type: multipart/mixed; boundary="===============2173147125958700769=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: PATCH: Enable udev-based autodetection of calypso modem on
 Freerunner
Date: Tue, 21 Dec 2010 11:22:39 -0800
Message-ID: <1292959359.2658.63.camel@aeonflux>
In-Reply-To: <4D10FD6D.20804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2173147125958700769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >>> We could document this as Freerunner specific notes to point people i=
nto
> >>> the right direction. And we should maybe to the same for IFX since th=
at
> >>> is currently only documented in the GIT commit logs.
> >>
> >> Documentation inside the individual modem driver is the way to go.  And
> >> IFX isn't even documented in git commit logs.  I looked ;)
> > =

> > commit 3443a7a177fbaca24c84658968aff0a55db8a51d
> > Author: Marcel Holtmann <marcel@holtmann.org>
> > Date:   Sat Sep 18 22:08:41 2010 +0900
> > =

> >     udev: Add support for IFX device detection
> >     =

> >     The IFX device detection is pretty static, but instead of using
> >     a static configuration file it is important to know when the device
> >     node is actually present. For this udev is perfect. Adding a simple
> >     udev rule is all that it takes:
> >     =

> >     KERNEL=3D=3D"ttyIFX[0-9]*", ENV{OFONO_DRIVER}=3D"ifx"
> >     =

> >     With this rule for every TTY with the kernel name like ttyIFX0, a n=
ew
> >     modem will be added and the IFX modem plugin driver requested for i=
t.
> > =

> > this is not enough?
> =

> Then I didn't look far back enough (or I'm simply blind).  But I still
> prefer this to be inside the driver or HACKING.calypso for easier access.

I am with you that this needs to be documented better than GIT commit
logs.

However I do prefer doc/calypso-modem.txt and doc/ifx-modem.txt though
since I don't wanna clutter the root directory.

Regards

Marcel



--===============2173147125958700769==--

