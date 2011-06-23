Content-Type: multipart/mixed; boundary="===============2638628605785265080=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] call-forward: Call forwarding state handling
Date: Thu, 23 Jun 2011 12:45:15 -0500
Message-ID: <4E037BAB.2050906@gmail.com>
In-Reply-To: <1308234695-11428-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2638628605785265080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 06/16/2011 09:31 AM, Nicolas Bertrand wrote:
> When CFU is active be cautious with conditional
> call-forward activation/deactivation
> ---
>  src/call-forwarding.c |   46 ++++++++++++++++++++++++++++++++++++++++---=
---
>  1 files changed, 40 insertions(+), 6 deletions(-)
> =


So I had to go back and re-read the thread that culminated in the need
for these changes.  I include it here for reference:
http://lists.ofono.org/pipermail/ofono/2011-January/007234.html

In particular see my previous 'todo' thoughts:
http://lists.ofono.org/pipermail/ofono/2011-January/007721.html

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 73ce433..eff5e9d 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -504,6 +504,7 @@ static DBusMessage *cf_get_properties_reply(DBusMessa=
ge *msg,
>  	DBusMessageIter dict;
>  	int i;
>  	dbus_bool_t status;
> +	GSList *hidden =3D NULL;
>  =

>  	reply =3D dbus_message_new_method_return(msg);
>  	if (reply =3D=3D NULL)
> @@ -515,17 +516,33 @@ static DBusMessage *cf_get_properties_reply(DBusMes=
sage *msg,
>  					OFONO_PROPERTIES_ARRAY_SIGNATURE,
>  						&dict);
>  =

> -	for (i =3D 0; i < 4; i++)
> -		property_append_cf_conditions(&dict, cf->cf_conditions[i],
> -						BEARER_CLASS_VOICE,
> -						cf_type_lut[i]);
> -
>  	if ((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
>  			cf->cfis_record_id > 0)
>  		status =3D is_cfu_enabled(cf, NULL);
>  	else
>  		status =3D FALSE;
>  =

> +	/*
> +	 * If unconditional call-forwarding is enabled,
> +	 * hide conditionnal status
> +	 */
> +	if (status =3D=3D TRUE) {
> +		struct ofono_call_forwarding_condition cd =3D {0, 0, {"", 0}, 0};
> +
> +		for (i =3D 0; i < 4; i++)
> +			hidden =3D g_slist_prepend(hidden, &cd);
> +	}

Lets not rely on status here, there can be situations where the EFcfis
and EFcff are not present on the SIM, or more likely the device does not
support reading of elementary EFs (e.g. N900).  So relying on
is_cfu_enabled is better here.

> +
> +	for (i =3D 0; i < 4; i++)
> +		property_append_cf_conditions(&dict, (status &&
> +				i !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL) ?
> +				hidden : cf->cf_conditions[i],
> +				BEARER_CLASS_VOICE,
> +				cf_type_lut[i]);
> +
> +	if (status =3D=3D TRUE)
> +		g_slist_free(hidden);
> +

This is the right idea, but the code could be a bit more readable,
albeit longer.  Can you do something like:

for () {
	GSList *l;

	if (cfu_enabled && i !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL)
		l =3D hidden;
	else
		l =3D cf->cf_conditions[i];

	property_append_cf_conditions(&dict, i, l,
					BEARER_CLASS_VOICE,
					cf_type_lut[i]);
}

>  	ofono_dbus_dict_append(&dict, "ForwardingFlagOnSim", DBUS_TYPE_BOOLEAN,
>  					&status);
>  =

> @@ -552,6 +569,13 @@ static void get_query_cf_callback(const struct ofono=
_error *error, int total,
>  			cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
>  	}
>  =

> +	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
> +			is_cfu_enabled(cf, NULL) =3D=3D TRUE) {
> +		DBusMessage *reply =3D cf_get_properties_reply(cf->pending, cf);
> +		__ofono_dbus_pending_reply(&cf->pending, reply);
> +		return;
> +	}
> +

This looks fine to me.

However, there's another path that needs to be taken care of.  Namely
that we set the cond lists queried via supplementary service operations
in ss_set_query_cf_callback.  You probably need to add extra logic there
to make sure that we don't overwrite / signal settings incorrectly.

In particular things can get funny if one queries conditional / all
settings when cfu is active.  Do note that query all/query conditional
MMI is not valid, but oFono implements it anyway.  If it makes it
easier, feel free to disable these.

>  	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
>  		DBusMessage *reply =3D cf_get_properties_reply(cf->pending, cf);
>  		__ofono_dbus_pending_reply(&cf->pending, reply);
> @@ -575,7 +599,8 @@ static DBusMessage *cf_get_properties(DBusConnection =
*conn, DBusMessage *msg,
>  	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
>  =

>  	if ((cf->flags & CALL_FORWARDING_FLAG_CACHED) ||
> -			ofono_modem_get_online(modem) =3D=3D FALSE)
> +			ofono_modem_get_online(modem) =3D=3D FALSE ||
> +			is_cfu_enabled(cf, NULL) =3D=3D TRUE)

I'm not sure about this change, I understand why you're doing it this
way.  There are several places we reset the cached flag due to error
conditions.  So to be on the safe side, perhaps we need to use two flags
for this?  E.g. something telling us that we need to re-query
conditionals once cfu is disabled.

>  		return cf_get_properties_reply(msg, cf);
>  =

>  	if (cf->driver->query =3D=3D NULL)
> @@ -698,6 +723,15 @@ static void set_property_callback(const struct ofono=
_error *error, void *data)
>  		return;
>  	}
>  =

> +	if (cf->query_next !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
> +			is_cfu_enabled(cf, NULL) =3D=3D TRUE) {
> +		DBusMessage *reply;
> +		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
> +		reply =3D dbus_message_new_method_return(cf->pending);
> +		__ofono_dbus_pending_reply(&cf->pending, reply);
> +		return;
> +	}
> +

This looks fine to me (but see my comment up above).  However, you must
also ensure that PropertyChanged signals are sent accordingly since you
have chosen to make conditional settings empty and vice-versa.

>  	/* Successfully set, query the entire set just in case */
>  	set_query_next_cf_cond(cf);
>  }

One more request, can you implement this 'quiescent' behavior inside
phonesim?  It would make it easier for us to stress-test these changes.

Thanks,
-Denis

--===============2638628605785265080==--

