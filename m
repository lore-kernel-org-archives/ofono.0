Content-Type: multipart/mixed; boundary="===============5542353572644614866=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: ofono fails to compile on gcc-6.3
Date: Tue, 04 Sep 2018 11:44:16 +0200
Message-ID: <20180904094416.GA17297@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5542353572644614866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I'm getting this:

  CC       drivers/rilmodem/network-registration.o
  drivers/rilmodem/network-registration.c:40:32: error: unknown option
  after =E2=80=98#pragma GCC diagnostic=E2=80=99 kind [-Werror=3Dpragmas]
   #pragma GCC diagnostic ignored "-Wrestrict"
cc1: error: unrecognized command line option =E2=80=98-Wno-format-truncatio=
n=E2=80=99
  [-Werror]
  cc1: all warnings being treated as errors

I commented out #pragma, and this allows compilation to
continue... until I hit same issue in
drivers/rilmodem/call-forwarding.c:41:32:

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5542353572644614866==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsdU9VL0FBQ2drUU1PZndhcFhiK3ZLNk53Q2dyWWVkUTBtMU5QNGZWSHFyMEVVaFZ6REgK
Yyt3QW5SczhaWmZnVkt2NS9ZcS9QaUgyMkFqYTJ1Y00KPWxxTXAKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5542353572644614866==--

