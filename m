Content-Type: multipart/mixed; boundary="===============4741300133333240268=="
MIME-Version: 1.0
From: Joly, Frederic <frederic.joly@intel.com>
Subject: RE: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Wed, 23 Feb 2011 18:24:07 +0000
Message-ID: <129600E5E5FB004392DDC3FB599660D701098A699C@irsmsx504.ger.corp.intel.com>
In-Reply-To: <4D653AA1.8000203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4741300133333240268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of Denis Kenzior
> Sent: Wednesday, February 23, 2011 5:50 PM
> To: ofono(a)ofono.org
> Cc: tomasz.gregorek(a)gmail.com
> Subject: Re: [PATCH] atmodem: CEREG support for LTE network status
> reporting in AT modem
> > After discussing internally with Fred Joly I would like to come back
> on the 4 properties :
> > - Suspended is applicable in LTE in case of CS Voice Call using CSFB
> =

> My understanding was that CS Fallback physically switches technologies.
>  It is not 'suspending' LTE like it does with GPRS.  Am I wrong on this
> one?

I would say yes. :) =

In case you are obliged to fallback from 4G to 2G without support of DTM, e=
xaclty like in GPRS.

> =

> Perhaps, but again we have no control of the attach procedure with LTE.
>  So the implementation has to rely on vendor specific radio settings.
> Same arguments about shoehorning logic apply here.

I'm a bit puzzled by this statement. It is not specific to LTE, but related=
 to +CFUN proprietary implementation against  +COPS or +CGATT  usage, isn't=
 it?

BR,

Fred
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


--===============4741300133333240268==--

