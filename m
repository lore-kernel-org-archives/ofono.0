Content-Type: multipart/mixed; boundary="===============5627310597918118844=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Droid 4 modem support in kernel & ofono
Date: Fri, 01 Feb 2019 21:36:16 +0100
Message-ID: <20190201203616.GA2087@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5627310597918118844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

Ok, so I got calls and smses somehow working in kernel&ofono ... which
is really all I need.

I pushed the tree to git(a)github.com:pavelmachek/ofono.git , branch
d4... But I had to do some "rather interesting" hacks. D4 modem
expects packets and current kernel drivers rely on write() boundaries
and flush(). .. which is a bit of problem for in ofonod, as it expects
to work with bytestream with no explicit packet boundaries.

However D4 still uses normal AT commands, so... it would be good to be
able to use AT parsing framework in ofono.

I believe easiest solution would be to automatically do the packet
splitting in kernel, it should be as easy as splitting on \r and
^Z. (Currently packets are only generated when \r or ^Z is seen on
write boundary, but that does not work well for ofono).

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5627310597918118844==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseFVyYjhBQ2drUU1PZndhcFhiK3ZMOURRQ2dyNHV2eHIreWdaNlUvellMb2dlUXFkVjMK
NkFJQW4wbFd6dWFlOGY1SXJRUVdmUHAyV0ZQM0hlMHAKPUNxV1EKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5627310597918118844==--

