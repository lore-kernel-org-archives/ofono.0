Content-Type: multipart/mixed; boundary="===============8384437130739528346=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] Use dist_ prefix as applicable
Date: Wed, 26 Jan 2011 11:23:05 +0100
Message-ID: <1296037385.1520.106.camel@aeonflux>
In-Reply-To: <1295873450-5891-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8384437130739528346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  Makefile.am |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index f941a19..1f09c11 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -25,17 +25,17 @@ local_headers =3D $(foreach file,$(pkginclude_HEADERS=
) \
>  if DATAFILES
>  dbusconfdir =3D @DBUS_CONFDIR@
>  =

> -dbusconf_DATA =3D src/ofono.conf
> +dist_dbusconf_DATA =3D src/ofono.conf

so I ran all dist tests on my systems and run the whole build check
process that I am normally running. I can not find any problem with it.

Maybe previously I was using a broken automake version or something like
that. So I am fine with this patch ...

>  if SYSTEMD
>  systemdunitdir =3D @SYSTEMD_UNITDIR@
>  =

> -systemdunit_DATA =3D src/ofono.service
> +dist_systemdunit_DATA =3D src/ofono.service
>  endif

... however this part is wrong. It is an ofono.service.in file. So
please leave this part out.

> -EXTRA_DIST =3D src/genbuiltin $(conf_files) $(udev_files) \
> +EXTRA_DIST =3D src/genbuiltin $(udev_files) \
>  					$(doc_files) $(test_scripts)

And these fit into one line now. So just put everything in one line.

Regards

Marcel



--===============8384437130739528346==--

