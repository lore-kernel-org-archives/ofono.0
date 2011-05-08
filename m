Content-Type: multipart/mixed; boundary="===============6588635146084606987=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] Fix primary context active/deactive result d-bus
 reply missing issue
Date: Sun, 08 May 2011 11:06:16 -0500
Message-ID: <4DC6BF78.7070004@gmail.com>
In-Reply-To: <1303887867-6467-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6588635146084606987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 04/27/2011 02:04 AM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> If user offline modem when the gprs_context is in enabling or disabling
> state(activating/disactivating), the GPRS primary context activate/disact=
ivate
> result will not be replied to the corresponding application.
> ---
>  drivers/atmodem/gprs-context.c |    7 +++++++
>  src/gprs.c                     |    5 +++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-contex=
t.c
> index ba95cbf..bfbd2c5 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -301,6 +301,13 @@ static void at_gprs_context_remove(struct ofono_gprs=
_context *gc)
>  =

>  	if (gcd->state !=3D STATE_IDLE && gcd->ppp) {
>  		g_at_ppp_unref(gcd->ppp);
> +
> +		if (gcd->state =3D=3D STATE_ENABLING)
> +			CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
> +
> +		if (gcd->state =3D=3D STATE_DISABLING)
> +			CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> +

The biggest problem with doing it this way is that the context's
unregister function has already been called.  When this is called we're
actually in the process of removing the context, hence why you require
the hacks in the core below.  We also don't emit the PropertyChanged
signal properly if we do it this way.

There might be a couple ways to fix this:

- Make a specific remove function for the ppp context driver.  This will
call the callbacks as you do above and then remove the driver.

- Handle all of this inside the core.

>  		g_at_chat_resume(gcd->chat);
>  	}
>  =

> diff --git a/src/gprs.c b/src/gprs.c
> index deffeb8..99cb55d 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -351,6 +351,9 @@ static struct pri_context *gprs_context_by_path(struc=
t ofono_gprs *gprs,
>  =

>  static void context_settings_free(struct context_settings *settings)
>  {
> +	if (settings =3D=3D NULL)
> +		return;
> +
>  	if (settings->ipv4) {
>  		g_free(settings->ipv4->ip);
>  		g_free(settings->ipv4->netmask);
> @@ -736,6 +739,8 @@ static void pri_reset_context_settings(struct pri_con=
text *ctx)
>  		return;
>  =

>  	settings =3D ctx->context_driver->settings;
> +	if (settings =3D=3D NULL)
> +		return;
>  =

>  	interface =3D settings->interface;
>  	settings->interface =3D NULL;

Regards,
-Denis

--===============6588635146084606987==--

