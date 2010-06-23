Content-Type: multipart/mixed; boundary="===============8479586129658015677=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] mbmmodem: Fix ip netmask should be 255.255.255.255
Date: Wed, 23 Jun 2010 08:58:23 +0200
Message-ID: <1277276303.2301.174.camel@localhost.localdomain>
In-Reply-To: <1277255191-1335-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8479586129658015677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Change static IP netmask to 255.255.255.255.
> ---
>  drivers/mbmmodem/gprs-context.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-cont=
ext.c
> index cca5087..2d0e4e2 100644
> --- a/drivers/mbmmodem/gprs-context.c
> +++ b/drivers/mbmmodem/gprs-context.c
> @@ -48,7 +48,7 @@
>  =

>  #define MAX_DNS 5
>  =

> -#define STATIC_IP_NETMASK "255.255.255.248"
> +#define STATIC_IP_NETMASK "255.255.255.255"
>  =

>  static const char *none_prefix[] =3D { NULL };
>  static const char *e2ipcfg_prefix[] =3D { "*E2IPCFG:", NULL };

did you see a problem with this or why do you propose this change. The
old f35xx gives this netmask back when using DHCP. What does the f36xx
and later return when using DHCP?

Regards

Marcel



--===============8479586129658015677==--

