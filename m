Content-Type: multipart/mixed; boundary="===============9033341523748792356=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 1/7] plugins/ste: Include STK support from MBM driver.
Date: Mon, 16 Aug 2010 22:44:12 +0200
Message-ID: <1281991452.23399.42.camel@localhost.localdomain>
In-Reply-To: <1281990950-21705-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9033341523748792356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > ... The build system builds the plugins
> > properly and you can cross reference modem drivers from your modem
> > plugin without any problems.
> =

> Simply refering to MBM driver from ste.c
> =

>  plugins/ste.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/ste.c b/plugins/ste.c
> index f3ae0b2..9cb49d3 100644
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
> +	ofono_stk_create(modem, 0, "mbmmodem", data->chat);
>  	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
>  =

>  	if (gprs && gc)

one minor nitpick here. Can you please not squeeze this in between GPRS
and GPRS Context atoms. Put it at the same location the MBM plugin does.

Regards

Marcel



--===============9033341523748792356==--

