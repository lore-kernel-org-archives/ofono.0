Content-Type: multipart/mixed; boundary="===============6556993005414554301=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] ste: Add support for multiple pdp contexts.
Date: Tue, 08 Feb 2011 07:42:01 -0800
Message-ID: <1297179721.1520.454.camel@aeonflux>
In-Reply-To: <1297163846-27817-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6556993005414554301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

> diff --git a/plugins/ste.c b/plugins/ste.c
> index cf8aed8..749c4f3 100644
> --- a/plugins/ste.c
> +++ b/plugins/ste.c
> @@ -66,6 +66,7 @@
>  #include <drivers/stemodem/if_caif.h>
>  =

>  #define NUM_CHAT	1
> +#define MAX_PDP_CONTEXTS	4
>  =

>  static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
>  =

> @@ -363,6 +364,7 @@ static void ste_post_online(struct ofono_modem *modem)
>  	struct ofono_message_waiting *mw;
>  	struct ofono_gprs *gprs;
>  	struct ofono_gprs_context *gc;
> +	int i;
>  =

>  	DBG("%p", modem);
>  =

> @@ -378,13 +380,18 @@ static void ste_post_online(struct ofono_modem *mod=
em)
>  =

>  	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_MBM,
>  					"atmodem", data->chat);
> -	gc =3D ofono_gprs_context_create(modem, 0, "stemodem", data->chat);
> -
> -	if (gprs && gc)
> -		ofono_gprs_add_context(gprs, gc);
> +	if (gprs) {
> +		for (i =3D 0; i < MAX_PDP_CONTEXTS; i++) {
> +			gc =3D ofono_gprs_context_create(
> +					modem, 0, "stemodem", data->chat);
> +			if (gc =3D=3D NULL)
> +				break;
> +
> +			ofono_gprs_add_context(gprs, gc);
> +		}
> +	}

you do not need to create the GPRS context atom multiple times. You can
just add the gc multiple times.

So I just wanna make sure that you guys wanna have multiple GPRS context
atom instances. For things like PPP and RawIP we have no other choice,
but for example ISI is a bit more flexible here. That is the reason why
we do allow it. Maybe CAIF is as flexible.

It is a bit question about resources that are used. I am fine either
way, but I need you to at least think about it ;)

Regards

Marcel



--===============6556993005414554301==--

