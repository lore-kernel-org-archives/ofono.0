Content-Type: multipart/mixed; boundary="===============8979649234131142140=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 05/12] call-forwarding: Minor cleanup of
 set_query_cf_callback
Date: Tue, 20 Mar 2012 18:54:44 -0500
Message-ID: <4F6918C4.70803@gmail.com>
In-Reply-To: <1331646393-5249-6-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8979649234131142140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 03/13/2012 08:46 AM, Oleg Zhurakivskyy wrote:
> ---
>  src/call-forwarding.c |   26 +++++++++++---------------
>  1 files changed, 11 insertions(+), 15 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index b1a1a72..7e5edcb 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -631,32 +631,28 @@ static void set_query_cf_callback(const struct ofon=
o_error *error, int total,
>  			void *data)
>  {
>  	struct ofono_call_forwarding *cf =3D data;
> -	GSList *l;
> -	DBusMessage *reply;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		ofono_error("Setting succeeded, but query failed");
>  		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
> -		reply =3D __ofono_error_failed(cf->pending);
> -		__ofono_dbus_pending_reply(&cf->pending, reply);
> +		__ofono_dbus_pending_reply(&cf->pending,
> +					__ofono_error_failed(cf->pending));

This looks fine...

>  		return;
>  	}
>  =

> -	if (cf->query_next =3D=3D cf->query_end) {
> -		reply =3D dbus_message_new_method_return(cf->pending);
> -		__ofono_dbus_pending_reply(&cf->pending, reply);
> -	}
> -

Actually this part is here on purpose, we want to generate a reply
before we generate a signal for PropertyChanged.

> -	l =3D cf_cond_list_create(total, list);
> -	set_new_cond_list(cf, cf->query_next, l);
> +	set_new_cond_list(cf, cf->query_next, cf_cond_list_create(total, list));
>  =

>  	DBG("%s conditions:", cf_type_lut[cf->query_next]);
> -	cf_cond_list_print(l);
> +	cf_cond_list_print(cf->cf_conditions[cf->query_next]);
>  =

> -	if (cf->query_next !=3D cf->query_end) {
> -		cf->query_next++;
> -		set_query_next_cf_cond(cf);
> +	if (cf->query_next =3D=3D cf->query_end) {
> +		__ofono_dbus_pending_reply(&cf->pending,
> +				dbus_message_new_method_return(cf->pending));
> +		return;
>  	}
> +
> +	cf->query_next++;
> +	set_query_next_cf_cond(cf);
>  }
>  =

>  static void set_query_next_cf_cond(struct ofono_call_forwarding *cf)

Regards,
-Denis

--===============8979649234131142140==--

