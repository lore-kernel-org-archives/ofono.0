Content-Type: multipart/mixed; boundary="===============4349444483318865160=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [isi-voicecall-fix PATCHv3 1/6] voicecall: fix dial result
 handling
Date: Mon, 22 Nov 2010 11:27:26 -0600
Message-ID: <4CEAA7FE.1080908@gmail.com>
In-Reply-To: <AANLkTi=s92Bwsw3Tvd0FzZkjWZYRQs3X2PfOMCXVN1oU@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4349444483318865160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

>>> +     gboolean dial_result_handled;
>>>  };

So I'm finally beginning to understand where you're going with this..

>>>
>>>  struct dial_request {
>>> @@ -1096,9 +1097,20 @@ static struct voicecall *dial_handle_result(stru=
ct ofono_voicecall *vc,
>>>               v =3D l->data;
>>>
>>>               if (v->call->status =3D=3D CALL_STATUS_DIALING ||
>>> -                             v->call->status =3D=3D CALL_STATUS_ALERTI=
NG ||
>>> -                             v->call->status =3D=3D CALL_STATUS_ACTIVE)
>>> +                             v->call->status =3D=3D CALL_STATUS_ALERTI=
NG)
>>>                       return v;

So if I understand correctly, you want to set dial_result_handled to
TRUE here as well, right?

>>> +
>>> +             /*
>>> +              * Dial request may return before existing active call
>>> +              * is put on hold or after dialed call has got active
>>> +              */
>>> +             if (v->call->status =3D=3D CALL_STATUS_ACTIVE &&
>>> +                             v->call->direction =3D=3D
>>> +                             CALL_DIRECTION_MOBILE_ORIGINATED &&
>>> +                             !v->dial_result_handled) {
>>> +                     v->dial_result_handled =3D TRUE;
>>> +                     return v;
>>> +             }
>>
>> I really don't see how this can work, since you never reset
>> dial_result_handled to FALSE anywhere.
> =

> Huh? voicecall_create() uses g_new0().
> =


So that is the piece I was missing.  Now I understand, thanks.

> For each outbound call there should be exactly one dial request, once
> that is returned in dial_handle_result(), the dial_result_handled
> should be TRUE.
> =

> I'll fix the above code.

Are you referring to setting dial_result_handled to TRUE for
ALERTING/DIALING or something else?

> =

>>>       }
>>>
>>>       call =3D synthesize_outgoing_call(vc, number);
>>> @@ -1119,6 +1131,8 @@ static struct voicecall *dial_handle_result(struc=
t ofono_voicecall *vc,
>>>
>>>       *need_to_emit =3D TRUE;
>>>
>>> +     v->dial_result_handled =3D TRUE;
>>> +
>>
>> dial_handle_result is ever called once, why do you need to set this here?
> =

> This prevents mixing this call with the call dialed next.
>

And this one makes sense now as well.  So I'm actually fine with the
fix.  Do you want to resend the patch?

Regards,
-Denis

--===============4349444483318865160==--

