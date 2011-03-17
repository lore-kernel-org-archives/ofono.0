Content-Type: multipart/mixed; boundary="===============2345084265642937945=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: Re: [PATCH] call-forwarding: fix for showing call forwarding states
Date: Thu, 17 Mar 2011 10:25:56 +0200
Message-ID: <1300350356.8348.76.camel@jussi-desktop>
In-Reply-To: <4D81815E.6060608@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2345084265642937945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2011-03-17 at 05:34 +0200, Denis Kenzior wrote:

> >> So I'm confused, the TODO entry says we should not return conditional
> >> entries if the unconditional call forwarding is set as they are now
> >> quiescent.
> >>
> >> Are you proposing we handle this a bit differently?
> > =

> > No. I'm setting the unconditional values to NULL in order to clean them
> > from API. If only unconditional is updated when there has been
> > unconditional conditions active before, list-modems would show them
> > still. After this change information about unconditional conditions
> > remains in oFono, but they are not shown in the API.
> =

> Ok, I think I understand now.  You're checking whether any unconditional
> entries exist.  If they do, you report them and assume all other entries
> are quiescent.  Right?

Right. And I only clean them from API. When unconditional is removed,
conditional states become visible without any query to network except
checking if the unconditional really disappear. =


> =

> So correct me if I'm wrong, but I don't think we can do that.  the
> current cf_conditions implementation stores all conditions, which could
> be unrelated to voice; and if my interpretation of 22.004 is correct you
> can have something like this:
> =

> Activate CFB for all services to Number 1
> Activate CFU for Data services to Number 2
> =

> Which results in cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL] not
> being NULL and you reporting CFB for voice incorrectly.
> =

> You are probably safer using is_cfu_enabled() function.

As far as I know scenario you describe cannot happen with oFono. There
is no data related conditions in the call forwarding API. Sure, you can
set data forwarding on using SS API, but I don't see how data forwarding
states could be shown in call forwarding API when all states in API
start with word "voice". Also according to comments in code fax and data
are not supported. =


> >>>  =

> >>>  	if ((cf->flags & CALL_FORWARDING_FLAG_CPHS_CFF) ||
> >>>  			cf->cfis_record_id > 0)
> >>> @@ -682,8 +696,23 @@ static void set_query_cf_callback(const struct o=
fono_error *error, int total,
> >>>  =

> >>>  static void set_query_next_cf_cond(struct ofono_call_forwarding *cf)
> >>>  {
> >>> -	cf->driver->query(cf, cf->query_next, BEARER_CLASS_DEFAULT,
> >>> -			set_query_cf_callback, cf);
> >>> +	DBusMessage *reply;
> >>> +
> >>> +	while (cf->query_next !=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
> >>> +		if (!cf->cf_conditions[cf->query_next]) {
> >>> +			cf->driver->query(cf, cf->query_next,
> >>> +				BEARER_CLASS_DEFAULT,
> >>> +				set_query_cf_callback, cf);
> >>> +				return;
> >>> +		} else {
> >>> +			cf->query_next++;
> >>> +			if (cf->query_next =3D=3D cf->query_end)
> >>> +				break;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	reply =3D dbus_message_new_method_return(cf->pending);
> >>> +	__ofono_dbus_pending_reply(&cf->pending, reply);
> >>
> >> Really lost here,
> > =

> > Query_next and query_end tell only what to ask from query_next to
> > query_end. This causes pointless query if there is a value in the middle
> > which is already known. What this implementation does it prevents the
> > query if the condition is already known. =

> >   =

> =

> So the reason it is this way is that if we're querying via SS we want to
> force the query to proceed anyway.  Even if the value is already known.
>  This is really only a problem for *#002# and *#004# or if the request
> of all CF conditions failed as a result of get_properties.  In the
> latter case we don't set the cached flag and re-get all the cfs again.

Change is not done for reasons you think here. Fix above is part of
change made mainly for following error situation: =


oFono has conditional and unconditional conditions on. It is rebooted.
Network reports only unconditional status. User removes unconditional
status using SS API. API shows no active call forwardings.  =


In order to fix this is I changed the cf_ss_control to ask everything if
unconditional is erased. This causes unnecessary queries if the oFono is
not rebooted after setting the unconditional on and unconditional
conditions exists. This is is prevented with change above. =


> Please note that *#002# and *#004# are not valid MMI strings anyway
> according to 22.004 ("Interrogation of groups of Supplementary Services
> is not supported.") but I threw them in there since the logic was
> already implemented.  If it makes things easier we can limit this
> functionality.
> =

> Either way this chunk belongs in a separate patch.

Well, my opinion is that it's part of the same states showing correctly
change for the reasons explained above, but sure I can separate them. =


> >>> @@ -1180,8 +1236,14 @@ static gboolean cf_ss_control(int type, const =
char *sc,
> >>>  		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
> >>>  		break;
> >>>  	case CALL_FORWARDING_TYPE_ALL_CONDITIONAL:
> >>> -		cf->query_next =3D CALL_FORWARDING_TYPE_BUSY;
> >>> -		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
> >>
> >> I don't see how handling both these cases with the same code can work.=
..
> > =

> > Well at least in my testings if there is break and separate query_next
> > and query_end for CALL_FORWARDING_TYPE_ALL_CONDITIONAL erasing the
> > condition by using ss API does not remove conditions from API. =

> > =

> =

> Sorry I'm still confused with this change.  Maybe a more detailed trace
> would help?

I rechecked this and sent the new version to community in Tuesday. I
found out that although in API level it seemed to work nicely it
actually worked so that first query failed and after that oFono asked
all conditions from network when list-modems were run. New version does
not do that anymore. I brought back the separate query_next and
query_end there for ALL_CONDITIONAL. =


> >>> +	case CALL_FORWARDING_TYPE_UNCONDITIONAL:
> >>> +		if (type =3D=3D SS_CONTROL_TYPE_REGISTRATION) {
> >>> +			cf->query_next =3D cf->ss_req->cf_type;
> >>> +			cf->query_end =3D cf->ss_req->cf_type;
> >>> +		} else {
> >>> +			cf->query_next =3D cf->ss_req->cf_type;
> >>> +			cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
> >>> +		}
> >>
> >> I'm a bit lost here, can you explain some more what you're trying to
> >> accomplish?
> > =

> > I was looking for this: If the user sets call forwarding unconditional
> > or all conditional on, there is no reason to ask anything else since
> > implementation in cf_get_properties_reply prevents the showing. If user
> > clears the call forwarding unconditional all have to be asked. =

> > =

> =

> I see, so again I'm not sure this optimization is going to work.
> Suppose I run an registration to CFall to Number 1 via USSD.  Something
> like:
> =

> **002*+12345#
> =

> I do want all affected services to show up in my USSD.Initiate return
> dictionary with the results that the network is giving us.  Not anything
> that is cached by oFono.  Think of MMI codes as completely bypassing the
> cache but oFono peeking at them to update its own properties.
> =

> It might be helpful to think of this as two caches.  The conditional
> cache and the unconditional cache.  If the conditional values are
> updated when CFU is on, then we should clear the conditional cache and
> re-query them next time they are needed (e.g. when CFU is turned off)

Hmm. I'm not sure if I follow. Current functionality works so that no
matter if the conditional conditions are visible or not they are queried
after update. Basically it works as before except states not shown
anymore if unconditional is on. What you describe is chance for further
optimization, not a bug or problem. =


Please check out the new version of the patch. Maybe that clarifies the
case little bit. =


Br,
-Jussi



--===============2345084265642937945==--

