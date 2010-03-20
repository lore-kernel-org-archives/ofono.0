Content-Type: multipart/mixed; boundary="===============6989507305494447273=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 6/6] Allow gsmdial to use gatchat ppp support
Date: Sat, 20 Mar 2010 16:35:42 +0100
Message-ID: <1269099342.2700.181.camel@localhost.localdomain>
In-Reply-To: <20100319124630.14d5ddc6@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6989507305494447273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> Add option to use PPP to gsmdial.
> =

> ---
>  gatchat/gsmdial.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++--
>  1 file changed, 87 insertions(+), 3 deletions(-)
> =

> Index: ofono/gatchat/gsmdial.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ofono.orig/gatchat/gsmdial.c	2010-03-19 12:28:11.725601078 -0700
> +++ ofono/gatchat/gsmdial.c	2010-03-19 12:43:54.427612839 -0700
> @@ -29,10 +29,14 @@
>  #include <errno.h>
>  #include <unistd.h>
>  #include <sys/signalfd.h>
> +#include <arpa/inet.h>
> +#include <netinet/in.h>
> +#include <net/if.h>

patches have to be always submitted against the latest tree.

Regards

Marcel



--===============6989507305494447273==--

