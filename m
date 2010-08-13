Content-Type: multipart/mixed; boundary="===============7861189990450810506=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] stemodem: Add support for STK.
Date: Fri, 13 Aug 2010 13:13:33 -0500
Message-ID: <4C658B4D.6030605@gmail.com>
In-Reply-To: <1281696794-10891-3-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7861189990450810506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> diff --git a/plugins/ste.c b/plugins/ste.c
> index f3ae0b2..ab48e18 100644
> --- a/plugins/ste.c
> +++ b/plugins/ste.c
> @@ -54,6 +54,7 @@
>  #include <ofono/voicecall.h>
>  #include <ofono/gprs.h>
>  #include <ofono/gprs-context.h>
> +#include <ofono/stk.h>
>  #include <drivers/atmodem/vendor.h>
>  =

>  #include <drivers/stemodem/caif_socket.h>
> @@ -241,6 +242,7 @@ static void ste_post_sim(struct ofono_modem *modem)
>  =

>  	gprs =3D ofono_gprs_create(modem,
>  			OFONO_VENDOR_STE, "atmodem", data->chat);
> +	ofono_stk_create(modem, 0, "stemodem", data->chat);
>  	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
>  =

>  	if (gprs && gc)

If this is indeed just a copy of the mbm driver, can't you simply do
this part and use ofono_stk_create(modem, 0, "mbmmodem", data->chat) ?

It seems wasteful to copy parts around.

Regards,
-Denis

--===============7861189990450810506==--

