Content-Type: multipart/mixed; boundary="===============4925262046452214784=="
MIME-Version: 1.0
From: Joly, Frederic <frederic.joly@intel.com>
Subject: RE: [RFC] AGPS Support
Date: Mon, 22 Nov 2010 22:52:30 +0000
Message-ID: <129600E5E5FB004392DDC3FB599660D70104DAF2A2@irsmsx504.ger.corp.intel.com>
In-Reply-To: <1288780795.9615.44.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4925262046452214784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Once again I apologise, I have not been able to react before on this.

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf Of Marcel Holtmann
> Sent: Wednesday, November 03, 2010 11:40 AM
> To: Sjur Br=C3=A6ndeland
> Cc: Ahmed, Suhail; Simon ETHBRIDGE; mats.tuneld(a)stericsson.com; ofono(a=
)ofono.org
>Subject: Re: [RFC] AGPS Support

> Or do we expect oFono core to do something with this data? I am under
> the impression that oFono core is just a pipe here.

> And in conclusion we have XML and ASN.1 adding some overhead to the
> actual data that is encoded. None of them is coming for free.

> If we wanna look at this not from the 27.007 standard angle, then we
> have to look at what the users of this D-Bus are talking and what would
> be easiest for them.


These last sentences did not provoke any comments or reactions, but I would=
 have expected they did because they are pointing out an important fact.
Ofono, in this feature, is just a pipe. The choice for proposing ASN.1 cont=
ainers or more exactly passing directing RRC frames, RRLP frames or other a=
ir interface protocols frames was driven by a simple fact: this data format=
ting can be easily supported, if not already supported, by nearly all the G=
PS vendors or positioning application frameworks, and this, thanks to the S=
UPL clients which are embedded inside positioning application frameworks or=
 GPS daemons.

Going to standard AT commands is virtuous, and all of us should support thi=
s. =

But the fact is that these AT commands for positioning support with xml dtd=
 (CPOS and CPOSR) are a late addition of release 8 end of 2008 while the co=
rresponding features had been introduced in the 3GPP standard 9 or 10 years=
 ago (just check R99 04.31!). So the GPS and positioning industry had to fi=
nd its own way before several years before the 3GPP minds proposing somethi=
ng. =


As of today, I'm suspicious about proposing the XML format as the only ofon=
o solution.
Do we have commitments from GPS vendors or positioning framework vendors or=
 telephone integrators that they are going to use the XML format?
Does STE GPS framework supports these XML formats?

I think these considerations should be put in the balance before pushing a =
single solution.

Thanks for reading me up to here,

Fred =


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


--===============4925262046452214784==--

