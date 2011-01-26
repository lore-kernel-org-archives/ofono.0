Content-Type: multipart/mixed; boundary="===============8046066946977879576=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] Support for pkg-config
Date: Wed, 26 Jan 2011 12:27:23 +0100
Message-ID: <1296041243.1520.128.camel@aeonflux>
In-Reply-To: <1296040172-19180-2-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8046066946977879576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  .gitignore   |    1 +
>  Makefile.am  |    3 +++
>  configure.ac |    2 +-
>  ofono.pc.in  |   10 ++++++++++
>  4 files changed, 15 insertions(+), 1 deletions(-)
>  create mode 100644 ofono.pc.in
> =

> diff --git a/.gitignore b/.gitignore
> index 7cfb1d9..59308be 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -20,6 +20,7 @@ install-sh
>  libtool
>  ltmain.sh
>  missing
> +ofono.pc
>  stamp-h1
>  autom4te.cache

please put ofono.pc on top of include/ofono line.
 =

> diff --git a/Makefile.am b/Makefile.am
> index 71365d7..3b29d19 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -21,6 +21,9 @@ local_headers =3D $(foreach file,$(pkginclude_HEADERS) \
>  				$(nodist_pkginclude_HEADERS), \
>  					include/ofono/$(notdir $(file)))
>  =

> +pkgconfigdir =3D $(libdir)/pkgconfig
> +pkgconfig_DATA =3D ofono.pc
> +
>  =

>  if DATAFILES
>  dbusconfdir =3D @DBUS_CONFDIR@
> diff --git a/configure.ac b/configure.ac
> index b034ff0..d26b64f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -226,4 +226,4 @@ fi
>  AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
>  			[Directory for the configuration files])
>  =

> -AC_OUTPUT(Makefile include/version.h src/ofono.service)
> +AC_OUTPUT(Makefile include/version.h src/ofono.service ofono.pc)
> diff --git a/ofono.pc.in b/ofono.pc.in
> new file mode 100644
> index 0000000..19f12e6
> --- /dev/null
> +++ b/ofono.pc.in
> @@ -0,0 +1,10 @@
> +prefix=3D@prefix@
> +exec_prefix=3D@exec_prefix@
> +libdir=3D@libdir@
> +plugindir=3D${libdir}/@PACKAGE@/plugins

Please remove plugindir in a separate paragraph.

> +includedir=3D@includedir@
> +
> +Name: oFono

This needs to be all lowercase. So just ofono.

> +Description: oFono - Open Source Telephony
> +Version: @VERSION@

You are missing the Libs: and Requires: line here.

> +Cflags: -I${includedir}

Something like this should do it:

prefix=3D@prefix@
exec_prefix=3D@exec_prefix@
libdir=3D@libdir@
includedir=3D@includedir@
 =

plugindir=3D${libdir}/@PACKAGE@/plugins

Name: @PACKAGE@
Description: oFono - Open Source Telephony
Requires: glib-2.0 dbus-1
Version: @VERSION@
Libs: -module -avoid-version -export-symbols-regex @PACKAGE(a)_plugin_desc
Cflags: -I${includedir}

Otherwise you are a bit out of luck when building external plugins.

Regards

Marcel



--===============8046066946977879576==--

