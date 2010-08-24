Content-Type: multipart/mixed; boundary="===============1502976844593182489=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [online PATCH 5/9] nokia: implement Online property
Date: Tue, 24 Aug 2010 18:21:32 +0200
Message-ID: <1282666892.6841.21.camel@localhost.localdomain>
In-Reply-To: <1282649524-31353-6-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1502976844593182489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  plugins/nokia.c |   32 +++++++++++++++++++++++++++++---
>  1 files changed, 29 insertions(+), 3 deletions(-)
> =

> diff --git a/plugins/nokia.c b/plugins/nokia.c
> index b7db2cc..f185d00 100644
> --- a/plugins/nokia.c
> +++ b/plugins/nokia.c
> @@ -45,6 +45,7 @@
>  #include <ofono/log.h>
>  =

>  #include <drivers/atmodem/vendor.h>
> +#include <drivers/atmodem/atutil.h>
>  =

>  static const char *none_prefix[] =3D { NULL };
>  =

> @@ -181,7 +182,7 @@ static int nokia_enable(struct ofono_modem *modem)
>  	g_at_chat_send(data->control, "ATE0 +CMEE=3D1", none_prefix,
>  						NULL, NULL, NULL);
>  =

> -	g_at_chat_send(data->control, "AT+CFUN=3D1", none_prefix,
> +	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
>  					cfun_enable, modem, NULL);
>  =


I have to test this one. This modem is so crappy it is not funny
anymore. It most likely contains the most buggy Qualcomm firmware I have
seen so far :(

Regards

Marcel



--===============1502976844593182489==--

