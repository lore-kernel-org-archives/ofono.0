Content-Type: multipart/mixed; boundary="===============7215037251299601006=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] call-forwarding: fix for showing call forwarding states
Date: Fri, 11 Mar 2011 16:48:48 -0600
Message-ID: <4D7AA6D0.7060808@gmail.com>
In-Reply-To: <1299666479-8438-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7215037251299601006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 03/09/2011 04:27 AM, Jussi Kangas wrote:
> ---
> Hi,
> =

> Here is a fix for call forwarding issue Jarko found a while back. ( TODO
> issue "Call forwarding state handling change" and mailing list
> conversation "Ofono CF states not always correct" ).
> =

> Br,
> Jussi
> =

>  src/call-forwarding.c |   78 +++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 files changed, 70 insertions(+), 8 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index d13f990..6f81296 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -514,10 +514,24 @@ static DBusMessage *cf_get_properties_reply(DBusMes=
sage *msg,
>  					OFONO_PROPERTIES_ARRAY_SIGNATURE,
>  						&dict);
>  =

> -	for (i =3D 0; i < 4; i++)
> -		property_append_cf_conditions(&dict, cf->cf_conditions[i],
> +	if (cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] =3D=3D 0) {

Please use a comparison to NULL here instead of 0

> +		DBG("Append all");
> +		for (i =3D 0; i < 4; i++)
> +			property_append_cf_conditions(&dict,
> +				cf->cf_conditions[i],
> +					BEARER_CLASS_VOICE,
> +						cf_type_lut[i]);

Please fix the indentation levels here, the lines following
property_append... should all be the same indentation level.

Also, we might want to skip the unconditional call forwarding settings here.

> +	} else {
> +		DBG("append only unconditional");
> +		property_append_cf_conditions(&dict,
> +			cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL],
> +				BEARER_CLASS_VOICE,
> +					cf_type_lut[0]);
> +		for (i =3D 1; i < 4; i++)
> +			property_append_cf_conditions(&dict, NULL,
>  						BEARER_CLASS_VOICE,
>  						cf_type_lut[i]);

So I'm confused, the TODO entry says we should not return conditional
entries if the unconditional call forwarding is set as they are now
quiescent.

Are you proposing we handle this a bit differently?

> +	}
>  =

>  	if ((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
>  			cf->cfis_record_id > 0)
> @@ -682,8 +696,23 @@ static void set_query_cf_callback(const struct ofono=
_error *error, int total,
>  =

>  static void set_query_next_cf_cond(struct ofono_call_forwarding *cf)
>  {
> -	cf->driver->query(cf, cf->query_next, BEARER_CLASS_DEFAULT,
> -			set_query_cf_callback, cf);
> +	DBusMessage *reply;
> +
> +	while (cf->query_next !=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
> +		if (!cf->cf_conditions[cf->query_next]) {
> +			cf->driver->query(cf, cf->query_next,
> +				BEARER_CLASS_DEFAULT,
> +				set_query_cf_callback, cf);
> +				return;
> +		} else {
> +			cf->query_next++;
> +			if (cf->query_next =3D=3D cf->query_end)
> +				break;
> +		}
> +	}
> +
> +	reply =3D dbus_message_new_method_return(cf->pending);
> +	__ofono_dbus_pending_reply(&cf->pending, reply);

Really lost here,

>  }
>  =

>  static void set_property_callback(const struct ofono_error *error, void =
*data)
> @@ -836,6 +865,7 @@ static void disable_conditional_callback(const struct=
 ofono_error *error,
>  static void disable_all_callback(const struct ofono_error *error, void *=
data)
>  {
>  	struct ofono_call_forwarding *cf =3D data;
> +	int i;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		DBG("Error occurred during erasure of all");
> @@ -848,6 +878,10 @@ static void disable_all_callback(const struct ofono_=
error *error, void *data)
>  	/* Query all cf types */
>  	cf->query_next =3D CALL_FORWARDING_TYPE_UNCONDITIONAL;
>  	cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
> +
> +	for (i =3D 0; i < CALL_FORWARDING_TYPE_ALL; i++)
> +		cf->cf_conditions[i] =3D 0;
> +

For pointers please use NULL instead of 0.

Why are we setting them to NULL here in the first place? And shouldn't
you free the data?

>  	set_query_next_cf_cond(cf);
>  }
>  =

> @@ -1014,8 +1048,25 @@ static void ss_set_query_cf_callback(const struct =
ofono_error *error, int total,
>  =

>  static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf)
>  {
> -	cf->driver->query(cf, cf->query_next, BEARER_CLASS_DEFAULT,
> -			ss_set_query_cf_callback, cf);
> +	DBusMessage *reply;
> +
> +	while (cf->query_next !=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
> +		if (!cf->cf_conditions[cf->query_next]) {
> +			cf->driver->query(cf, cf->query_next,
> +				BEARER_CLASS_DEFAULT,
> +				ss_set_query_cf_callback, cf);
> +				return;
> +		} else {
> +			cf->query_next++;
> +			if (cf->query_next =3D=3D cf->query_end)
> +				break;
> +		}
> +	}
> +
> +	reply =3D cf_ss_control_reply(cf, cf->ss_req);
> +	__ofono_dbus_pending_reply(&cf->pending, reply);
> +	g_free(cf->ss_req);
> +	cf->ss_req =3D NULL;

Again, very lost

>  }
>  =

>  static void cf_ss_control_callback(const struct ofono_error *error, void=
 *data)
> @@ -1032,6 +1083,11 @@ static void cf_ss_control_callback(const struct of=
ono_error *error, void *data)
>  		return;
>  	}
>  =

> +	if (cf->ss_req) {
> +		if (cf->ss_req->ss_type =3D=3D SS_CONTROL_TYPE_ERASURE)
> +			cf->cf_conditions[cf->ss_req->cf_type] =3D 0;
> +	}
> +
>  	ss_set_query_next_cf_cond(cf);
>  }
>  =

> @@ -1180,8 +1236,14 @@ static gboolean cf_ss_control(int type, const char=
 *sc,
>  		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
>  		break;
>  	case CALL_FORWARDING_TYPE_ALL_CONDITIONAL:
> -		cf->query_next =3D CALL_FORWARDING_TYPE_BUSY;
> -		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;

I don't see how handling both these cases with the same code can work...

> +	case CALL_FORWARDING_TYPE_UNCONDITIONAL:
> +		if (type =3D=3D SS_CONTROL_TYPE_REGISTRATION) {
> +			cf->query_next =3D cf->ss_req->cf_type;
> +			cf->query_end =3D cf->ss_req->cf_type;
> +		} else {
> +			cf->query_next =3D cf->ss_req->cf_type;
> +			cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
> +		}

I'm a bit lost here, can you explain some more what you're trying to
accomplish?

>  		break;
>  	default:
>  		cf->query_next =3D cf->ss_req->cf_type;

Regards,
-Denis

--===============7215037251299601006==--

