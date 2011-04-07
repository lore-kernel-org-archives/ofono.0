Content-Type: multipart/mixed; boundary="===============5857327239204830303=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: RE: [RFC PATCH v3] gprs: add function to handle activated context
Date: Thu, 07 Apr 2011 10:06:06 +0100
Message-ID: <8281606748F03E4390BB98A3F47F2E948B3B0AAF92@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4D9C735C.50902@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5857327239204830303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Arun Ravindran
>Sent: Wednesday, April 06, 2011 4:06 PM
>Cc: ofono(a)ofono.org
>Subject: Re: [RFC PATCH v3] gprs: add function to handle activated context
>
>Hi Pessi,
>
>> Hi Arun,
>>
>> 2011/4/6 Arun Ravindran<ext-arun.1.ravindran@nokia.com>:
>>> According to this, the cid of user initiated context and network
>initiated
>>> context doesn't overlap.
>> The problem is, the initial EPS context is initiated by mobile, not by
>> the network. The mobile sends a piggybacked
>> PDN CONNECTIVITY REQUEST with the initial attach request in order to
>> initiate the initial EPS context.
>>
>
>How does this happen from oFono (or in the TE-MT Interface).

It's triggered by AT+CGATT=3D1 (or AT+CFUN=3D1 if we have auto attach enabl=
ed).

>
>Does it mean that in for EPS context the TE will have to do the same
>steps what it does for GPRS?
>

For the EPS context (non initial) yes.

For the initial EPS context we don't use AT+CGACT and CGDCONT.


>The PDN CONNECTIVITY REQUEST has the APN name, and for TE, CGDCONT to
>set the APN is called with a context id, in that case what is the need
>for the cid handling done in this patch?

From 24.301: =


In order to request connectivity to a PDN using the default APN, the UE inc=
ludes the Access point name IE in the PDN CONNECTIVITY REQUEST message or, =
when applicable, in the ESM INFORMATION RESPONSE message, according to the =
following conditions:
-    if use of a PDN using the default APN requires PAP/CHAP, then the UE s=
hould include the Access point name IE; and
-    in all other conditions, the UE need not include the Access point name=
 IE.
----

For the initial EPS context the UE may have to provide the APN in some case=
s. From 27007 we don't have an at command such as AT+CGCONT to specify the =
parameter that'll be used for the initial EPS context (like APN).

Regarding the patch, In 3G when you get the following unsolicited  "ME PDN =
ACT X" (where X is the CID, see +CGEREP) it's because you activated a conte=
xt (AT+CGACT).
In this case you already specified the CID with AT+CDCONT before AT+CGACT.

In LTE you can get this event in two cases; after the attach procedure (AT+=
CGATT) and in this case you don't know the CID before, or after AT+CGDCONT =
and AT+CGACT as in 3G.

The idea was to propose a function to handle the first case with the initia=
l EPS context.

Regards,
Redouane.

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


--===============5857327239204830303==--

