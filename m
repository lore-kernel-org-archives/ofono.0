Content-Type: multipart/mixed; boundary="===============3314559744360252076=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] STE-driver: Terminating voice call in state
 DIALING/ALERTING.
Date: Thu, 05 Aug 2010 11:24:12 -0500
Message-ID: <4C5AE5AC.70806@gmail.com>
In-Reply-To: <1280931716-2811-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3314559744360252076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 08/04/2010 09:21 AM, Sjur Br=C3=A6ndeland wrote:
> From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
> =

> This patch splits the callback hangup into hangup_all and hangup_active.
> =

> ---
> Hi Denis,
> I'm picking up a really old thread here...

Yes a really old thread ;)

> =

>> Denis Kenzior wrote:
>>>>> c) If you have an call on hold and initiate a new call, but want to
>>>>> terminate the newly initiated call (DIALING), then this call cannot
>>>>> be terminated with CHLD=3D1X, but you would have to use ATH (or
>>>>> possible CHUP).
>>>>
>>>> Yes, so this is the case that we do need to take care of in the core.
>>>> Most
>>>> modems let us get away with sending release_specific up to this point.
>>>
>>> For the STE modem, calls in state DIALING and ALERTING will have to be
>>>  terminated with ATH or AT+CHUP, AT+CHLD=3D1x does not work. This means=
 that
>>>  the current implementation, using release_specific (and thus AT+CHLD=
=3D1x)
>>>  will not work.
>>
>> Yep, so please critique my earlier suggestion of splitting up hangup
>> into two methods: hangup_all and hangup_active.  Modem drivers will need=
 to
>> provide one or the other or both.
>> The core can then use the hangup_active (if available) in those cases wh=
ere
>> release_specific might not work.  The condition for hangup_active will b=
e that
>> it does not affect held or waiting calls.  For ST-E the hangup_active
>> implementation will simply be +CHUP. For modems that do not have this
>> available we will fall back to release_specific and assume that on those
>> CHLD=3D1X or equivalent can affect dialing/alerting calls.
> =

> If I understand you correctly STE driver should implement
> hangup_active using +CUP. Core should then use hangup_active on calls
> in state DIALING and ALERTING - Yes, I think this would work.
> =

>> hangup_all can also be used for cases where we loop release_specific
>> over all active/dialing/alerting/held/incoming calls.  For ST-E the hang=
up_all
>> implementation might be +CHUP;CHLD=3D1n;...;+CHLD=3D1m where n, m, etc a=
re
>> ids of the HELD calls.  We should not hangup waiting calls to be complia=
nt
>> with section 6.5.5.1 of 3GPP 22.030:
>> "Entering END	-Releases the subscriber from all calls
>> (except a possible waiting call)."
> =

> I guess the stedriver will not implement the hangup_all because the STE
> modem does not have an AT command for terminating all calls. (I assume you
> don't want the driver to iterate over calls constructing a command like:
> "+CHUP;CHLD=3D1n;...;+CHLD=3D1m").
> =

> I've probably not understood your proposal fully, but I have tried to
> put together some code based on it. Please have a look and check if =

> you had something like this in mind.
> =

> However, I think we can solve this even simpler if we just
> call hangup for any ALERTING/DIALING call..

This is a real gray area.  On some devices this will work, on others it
might have un-intentional consequences.  At least on the calypso,
sending CHUP/ATH will terminate all calls not in the WAITING state.

> =

> Regards
> Sjur
> =

> diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
> index a56709a..2ddae05 100644
> --- a/drivers/stemodem/voicecall.c
> +++ b/drivers/stemodem/voicecall.c
> @@ -260,7 +260,7 @@ static void ste_answer(struct ofono_voicecall *vc,
>  	ste_template("ATA", vc, ste_generic_cb, 0, cb, data);
>  }
>  =

> -static void ste_hangup(struct ofono_voicecall *vc,
> +static void ste_hangup_active(struct ofono_voicecall *vc,
>  			ofono_voicecall_cb_t cb, void *data)
>  {
>  	ste_template("AT+CHUP", vc, ste_generic_cb, 0x3f, cb, data);
> @@ -569,7 +569,7 @@ static struct ofono_voicecall_driver driver =3D {
>  	.remove			=3D ste_voicecall_remove,
>  	.dial			=3D ste_dial,
>  	.answer			=3D ste_answer,
> -	.hangup			=3D ste_hangup,
> +	.hangup_active		=3D ste_hangup_active,
>  	.hold_all_active	=3D ste_hold_all_active,
>  	.release_all_held	=3D ste_release_all_held,
>  	.set_udub		=3D ste_set_udub,
> diff --git a/include/voicecall.h b/include/voicecall.h
> index 6ceb3d8..2500e5f 100644
> --- a/include/voicecall.h
> +++ b/include/voicecall.h
> @@ -67,7 +67,11 @@ struct ofono_voicecall_driver {
>  			ofono_voicecall_cb_t cb, void *data);
>  	void (*answer)(struct ofono_voicecall *vc,
>  			ofono_voicecall_cb_t cb, void *data);
> -	void (*hangup)(struct ofono_voicecall *vc,
> +	void (*hangup_all)(struct ofono_voicecall *vc,
> +			ofono_voicecall_cb_t cb, void *data);
> +/* HACK: for temporary backwards compability */
> +#define hangup_active hangup
> +	void (*hangup_active)(struct ofono_voicecall *vc,
>  			ofono_voicecall_cb_t cb, void *data);
>  	void (*hold_all_active)(struct ofono_voicecall *vc,
>  			ofono_voicecall_cb_t cb, void *data);
> diff --git a/src/voicecall.c b/src/voicecall.c
> index a30aaa5..a420777 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -264,12 +264,12 @@ static DBusMessage *voicecall_hangup(DBusConnection=
 *conn,
>  	/* According to various specs, other than 27.007, +CHUP is used
>  	 * to reject an incoming call
>  	 */
> -	if (call->status =3D=3D CALL_STATUS_INCOMING) {
> +	if (vc->driver->hangup_active && call->status =3D=3D CALL_STATUS_INCOMI=
NG) {

You're breaking the logic somewhat here.  If the call is INCOMING, we
shouldn't skip the rest of the block if hangup_active is not implemented.

>  		if (vc->driver->hangup =3D=3D NULL)
>  			return __ofono_error_not_implemented(msg);
>  =

>  		vc->pending =3D dbus_message_ref(msg);
> -		vc->driver->hangup(vc, generic_callback, vc);
> +		vc->driver->hangup_active(vc, generic_callback, vc);
>  =

>  		return NULL;
>  	}

Here we need to check whether hangup_active or hangup_all are
implemented. If both are, then prefer hangup_all.  This would make it
easier to keep compatibility with current drivers.

> @@ -286,12 +286,12 @@ static DBusMessage *voicecall_hangup(DBusConnection=
 *conn,
>  =

>  	num_calls =3D g_slist_length(vc->call_list);
>  =

> -	if (num_calls =3D=3D 1 && vc->driver->hangup &&
> +	if (vc->driver->hangup_active && num_calls =3D=3D 1 && vc->driver->hang=
up &&

This should probably be a condition something like:

if (num_calls =3D=3D 1 && (vc->driver->hangup || vc->driver->hangup_active)
...

>  			(call->status =3D=3D CALL_STATUS_ACTIVE ||
>  				call->status =3D=3D CALL_STATUS_DIALING ||
>  				call->status =3D=3D CALL_STATUS_ALERTING)) {
>  		vc->pending =3D dbus_message_ref(msg);
> -		vc->driver->hangup(vc, generic_callback, vc);
> +		vc->driver->hangup_active(vc, generic_callback, vc);

And again prefer hangup_all over hangup_active to keep compatibility
with old drivers.

>  =

>  		return NULL;
>  	}
> @@ -304,6 +304,16 @@ static DBusMessage *voicecall_hangup(DBusConnection =
*conn,
>  		return NULL;
>  	}
>  =

> +	if (vc->driver->hangup_active !=3D NULL &&
> +		(call->status =3D=3D CALL_STATUS_ALERTING ||
> +			call->status =3D=3D CALL_STATUS_DIALING)) {
> +
> +		vc->pending =3D dbus_message_ref(msg);
> +		vc->driver->hangup_active(vc, generic_callback, vc);
> +
> +		return NULL;
> +	}
> +

This seems reasonable

>  	if (vc->driver->release_specific =3D=3D NULL)
>  		return __ofono_error_not_implemented(msg);
>  =

> @@ -762,7 +772,14 @@ static void voicecalls_release_next(struct ofono_voi=
cecall *vc)
>  =

>  	vc->release_list =3D g_slist_remove(vc->release_list, call);
>  =

> -	vc->driver->release_specific(vc, call->call->id,
> +	if (vc->driver->hangup_active !=3D NULL &&
> +		(call->call->status =3D=3D CALL_STATUS_ALERTING ||
> +			call->call->status =3D=3D CALL_STATUS_DIALING ||
> +			call->call->status =3D=3D CALL_STATUS_INCOMING))

This reminds me that we should treat INCOMING calls in HangupAll
specially.  It should not be handled here.  HangupAll should also skip
waiting calls.

> +
> +		vc->driver->hangup_active(vc, multirelease_callback, vc);
> +	else
> +		vc->driver->release_specific(vc, call->call->id,
>  						multirelease_callback, vc);
>  }
>  =

> @@ -1131,9 +1148,12 @@ static DBusMessage *manager_hangup_all(DBusConnect=
ion *conn,
>  =

>  	vc->pending =3D dbus_message_ref(msg);
>  =

> -	voicecalls_release_queue(vc, vc->call_list);
> -	voicecalls_release_next(vc);
> -
> +	if (vc->driver->hangup_all !=3D NULL)
> +		vc->driver->hangup_all(vc, generic_callback, vc);
> +	else {
> +		voicecalls_release_queue(vc, vc->call_list);
> +		voicecalls_release_next(vc);
> +	}

This looks reasonable.

>  	return NULL;
>  }
>  =


Regards,
-Denis

--===============3314559744360252076==--

