Content-Type: multipart/mixed; boundary="===============7771554454337021953=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] netreg: Add CPHS CSP implementation
Date: Thu, 03 Feb 2011 15:58:23 -0600
Message-ID: <4D4B24FF.1040508@gmail.com>
In-Reply-To: <AANLkTikYqwWwF7Wi1SCi78dim0QveT3=_s_9o9aT7rbB@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7771554454337021953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 02/03/2011 03:22 PM, Aki Niemi wrote:
> Hi Denis,
> =

> 2011/2/3 Denis Kenzior <denkenz@gmail.com>:
>>> +     if (netreg->mode =3D=3D NETWORK_REGISTRATION_MODE_AUTO_ONLY)
>>> +             return NULL;
>>> +
>>
>> So we might just return access_denied here as well.
> =

> There is a reason for allowing this, namely that sometimes you want to
> re-run the logic for automatically operator selection. Granted, this
> is not your most common use case, but since it also does no harm to
> allowing it, I didn't.
> =


This might not really work on all modem firmware though.  I'm not too
sure you want to do this.

>> This brings up another point, since the CPHS CSP file is actually
>> user-writeable (for some unknown reason) the user can remove the SIM,
>> put it in another phone and modify the forced-auto settings.  If you
>> store the forced-auto mode in the settings file, then there's no way to
>> ever go back to non-forced auto, even though he should be able to.
> =

> I think the above way will in fact default to auto even if the
> settings store has auto-only. And yes, EFcsp can definitely change
> even at run-time, as manual mode really should be allowed when
> roaming, at least in countries that the operator for instance has
> multiple suitable roaming partners with varying coverage.

CPHS 4.2 only says that the manual mode selection should be disabled, so
I'm assuming this magic happens via STK Refresh.  If so, then it might
be worth it to go back from forced-auto (if set) to auto when reading
the CSP file.

Regards,
-Denis

--===============7771554454337021953==--

