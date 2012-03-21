Content-Type: multipart/mixed; boundary="===============5225648803237969771=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv3 09/12] call-forwarding: Cache cfs on CFU removal
Date: Wed, 21 Mar 2012 13:51:40 +0200
Message-ID: <4F69C0CC.7030809@intel.com>
In-Reply-To: <4F691DDB.3060502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5225648803237969771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 03/21/2012 02:16 AM, Denis Kenzior wrote:
>> +#define CALL_FORWARDING_FLAG_CACHE	0x4
>
> You really have to pick a better name for this flag, I really don't
> understand its purpose right now.

The intention of this flag was to distinguish the setting of the single CF =

condition from the CFU deactivation were the conditional queries will be re=
-run =

and cached. But, after having another look at this, you are correct, such f=
lag =

isn't needed. I will be glad to get rid of it, the naming is really confusi=
ng.

Thanks for reviewing and help! I will fix all these and prepare another pat=
chset.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============5225648803237969771==--

