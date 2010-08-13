Content-Type: multipart/mixed; boundary="===============5607062389483494238=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: Terminating emergency calls
Date: Fri, 13 Aug 2010 15:44:22 +0200
Message-ID: <AANLkTiktt2fgxpRyg__p+f__K2gYx3kVLEXM30sfCFQf@mail.gmail.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B3528F0C61C@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5607062389483494238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 Zhang, Zhenhua <zhenhua.zhang@intel.com> wrote:
>> Denis Kenzior <denkenz@gmail.com> wrote:
>>>> I thought of one more issue with voice calls.
>>>> I don't think it is safe to to terminate emergency calls using
>>>> release_specific, AT+CHLD=3D1X. At least this don't work for STE
>>>> modems.
>>>>
>>>> I suggest calls in state active should be terminated using
>>>> hangup_all or hangup_active. What do you think?
>>>
>>> So in the case of a single call, the emergency call will be
>>> terminated using hangup_all / hangup_active anyway. =C2=A0I have relaxed
>>> the single call restriction for active calls when hangup_active is
>>> provided by the
>>> driver. =C2=A0Refer to c7b13ec2fe664b122216a312f2442c9ca26f5f43
>>
>> Yes, it seems to be ok for voicecall_hangup, but in manager_hangup_all
>> the active call is still terminated with release_specific in
>> voiceall_release_next.
>> This implies that if you have an emergency call and terminate it with
>> manager_hangup_all AT+CHLD=3D1X still will be used, right?
>>
>> I suggest we change voicecall_release_next like this:
>>
>> =C2=A0 =C2=A0 =C2=A0 if (vc->driver->hangup_active !=3D NULL &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (call->call->status =3D=3D CALL_STATUS_ALERTING ||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 call->call->status =3D=3D CALL_STATUS_DI=
ALING ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 call->call->status =3D=3D CALL_STATUS_ACTIVE ||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 call->call->status =3D=3D CALL_STATUS_IN=
COMING))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc->driver->hangup_acti=
ve(vc, multirelease_callback, vc);
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc->driver->release_spe=
cific(vc, call->call->id,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 multirelease_callback, vc);
>>
>>> For mpty calls this gets tricky. =C2=A0I'd like some answers to these
>>> questions:
>>>
>>> - Can Emergency calls participate in mpty?
>>
>> I have to verify this with some of my colleagues, but I am pretty sure
>> emergency calls cannot be applied to the AT+CHLD command. i.e. they
>> cannot be part of mpty.

Initial testing on STE modem indicates that emergency call cannot
participate in multi call or be put on hold.

>
> If emergency calls cannot be part of mpty call, we can use either hangup_=
all or
> hangup_active as Denis said. However, your suggested fix will break multi=
party call
> scenario since multiparty_hangup calls voicecall_release_next as well.

Yes, you're right using hangup_active will terminate all active calls
participating in a multi call.
So my proposal will not work as is. Maybe we need to know if
release_next was called for multi call?

>Maybe we
> should use call->type to indicate whether it's an emergy call. It looks t=
o me that the
> type flag in struct ofono_call hasn't been used yet. Correct me if I am w=
rong.

Regards
Sjur

--===============5607062389483494238==--

