Content-Type: multipart/mixed; boundary="===============1505534603329529886=="
MIME-Version: 1.0
From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>
Subject: Re: [RFC PATCH v3] gprs: add function to handle activated context
Date: Thu, 07 Apr 2011 15:40:47 +0300
Message-ID: <4D9DB0CF.80800@nokia.com>
In-Reply-To: <8281606748F03E4390BB98A3F47F2E948B3B0AAF92@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1505534603329529886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Redouane,

>>> the network. The mobile sends a piggybacked
>>> PDN CONNECTIVITY REQUEST with the initial attach request in order to
>>> initiate the initial EPS context.
>>>
>> How does this happen from oFono (or in the TE-MT Interface).
> The problem is, the initial EPS context is initiated by mobile, not by
> It's triggered by AT+CGATT=3D1 (or AT+CFUN=3D1 if we have auto attach ena=
bled).
>> Does it mean that in for EPS context the TE will have to do the same
>> steps what it does for GPRS?
> For the EPS context (non initial) yes.
>
> For the initial EPS context we don't use AT+CGACT and CGDCONT.
>> the PDN CONNECTIVITY REQUEST has the APN name, and for TE, CGDCONT to
>> set the APN is called with a context id, in that case what is the need
>> for the cid handling done in this patch?
>  From 24.301:
>
> In order to request connectivity to a PDN using the default APN, the UE i=
ncludes the Access point name IE in the PDN CONNECTIVITY REQUEST message or=
, when applicable, in the ESM INFORMATION RESPONSE message, according to th=
e following conditions:
> -    if use of a PDN using the default APN requires PAP/CHAP, then the UE=
 should include the Access point name IE; and
> -    in all other conditions, the UE need not include the Access point na=
me IE.
> ----
>
> For the initial EPS context the UE may have to provide the APN in some ca=
ses. From 27007 we don't have an at command such as AT+CGCONT to specify th=
e parameter that'll be used for the initial EPS context (like APN).
>
> Regarding the patch, In 3G when you get the following unsolicited  "ME PD=
N ACT X" (where X is the CID, see +CGEREP) it's because you activated a con=
text (AT+CGACT).
> In this case you already specified the CID with AT+CDCONT before AT+CGACT.
>
> In LTE you can get this event in two cases; after the attach procedure (A=
T+CGATT) and in this case you don't know the CID before, or after AT+CGDCON=
T and AT+CGACT as in 3G.
>

So the spec says, ME PDN ACT can come even for an implicit context =

activation request associated with CGATT, which is the case with EPS.

For 3G, if this happens (ME PDN ACT) for UE initiated activation of =

context, then the cid is already set with CGDCONT.

For EPS this can happen for default context, where cid is not set with =

CGDCONT, but is in the range as returned by CGDCONT.

Here the cid issue, because cid is managed by ofono and is never =

communicated to modem.  Probably to avoid sending too many CGDCONT's =

during startup. or is it something else?

I thought the default context activation will come to TE as NW ACT, with =

a cid not in range of CGDCONT.


regards
Arun



--===============1505534603329529886==--

