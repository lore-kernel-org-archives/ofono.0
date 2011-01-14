Content-Type: multipart/mixed; boundary="===============9167211881547363974=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 2/2] plugins: add ctm create to ifx plugin
Date: Fri, 14 Jan 2011 01:15:00 +0100
Message-ID: <1294964100.3873.109.camel@aeonflux>
In-Reply-To: <1294929082-19792-3-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9167211881547363974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>  plugins/ifx.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index c0a69c2..08b0001 100644
> --- a/plugins/ifx.c
> +++ b/plugins/ifx.c
> @@ -57,6 +57,7 @@
>  #include <ofono/radio-settings.h>
>  #include <ofono/audio-settings.h>
>  #include <ofono/stk.h>
> +#include <ofono/ctm.h>
>  #include <ofono/log.h>
>  =

>  #include <drivers/atmodem/atutil.h>
> @@ -700,6 +701,7 @@ static void ifx_post_sim(struct ofono_modem *modem)
>  =

>  	DBG("%p", modem);
>  =

> +	ofono_ctm_create(modem, 0, "ifxmodem", data->dlcs[AUX_DLC]);

so no emergency calls with CTM are possible? Or do we have to
potentially also handle that?

Regards

Marcel



--===============9167211881547363974==--

