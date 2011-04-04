Content-Type: multipart/mixed; boundary="===============0214787222536212302=="
MIME-Version: 1.0
From: Claudio Degioanni <claudio.degioanni@zirak.it>
Subject: Re: Trouble using Huwei E160G
Date: Mon, 04 Apr 2011 10:32:49 +0200
Message-ID: <4D998231.7040003@zirak.it>
In-Reply-To: <A782C372B9527D44AB20BF45FEEBB14F75BFE7220E@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0214787222536212302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

Ok thanks for pointing this out.
We did not use the cage anymore, and simply moving the dongle around we are=
 able to make it use UMTS or GPRS, since the UMTS signal is pretty low in t=
his area.

This way we are able to test both scenarios, but still we observe the behav=
ior that we reported in the previous email:

>> 1) Connect 3G key and wait for umts coverage (blue led)
>>
>> I activated the 3g connection, but ofono response is
>>
>> Error org.ofono.Error.NotImplemented: Implementation not provided
>>
>> I have tested the 3g connection on umts on windows and works connectly.
>>
>> 2) Connect 3G key and wait for gprs coverage (green led)
>>
>> I activated the 3g connection, but ofono response is
>>
>> Error org.ofono.Error.NotAttached: GPRS is not attached

and we are still not able to get it working..

Thanks,
Claudio

Il 04/04/2011 10.12, Aygon, Bertrand ha scritto:
> Hi,
>
>> We work in a zone with limited utms coverage, some times it use gprs
>> (green blinking led). The test 1 is the normal case with good umts cover=
age, for test 2 i force gprs using for
>> example a simple Faraday Cage.
> If you use a Faraday Cage, you will lose all network capabilities, and no=
t just UMTS.
>
> According to oFono source code, Huwei modem doesn't support the radio set=
tings, so there is no way to 'force' UMTS or GPRS. So you will have what th=
e network will assign to you, based on your coverage, and the network capab=
ilities.
>
> So please do not use a Faraday Cage, this will not help at all.
>
> Regards,
>
> Bertrand.
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, =

> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono


--===============0214787222536212302==--

