Content-Type: multipart/mixed; boundary="===============8383326865723523155=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: Trouble using Huwei E160G
Date: Tue, 05 Apr 2011 11:09:59 +0100
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75BFECF816@irsmsx503.ger.corp.intel.com>
In-Reply-To: <4D9AE808.9090302@zirak.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8383326865723523155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>> From what I can see when you do the 'list-modem', your modem is already =
enabled and online, so you do not have to do the >>./enable_modem and ./onl=
ine-modem.
>>
>> The PS context is also created (looking at ./list-contexts answer).
>>
>> So just the ./activate-context should be fine.
>>
>> But there is an error ... From what I can see in the source code, it sho=
uld be enable 'post sim'. And still according to source code, >>the Huawei =
modem seems to skip some SIM status during warm start.
>>
>> So, can you please unplug replug the USB key, wait a few, just execute .=
/list-modems and ./list-contexts (nothing else).
>> You should see the modem enabled and online, and your context created. =

>> If so, just execute ./activate-context
>
>I have made the test proposed, I still recive the same error :)
>
>I have attacched the new log of test. Ofono create the connection context,=
 but on activation it repond with not implemented.

Sorry, I have no idea, I have try all I have in mind, but now, we need the =
help of someone else.

Huawei modem should support data call. The AT log looks correct. Why there =
is a not implemented error, I don't know...

Sorry again,

Bertrand.
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============8383326865723523155==--

