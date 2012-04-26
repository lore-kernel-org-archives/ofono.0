Content-Type: multipart/mixed; boundary="===============2510068057033297146=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv4 11/13] call-forwarding: Re-run ss path queries on CFU
 unset
Date: Thu, 26 Apr 2012 10:54:48 +0300
Message-ID: <4F98FF48.70201@intel.com>
In-Reply-To: <4F970B3E.6010006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2510068057033297146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 04/24/2012 11:21 PM, Denis Kenzior wrote:
>> OK, thanks, I see. Would it make sense to return the method immediately
>> and then to re-query the conditionals? Or, just to wait until anybody
>> needs them?
>
> This probably needs a bit of thought, but here's one possible strategy,
> feel free to suggest any improvements:
>
> - If unconditional is reset and conditionals are known (e.g. they were
> queried before and not cleared) then we can simply signal them here
>
> - If the unconditional is reset and the CACHED flag is not set (e.g. the
> application didn't trigger a GetProperties yet) then we probably can
> skip the re-query, the next GetProperties will do it for us.
>
> - If unconditional is reset and CACHED is set but we don't know the
> conditionals, then we should query all conditionals before returning
> from the method call.

Thanks for the help here. On a first thought, in order to differ 1) from 3) =

might require a flag, but let me check if the specific code path for re-que=
rying =

the conditionals might be cleaner.

>>> Also, there is an optimization we can make here, e.g. if we queried the
>>> conditional forwarding settings prior to CFU being enabled, then we can
>>> keep those around.  This is why the TODO item refers to the 'conditional
>>> cache.'  In the case of CFU being flipped to enabled and then disabled,
>>> we do not need to query.
>>
>> Thanks for the help here. Let's go for this approach too.
>
> Okay, just remember the conditionals can be erased when CFU is active,
> including through MMI codes.

OK, thanks, will check regarding MMI.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============2510068057033297146==--

