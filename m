Content-Type: multipart/mixed; boundary="===============6671974669478577521=="
MIME-Version: 1.0
From: jeevaka.badrappan@linux.intel.com
Subject: Re: [PATCH 2/4] voicecall: api for set/clear alpha and icon id
Date: Fri, 15 Jul 2011 09:41:28 -0700
Message-ID: <52928.10.254.189.70.1310748088.squirrel@linux.intel.com>
In-Reply-To: <4E2065EE.7010902@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6671974669478577521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>>  	}
>>
>> +	if (vc->dial_req) {
>> +		v->message =3D vc->dial_req->message;
>> +		v->icon_id =3D vc->dial_req->icon_id;
>> +
>> +		vc->dial_req->message =3D NULL;
>> +		vc->dial_req->call =3D v;
>> +
>> +		newcall->phone_number.type =3D vc->dial_req->ph.type;
>> +		strncpy(newcall->phone_number.number, vc->dial_req->ph.number,
>> +									20);
>
> Do you really want to do this?  I suspect we should override the phone
> number information only if the CLIP validity is not valid.

Agreed.

>
>> +
>> +		/*
>> +		 * TS 102 223 Section 6.4.13: The terminal shall not store
>> +		 * in the UICC the call set-up details (called party number
>> +		 * and associated parameters)
>> +		 */
>> +		v->untracked =3D TRUE;
>> +	}
>> +
>
> This looks fine, but there's a very subtle thing going on which breaks
> one particular case.  Some background, voicecall driver is free to
> notify the call before returning from the atd callback, or vice versa.
>
> So e.g.
>
> #1
> driver->dial(.., cb, data);
> ofono_voicecall_notify()
> cb(data);
>
> or
>
> #2
> driver->dial(..., cb, data);
> cb(data);
> ofono_voicecall_notify()
>
> In the case that oFono generates the Set Up Call Request and assuming
> driver behavior #1, you end up performing some steps twice.  Perhaps we
> should set a flag in vc->flags to indicate that the call setup is being
> initiated by the modem, and only trigger this path if this flag is set.
>

I haven't seen the case where the call status is notified before dial
callback. But agreed, we will end up in steps twice in this case. Proposed
change is fine with me. Will be incorporated in the next version.

>> +void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall
>> *vc)
>> +{
>> +	const char *number;
>> +
>> +	if (vc->dial_req =3D=3D NULL)
>> +		return;
>> +
>> +	number =3D phone_number_to_string(&vc->dial_req->ph);
>> +
>> +	/*
>> +	 * Incase the modem fails to setup the call and if there is no call
>> +	 * created, then the emergency mode has to be cleared.
>> +	 */
>> +	if (!strcmp(number, "112")) {
>> +		if (voicecalls_num_active(vc) =3D=3D 0 &&
>> +				voicecalls_num_connecting(vc) =3D=3D 0) {
>> +			struct ofono_modem *modem =3D
>> +					__ofono_atom_get_modem(vc->atom);
>> +
>> +			__ofono_modem_dec_emergency_mode(modem);
>> +		}
>> +	}
>
> I'm guessing what you're trying to take care of here is the case that
> the set up call might have been canceled before the call was notified,
> right?
>
> Wouldn't it be better to do:
>
> if (vc->dial_req->call =3D=3D NULL)
> 	...
>
> ?
>
> However, in the end I think it is simpler to only initiate the emergency
> mode when we have the call, and let it be deactivated by the disconnect
> notification.  Then this function becomes way simpler.
>
>> +
>> +	g_free(vc->dial_req->message);
>> +	vc->dial_req->message =3D NULL;
>> +
>> +	g_free(vc->dial_req);
>> +	vc->dial_req =3D NULL;
>> +}
>> +
>
> However, I'm actually questioning the need for this function since the
> cancellation can only be accomplished by hanging up the call before it
> is active, in which case the modem will take care of sending the
> appropriate terminal response.

Here, I'm trying to cover the following case:

1. oFono core is informed of the modem handled setup call and requests
user confirmation
2. User confirms the call
3. User confirmation sent to modem.
4. Due to some reason, modem is not able to setup the call. So, basically
oFono core is not notified of any call status notifications
5. Modem sends the terminal response to SAT and notifies oFono core of the
command/session completion

Regards,
Jeevaka

--===============6671974669478577521==--

