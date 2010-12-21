Content-Type: multipart/mixed; boundary="===============4255672887642477193=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: PATCH: Enable udev-based autodetection of calypso modem on
 Freerunner
Date: Tue, 21 Dec 2010 10:13:02 -0800
Message-ID: <1292955183.2658.60.camel@aeonflux>
In-Reply-To: <4D10EB6C.8010503@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4255672887642477193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >> I think the better way would be to drop a udev rule directly into
> >> /etc/udev.d or similar.  The rule should be as simple as:
> >> KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"calypso"
> > =

> > Do you mean in another file than 97-ofono.rules?
> =

> Yep.

I prefer not to have this inside ofono.git at all. We also leave the IFX
specific ones out. It is really up to the package maintainers to get
this sorted.

We could document this as Freerunner specific notes to point people into
the right direction. And we should maybe to the same for IFX since that
is currently only documented in the GIT commit logs.

Regards

Marcel



--===============4255672887642477193==--

