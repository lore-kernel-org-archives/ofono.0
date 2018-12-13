Content-Type: multipart/mixed; boundary="===============4852673580283728951=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Thu, 13 Dec 2018 23:06:28 +0100
Message-ID: <20181213220628.GA3237@amd>
In-Reply-To: <20181213220145.GA28696@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4852673580283728951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu 2018-12-13 23:01:45, Pavel Machek wrote:
> Hi!
> =

> > If a firmware crashes on a device with a PIN lock and the user was brow=
sing
> > the internet at that time, it would be quite intrusive to interrupt the=
 user
> > and prompt them for a PIN (after all, they already entered the PIN).
> > Additionally, if the PIN was stored for just this case and the firmware
> > reboots fast enough, a crash might not even be noticed by the user at a=
ll.
> > Now one can argue that the firmware shouldn't crash, and I agree, but
> > realistically the chances of that never happening are NIL.
> =

> Can I have another scenario?
> =

> User is waiting for important call, phone in his pocket, expecting it
> to ring. Firmware crashes, reboots... and asks for a PIN.
> =

> When the important call comes, phone is not available... as it is
> waiting for PIN...

And when user realizes what happened, he disables the PIN on his SIM
card. When his phone is stolen, thief is able to do many expensive
calls on his account...

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============4852673580283728951==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd1MxK1FBQ2drUU1PZndhcFhiK3ZKNmFBQ2dnbGpoNGRWNitRVEJRa0g1UlBRREZNck0K
YW9BQW5BNlNIN3dYTGQwRkt1T2lBWGVJZXlCSDNTbU0KPTI0VDQKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============4852673580283728951==--

