Content-Type: multipart/mixed; boundary="===============1382544206983388504=="
MIME-Version: 1.0
From: jeevaka.badrappan@linux.intel.com
Subject: Re: [PATCH 3/4] stk: Handle set up call in handled_notify
Date: Fri, 15 Jul 2011 09:45:28 -0700
Message-ID: <52936.10.254.189.70.1310748328.squirrel@linux.intel.com>
In-Reply-To: <4E206C32.3060000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1382544206983388504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> +static void proactive_command_handled_end(struct ofono_stk *stk)
>> +{
>> +	stk->modem_handled_cmd =3D FALSE;
>> +
>> +	if (stk->pending_cmd =3D=3D NULL)
>> +		return;
>> +
>> +	switch(stk->pending_cmd->type) {
>> +	case STK_COMMAND_TYPE_SETUP_CALL:
>> +	{
>> +		struct ofono_voicecall *vc =3D NULL;
>> +		struct ofono_atom *vc_atom;
>> +
>> +		vc_atom =3D __ofono_modem_find_atom(
>> +					__ofono_atom_get_modem(stk->atom),
>> +					OFONO_ATOM_TYPE_VOICECALL);
>> +		if (vc_atom)
>> +			vc =3D __ofono_atom_get_data(vc_atom);
>> +
>> +		if (vc !=3D NULL)
>> +			__ofono_voicecall_clear_alpha_and_icon_id(vc);
>> +
>> +		break;
>> +	}
>> +
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>
> So I'm still not sure this part is actually needed.  Once the user has
> acknowledged the call, there is no way for us to cancel it until the
> call is notified to the voicecall driver.  So unless the modem is drunk,
> I don't really see the need to cover this case.
>
> Once the call is notified to voicecall driver, then the need for
> clearing alpha/icon id disappears.  The voicecall driver will do this
> automatically based on the ofono_voicecall_disconnected notification.
>
> What do you guys think?

As pointed in other mail thred, trying to cover the following case:

1. oFono core is informed of the modem handled setup call and requests
user confirmation
2. User confirms the call
3. User confirmation sent to modem.
4. Due to some reason, modem is not able to setup the call. So, basically
oFono core is not notified of any call status notifications
5. Modem sends the terminal response to SAT and notifies oFono core of the
command/session completion

Basically, if the modem due to some reason fails to initiate/setup the
call and call status notifications not sent to the voice call driver side.
This case, we will be left with dial_req, message and icon id set but not
freed.

Regards,
Jeevaka

--===============1382544206983388504==--

