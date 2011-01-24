Content-Type: multipart/mixed; boundary="===============5246866108761555740=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] Use dist_ prefix as applicable
Date: Tue, 25 Jan 2011 00:17:16 +0100
Message-ID: <1295911036.1520.7.camel@aeonflux>
In-Reply-To: <1295873450-5891-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5246866108761555740==
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

there was a reason why I did not do this. I need to figure out what it
was or if it is something that doesn't apply to ofono.git tree.

Regards

Marcel



--===============5246866108761555740==--

