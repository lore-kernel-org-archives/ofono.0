Content-Type: multipart/mixed; boundary="===============8979149184589808808=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] gprs: detach from PS domain only if needed
Date: Wed, 24 Oct 2018 21:45:00 -0500
Message-ID: <ed8840bd-fe83-e148-f46b-1ac33c574ab8@gmail.com>
In-Reply-To: <1540393754-9419-2-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8979149184589808808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 10/24/2018 10:09 AM, Christophe Ronco wrote:
> With some huawei USB keys (E3372, MS2372h), when switching from WCDMA to
> LTE network, a network attachment loss is reported during a short time.
> Forcing data detach in this case is a bad idea. Consequences can be a loop
> like that:
> t0) Attached to WCDMA network
> t1) Switch to LTE network
> t1+xs) Attachment loss reported
> t1+(x+2)s) Attached to WCDMA network
> t2) Switch to LTE network
> t2) Attachment loss reported
> t2+2s) Attached to WCDMA network

So LTE is weird.  For some reason 3GPP decided to have +CGATT control =

attach procedures even for LTE, which honestly makes no sense to me, but =

what can you do..

So yes, I agree the current behavior needs to be fixed, the tricky part =

is how...

> =

> With this patch we force gprs detach only if unpowered or roaming while
> roaming is not allowed. We don't force gprs detach if we loose network.

And herein lies the issue.  For UMTS/GSM the whole point of oFono =

behavior was to not even attach to PS while roaming as that would incur =

roaming charges.  So oFono has to control the attach status (as that is =

what 27.007 intended anyway).  However, many vendors (particularly with =

data-only modules) went in the direction of always auto-attaching to PS =

without having any way to control that behavior.  Hence oFono uses a =

rather large hammer and detaches on every registration loss.

The whole 'roaming charges while attached to PS' may now be a purely =

historical oddity, I really don't know.  But it does lead to a weird =

side-effect where RoamingAllowed=3DFalse could result in oFono forcing a =

detach on PS and thus the modem never switching over to LTE as a result.

So the ideal situation would be to turn all this off for LTE based =

dongles, have the ability to tell the modem not to auto-attach on 3G/2G, =

and maybe even attach only controlling 3G/2G PS domain only, not LTE.

> ---
>   src/gprs.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index edd17f2..320505a 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1676,15 +1676,24 @@ static void gprs_netreg_removed(struct ofono_gprs=
 *gprs)
>   static void gprs_netreg_update(struct ofono_gprs *gprs)
>   {
>   	ofono_bool_t attach;
> +	ofono_bool_t force_detach;
> +
> +	DBG("netreg:%u, powered:%u, roaming_allowed:%u, driver_attached:%u",
> +				gprs->netreg_status, gprs->powered,
> +				gprs->roaming_allowed, gprs->driver_attached);
>   =

>   	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGI=
STERED;
> +	attach |=3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAM=
ING;
>   =

> -	attach =3D attach || (gprs->roaming_allowed &&
> -		gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
> +	if (!attach)
> +		return;
>   =

> -	attach =3D attach && gprs->powered;
> +	force_detach =3D !gprs->powered || (!gprs->roaming_allowed &&
> +		gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);

See above.  You're going from 'oFono controls attach' to 'modem controls =

attach and we only detach if needed' This is a fairly major behavioral =

change, so we may want to start in a bit less drastic way...

>   =

> -	DBG("attach: %u, driver_attached: %u", attach, gprs->driver_attached);
> +	if ((force_detach && !gprs->driver_attached) ||
> +				(!force_detach && gprs->driver_attached))
> +		return;
>   =

>   	if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
>   			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
> @@ -1692,9 +1701,6 @@ static void gprs_netreg_update(struct ofono_gprs *g=
prs)
>   		 * For LTE we set attached status only on successful
>   		 * context activation.
>   		 */
> -                return;
> -
> -	if (gprs->driver_attached =3D=3D attach)
>   		return;
>   =

>   	if (gprs->flags & GPRS_FLAG_ATTACHING) {
> @@ -1703,9 +1709,9 @@ static void gprs_netreg_update(struct ofono_gprs *g=
prs)
>   	}
>   =

>   	gprs->flags |=3D GPRS_FLAG_ATTACHING;
> -
> -	gprs->driver_attached =3D attach;
> -	gprs->driver->set_attached(gprs, attach, gprs_attach_callback, gprs);
> +	gprs->driver_attached =3D !gprs->driver_attached;
> +	gprs->driver->set_attached(gprs, gprs->driver_attached,
> +						gprs_attach_callback, gprs);
>   }
>   =

>   static void netreg_status_changed(int status, int lac, int ci, int tech,
> =


Regards,
-Denis

--===============8979149184589808808==--

