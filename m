Content-Type: multipart/mixed; boundary="===============6348721017664138008=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: Build Breakage
Date: Thu, 20 Aug 2009 08:55:13 +0200
Message-ID: <41cbd26451d7b85a26b2d45d180424a0@chewa.net>
In-Reply-To: <200908191959.39030.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6348721017664138008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 19 Aug 2009 19:59:37 -0500, Denis Kenzior <denkenz@gmail.com>
wrote:
> The latest gisi changes break the build:
> =

> pep.c: In function =E2=80=98g_isi_pep_create=E2=80=99:
> pep.c:80: error: =E2=80=98SOCK_NONBLOCK=E2=80=99 undeclared (first use in=
 this
> function)
> pep.c:80: error: (Each undeclared identifier is reported only once
> pep.c:80: error: for each function it appears in.)
> pep.c:80: error: =E2=80=98SOCK_CLOEXEC=E2=80=99 undeclared (first use in =
this
> function)
> make[2]: *** [pep.lo] Error 1
> make[1]: *** [all-recursive] Error 1
> =

> SOCK_NONBLOCK and SOCK_CLOEXEC are only available on kernel >=3D 2.6.28 &
> glibc =


kernel <=3D 2.6.27 do not support ISI...

-- =

R=C3=A9mi Denis-Courmont


--===============6348721017664138008==--

