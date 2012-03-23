Content-Type: multipart/mixed; boundary="===============6066066965651026347=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/3] let configure find required libs
Date: Fri, 23 Mar 2012 12:11:53 -0700
Message-ID: <1332529913.1870.60.camel@aeonflux>
In-Reply-To: <1330417045-26518-3-git-send-email-jr_extern@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6066066965651026347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

>  Makefile.am  |    2 +-
>  configure.ac |   24 +++++++++++++++++-------
>  2 files changed, 18 insertions(+), 8 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index bebcb90..178def4 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -28,7 +28,7 @@ src_mmsd_SOURCES =3D $(gdbus_sources) $(gweb_sources) $=
(builtin_sources) \
>  			src/push.h src/push.c src/store.h src/store.c \
>  			src/wsputil.h src/wsputil.c src/mmsutil.h src/mmsutil.c
>  =

> -src_mmsd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -lresolv -l=
dl
> +src_mmsd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@
>  =

>  src_mmsd_LDFLAGS =3D -Wl,--export-dynamic
>  =

> diff --git a/configure.ac b/configure.ac
> index d82569b..883b59c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -64,15 +64,25 @@ dnl be different for different compiler flags (known =
issue on AIX)
>  LT_INIT([dlopen,disable-static])
>  AC_SUBST([LIBTOOL_DEPS])
>  =

> +dnl check how we can use the resolver. while resolv.h comes with bind,
> +dnl it's probably reasonable to use a combined search macro like
> +dnl smart-snmpd's ACX_CHECK_LIB_FLAGS
>  AC_CHECK_HEADERS(resolv.h, dummy=3Dyes,
>  			AC_MSG_ERROR(resolver header files are required))
> -AC_CHECK_LIB(resolv, ns_initparse, dummy=3Dyes, [
> -	AC_CHECK_LIB(resolv, __ns_initparse, dummy=3Dyes,
> -			AC_MSG_ERROR(resolver library support is required))
> -])
> -
> -AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
> -			AC_MSG_ERROR(dynamic linking loader is required))
> +dnl ns_initparse is libresolv internal use only - limited usage intended?
> +AC_SEARCH_LIBS(ns_initparse, resolv, ,
> +		AC_MSG_ERROR(resolver support is required))
> +dnl AC_CHECK_LIB(resolv, ns_initparse, dummy=3Dyes, [
> +dnl 	AC_CHECK_LIB(resolv, __ns_initparse, dummy=3Dyes,
> +dnl 			AC_MSG_ERROR(resolver library support is required))
> +dnl ])
> +
> +dnl search how we can load dynamic libraries
> +dnl TODO use libltdl, which would work on BeOS (Haiku), Darwin (MacOS X)=
 or
> +dnl      for debugging purposes with libtool's dlpreopen
> +AC_SEARCH_LIBS(dlopen, dl, , AC_MSG_ERROR(dynamic linking loader is requ=
ired))
> +dnl AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
> +dnl 			AC_MSG_ERROR(dynamic linking loader is required))

what is this actually fixing. And all the dnl with dead code need to go
away.

Regards

Marcel



--===============6066066965651026347==--

