Content-Type: multipart/mixed; boundary="===============4650826356715335371=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [isi-voicecall-fix PATCHv3 2/6] isi/voicecall: fix status
 reporting
Date: Mon, 22 Nov 2010 10:37:37 -0600
Message-ID: <4CEA9C51.6090801@gmail.com>
In-Reply-To: <AANLkTin3+7yTxJq8WPELPBV=oLhe-m2nizrbkXN=AABp@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4650826356715335371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 11/22/2010 10:09 AM, Pekka Pessi wrote:
> Hi Denis,
> =

>>> +enum clcc_status {
>>> +     CLCC_STATUS_ACTIVE =3D 0,
>>> +     CLCC_STATUS_HOLD =3D 1,
>>> +     CLCC_STATUS_DIALING =3D 2,
>>> +     CLCC_STATUS_ALERTING =3D 3,
>>> +     CLCC_STATUS_INCOMING =3D 4,
>>> +     CLCC_STATUS_WAITING =3D 5,
>>> +     CLCC_STATUS_DISCONNECTED =3D 6, /* Nonstandard */
>>> +};
>>
>> Please follow M11 completely here, particularly the tabs before the valu=
es.
> =

> You mean M11 preference? If you want something, be explicit, do not prefe=
r.

Fair enough, fixed.

> =

> I laud your goal to improve the coding style within oFono - and it
> even might be best to do that step-by-step and avoid large patches
> just to fix the style - but I'm lazy typist and I usually just kill
> and yank pieces of code, like this one from from "src/common.h" patch
> a78b3629, authored by some Denis Kenzior.

Nobody is denying that the existing code has style violations.  But new
patches should not be propagating past mistakes or introducing new ones.
 This is your chance to fix it properly and my chance to catch these.

> =

> The current codebase contains a lot of code in outdated style and
> copy'n'paste coding just does not cut it, it would be ++good to have a
> custom checkpatch that would show the style problems without tedious
> and error-prone manual inspection. I'd do that myself but my perl-fu
> is bit rusty.
> =


I have said this before, I'm not against this at all, as long as someone
volunteers to maintain it properly.  So far there has been no takers.

>>> +     memcpy(number->number, call->address, sizeof number->number);
>>
>> Please watch out for the sizeof usage.
> =

> This needs an entry in doc/codingstyle.txt.
> =


Feel free to send a patch, you're the expert on this by now ;)

>>> +     case CALL_STATUS_IDLE:
>>> +     case CALL_STATUS_TERMINATED:
>>> +             isi_call_disconnected(ovc, call);
>>
>> Is the break statement missing here?
> =

> Hm? Where? Between IDLE and TERMINATED?
> =


Yes, in general I'd like a break statement after every case block.
Otherwise, when adding new case statements it is quite easy to introduce
hard to spot bugs.

Regards,
-Denis

--===============4650826356715335371==--

