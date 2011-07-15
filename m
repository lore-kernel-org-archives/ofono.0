Content-Type: multipart/mixed; boundary="===============7763333709790899266=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] stk: Handle set up call in handled_notify
Date: Fri, 15 Jul 2011 11:59:53 -0500
Message-ID: <4E207209.6090501@gmail.com>
In-Reply-To: <52936.10.254.189.70.1310748328.squirrel@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7763333709790899266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 07/15/2011 11:45 AM, jeevaka.badrappan(a)linux.intel.com wrote:
> Hi Denis,
> =

>>> +static void proactive_command_handled_end(struct ofono_stk *stk)
>>> +{
>>> +	stk->modem_handled_cmd =3D FALSE;
>>> +
>>> +	if (stk->pending_cmd =3D=3D NULL)
>>> +		return;
>>> +
>>> +	switch(stk->pending_cmd->type) {
>>> +	case STK_COMMAND_TYPE_SETUP_CALL:
>>> +	{
>>> +		struct ofono_voicecall *vc =3D NULL;
>>> +		struct ofono_atom *vc_atom;
>>> +
>>> +		vc_atom =3D __ofono_modem_find_atom(
>>> +					__ofono_atom_get_modem(stk->atom),
>>> +					OFONO_ATOM_TYPE_VOICECALL);
>>> +		if (vc_atom)
>>> +			vc =3D __ofono_atom_get_data(vc_atom);
>>> +
>>> +		if (vc !=3D NULL)
>>> +			__ofono_voicecall_clear_alpha_and_icon_id(vc);
>>> +
>>> +		break;
>>> +	}
>>> +
>>> +	default:
>>> +		break;
>>> +	}
>>> +}
>>> +
>>
>> So I'm still not sure this part is actually needed.  Once the user has
>> acknowledged the call, there is no way for us to cancel it until the
>> call is notified to the voicecall driver.  So unless the modem is drunk,
>> I don't really see the need to cover this case.
>>
>> Once the call is notified to voicecall driver, then the need for
>> clearing alpha/icon id disappears.  The voicecall driver will do this
>> automatically based on the ofono_voicecall_disconnected notification.
>>
>> What do you guys think?
> =

> As pointed in other mail thred, trying to cover the following case:
> =

> 1. oFono core is informed of the modem handled setup call and requests
> user confirmation
> 2. User confirms the call
> 3. User confirmation sent to modem.
> 4. Due to some reason, modem is not able to setup the call. So, basically
> oFono core is not notified of any call status notifications
> 5. Modem sends the terminal response to SAT and notifies oFono core of the
> command/session completion
> =

> Basically, if the modem due to some reason fails to initiate/setup the
> call and call status notifications not sent to the voice call driver side.
> This case, we will be left with dial_req, message and icon id set but not
> freed.
> =


OK I see now.  In theory we could do some basic sanity checks (e.g.
modem is online, etc) to alleviate this, but your proposal is probably
safer even if more complicated.

Also, you probably can formalize proactive_command_handled_end and not
call stk_unset_alpha_id unnecessarily in the case of modem-handled Set
Up Call.

And I'm still not sure about modem_handled_cmd variable.  Can't you set
cancel_cmd to proactive_command_handled_end?

Regards,
-Denis

--===============7763333709790899266==--

