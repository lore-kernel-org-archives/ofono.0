Content-Type: multipart/mixed; boundary="===============7660350554096676328=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH phonesim v2 1/8] Port to qt5
Date: Tue, 29 Oct 2019 11:06:12 -0500
Message-ID: <2cc8ae14-7914-cffc-ff8a-9826cef7c123@gmail.com>
In-Reply-To: <20191027163009.13406-2-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7660350554096676328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonah,

On 10/27/19 11:30 AM, Jonah Br=C3=BCchert wrote:
> From: Simon Busch <morphis@gravedo.de>
> =

> Signed-off-by: Simon Busch <morphis@gravedo.de>
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>

We don't use Signed-off-by, so please drop this in the future.

> ---
>   Makefile.am         | 2 +-
>   configure.ac        | 6 +++---
>   src/control.cpp     | 4 ++--
>   src/qsimcommand.cpp | 2 +-
>   src/qsmsmessage.cpp | 2 +-
>   5 files changed, 8 insertions(+), 8 deletions(-)
> =


In general we prefer the commits to be separated out between build =

changes and actual code changes.

> diff --git a/Makefile.am b/Makefile.am
> index 2a6fccf..8c99b04 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -46,7 +46,7 @@ nodist_src_phonesim_SOURCES =3D src/ui_controlbase.h \
> =

>   src_phonesim_LDADD =3D $(QT_LIBS)
> =

> -AM_CXXFLAGS =3D -Wall $(QT_CFLAGS)
> +AM_CXXFLAGS =3D -Wall $(QT_CFLAGS) -fPIC -fPIE

You set -fPIE here but remove it in patch 6.  Do you want to squash =

these two together?

> =

>   AM_CPPFLAGS =3D -I$(top_srcdir)/src -I$(top_builddir)/src
> =


Regards,
-Denis
--===============7660350554096676328==--

