Content-Type: multipart/mixed; boundary="===============6027926541928860483=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] bluetooth: make bluetooth.c not a plugin
Date: Mon, 21 Jun 2010 22:59:04 -0500
Message-ID: <201006212259.04384.denkenz@gmail.com>
In-Reply-To: <1277023884-27143-6-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6027926541928860483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> ---
>  Makefile.am         |    7 ++++---
>  plugins/bluetooth.c |    2 --
>  2 files changed, 4 insertions(+), 5 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 96116a5..d51d6db 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -71,6 +71,9 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c=
 \
>  				gatchat/ppp_auth.c gatchat/ppp_net.c \
>  				gatchat/ppp_ipcp.c
> =

> +bluetooth_sources =3D plugins/bluetooth.c plugins/bluetooth.h
> +
> +
>  udev_files =3D plugins/ofono.rules
> =

>  if UDEV
> @@ -133,6 +136,7 @@ endif
>  if ATMODEM
>  builtin_modules +=3D atmodem
>  builtin_sources +=3D $(gatchat_sources) \
> +				$(bluetooth_sources) \

This seems really wrong, ATMODEM has nothing to do with bluetooth.

Is it possible to break bluetooth.c library out completely, similar to =

GAtChat?  Do you feel there'll be enough shared between dun/hfp/sap to do s=
o?

Regards,
-Denis

--===============6027926541928860483==--

