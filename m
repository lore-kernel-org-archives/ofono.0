Content-Type: multipart/mixed; boundary="===============7802176643109837206=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Voice calls over qmi was Re: Incoming sms problem on Motorola
 Droid 4
Date: Sat, 12 May 2018 13:02:55 +0200
Message-ID: <20180512110255.GA14983@amd>
In-Reply-To: <40c47311-04c7-20ab-7bf9-0228e2ce85fe@joeyhewitt.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7802176643109837206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > It looks like the QMI voicecall driver is just a stub with no operations
> actually implemented.
> =

> I hope I'm not stealing their thunder, but Alexander Couzens at sysmocom
> seems to be working on implementing it [0]. Last fall, I had
> incoming/outgoing calls in oFono working on my MSM8930-based Android phone
> with these patches. You will probably want to revert the "NOT_FOR_MERGE"
> commit(s).

Out of interest, what kind of phone how usable it is?

(Bacially everything works on Motorola Droid 4, with exception of
camera, and yes, I have some interesting hacks at places. That is with
current kernel and recent debian / Maemo Leste). =


https://pavelmachek.livejournal.com/141420.html?nojs=3D1

> I have some rough (outdated?) patches on top of theirs, for DTMF[1], and
> improving the implementation of release_specific()[2]. (I don't know some=
 of
> the technical details of GSM and QMI, but those changes made declining
> incoming calls work the way I expected.)
> =

> -Joey
> =

> [0] https://git.sysmocom.de/ofono/log/?h=3Dlynxis/master

Thanks for pointer.

include/ofono/call-list.h was missing; I provided a symlink to
include/call-list.h.

drivers/qmimodem/lde.c was missing. I provided an empty file. This
can't end well.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============7802176643109837206==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscjJ5ZDhBQ2drUU1PZndhcFhiK3ZMbGhnQ2d2aVlPYlp4K0s4TG5MOWZmZmZlbnJCMUIK
T2VvQW5qcXdZUS9OQlF3R3JFMkJIUmJpbkVqNDZkdGsKPW1qaGwKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============7802176643109837206==--

