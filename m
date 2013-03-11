Content-Type: multipart/mixed; boundary="===============6865126309040237132=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 02/13] dundee: Start BlueZ 5 support
Date: Mon, 11 Mar 2013 18:01:39 +0100
Message-ID: <513E0DF3.90200@monom.org>
In-Reply-To: <1362425590-26075-3-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6865126309040237132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

I guess, I am in charge to review your patches. Let's start then :)

Just a nitpick in this one.

On 03/04/2013 08:33 PM, Paulo Borges wrote:
> This patch adds the BlueZ 5 support file for dundee.
> ---
>   Makefile.am     |   16 ++++++++++------
>   dundee/bluez5.c |   37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+), 6 deletions(-)
>   create mode 100644 dundee/bluez5.c
>
> diff --git a/Makefile.am b/Makefile.am
> index ed35988..1748d06 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -756,24 +756,28 @@ endif
>   endif
>
>   if BLUETOOTH
> -if BLUEZ4
>   if DUNDEE
>   sbin_PROGRAMS +=3D dundee/dundee
>
> -dundee_dundee_SOURCES =3D $(gdbus_sources) $(gatchat_sources) $(btio_sou=
rces) \
> -			src/log.c src/dbus.c plugins/bluez4.c \
> -			dundee/dundee.h dundee/main.c dundee/dbus.c \
> -			dundee/manager.c dundee/device.c dundee/bluez4.c
> +dundee_common_sources =3D $(gdbus_sources) $(gatchat_sources) \
> +			src/log.c src/dbus.c dundee/dundee.h dundee/main.c \
> +			dundee/dbus.c dundee/manager.c dundee/device.c
>
>   dundee_dundee_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -ldl
>
>   if DATAFILES
>   dist_dbusconf_DATA +=3D dundee/dundee.conf
> -
>   if SYSTEMD
>   systemdunit_DATA +=3D dundee/dundee.service
>   endif
>   endif

The line removal seems not necessary.

cheers,
daniel

--===============6865126309040237132==--

