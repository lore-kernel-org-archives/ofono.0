Content-Type: multipart/mixed; boundary="===============4507718929506339728=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Trouble compiling ... Re: ofono fails to compile on gcc-6.3
Date: Sat, 29 Dec 2018 21:30:46 +0100
Message-ID: <20181229203046.GA1949@amd>
In-Reply-To: <53dd54d0-9b4d-739f-ef1c-e0268998b29c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4507718929506339728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >>   CC       drivers/rilmodem/network-registration.o
> >>   drivers/rilmodem/network-registration.c:40:32: error: unknown option
> >>   after =E2=80=98#pragma GCC diagnostic=E2=80=99 kind [-Werror=3Dpragm=
as]
> >>    #pragma GCC diagnostic ignored "-Wrestrict"
> >>cc1: error: unrecognized command line option =E2=80=98-Wno-format-trunc=
ation=E2=80=99
> >>   [-Werror]
> >>   cc1: all warnings being treated as errors
> >>
> >>I commented out #pragma, and this allows compilation to
> >>continue... until I hit same issue in
> >>drivers/rilmodem/call-forwarding.c:41:32:
> =

> Yeah, I'm not sure what to do with these.  Marcel put in the #pragmas to
> silence some warnings on GCC 8.x, but it seems GCC 6 doesn't know about
> these #pragma directives and complains.

/* Test for GCC > 3.2.0 */
#if __GNUC__ > 3 || \
    (__GNUC__ =3D=3D 3 && (__GNUC_MINOR__ > 2 || \
                           (__GNUC_MINOR__ =3D=3D 2 && \
			                           __GNUC_PATCHLEVEL__
						   > 0))
#pragma...
#endif

?

> >Plus there's new one:
> >   CC       drivers/rilmodem/sim.o
> >   drivers/rilmodem/sim.c: In function =E2=80=98ril_file_io_cb=E2=80=99:
> >   drivers/rilmodem/sim.c:381:49: warning: passing argument 2 of
> >   =E2=80=98l_util_from_hexstring=E2=80=99 from incompatible pointer type
> >     response =3D l_util_from_hexstring(hex_response, &len);
> >                                                      ^
> >						     In file included
> >   from ./ell/ell.h:1:0,
> >                    from drivers/rilmodem/sim.c:34:
> >		   ./ell/util.h:271:16: note: expected =E2=80=98size_t *=E2=80=99 but
> >   argument is of type =E2=80=98long int *=E2=80=99
> >    unsigned char *l_util_from_hexstring(const char *str, size_t
> >   *out_len);
> >                   ^
> =

> Ah darn, thought I got them all but seems I missed one.  Should be fixed
> now.

Ok, good.

Would it be possible to get reasonable error message when ell is not
found?

"ell not found, you need to install it, please see README file"? It
took me a while to figure out...

Thanks,

									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============4507718929506339728==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd24yWFlBQ2drUU1PZndhcFhiK3ZKcXVBQ2ZUWjc3S0tGQTVITXY2d3lOckVTMHMyalYK
VTNZQW4xTWZKa0RpNmhTWURHMW03T1RreHhLUVBXVE4KPVJJR3AKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============4507718929506339728==--

