Content-Type: multipart/mixed; boundary="===============9131030911251071409=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Trouble compiling ... Re: ofono fails to compile on gcc-6.3
Date: Sat, 29 Dec 2018 10:53:22 +0100
Message-ID: <20181229095322.GB15358@amd>
In-Reply-To: <20180904094416.GA17297@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9131030911251071409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue 2018-09-04 11:44:16, Pavel Machek wrote:

commit f13047bf9334795b89b09fef3a051e7dfbe207f2
Author: Denis Kenzior <denkenz@gmail.com>
Date:   Thu Dec 27 18:19:31 2018 -0600

    stktest: Fix immediate response test

I have updated to recent ofono -- and the problem is still there: =


> =

>   CC       drivers/rilmodem/network-registration.o
>   drivers/rilmodem/network-registration.c:40:32: error: unknown option
>   after =E2=80=98#pragma GCC diagnostic=E2=80=99 kind [-Werror=3Dpragmas]
>    #pragma GCC diagnostic ignored "-Wrestrict"
> cc1: error: unrecognized command line option =E2=80=98-Wno-format-truncat=
ion=E2=80=99
>   [-Werror]
>   cc1: all warnings being treated as errors
> =

> I commented out #pragma, and this allows compilation to
> continue... until I hit same issue in
> drivers/rilmodem/call-forwarding.c:41:32:

Plus there's new one:
  CC       drivers/rilmodem/sim.o
  drivers/rilmodem/sim.c: In function =E2=80=98ril_file_io_cb=E2=80=99:
  drivers/rilmodem/sim.c:381:49: warning: passing argument 2 of
  =E2=80=98l_util_from_hexstring=E2=80=99 from incompatible pointer type
    response =3D l_util_from_hexstring(hex_response, &len);
                                                     ^
						     In file included
  from ./ell/ell.h:1:0,
                   from drivers/rilmodem/sim.c:34:
		   ./ell/util.h:271:16: note: expected =E2=80=98size_t *=E2=80=99 but
  argument is of type =E2=80=98long int *=E2=80=99
   unsigned char *l_util_from_hexstring(const char *str, size_t
  *out_len);
                  ^
		  drivers/rilmodem/sim.c: At top level:
		  cc1: warning: unrecognized command line option
  "-Wno-format-truncation"
    CC       drivers/rilmodem/ussd.o
      CC       drivers/rilmodem/call-forwarding.o
      drivers/rilmodem/call-forwarding.c:40:9: warning: unknown option
  after =E2=80=98#pragma GCC diagnostic=E2=80=99 kind [-Wpragmas]
   #pragma GCC diagnostic ignored "-Wrestrict"
            ^
	    cc1: warning: unrecognized command line option
  "-Wno-format-truncation"
  =

Oh and... the ell thing is a trap, ending in compile error. It would
be nice to test for ../ell directory at configure time.
  =

Best regards,
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============9131030911251071409==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd25SQklBQ2drUU1PZndhcFhiK3ZLQUhBQ2ZkZjhHZnhkbGdWZ2pYRDFYZ1lMYU5rWTUK
T2hzQW5pVUFBL2RiZVo5SnNEYUVDZUI0T2t5VjdNem8KPUhhdGYKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============9131030911251071409==--

