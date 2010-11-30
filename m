Content-Type: multipart/mixed; boundary="===============1869915082349031528=="
MIME-Version: 1.0
From: Marko.Ovaska@nokia.com
Subject: RE: [RFC] AGPS Support
Date: Tue, 30 Nov 2010 18:17:12 +0100
Message-ID: <B737AE8337D70F47B693AC85FA440B08328D7519BE@NOK-EUMSG-02.mgdnok.nokia.com>
In-Reply-To: <129600E5E5FB004392DDC3FB599660D70104DAF2A2@irsmsx504.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1869915082349031528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



: -----Original Message-----
: Behalf Of ext Joly, Frederic

: > -----Original Message-----
: > From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On B=
ehalf Of Marcel Holtmann
: > Sent: Wednesday, November 03, 2010 11:40 AM
--
: > Or do we expect oFono core to do something with this data? I am under
: > the impression that oFono core is just a pipe here.


I would not expect oFono core to do anything with assistance data, last I l=
ooked oFono does not have positioning engine that needs helper data to enha=
nce fix time. =


Positioning engine, whether in Linux or in GPR chip, interfaces user plane =
A-GPS OMA SUPL servers and control plane A-GPS (plus 3GPP commands) to cell=
ular network residing servers. Both interfaces, in the end, point to 3GPP T=
S's with ASN.1 BER encoded content for assistance data. Control plane or us=
er plane A-GPS servers do not do XML formats. Only 27.007 introduces format=
 conversion.
So raw pipe, as Sjur proposed, but with ASN.1 formatted payload without pay=
load conversions in modem NOR in Linux side (oFono core, modem plugin or po=
sitioning engine) to XML.


 =

: > And in conclusion we have XML and ASN.1 adding some overhead to the
: > actual data that is encoded. None of them is coming for free.
: =

: > If we wanna look at this not from the 27.007 standard angle, then we
: > have to look at what the users of this D-Bus are talking and what
: would
: > be easiest for them.

OMA SUPL specifications point to 3GPP 44.031 and TS 25.331. The common nomi=
nator for positioning engines is OMA and non-27.007 TS's use of ASN.1 forma=
tted data. TS 27.007 from positioning user view is the odd standard. =


 =

: As of today, I'm suspicious about proposing the XML format as the only
: ofono solution.
: Do we have commitments from GPS vendors or positioning framework
: vendors or telephone integrators that they are going to use the XML
: format?
: Does STE GPS framework supports these XML formats?

As above, positioning engine has to be ASN.1 capable when user plane A-GPS =
is used. Products over different mobile platforms do user plane A-GPS, cont=
rol plane with AT interface introduced XML just adds overhead.

  Marko



--===============1869915082349031528==--

