Content-Type: multipart/mixed; boundary="===============7603062527746693051=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: RE: [RFC PATCH] gprs: add function to handle activated context
Date: Tue, 11 Jan 2011 12:46:34 +0000
Message-ID: <8281606748F03E4390BB98A3F47F2E948A9C1245D9@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4D277F2B.8070102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7603062527746693051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > Considering that from a modem standpoint the CID race condition can
> be resolved,
> > some modem implementation may not have reserved a range of CID for
> their own purpose,
> > or may not provide a mechanism to reserve a range of CID.
> >
> =

> If the CGDCONT race is guaranteed to be solved by the modem =

> manufacturers, great.  Unfortunately that is not the only race present.
>  Hint: The gatchat implementation uses non-blocking IO, select and a =

> command queue.  So it is fully possible for oFono to reserve a CID, =

> send out a driver activation request, but receive a network initiated =

> context activation / default bearer activation before the CGDCONT was =

> even sent.
> =

> Having cid ranges that do not overlap seems the safest approach to me =

> right now.  Unless someone has a better idea...
> =


I think we have two cases :
1- CGDCONT=3DX,... is sent to the modem (ERROR response) before we get "+CG=
EV: ME PDN ACT X"
2- CGDCONT=3DX,... is sent to the modem (ERROR response) after we get "+CGE=
V: ME PDN ACT X"

For the first case the CID will be released inside oFono core before we get=
 "+CGEV" event : No problem =

For the second case the CID will be released inside oFono after we get "+CG=
EV" event , but we are sure it'll be released : No problem

But regardless the solution we choose either the CID sent by the driver sho=
uld be free or the CID sent by the driver should be outside the range, in b=
oth solutions the submitted patch should be ok.
Could you confirm ?

Regarding Context type maybe we can keep Internet today and see how far we =
can get ?

Regards,
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


--===============7603062527746693051==--

