Content-Type: multipart/mixed; boundary="===============3948033039130224660=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH V3 2/4] voicecall: add ATD support for HFP emulator
Date: Tue, 07 Jun 2011 17:01:51 +0200
Message-ID: <4DEE3D5F.6030809@linux.intel.com>
In-Reply-To: <4DEC36CC.1060306@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3948033039130224660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 06/06/2011 04:09, Denis Kenzior a =C3=A9crit :
> Hi Frederic,
>
> <snip>
>
>>>> +
>>>> +    if (vc->pending_em) {
>>>> +        result.type =3D OFONO_ERROR_TYPE_FAILURE;
>>>> +        goto send;
>>>> +    }
>>>
>>> You might also want to check that the Dial is not happening via D-Bus or
>>> STK, and vice-versa.
>>
>> Voicecall_dial will check if there is already a pending outgoing call.
>> I think this is sufficient to manage concurrent ATD between D-Bus, STK
>> and emulator.
>>
>
> No, it isn't.  voicecall_dial only checks for dialing / alerting calls.
>   However, you have to remember that the call isn't created until the
> dial callback returns or ofono_voicecall_notify is called with the newly
> created call.  This can take some time (e.g. due to queuing on the
> GAtChat object), and during this time new Dial requests have to be reject=
ed.
>
> D-Bus API implementation handles this by using vc->pending (and it is a
> bug that it doesn't check vc->dial_req).   STK handles this by checking
> vc->pending and the existence of dial_req object.
>
> Once you introduce the emulator, there is no cross-checking between the
> emulator and the existing ways.  Between emulators you handle this by
> using vc->pending_em, but you should also be checking that a Dial hasn't
> been scheduled via STK/D-Bus API.
>
> Regards,
> -Denis

OK
Thanks for your explanation, hope rest of v4 of my patches are OK, I =

will prepare the v5 to manage this correctly

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============3948033039130224660==--

