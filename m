Content-Type: multipart/mixed; boundary="===============8581916330464141017=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 6/8] call-forwarding: Don't run conditional queries if
 cfu is active
Date: Wed, 22 Feb 2012 07:24:30 -0600
Message-ID: <4F44EC8E.90501@gmail.com>
In-Reply-To: <1328531641-10612-7-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8581916330464141017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 02/06/2012 06:33 AM, Oleg Zhurakivskyy wrote:
> ---
>  src/call-forwarding.c |   18 +++++++++++-------
>  1 files changed, 11 insertions(+), 7 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 7b086e0..2813005 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -584,20 +584,24 @@ static void get_query_cf_callback(const struct ofon=
o_error *error, int total,
>  	struct ofono_call_forwarding *cf =3D data;
>  =

>  	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		GSList *l;
> -		l =3D cf_cond_list_create(total, list);
> +		GSList *l =3D cf_cond_list_create(total, list);
> +
>  		set_new_cond_list(cf, cf->query_next, l);
>  =

>  		DBG("%s conditions:", cf_type_lut[cf->query_next]);
> +
>  		cf_cond_list_print(l);

I separated out two above chunks as a separate patch and applied them,
since they are just cleanup anyway.


> +	}
>  =

> -		if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE)
> +	if ((is_cfu_enabled(cf) &&
> +			cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL) ||
> +			cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
> +
> +		if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
>  			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
> -	}
>  =

> -	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
> -		DBusMessage *reply =3D cf_get_properties_reply(cf->pending, cf);
> -		__ofono_dbus_pending_reply(&cf->pending, reply);
> +		__ofono_dbus_pending_reply(&cf->pending,
> +				cf_get_properties_reply(cf->pending, cf));
>  		return;
>  	}
>  =


The rest is on the right track, however I don't think this really works
in the case where CFU is set when the query is being performed for the
first time.

e.g.
- GetProperties -> query all
- CFU is set, so don't query conditionals (which is correct since they
are useless)
- CFU is removed -> conditionals need to be updated now since they don't
reflect reality

Regards,
-Denis

--===============8581916330464141017==--

