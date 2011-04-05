Content-Type: multipart/mixed; boundary="===============2452003389225984623=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: Trouble using Huwei E160G
Date: Tue, 05 Apr 2011 10:35:21 +0100
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75BFECF7BB@irsmsx503.ger.corp.intel.com>
In-Reply-To: <4D9ADA4F.5060501@zirak.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2452003389225984623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>>>>>> 1) Connect 3G key and wait for umts coverage (blue led)
>>>>>>
>>>>>> I activated the 3g connection, but ofono response is
>>>>>>
>>>>>> Error org.ofono.Error.NotImplemented: Implementation not provided

From what I can see when you do the 'list-modem', your modem is already en=
abled and online, so you do not have to do the ./enable_modem and ./online-=
modem.

The PS context is also created (looking at ./list-contexts answer).

So just the ./activate-context should be fine.

But there is an error ... From what I can see in the source code, it should=
 be enable 'post sim'. And still according to source code, the Huawei modem=
 seems to skip some SIM status during warm start.

So, can you please unplug replug the USB key, wait a few, just execute ./li=
st-modems and ./list-contexts (nothing else).
You should see the modem enabled and online, and your context created. If s=
o, just execute ./activate-context

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


--===============2452003389225984623==--

