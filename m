Content-Type: multipart/mixed; boundary="===============5921525533218028703=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v1 1/6] Makefile: Add configure option for BlueZ 4 and 5
Date: Tue, 15 Jan 2013 11:01:44 -0800
Message-ID: <1358276504.2445.3.camel@aeonflux>
In-Reply-To: <1358274288-24857-2-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5921525533218028703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

> BlueZ 5 is the default option. If --enable-bluez4 is provided, oFono
> plugins based on BlueZ 4 are enabled prior to BlueZ 5.
> --disable-bluetooth configure option disables BlueZ 5 and BlueZ 4
> plugins.
> ---
>  Makefile.am  |  4 +++-
>  configure.ac | 24 ++++++++++++++++--------
>  2 files changed, 19 insertions(+), 9 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 0d2ba9f..811a3f5 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -407,7 +407,7 @@ builtin_sources +=3D plugins/samsung.c
>  builtin_modules +=3D sim900
>  builtin_sources +=3D plugins/sim900.c
>  =

> -if BLUETOOTH
> +if BLUEZ4
>  builtin_modules +=3D bluetooth
>  builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
>  =

> @@ -742,6 +742,7 @@ tools_stktest_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
>  endif
>  endif
>  =

> +if BLUEZ4
>  if DUNDEE
>  sbin_PROGRAMS +=3D dundee/dundee
>  =

> @@ -759,6 +760,7 @@ if SYSTEMD
>  systemdunit_DATA +=3D dundee/dundee.service
>  endif
>  endif
> +endif
>  =

>  endif
>  =

> diff --git a/configure.ac b/configure.ac
> index 450352b..47b0600 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -173,15 +173,23 @@ AC_ARG_ENABLE(qmimodem, AC_HELP_STRING([--disable-q=
mimodem],
>  AM_CONDITIONAL(QMIMODEM, test "${enable_qmimodem}" !=3D "no")
>  =

>  AC_ARG_ENABLE(bluetooth, AC_HELP_STRING([--disable-bluetooth],
> -				[disable Bluetooth modem support]),
> -					[enable_bluetooth=3D${enableval}])
> -if (test "${enable_bluetooth}" !=3D "no"); then
> -	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.99, dummy=3Dyes,
> -			AC_MSG_ERROR(Bluetooth library >=3D 4.99 is required))
> +				[disable BlueZ 4 and BlueZ 5 plugins support]),
> +					[enable_bluez5=3D${enableval}])
> +
> +AC_ARG_ENABLE(bluez4, AC_HELP_STRING([--enable-bluez4],
> +				[enable BlueZ 4 plugins support prior to BlueZ 5]),
> +					[enable_bluez4=3D${enableval}])
> +
> +if (test "${enable_bluez4}" =3D "yes"); then
> +	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.99 bluez < 5,
> +			  enable_bluez4=3Dyes enable_bluez5=3Dno,
> +			  AC_MSG_ERROR(Bluetooth library >=3D 4.99 and < 5 is required))
> +	AC_SUBST(BLUEZ_CFLAGS)
> +	AC_SUBST(BLUEZ_LIBS)
>  fi
> -AC_SUBST(BLUEZ_CFLAGS)
> -AC_SUBST(BLUEZ_LIBS)
> -AM_CONDITIONAL(BLUETOOTH, test "${enable_bluetooth}" !=3D "no")
> +
> +AM_CONDITIONAL(BLUEZ4, test "${enable_bluez4}" =3D "yes")
> +AM_CONDITIONAL(BLUEZ5, test "${enable_bluez5}" !=3D "no" && test "${enab=
le_bluez4}" !=3D "yes")

can we keep BLUETOOTH conditional for overall Bluetooth enabled/disabled
and just make BLUEZ4 the if-else statement for selecting which one.

Regards

Marcel



--===============5921525533218028703==--

