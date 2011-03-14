Content-Type: multipart/mixed; boundary="===============1911368746016931402=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: Re: [PATCH] call-forwarding: fix for showing call forwarding states
Date: Mon, 14 Mar 2011 15:47:31 +0200
Message-ID: <1300110451.2561.163.camel@jussi-desktop>
In-Reply-To: <4D7AA6D0.7060808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1911368746016931402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,

On Sat, 2011-03-12 at 00:48 +0200, Denis Kenzior wrote: =

> > +	} else {
> > +		DBG("append only unconditional");
> > +		property_append_cf_conditions(&dict,
> > +			cf->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL],
> > +				BEARER_CLASS_VOICE,
> > +					cf_type_lut[0]);
> > +		for (i =3D 1; i < 4; i++)
> > +			property_append_cf_conditions(&dict, NULL,
> >  						BEARER_CLASS_VOICE,
> >  						cf_type_lut[i]);
> =

> So I'm confused, the TODO entry says we should not return conditional
> entries if the unconditional call forwarding is set as they are now
> quiescent.
> =

> Are you proposing we handle this a bit differently?

No. I'm setting the unconditional values to NULL in order to clean them
from API. If only unconditional is updated when there has been
unconditional conditions active before, list-modems would show them
still. After this change information about unconditional conditions
remains in oFono, but they are not shown in the API.

> =

> > +	}
> >  =

> >  	if ((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
> >  			cf->cfis_record_id > 0)
> > @@ -682,8 +696,23 @@ static void set_query_cf_callback(const struct ofo=
no_error *error, int total,
> >  =

> >  static void set_query_next_cf_cond(struct ofono_call_forwarding *cf)
> >  {
> > -	cf->driver->query(cf, cf->query_next, BEARER_CLASS_DEFAULT,
> > -			set_query_cf_callback, cf);
> > +	DBusMessage *reply;
> > +
> > +	while (cf->query_next !=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
> > +		if (!cf->cf_conditions[cf->query_next]) {
> > +			cf->driver->query(cf, cf->query_next,
> > +				BEARER_CLASS_DEFAULT,
> > +				set_query_cf_callback, cf);
> > +				return;
> > +		} else {
> > +			cf->query_next++;
> > +			if (cf->query_next =3D=3D cf->query_end)
> > +				break;
> > +		}
> > +	}
> > +
> > +	reply =3D dbus_message_new_method_return(cf->pending);
> > +	__ofono_dbus_pending_reply(&cf->pending, reply);
> =

> Really lost here,

Query_next and query_end tell only what to ask from query_next to
query_end. This causes pointless query if there is a value in the middle
which is already known. What this implementation does it prevents the
query if the condition is already known. =

  =

> >  static void set_property_callback(const struct ofono_error *error, voi=
d *data)
> > @@ -836,6 +865,7 @@ static void disable_conditional_callback(const stru=
ct ofono_error *error,
> >  static void disable_all_callback(const struct ofono_error *error, void=
 *data)
> >  {
> >  	struct ofono_call_forwarding *cf =3D data;
> > +	int i;
> >  =

> >  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> >  		DBG("Error occurred during erasure of all");
> > @@ -848,6 +878,10 @@ static void disable_all_callback(const struct ofon=
o_error *error, void *data)
> >  	/* Query all cf types */
> >  	cf->query_next =3D CALL_FORWARDING_TYPE_UNCONDITIONAL;
> >  	cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
> > +
> > +	for (i =3D 0; i < CALL_FORWARDING_TYPE_ALL; i++)
> > +		cf->cf_conditions[i] =3D 0;
> > +
> =

> For pointers please use NULL instead of 0.
> =

> Why are we setting them to NULL here in the first place? And shouldn't
> you free the data?

This is the other half of the implementation that prevents the querying
already known conditions. What I'm doing here is that I'm using the
cf_conditions as a flag to tell what is known. And since this is the
response for clearing all conditions, we don't know anything and
everything has to be queried in order to see if the request was
succesful or not. What comes to freeing the data I think you are right.
I think totally new parameter inside cf would be a better solution. That
would be less heavy. I'll check that out. =


> > @@ -1180,8 +1236,14 @@ static gboolean cf_ss_control(int type, const ch=
ar *sc,
> >  		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
> >  		break;
> >  	case CALL_FORWARDING_TYPE_ALL_CONDITIONAL:
> > -		cf->query_next =3D CALL_FORWARDING_TYPE_BUSY;
> > -		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
> =

> I don't see how handling both these cases with the same code can work...

Well at least in my testings if there is break and separate query_next
and query_end for CALL_FORWARDING_TYPE_ALL_CONDITIONAL erasing the
condition by using ss API does not remove conditions from API. =


> > +	case CALL_FORWARDING_TYPE_UNCONDITIONAL:
> > +		if (type =3D=3D SS_CONTROL_TYPE_REGISTRATION) {
> > +			cf->query_next =3D cf->ss_req->cf_type;
> > +			cf->query_end =3D cf->ss_req->cf_type;
> > +		} else {
> > +			cf->query_next =3D cf->ss_req->cf_type;
> > +			cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
> > +		}
> =

> I'm a bit lost here, can you explain some more what you're trying to
> accomplish?

I was looking for this: If the user sets call forwarding unconditional
or all conditional on, there is no reason to ask anything else since
implementation in cf_get_properties_reply prevents the showing. If user
clears the call forwarding unconditional all have to be asked. =


Br, =

-Jussi






--===============1911368746016931402==--

