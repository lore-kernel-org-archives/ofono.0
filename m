Content-Type: multipart/mixed; boundary="===============5568397444789515661=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] document getting of ell, point people at useful docs
Date: Fri, 01 Feb 2019 23:25:54 +0100
Message-ID: <20190201222554.GA22438@amd>
In-Reply-To: <4ED57398-61D8-4F54-865A-9CCD09E9ED55@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5568397444789515661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > diff --git a/README b/README
> > index 45bb2e9..04a50a5 100644
> > --- a/README
> > +++ b/README
> > @@ -16,11 +16,14 @@ To configure run:
> > 	./configure --prefix=3D/usr --mandir=3D/usr/share/man \
> > 				--sysconfdir=3D/etc --localstatedir=3D/var
> > =

> > -Configure automatically searches for all required components and packa=
ges.
> > +Configure automatically searches for all required components and
> > +packages, except ell, mentioned below.
> > =

> =

> Nope. Since ELL is actually optional. It is clearly described just a few =
lines below.
> =


Is it optional? This is definitely unclear. Are we looking at same README?

commit 55e5a766f2833d6aaaf98d0f8cc250585717bc07
Author: Nandini Rebello <nandini.rebello@intel.com>
Date:   Wed Jan 16 12:15:31 2019 +0530

README says:

Embedded Linux library
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In order to compile the daemon and utilities the development version
of Embedded Linux library is required to be present. The development
repositories can be found here:

which sounds like "required" to me. Then there is:

When using --enable-external-ell build option, it is not required that
the Embedded Linux library source code is available in the top level
directory.

But I read it as "can be present somewhere else".

Plus, build actually fails, with pretty cryptic error message:

./bootstrap-configure
./configure
pavel(a)duo:~/g/ofono$ make
make --no-print-directory all-am
make[1]: *** No rule to make target 'ell/util.c', needed by
'ell/util.lo'.  Stop.
Makefile:2066: recipe for target 'all' failed
make: *** [all] Error 2


									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5568397444789515661==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseFV4M0lBQ2drUU1PZndhcFhiK3ZKdHhnQ2duRnVSRVE2TVRsUC9ndGV6OVppSkdyZUMK
MzNnQW9JdHZ1dUVRcjVzUzlGZ0pJa202OWUwZHJ4TkEKPU9HZHMKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5568397444789515661==--

