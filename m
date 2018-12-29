Content-Type: multipart/mixed; boundary="===============5600524913905775535=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Motorola motmdm support
Date: Sat, 29 Dec 2018 23:08:56 +0100
Message-ID: <20181229220856.GA28688@amd>
In-Reply-To: <e959006f-5f8d-8d25-b9d2-dbbcb6a5b073@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5600524913905775535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

And thanks for a quick replies.

> >There's qmi and "normal" (but very buggy) AT interface on
> >them. Unfortunately that uses USB and uses too much power (which is a
> >problem on phone).
> >
> >Plus there's /dev/motmdm1, motmdm3 and motmdm9, multiplexed over
> >serial line.
> =

> Kernel 27.010 multiplexer or something else entirely?

Kernel 27.010 multiplexer, AFAICT. Some of the endpoints are handled
in kernel (gps, audio mixer control).

> >Other major difference is that commands need to be sent to the right
> >device. It seems motmdm1 is for status and call control, and motmdm9
> >is for incoming sms.
> >
> >I guess that right way to do this is to introduce
> >drivers/motorolamodem (or can we just have drivers/motorola?).
> =

> For some weird historic reason we called the atom drivers and thus the
> subdirectory housing the relevant sources with the 'modem' suffix.  So I
> guess we should stick to that just to be consistent.

Ok.

One more question: I guess I'll need to implement this... Is there
another example of driver doing AT commands but on multiple file
descriptors? I could really use something to look at as a template.. =


Thanks,

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5600524913905775535==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd244SGdBQ2drUU1PZndhcFhiK3ZJQmVnQ2ZWQjA2eFZmREptaFdmaFkzNjZDYXYxd3gK
S3MwQW9LYzNlUS9mK0ZqeVdPbVpRWGxnK2YyRTRnbjIKPWdyeGgKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5600524913905775535==--

