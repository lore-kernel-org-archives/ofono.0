Content-Type: multipart/mixed; boundary="===============1786183325326094299=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] changing depreciated libtool initialization to modern
 one
Date: Fri, 23 Mar 2012 12:09:49 -0700
Message-ID: <1332529789.1870.58.camel@aeonflux>
In-Reply-To: <4F4CFDAE.1090604@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1786183325326094299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

> >  Makefile.am  |    4 ++++
> >  configure.ac |   10 ++++++++--
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> > =

> > diff --git a/Makefile.am b/Makefile.am
> > index c3a4486..bebcb90 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -1,6 +1,10 @@
> >  =

> >  AM_MAKEFLAGS =3D --no-print-directory
> >  =

> > +LIBTOOL_DEPS =3D @LIBTOOL_DEPS@
> > +libtool: $(LIBTOOL_DEPS)
> > +	$(SHELL) ./config.status libtool
> > +
> >  gdbus_sources =3D gdbus/gdbus.h gdbus/mainloop.c gdbus/watch.c \
> >  					gdbus/object.c gdbus/polkit.c
> >  =

> > diff --git a/configure.ac b/configure.ac
> > index 34cc526..d82569b 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -31,8 +31,8 @@ AC_PROG_INSTALL
> >  m4_define([_LT_AC_TAGCONFIG], [])
> >  m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
> >  =

> > -AC_DISABLE_STATIC
> > -AC_PROG_LIBTOOL
> > +dnl AC_DISABLE_STATIC
> > +dnl AC_PROG_LIBTOOL
> >  =

> >  AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization],
> >  			[disable code optimization through compiler]), [
> > @@ -58,6 +58,12 @@ AC_ARG_ENABLE(pie, AC_HELP_STRING([--enable-pie],
> >  	fi
> >  ])
> >  =

> > +dnl LT_INIT should be invoked after all compiler flags checks, because
> > +dnl of LT_INIT remembers the RPATH stored in test targets which might
> > +dnl be different for different compiler flags (known issue on AIX)
> > +LT_INIT([dlopen,disable-static])
> This should be
> +LT_INIT([dlopen disable-static])

please send an updated patch.

Regards

Marcel



--===============1786183325326094299==--

