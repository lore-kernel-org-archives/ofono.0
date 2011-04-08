Content-Type: multipart/mixed; boundary="===============6155964621216258030=="
MIME-Version: 1.0
From: Joly, Frederic <frederic.joly@intel.com>
Subject: RE: [RFC PATCH v3] gprs: add function to handle activated context
Date: Fri, 08 Apr 2011 08:59:10 +0100
Message-ID: <129600E5E5FB004392DDC3FB599660D701220E3B5D@irsmsx504.ger.corp.intel.com>
In-Reply-To: <4D9C329C.2000106@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6155964621216258030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

My 2 cts.

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of Arun Ravindran
> Sent: Wednesday, April 06, 2011 11:30 AM
> To: ofono(a)ofono.org
> Subject: Re: [RFC PATCH v3] gprs: add function to handle activated
> 27.007 section 10.1.1 says
> =

> Defined values
> <cid>: a numeric parameter which specifies a particular PDP context
> definition. The parameter is local to the TE-
> MT interface and is used in other PDP context-related commands. The
> range of permitted values (minimum
> value =3D 1) is returned by the test form of the command.
> NOTE 1: The <cid>s for network-initiated PDP contexts will have values
> outside the ranges indicated for the
> <cid> in the test form of the commands +CGDCONT and +CGDSCONT.
> =

Rigth, but just a general comment.
This is a release 9 clarification. The 27.007 Change request was only adopt=
ed one year ago (March 2010).
I believe we should keep this is mind to maintain if necessary the backward=
 compatibility.
I don't foresee yet an issue, but IMS services seem to get now some tractio=
n even on 3G.
Of course no evidence that network initiated PDP context are going to be us=
ed, but their usage fits pretty well with IMS...

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


--===============6155964621216258030==--

