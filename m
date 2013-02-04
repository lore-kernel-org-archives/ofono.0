Content-Type: multipart/mixed; boundary="===============4220332937661382072=="
MIME-Version: 1.0
From: Timo =?unknown-8bit?q?M=C3=BCller?= <mail@timomueller.eu>
Subject: Re: [PATCHv2 2/2] hfpmodem: Request AT+CLCC again after callheld=<2
 or 3>
Date: Mon, 04 Feb 2013 17:20:13 +0100
Message-ID: <510FDFBD.8020900@timomueller.eu>
In-Reply-To: <5109EE68.5050109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4220332937661382072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote, On 31.01.2013 05:09:
> Hi Timo,
>
> On 01/28/2013 04:13 AM, Timo Mueller wrote:
>> From: Timo Mueller<timo.mueller@bmw-carit.de>
>>
>> With a call being active, placing a second call on the AG device will
>> lead to the active call being put on hold. During the transition some
>> phones do not update the list of current calls. This leads to an +CLCC
>> response that does not contain the new outgoing call, even though an
>> outgoing callsetup was reported.
>>
>> The list will be updated once the active call was put on hold and
>> callheld=3D2 is reported. In this case the list has to be requested
>> again (AT+CLCC).
>>
>> AT sequence that exhibited the failure (AG device was a Nokia N9
>> having an active outgoing call and placing a second outgoing call)
>>
>
> Ugh.
>
> <snip>
>
>> @@ -1072,6 +1074,14 @@ static void ciev_callheld_notify(struct
>> ofono_voicecall *vc,
>>                   call->status =3D CALL_STATUS_HELD;
>>                   ofono_voicecall_notify(vc, call);
>>               }
>> +
>> +            if (callsetup =3D=3D 2 || callsetup =3D=3D 3) {
>> +                dialing =3D find_dialing(vd->calls);
>> +
>> +                if (dialing =3D=3D NULL)
>> +                    g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
>> +                        clcc_poll_cb, vc, NULL);
>> +            }
>>           } else if (callheld =3D=3D 1) {
>>               if (vd->clcc_source)
>>                   g_source_remove(vd->clcc_source);
>
> I'm seeing reports of too many devices doing too many weird things, and
> if we change the core logic for each and every one then the code becomes
> a huge mess quickly.  It would be hard to validate or regression test it
> without massive investment in automated interoperability testing.
>
> Marcel and I spoke briefly about this and our belief is that we need to
> introduce manufacturer specific quirks to HFP drivers instead of trying
> to solve this generically.
>
> BlueZ should be able to provide us enough information about the remote
> device for us to make a fairly good guess as to the manufacturer /
> version.  Additional details can be queried by manufacturer specific
> commands (e.g. in the case of iOS).  That should be enough for us to
> simply set the vendor / quirk ID and take appropriate action in the drive=
r.
>
> We can always fall back to strict spec compliant behavior by default if
> the manufacturer quirks cannot be determined.  What do you think?

I agree, that the core logic shouldn't be polluted with phone specific =

workarounds. This is especially true when the quirks somehow interfere =

or modify the standard path. Having said this, I'd consider this fix =

general enough to justify it's integration in the standard driver, since =

the policy makes sense for any phone (mis)behaving this way, keeping the =

phone specific quirks to an absolute minimum.

I know that the N9 is the only phone that has seen this problem so far, =

but the problem will occur with every phone that doesn't "atomically" =

change the CLCC list the moment it reports an indicator change (+CIEV).

As described in the commit message the phone already told the HF that it =

has set up an outgoing call (or that it's already alerting). The  only =

thing missing is the detailed information about the call, which is =

retrieved using the AT+CLCC request.

So in this case I think it's valid to generally try to fill in the =

missing information by issuing another AT+CLCC request. Otherwise the =

call will be alerting and although the phone has reported all indicator =

changes to oFono, we won't be able to reasonably control it from HF side.

>
> Regards,
> -Denis

Best regards,
Timo


--===============4220332937661382072==--

