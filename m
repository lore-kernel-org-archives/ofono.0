Content-Type: multipart/mixed; boundary="===============0076638952078520380=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] call-forwarding: Read/Write cfis/cphs-cff
Date: Fri, 03 Dec 2010 13:08:56 -0600
Message-ID: <4CF94048.4000005@gmail.com>
In-Reply-To: <1291027083-19231-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0076638952078520380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 11/29/2010 04:37 AM, Jeevaka Badrappan wrote:
> ---
>  src/call-forwarding.c |  266 +++++++++++++++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 260 insertions(+), 6 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index ce03c40..bb345a6 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -34,6 +34,7 @@
>  #include "ofono.h"
>  =

>  #include "common.h"
> +#include "simutil.h"
>  =

>  #define CALL_FORWARDING_FLAG_CACHED 0x1
>  =

> @@ -58,6 +59,12 @@ struct ofono_call_forwarding {
>  	int query_next;
>  	int query_end;
>  	struct cf_ss_request *ss_req;
> +	struct ofono_sim *sim;
> +	unsigned char cfis_record_id;
> +	unsigned char cfis_indicator;
> +	ofono_bool_t cphs_cff_present;
> +	ofono_bool_t status_on_sim;
> +	ofono_bool_t online;

Why do you need to track this variable?  Can't you simply call
ofono_modem_get_online()?

>  	struct ofono_ussd *ussd;
>  	unsigned int ussd_watch;
>  	const struct ofono_call_forwarding_driver *driver;

<snip>

> @@ -372,6 +458,7 @@ static DBusMessage *cf_get_properties_reply(DBusMessa=
ge *msg,
>  	DBusMessageIter iter;
>  	DBusMessageIter dict;
>  	int i;
> +	dbus_bool_t status;
>  =

>  	reply =3D dbus_message_new_method_return(msg);
>  =

> @@ -384,10 +471,21 @@ static DBusMessage *cf_get_properties_reply(DBusMes=
sage *msg,
>  					OFONO_PROPERTIES_ARRAY_SIGNATURE,
>  						&dict);
>  =

> -	for (i =3D 0; i < 4; i++)
> -		property_append_cf_conditions(&dict, cf->cf_conditions[i],
> +	if (cf->online =3D=3D TRUE) {

So I'm really confused by this one, if we're offline and haven't managed
to query the conditions, just return them.  They will be all empty with
the possible exception of VoiceUnconditional

> +		for (i =3D 0; i < 4; i++)
> +			property_append_cf_conditions(&dict,
> +						cf->cf_conditions[i],
>  						BEARER_CLASS_VOICE,
>  						cf_type_lut[i]);
> +	} else if (cf->status_on_sim =3D=3D TRUE)
> +		property_append_cf_conditions(&dict,
> +			cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL],
> +			BEARER_CLASS_VOICE,
> +			cf_type_lut[CALL_FORWARDING_TYPE_UNCONDITIONAL]);
> +
> +	status =3D cf->status_on_sim;
> +	ofono_dbus_dict_append(&dict, "ForwardingFlagOnSim", DBUS_TYPE_BOOLEAN,
> +					&status);
>  =

>  	dbus_message_iter_close_container(&iter, &dict);
>  =


<snip>

> @@ -433,7 +539,8 @@ static DBusMessage *cf_get_properties(DBusConnection =
*conn, DBusMessage *msg,
>  {
>  	struct ofono_call_forwarding *cf =3D data;
>  =

> -	if (cf->flags & CALL_FORWARDING_FLAG_CACHED)
> +	if ((cf->flags & CALL_FORWARDING_FLAG_CACHED) ||
> +			cf->online =3D=3D FALSE)

Why do you split this on two lines? Are you sure it won't fit on one?

>  		return cf_get_properties_reply(msg, cf);
>  =

>  	if (!cf->driver->query)
> @@ -536,7 +643,8 @@ static void set_query_cf_callback(const struct ofono_=
error *error, int total,
>  	if (cf->query_next !=3D cf->query_end) {
>  		cf->query_next++;
>  		set_query_next_cf_cond(cf);
> -	}
> +	} else
> +		sim_set_cf_indicator(cf);

Should we do this only if we actually queried the set that includes
unconditional?

>  }
>  =

>  static void set_query_next_cf_cond(struct ofono_call_forwarding *cf)
> @@ -597,6 +705,9 @@ static DBusMessage *cf_set_property(DBusConnection *c=
onn, DBusMessage *msg,
>  	int cls;
>  	int type;
>  =

> +	if (cf->online =3D=3D FALSE)
> +		return __ofono_error_not_available(msg);
> +
>  	if (__ofono_call_forwarding_is_busy(cf) ||
>  			__ofono_ussd_is_busy(cf->ussd))
>  		return __ofono_error_busy(msg);
> @@ -864,7 +975,8 @@ static void ss_set_query_cf_callback(const struct ofo=
no_error *error, int total,
>  	if (cf->query_next !=3D cf->query_end) {
>  		cf->query_next++;
>  		ss_set_query_next_cf_cond(cf);
> -	}
> +	} else
> +		sim_set_cf_indicator(cf);

Should we do this only if we actually queried the set that includes
unconditional?

>  }
>  =

>  static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf)

<snip>

> @@ -1220,6 +1461,7 @@ void ofono_call_forwarding_register(struct ofono_ca=
ll_forwarding *cf)
>  	DBusConnection *conn =3D ofono_dbus_get_connection();
>  	const char *path =3D __ofono_atom_get_path(cf->atom);
>  	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
> +	struct ofono_atom *sim_atom;
>  	struct ofono_atom *ussd_atom;
>  =

>  	if (!g_dbus_register_interface(conn, path,
> @@ -1234,6 +1476,18 @@ void ofono_call_forwarding_register(struct ofono_c=
all_forwarding *cf)
>  =

>  	ofono_modem_add_interface(modem, OFONO_CALL_FORWARDING_INTERFACE);
>  =

> +	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
> +
> +	if (sim_atom) {
> +		cf->sim =3D __ofono_atom_get_data(sim_atom);
> +
> +		if (ofono_sim_get_state(cf->sim) =3D=3D OFONO_SIM_STATE_READY)

This check can be skipped, we're always in post_sim state.  The only way
to get there is if we reached OFONO_SIM_STATE_READY

> +			sim_read_cf_indicator(cf);
> +	}
> +
> +	__ofono_modem_add_online_watch(modem, modem_online_status_changed,
> +					cf, NULL);
> +
>  	cf->ussd_watch =3D __ofono_modem_add_atom_watch(modem,
>  					OFONO_ATOM_TYPE_USSD,
>  					ussd_watch, cf, NULL);

Regards,
-Denis

--===============0076638952078520380==--

