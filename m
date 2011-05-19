Content-Type: multipart/mixed; boundary="===============7830459546862825527=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH 2/4] voicecall: add ATD support for HFP emulator
Date: Thu, 19 May 2011 18:16:34 +0200
Message-ID: <4DD54262.3090008@linux.intel.com>
In-Reply-To: <4DD3F042.4050506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7830459546862825527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 18/05/2011 18:13, Denis Kenzior a =C3=A9crit :
> Hi Frederic,
>
>>>> +    if (!strncmp(number, "*31#", 4)) {
>>>> +        number +=3D 4;
>>>> +        clir =3D OFONO_CLIR_OPTION_INVOCATION;
>>>> +    } else if (!strncmp(number, "#31#", 4)) {
>>>> +        number +=3D 4;
>>>> +        clir =3D  OFONO_CLIR_OPTION_SUPPRESSION;
>>>> +    } else
>>>> +        clir =3D OFONO_CLIR_OPTION_DEFAULT;
>>>> +
>>>
>>> Actually this is not quite right.  The clir option is determined by the
>>> presence of 'I'/'i' characters at the end of the dial string.  Refer to
>>> 27.007 for more details.
>>>
>>> oFono does not actually recognize temporary forms of *31/#31
>>> invocation yet.
>>>
>> I added *31/#31 as I found them in telephony-ofono implementation of
>> BlueZ HFP AG,
>> but 27.007 uses I/i,
>> and HFP 1.5 does not seem to support clir option (ATDdd...dd;)
>>
>> Should I remove this part of code and only be compatible with HFP specs ?
>>
>
> Might as well handle the I/i and G/g part according to 27.007 since that
> is pretty easy and we'll have to do it anyway.  *31/#31 is really an MMI
> code, it should never be sent to the modem, so please remove that for now.
>
OK, so I will remove this part and will send a patch on I/i,G/g support =

later.

>>>> +    err =3D voicecall_dial(vc, number, clir, emulator_dial_callback, =
vc);
>>>> +    switch (err) {
>>>> +    case DIAL_NO_ERROR:
>>>> +        result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
>>>> +        break;
>>>> +
>>>> +    case DIAL_NO_NETWORK:
>>>> +        result.error =3D 30;
>>>> +        result.type =3D OFONO_ERROR_TYPE_CME;
>>>> +        break;
>>>
>>> This might need to be NO CARRIER
>>>
>> As far as I understand, when there is no network, ATD should reply NO
>> CARRIER if CMEE error mode is set to 0, or +CME ERROR: 30 if it is set
>> to 1.
>
> Not quite.  CMEE controls the presentation of 'extended' CME ERROR code.
>   Either as ERROR, CME ERROR:<num>  or CME ERROR:<str>.  NO CARRIER is
> not an extended error code at all, and so is only affected by ATV
> setting, not CMEE.
>
OK, thanks for your explanation.

>> So, I think that voicecall should return an OFONO_ERROR_TYPE_CME 30, and
>> ofono_emulator_send_final should take care of replying the right string.
>>
>
> Nope, you have to take your pick, either CME ERROR: 30, or NO CARRIER.
> I'd expect most implementations to reply with a NO CARRIER in this case,
> but can you check what other implementations do in reality?
>

In paragraph 6.2.13.11 of tr002v15, in reply to ATD command without =

network, the flowchart shows usage of +CME ERROR: 30 or ERROR reply (no =

usage of NO CARRIER).

Paragraph 4.33.2 of HFP 1.5 specification said that NO CARRIER (and =

BUSY, NO ANSWER, ...) "are in addition to the +CME ERROR: reponses".

My understanding of specs is that we should send the CME ERROR and, if =

we want, NO CARRIER in addition.

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============7830459546862825527==--

