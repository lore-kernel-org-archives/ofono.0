Content-Type: multipart/mixed; boundary="===============1535068426000225204=="
MIME-Version: 1.0
From: Joly, Frederic <frederic.joly@intel.com>
Subject: RE: [PATCH] doc: Add Location Services API (resending now that I am
 on ofono mailing list)
Date: Mon, 22 Nov 2010 21:50:22 +0000
Message-ID: <129600E5E5FB004392DDC3FB599660D70104DAF288@irsmsx504.ger.corp.intel.com>
In-Reply-To: <B4268AAFAFA3E244B5B0641D5914917048B76BEA90@EXDCVYMBSTM006.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1535068426000225204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Simon LETHBRIDGE
Sent: Thursday, November 18, 2010 10:50 AM
To: Denis Kenzior; ofono(a)ofono.org
Cc: Sjur BRENDELAND
Subject: RE: [PATCH] doc: Add Location Services API (resending now that I a=
m on ofono mailing list)

> Hi Denis,

> > -----Original Message-----
> > From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> > Sent: 11 November 2010 21:50
> > To: ofono(a)ofono.org
> > Cc: Sjur Br=C3=A6ndeland; Simon LETHBRIDGE; Sjur BRENDELAND
> > Subject: Re: [PATCH] doc: Add Location Services API
 =


> > =

> > And +CPOSR can transfer the following elements from the network:
> > <assist_data>, <pos_meas>, <msg>.
> > =

> > Am I right so far?

> This is substantially correct, however the assistance data request can on=
ly be made in response to a positioning =

> request from the network.  If assistance is required otherwise then an MO=
LR is needed, which we don't support yet. =

Since you mentioned in another post the LPP, I would just point out that in=
 2G and 3G the MO-LR invoke was needed to request the assistance data, but =
for 4G, this is not anymore the case. It seems you can directly request the=
 assistance data at the access stratum level. (see 36.355 =C2=A75.2.1 & =C2=
=A76.3).
So we should consider also assistance data request in the API proposal, I b=
elieve.


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

--===============1535068426000225204==--

