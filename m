Content-Type: multipart/mixed; boundary="===============4657537190979688982=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 01/10] gprs: avoid useless loop iteration
Date: Mon, 10 Jan 2011 16:36:57 -0800
Message-ID: <1294706217.3873.6.camel@aeonflux>
In-Reply-To: <1294665325-11937-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4657537190979688982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  src/gprs.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index 58166f8..8afaffb 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1991,12 +1991,12 @@ void ofono_gprs_context_deactivated(struct ofono_=
gprs_context *gc,
>  	for (l =3D gc->gprs->contexts; l; l =3D l->next) {
>  		ctx =3D l->data;
>  =

> -		if (ctx->active =3D=3D FALSE)
> -			continue;
> -
>  		if (ctx->context.cid !=3D cid)
>  			continue;
>  =

> +		if (ctx->active =3D=3D FALSE)
> +			break;
> +

I don't expect a huge amount of context that this would make a
difference actually, but sure, why not. Patch has been applied.

Regards

Marcel



--===============4657537190979688982==--

