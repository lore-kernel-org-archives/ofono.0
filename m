Content-Type: multipart/mixed; boundary="===============0356096030960616150=="
MIME-Version: 1.0
From: Claudio Degioanni <claudio.degioanni@zirak.it>
Subject: Re: Trouble using Huwei E160G
Date: Fri, 01 Apr 2011 08:59:08 +0200
Message-ID: <4D9577BC.8030209@zirak.it>
In-Reply-To: <A782C372B9527D44AB20BF45FEEBB14F75BFE71AF2@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0356096030960616150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Il 31/03/2011 16.42, Aygon, Bertrand ha scritto:
> Hi,
>
>> I have performed 2 tests
>>
>> 1) Connect 3G key and wait for umts coverage (blue led)
>>
>> I activated the 3g connection, but ofono response is
>>
>> Error org.ofono.Error.NotImplemented: Implementation not provided
>>
>> Attacched there is the log of ofono test_umts.log
>>
>> I have tested the 3g connection on umts on windows and works connectly.
>>
>> 2) Connect 3G key and wait for gprs coverage (green led)
>>
>> I activated the 3g connection, but ofono response is
>>
>> Error org.ofono.Error.NotAttached: GPRS is not attached
>>
>> Attacched there is the log of ofono test_gprs.log
> I am not familiar with Huwai modem, and still learning oFono.
>
> But one question: how do you make difference between test 1 and test 2? =

The difference is visible on device, it has a led blinking green fro
gprs and blue for utms coverage.
> How did you force UMTS and then GPRS?
> It seems that during test 1, you got network service. But not during test=
 2.
>
> Can you please tell me exactly what you did for test 1, and what you did =
for test 2?
We work in a zone with limited utms coverage, some times it use gprs
(green blinking led). The test 1 is the
normal case with good umts coverage, for test 2 i force gprs using for
example a simple Faraday Cage.

regs
Claudio

> Regards,
>
> Bertrand.
>
>
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


--===============0356096030960616150==--

