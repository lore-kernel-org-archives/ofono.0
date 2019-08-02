Content-Type: multipart/mixed; boundary="===============6183660520736777188=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netreg, gprs: Use -1 as netreg status during init.
Date: Fri, 02 Aug 2019 08:04:53 -0500
Message-ID: <726bbb5d-1ef2-9d91-112e-7e5cafb12ead@gmail.com>
In-Reply-To: <20190801114855.11639-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6183660520736777188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/1/19 6:48 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> Previously the valid "unknown" registration status was set
> during startup, but its a bit problematic for gprs.
> There might be cases where a LTE context is activated
> before netreg is finished updating its status.
> And then gprs could make faulty actions.
> Instead we set the status to -1 when the drivers supports
> fetching the status manually, which is done during startup.
> During the time the status is -1, gprs postpones actions until
> the status is valid (>=3D 0).
> ---
>   src/gprs.c    | 12 ++++++++++--
>   src/network.c |  5 ++++-
>   2 files changed, 14 insertions(+), 3 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index bdb8c8a2..07802c36 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1661,6 +1661,14 @@ static void gprs_netreg_update(struct ofono_gprs *=
gprs)
>   {
>   	ofono_bool_t attach;
>   =

> +	/* This function can get called by other reasons than netreg
> +	 * updating its status. So check if we have a valid netreg status yet.
> +	 * The only reason for not having a valid status is basically during
> +	 * startup while the netreg atom is fetching the status.
> +	 */

Note doc/coding-style.txt item M2 for our commenting style...

> +	if (gprs->netreg_status < 0)
> +		return;
> +
>   	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGI=
STERED;
>   =

>   	attach =3D attach || (gprs->roaming_allowed &&
> @@ -3083,8 +3091,8 @@ struct ofono_gprs *ofono_gprs_create(struct ofono_m=
odem *modem,
>   		break;
>   	}
>   =

> -	gprs->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
> -	gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
> +	gprs->status =3D -1;

Why do you need to mess with this?  It seems to be not used

> +	gprs->netreg_status =3D -1;
>   	gprs->used_pids =3D l_uintset_new(MAX_CONTEXTS);
>   =


Wouldn't changes to gprs.c be sufficient, without touching netreg.c?

>   	return gprs;
> diff --git a/src/network.c b/src/network.c
> index 2824eae6..1db01bcf 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -1874,7 +1874,7 @@ struct ofono_netreg *ofono_netreg_create(struct ofo=
no_modem *modem,
>   	if (netreg =3D=3D NULL)
>   		return NULL;
>   =

> -	netreg->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
> +	netreg->status =3D -1;

Okay, but a minor problem with this is that there now exists a brief =

moment in type where the Status property has a weird value...

>   	netreg->location =3D -1;
>   	netreg->cellid =3D -1;
>   	netreg->technology =3D -1;
> @@ -1893,6 +1893,9 @@ struct ofono_netreg *ofono_netreg_create(struct ofo=
no_modem *modem,
>   			continue;
>   =

>   		netreg->driver =3D drv;
> +		/* Check if we can init the status properly using the driver */
> +		if (netreg->driver->registration_status =3D=3D NULL)
> +			netreg->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
>   		break;
>   	}
>   =

> =


Regards,
-Denis

--===============6183660520736777188==--

