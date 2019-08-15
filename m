Content-Type: multipart/mixed; boundary="===============6488408115922307485=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] gprs: Check for LTE in gprs_attached_update
Date: Thu, 15 Aug 2019 15:47:25 -0500
Message-ID: <d8e48101-068c-4994-759d-e985f4ecd062@gmail.com>
In-Reply-To: <20190814182444.13508-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6488408115922307485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/14/19 1:24 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> Since we have a different condition for the attach state
> when running on LTE, we should consider it in gprs_attached_update.
> Previously it's done in some instances. But for instance if
> the driver got detached from GPRS but now running on LTE with a
> context up, we would be deattached.

So are you talking about a hand-over? Do we have logs to help visualize =

this?

> ---
>   src/gprs.c | 52 +++++++++++++++++++++++++++++-----------------------
>   1 file changed, 29 insertions(+), 23 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index bba482cb..94d13f82 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1571,13 +1571,34 @@ static void release_active_contexts(struct ofono_=
gprs *gprs)
>   	}
>   }
>   =

> +static gboolean on_lte(struct ofono_gprs *gprs)
> +{
> +	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
> +			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
> +		return TRUE;
> +
> +	return FALSE;
> +}
> +
>   static void gprs_attached_update(struct ofono_gprs *gprs)
>   {
>   	ofono_bool_t attached;
> +	int status =3D gprs->status;
>   =

> -	attached =3D gprs->driver_attached &&
> -		(gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
> -			gprs->status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
> +	if (on_lte(gprs))
> +		/*
> +		 * For LTE we attached status reflects successful context
> +		 * activation.
> +		 * Since we in gprs_netreg_update not even try to attach
> +		 * to GPRS if we are running on LTE, we can on some modems
> +		 * expect the gprs status to be unknown. That must not
> +		 * result in detaching...
> +		 */
> +		attached =3D have_active_contexts(gprs);

On LTE Attached should just be always True.  Someone can correct me if =

I'm wrong, but a default context is a pre-requisite for E-UTRAN attachment.

> +	else
> +		attached =3D gprs->driver_attached &&
> +			(status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
> +				status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
>   =

>   	if (attached =3D=3D gprs->attached)
>   		return;
> @@ -1591,11 +1612,14 @@ static void gprs_attached_update(struct ofono_gpr=
s *gprs)
>   	if (attached =3D=3D FALSE) {
>   		release_active_contexts(gprs);
>   		gprs->bearer =3D -1;
> -	} else if (have_active_contexts(gprs) =3D=3D TRUE) {
> +	} else if (have_active_contexts(gprs) =3D=3D TRUE &&
> +		!on_lte(gprs)) {

Not our style.  See item M4.  Might want to see if it fits on the =

previous line.

>   		/*
>   		 * Some times the context activates after a detach event and
>   		 * right before an attach. We close it to avoid unexpected open
>   		 * contexts.
> +		 * Skip that for LTE since the condition to be attached on LTE
> +		 * is that a context gets activated
>   		 */
>   		release_active_contexts(gprs);
>   		gprs->flags |=3D GPRS_FLAG_ATTACHED_UPDATE;
> @@ -1660,15 +1684,6 @@ static void gprs_netreg_removed(struct ofono_gprs =
*gprs)
>   	gprs_attached_update(gprs);
>   }
>   =

> -static gboolean on_lte(struct ofono_gprs *gprs)
> -{
> -	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
> -			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
> -		return TRUE;
> -
> -	return FALSE;
> -}
> -
>   static void gprs_netreg_update(struct ofono_gprs *gprs)
>   {
>   	ofono_bool_t attach;
> @@ -2573,16 +2588,7 @@ void ofono_gprs_status_notify(struct ofono_gprs *g=
prs, int status)
>   =

>   	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
>   			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
> -		/*
> -		 * For LTE we attached status reflects successful context
> -		 * activation.
> -		 * Since we in gprs_netreg_update not even try to attach
> -		 * to GPRS if we are running on LTE, we can on some modems
> -		 * expect the gprs status to be unknown. That must not
> -		 * result in detaching...
> -		 */
> -		if (!on_lte(gprs))
> -			gprs_attached_update(gprs);
> +		gprs_attached_update(gprs);
>   		return;
>   	}
>   =

> =


Otherwise I'm fine moving the on_lte logic into gprs_attached_update =

itself...

Regards,
-Denis

--===============6488408115922307485==--

