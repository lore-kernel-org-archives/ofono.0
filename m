Content-Type: multipart/mixed; boundary="===============8014206097023336929=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Build Breakage
Date: Wed, 19 Aug 2009 19:59:37 -0500
Message-ID: <200908191959.39030.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8014206097023336929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The latest gisi changes break the build:

pep.c: In function =E2=80=98g_isi_pep_create=E2=80=99:
pep.c:80: error: =E2=80=98SOCK_NONBLOCK=E2=80=99 undeclared (first use in t=
his function)
pep.c:80: error: (Each undeclared identifier is reported only once
pep.c:80: error: for each function it appears in.)
pep.c:80: error: =E2=80=98SOCK_CLOEXEC=E2=80=99 undeclared (first use in th=
is function)
make[2]: *** [pep.lo] Error 1
make[1]: *** [all-recursive] Error 1

SOCK_NONBLOCK and SOCK_CLOEXEC are only available on kernel >=3D 2.6.28 & g=
libc =

>=3D 2.9.  I know this is hardly bleeding edge, but oFono should continue =

working with older systems.  Perhaps a --disable-isi configure option is =

_really_ in order?

Regards,
-Denis

--===============8014206097023336929==--

