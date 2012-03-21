Content-Type: multipart/mixed; boundary="===============0302991052597647673=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv3 04/12] call-forwarding: Refactor cf_find_unconditional()
Date: Wed, 21 Mar 2012 13:46:38 +0200
Message-ID: <4F69BF9E.1050508@intel.com>
In-Reply-To: <4F691813.3070803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0302991052597647673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 03/21/2012 01:51 AM, Denis Kenzior wrote:
>> +#define cf_find_unconditional(_cf)					\
>> +({									\
>> +	cf_find((_cf)->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL],\
>> +		BEARER_CLASS_VOICE);					\
>> +})
>> +
>
> Actually I'd prefer if we made this an inline function rather than a
> macro.  A bit easier to read that way.

Sure, strongly agree. I was going to do this myself, it just didn't make it=
 into =

these patches.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============0302991052597647673==--

