Content-Type: multipart/mixed; boundary="===============6224022108932247122=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: Trouble using Huwei E160G
Date: Mon, 04 Apr 2011 09:53:41 +0100
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75BFE72258@irsmsx503.ger.corp.intel.com>
In-Reply-To: <4D998231.7040003@zirak.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6224022108932247122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>Ok thanks for pointing this out.
>We did not use the cage anymore, and simply moving the dongle around we ar=
e able to make it use UMTS or GPRS, since the UMTS signal is >pretty low in=
 this area.
>
>This way we are able to test both scenarios, but still we observe the beha=
vior that we reported in the previous email:

Gentle reminder to not top post on the mailing list.

>> 1) Connect 3G key and wait for umts coverage (blue led)
>>
>> I activated the 3g connection, but ofono response is
>>
>> Error org.ofono.Error.NotImplemented: Implementation not provided
>>

Can you please send the full log for this case, and also the term output, s=
o I can see what you are exactly doing.

>> I have tested the 3g connection on umts on windows and works connectly.
>>
>> 2) Connect 3G key and wait for gprs coverage (green led)
>>
>> I activated the 3g connection, but ofono response is
>>
>> Error org.ofono.Error.NotAttached: GPRS is not attached

And same for this test.

But one question, are you able to do a data call using this 3G SUB key conn=
ected to a Windows PC?

Regards,

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


--===============6224022108932247122==--

