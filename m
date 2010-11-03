Content-Type: multipart/mixed; boundary="===============8383190886909718403=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] Add option to support version
Date: Wed, 03 Nov 2010 08:40:31 +0100
Message-ID: <1288770031.9615.5.camel@aeonflux>
In-Reply-To: <1288767466-12837-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8383190886909718403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

>  Makefile.am  |    2 +-
>  bootstrap    |    2 +-
>  configure.ac |    1 +
>  src/main.cpp |   11 +++++++++--
>  4 files changed, 12 insertions(+), 4 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index f124b08..dd54c42 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -50,7 +50,7 @@ dist_pkgdata_DATA =3D src/default.xml
>  EXTRA_DIST =3D src/controlbase.ui src/GSMSpecification.xml
>  =

>  MAINTAINERCLEANFILES =3D Makefile.in \
> -	aclocal.m4 configure depcomp missing install-sh
> +	aclocal.m4 configure config.h.in depcomp missing install-sh
>  =

> =

>  $(src_phonesim_OBJECTS): src/ui_controlbase.h
> diff --git a/bootstrap b/bootstrap
> index 562c115..05eee20 100755
> --- a/bootstrap
> +++ b/bootstrap
> @@ -1,3 +1,3 @@
>  #!/bin/sh
>  =

> -aclocal && automake --add-missing --copy && autoconf
> +aclocal && autoheader && automake --add-missing --copy && autoconf
> diff --git a/configure.ac b/configure.ac
> index 725ae7e..445a11c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -2,6 +2,7 @@ AC_PREREQ(2.60)
>  AC_INIT(phonesim, 1.8)
>  =

>  AM_INIT_AUTOMAKE([foreign subdir-objects])
> +AM_CONFIG_HEADER(config.h)
>  =

>  m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
>  =

> diff --git a/src/main.cpp b/src/main.cpp
> index d7de416..6a00cb5 100644
> --- a/src/main.cpp
> +++ b/src/main.cpp
> @@ -17,6 +17,10 @@
>  **
>  ************************************************************************=
****/
>  =

> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +

this is not how this works actually. Either you do that in every single
file or you better don't do it at all.

Run "make V=3D1" and you see what are the actual parameters.

depbase=3D`echo src/main.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
g++ -DPACKAGE_NAME=3D\"phonesim\" -DPACKAGE_TARNAME=3D\"phonesim\" -DPACKAG=
E_VERSION=3D\"1.8\" -DPACKAGE_STRING=3D\"phonesim\ 1.8\" -DPACKAGE_BUGREPOR=
T=3D\"\" -DPACKAGE_URL=3D\"\" -DPACKAGE=3D\"phonesim\" -DVERSION=3D\"1.8\" =
-I. -I./src -I./src   -Wall -DQT_SHARED -I/usr/include/QtCore -I/usr/includ=
e/QtGui -I/usr/include/QtXml -I/usr/include/QtNetwork -I/usr/include/QtScri=
pt -I/usr/include/QtDBus   -g -O2 -MT src/main.o -MD -MP -MF $depbase.Tpo -=
c -o src/main.o src/main.cpp &&\
mv -f $depbase.Tpo $depbase.Po

As you can see that it nicely does -DVERSION=3D\"1.8\" actually.

>  #include <server.h>
>  #include "control.h"
>  #include <qapplication.h>
> @@ -28,7 +32,7 @@ static void usage()
>  {
>      qWarning() << "Usage:"
>                 << QFileInfo(QCoreApplication::instance()->applicationFil=
ePath()).fileName().toLocal8Bit().constData()
> -               << "[-p port] [-gui] filename";
> +               << "[-v] [-p port] [-gui] filename";
>      exit(-1);
>  }
>  =

> @@ -43,7 +47,10 @@ int main(int argc, char **argv)
>      // Parse the command-line.
>      index =3D 1;
>      for (index =3D 1; index < argc; index++) {
> -        if (strcmp(argv[index],"-p") =3D=3D 0) {
> +        if (strcmp(argv[index],"-v") =3D=3D 0) {
> +            qWarning() << VERSION;
> +            exit(0);
> +        } else if (strcmp(argv[index],"-p") =3D=3D 0) {
>              index++;
>              if (index >=3D argc) {
>                  qWarning() << "ERROR: Got -p but missing port number";

So this is all you need. And nothing more.

Regards

Marcel



--===============8383190886909718403==--

