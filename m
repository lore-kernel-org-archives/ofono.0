Content-Type: multipart/mixed; boundary="===============2222556636550081665=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Do not detach when running LTE and GPRS is
 unavailable.
Date: Sun, 11 Aug 2019 09:57:28 -0500
Message-ID: <a128be49-4aa7-8f03-1068-708dbd4154b4@gmail.com>
In-Reply-To: <20190811145810.31475-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2222556636550081665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/11/19 9:58 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> There are cases where the gprs status might updated to for instance
> "unknown" while LTE is the bearer.
> In that case we should not set the attach state to FALSE,
> since then running LTE the conext activation reflects the attached
> state.

It might be nice to include a log snippet of how the current behavior =

fails...

> ---
>   src/gprs.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index 9cb69d14..1a9b234d 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1660,6 +1660,15 @@ static void gprs_netreg_removed(struct ofono_gprs =
*gprs)
>   	gprs_attached_update(gprs);
>   }
>   =

> +static gboolean expect_lte_context_auto_activation(struct ofono_gprs *gp=
rs)

I'm not thrilled about the name?  Isn't this just 'on_lte?' or something =

like that?

> +{
> +	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
> +			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
> +		return TRUE;
> +
> +	return FALSE;
> +}
> +
>   static void gprs_netreg_update(struct ofono_gprs *gprs)
>   {
>   	ofono_bool_t attach;
> @@ -1682,8 +1691,7 @@ static void gprs_netreg_update(struct ofono_gprs *g=
prs)
>   =

>   	DBG("attach: %u, driver_attached: %u", attach, gprs->driver_attached);
>   =

> -	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
> -			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
> +	if (expect_lte_context_auto_activation(gprs))
>   		/*
>   		 * For LTE we set attached status only on successful
>   		 * context activation.
> @@ -2560,7 +2568,12 @@ void ofono_gprs_status_notify(struct ofono_gprs *g=
prs, int status)
>   =

>   	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
>   			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
> -		gprs_attached_update(gprs);
> +		/*
> +		 * For LTE we attached status reflects successful context
> +		 * activation.
> +		 */

So I don't get this.  We have CREG telling us: "we're on LTE" and CGREG =

telling us "Oh we don't know what our status is".  Why do you trust one =

and not the other?  Are you sure this doesn't belong in a driver quirk =

somewhere?

> +		if (!expect_lte_context_auto_activation(gprs))
> +			gprs_attached_update(gprs);
>   		return;
>   	}
>   =

> =


Regards,
-Denis

--===============2222556636550081665==--

