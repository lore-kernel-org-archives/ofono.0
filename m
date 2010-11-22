Content-Type: multipart/mixed; boundary="===============0710025747166174800=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [isi-voicecall-fix PATCHv3 1/6] voicecall: fix dial result
 handling
Date: Mon, 22 Nov 2010 18:50:11 +0200
Message-ID: <AANLkTi=s92Bwsw3Tvd0FzZkjWZYRQs3X2PfOMCXVN1oU@mail.gmail.com>
In-Reply-To: <4CEA739C.4070401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0710025747166174800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/11/22 Denis Kenzior <denkenz@gmail.com>:
>> If there is an existing active call when dialing the existing call will
>> be automatically put on hold. The dialing result handling depended on
>> the voicecall driver putting the call on hold before the dial command
>> callback is called.
>>
>> However, this is not true on isimodem driver, where the dial request
>> returns immediately before the existing call have changed its
>> status. The dial result handling now checks if the active call has been
>> resulted from the dial request.
>> ---
>> =C2=A0src/voicecall.c | =C2=A0 18 ++++++++++++++++--
>> =C2=A01 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index bd64432..e3ce2a5 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -68,6 +68,7 @@ struct voicecall {
>> =C2=A0 =C2=A0 =C2=A0 char *message;
>> =C2=A0 =C2=A0 =C2=A0 uint8_t icon_id;
>> =C2=A0 =C2=A0 =C2=A0 gboolean untracked;
>> + =C2=A0 =C2=A0 gboolean dial_result_handled;
>> =C2=A0};
>>
>> =C2=A0struct dial_request {
>> @@ -1096,9 +1097,20 @@ static struct voicecall *dial_handle_result(struc=
t ofono_voicecall *vc,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D l->data;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v->call->status =3D=
=3D CALL_STATUS_DIALING ||
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 v->call->status =3D=3D CALL_STATUS_ALERTING ||
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 v->call->status =3D=3D CALL_STATUS_ACTIVE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 v->call->status =3D=3D CALL_STATUS_ALERTING)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return v;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Dial request may ret=
urn before existing active call
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is put on hold or af=
ter dialed call has got active
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v->call->status =3D=3D C=
ALL_STATUS_ACTIVE &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 v->call->direction =3D=3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 CALL_DIRECTION_MOBILE_ORIGINATED &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 !v->dial_result_handled) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
v->dial_result_handled =3D TRUE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return v;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> I really don't see how this can work, since you never reset
> dial_result_handled to FALSE anywhere.

Huh? voicecall_create() uses g_new0().

For each outbound call there should be exactly one dial request, once
that is returned in dial_handle_result(), the dial_result_handled
should be TRUE.

I'll fix the above code.

>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 call =3D synthesize_outgoing_call(vc, number);
>> @@ -1119,6 +1131,8 @@ static struct voicecall *dial_handle_result(struct=
 ofono_voicecall *vc,
>>
>> =C2=A0 =C2=A0 =C2=A0 *need_to_emit =3D TRUE;
>>
>> + =C2=A0 =C2=A0 v->dial_result_handled =3D TRUE;
>> +
>
> dial_handle_result is ever called once, why do you need to set this here?

This prevents mixing this call with the call dialed next.

> This seems to be the wrong way to go, is there any way for you to delay
> returning from the dial operation until the call is put on hold?

While it is technically possible it does not make much sense.

-- =

Pekka.Pessi mail at nokia.com

--===============0710025747166174800==--

