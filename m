Content-Type: multipart/mixed; boundary="===============0321999464250025950=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Wed, 19 Sep 2018 10:19:30 -0500
Message-ID: <6d7fec85-10d2-f925-dc86-e15a03179b35@gmail.com>
In-Reply-To: <ff5bb1b4-7b9a-2b9a-c407-8097724781b0@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0321999464250025950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 09/19/2018 03:35 AM, Slava Monich wrote:
> On 19/09/18 08:37, Giacinto Cifelli wrote:
>> ---
>> =C2=A0 include/gprs-context.h |=C2=A0 1 +
>> =C2=A0 include/lte.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 11 +++++++++--
>> =C2=A0 2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/gprs-context.h b/include/gprs-context.h
>> index 20ca9ef..8869c12 100644
>> --- a/include/gprs-context.h
>> +++ b/include/gprs-context.h
>> @@ -57,6 +57,7 @@ enum ofono_gprs_context_type {
>> =C2=A0 enum ofono_gprs_auth_method {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OFONO_GPRS_AUTH_METHOD_PAP,
>> +=C2=A0=C2=A0=C2=A0 OFONO_GPRS_AUTH_METHOD_NONE,
> =

> I think there should be OFONO_GPRS_AUTH_METHOD_ANY (or =

> OFONO_GPRS_AUTH_METHOD_PAP_CHAP) here as well, for completeness. Many =

> modems support that too (and we had to add it in our fork).

There is no such thing in 3GPP, so how does that work?

And by the way,  none of the provisioning databases I'm aware of have =

this possibility and CHAP is actually a sane default.  While there are =

probably 2 providers left on this planet that might still insist on PAP, =

the 3GPP specs actually mandate CHAP anyway.

> =

> =

>> =C2=A0 };
>> =C2=A0 struct ofono_gprs_primary_context {
>> diff --git a/include/lte.h b/include/lte.h
>> index ef84ab9..38587c3 100644
>> --- a/include/lte.h
>> +++ b/include/lte.h
>> @@ -3,6 +3,7 @@
>> =C2=A0=C2=A0 *=C2=A0 oFono - Open Source Telephony
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 *=C2=A0 Copyright (C) 2016=C2=A0 Endocode AG. All rights re=
served.
>> + *=C2=A0 Copyright (C) 2018 Gemalto M2M
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 *=C2=A0 This program is free software; you can redistribute=
 it and/or =

>> modify
>> =C2=A0=C2=A0 *=C2=A0 it under the terms of the GNU General Public Licens=
e version 2 as
>> @@ -28,14 +29,18 @@ extern "C" {
>> =C2=A0 #include <ofono/types.h>
>> -struct ofono_lte;
>> -
>> =C2=A0 struct ofono_lte_default_attach_info {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
>> +=C2=A0=C2=A0=C2=A0 enum ofono_gprs_proto proto;
>> +=C2=A0=C2=A0=C2=A0 enum ofono_gprs_auth_method auth_method;
>> +=C2=A0=C2=A0=C2=A0 char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
>> +=C2=A0=C2=A0=C2=A0 char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
>> =C2=A0 };
> =

> This is starting to look suspiciously similar to struct =

> ofono_gprs_primary_context (the only thing left is cid). Is it really =

> necessary to maintain two copies of essentially the same structure or is =

> there some room for unification here?
> =


I don't really see a problem here.  One is active context details, the =

other is default attach details.  But if OFONO_GPRS_* defines are going =

to be used in multiple include/ofono files, then these defines should be =

moved to types.h.

Regards,
-Denis

--===============0321999464250025950==--

