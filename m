Content-Type: multipart/mixed; boundary="===============9086869904808279981=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2] atmodem: Fix crash on context activation.
Date: Thu, 10 May 2012 17:43:37 +0200
Message-ID: <4FABE229.8020402@linux.intel.com>
In-Reply-To: <1334581740-6681-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9086869904808279981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 16/04/2012 15:09, Guillaume Zajac wrote:
> Shutdown PPP session if modem did not do it.
> ---
>   drivers/atmodem/gprs-context.c |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-contex=
t.c
> index 16893ce..100c80b 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -239,6 +239,17 @@ static void at_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
>   	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
>   	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
>
> +	/*
> +	 * For some modem, mainly Huawei branded, when GPRS is no more attached
> +	 * to the network, oFono core will reset context although the modem
> +	 * has not ended ppp sesssion at driver level.
> +	 * In this case trigger a disconnection manually and send an error.
> +	 */
> +	if (gcd->ppp !=3D NULL&&  gcd->state =3D=3D STATE_ACTIVE) {
> +		g_at_ppp_shutdown(gcd->ppp);
> +		goto error;
> +	}
> +
>   	gcd->state =3D STATE_ENABLING;
>
>   	if (gcd->vendor =3D=3D OFONO_VENDOR_ZTE) {

Do you have any feedback on this fix?

Thanks.

Kind regards,
Guillaume

--===============9086869904808279981==--

