Content-Type: multipart/mixed; boundary="===============6635788234576932491=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 09/12] call-forwarding: Cache cfs on CFU removal
Date: Tue, 20 Mar 2012 19:16:27 -0500
Message-ID: <4F691DDB.3060502@gmail.com>
In-Reply-To: <1331646393-5249-10-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6635788234576932491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 03/13/2012 08:46 AM, Oleg Zhurakivskyy wrote:
> Since the re-querying is done, cache the call forwardings.
> ---
>  src/call-forwarding.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 575d96d..7109c21 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -38,6 +38,7 @@
>  =

>  #define CALL_FORWARDING_FLAG_CACHED	0x1
>  #define CALL_FORWARDING_FLAG_CPHS_CFF	0x2
> +#define CALL_FORWARDING_FLAG_CACHE	0x4
>  =


You really have to pick a better name for this flag, I really don't
understand its purpose right now.

>  /* According to 27.007 Spec */
>  #define DEFAULT_NO_REPLY_TIMEOUT 20
> @@ -635,7 +636,8 @@ static void set_query_cf_callback(const struct ofono_=
error *error, int total,
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		ofono_error("Setting succeeded, but query failed");
> -		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
> +		cf->flags &=3D ~(CALL_FORWARDING_FLAG_CACHED |
> +				CALL_FORWARDING_FLAG_CACHE);
>  		__ofono_dbus_pending_reply(&cf->pending,
>  					__ofono_error_failed(cf->pending));
>  		return;
> @@ -655,6 +657,11 @@ static void set_query_cf_callback(const struct ofono=
_error *error, int total,
>  		cf->flags ^=3D CALL_FORWARDING_FLAG_CACHED;
>  =

>  	if (cf->query_next =3D=3D cf->query_end) {
> +		if (cf->flags & CALL_FORWARDING_FLAG_CACHE) {
> +			cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHE;
> +			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
> +		}
> +
>  		__ofono_dbus_pending_reply(&cf->pending,
>  				dbus_message_new_method_return(cf->pending));
>  		return;
> @@ -701,12 +708,13 @@ static DBusMessage *set_property_request(struct ofo=
no_call_forwarding *cf,
>  	cf->query_next =3D type;
>  =

>  	if (type =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
> -		ph->number[0] =3D=3D '\0' && is_cfu_enabled(cf))
> +		ph->number[0] =3D=3D '\0' && is_cfu_enabled(cf)) {
>  		/*
>  		 * CFU is removed, conditionals need to be updated
>  		 */
>  		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
> -	else
> +		cf->flags |=3D CALL_FORWARDING_FLAG_CACHE;
> +	} else
>  		cf->query_end =3D type;
>  =

>  	DBG("Farming off request, will be erasure: %d", ph->number[0] =3D=3D '\=
0');

Regards,
-Denis

--===============6635788234576932491==--

