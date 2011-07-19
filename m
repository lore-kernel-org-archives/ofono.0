Content-Type: multipart/mixed; boundary="===============8385836939319024021=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH] voicecall: fix callheld indicator for PTS
Date: Tue, 19 Jul 2011 15:50:13 +0200
Message-ID: <4E258B95.1070800@linux.intel.com>
In-Reply-To: <4E24621B.7070005@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8385836939319024021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 18/07/2011 18:40, Denis Kenzior a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
> On 07/18/2011 09:33 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
>> Fix PTS test TP/TWC/BV-03-I [Call Waiting- Hold Active/Retrieve
>> Waiting Call or Held].
>>
>> PTS test fails after receiving intermediate update of callheld indicator
>> with value 0 (no held call) before it receives update to value 1
>> (active and held calls). This is due to the non-atomic update of calls
>> status after call swap (moving first call to active state before moving
>> second one to hold state).
>
> Which scenario fails exactly?
> -<1-N>  Active + Waiting ->  Active + Held
> -<1-N>  Active + 1 Held ->  1 Active +<1-N>  Held
> - 1 Active +<1-N>  Held ->  <1-N>  Active + 1 Held
>
> Also note that you can't really count on the order of the updates, these
> are completely up to the implementation.
>

This test fails for (tested with phonesim) :
- 1st call held + 2nd call active -> 1st call active + 2nd call held

I understand that order of update for calls will be implementation =

dependent, this problem occurs when 1st call to be updated was held and =

become active.

>>
>> HFP 1.5 spec specifies that an update of callheld indicator to 1 should
>> be sent after AT+CHLD=3D2 command.
>> As oFono emulator sends +CIEV only if the indicator value changes, we
>> need to use an intermediate state for callheld indicator (2, all calls on
>> hold).
>>
>> So, in case of multiple active calls, or an active call with an active
>> mutiparty call, force update of callheld indicator to 2.
>> ---
>>   src/voicecall.c |   18 ++++++++++++++----
>>   1 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index 3646951..4b8373e 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -733,7 +733,8 @@ static void emulator_callheld_status_cb(struct ofono=
_atom *atom, void *data)
>>   static void notify_emulator_call_status(struct ofono_voicecall *vc)
>>   {
>>   	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>> -	gboolean call =3D FALSE;
>> +	unsigned int non_mpty =3D 0;
>> +	gboolean multiparty =3D FALSE;
>>   	gboolean held =3D FALSE;
>>   	gboolean incoming =3D FALSE;
>>   	gboolean dialing =3D FALSE;
>> @@ -750,7 +751,12 @@ static void notify_emulator_call_status(struct ofon=
o_voicecall *vc)
>>
>>   		switch (v->call->status) {
>>   		case CALL_STATUS_ACTIVE:
>> -			call =3D TRUE;
>> +			if (g_slist_find_custom(vc->multiparty_list,
>> +						GINT_TO_POINTER(v->call->id),
>> +						call_compare_by_id))
>> +				multiparty =3D TRUE;
>> +			else
>> +				non_mpty++;
>>   			break;
>
> What is this trying to achieve? You cannot have multiple calls in active
> / held state unless they are part of the mpty.  So if you have 3 active
> calls, all 3 must be on the mpty list.
>

As calls status are updated separately, you can have multiple active =

calls (for a short time) which are not part of a multi-party list :

  - 1st call held + 2nd call active (callheld indicator =3D 1)
      -> 1st call active + 2nd call active (intermediate state,
                                            callheld indicator =3D 0)
      -> 1st call active + 2nd call held (callheld indicator =3D 1)

>>
>>   		case CALL_STATUS_HELD:
>> @@ -775,7 +781,8 @@ static void notify_emulator_call_status(struct ofono=
_voicecall *vc)
>>   		}
>>   	}
>>
>> -	data.status =3D call || held ? OFONO_EMULATOR_CALL_ACTIVE :
>> +	data.status =3D non_mpty || multiparty || held ?
>> +					OFONO_EMULATOR_CALL_ACTIVE :
>>   					OFONO_EMULATOR_CALL_INACTIVE;
>>
>>   	__ofono_modem_foreach_registered_atom(modem,
>> @@ -799,8 +806,11 @@ static void notify_emulator_call_status(struct ofon=
o_voicecall *vc)
>>   						&data);
>>
>>   	if (held)
>> -		data.status =3D call ? OFONO_EMULATOR_CALLHELD_MULTIPLE :
>> +		data.status =3D (non_mpty || multiparty) ?
>> +					OFONO_EMULATOR_CALLHELD_MULTIPLE :
>>   					OFONO_EMULATOR_CALLHELD_ON_HOLD;
>> +	else if (non_mpty>  1 || (non_mpty&&  multiparty))
>> +		data.status =3D OFONO_EMULATOR_CALLHELD_ON_HOLD;
>>   	else
>>   		data.status =3D OFONO_EMULATOR_CALLHELD_NONE;
>>
>
> I think a different approach is needed.  One idea off the top of my
> head:  Can we mark calls which we foresee being as part of the
> transaction and only send the status updates once all of them have
> entered the desired state.
>

I agree with you this should be the best way, but:

- currently in voicecall atom during call swap, and as far as I =

understand, the calls are updated separately from the modem driver and =

there is no way to know when this update ends.
I do not found a way to perform this with certainty that it will not =

break actual behavior (regarding DBus), This is why I proposed this =

hack, limited to emulator related code.

- currently HFP indicators are only sent when their value changes, we =

need to move through an intermediate state (callheld =3D 2), or =

add/change API to be able to force the sending of the indicator.

> Regards,
> -Denis

Regards

Fred


-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============8385836939319024021==--

