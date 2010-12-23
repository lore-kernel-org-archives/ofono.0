Content-Type: multipart/mixed; boundary="===============0994827526774135543=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [RFC PATCH 5/5 v2] cell-info: Documentation
Date: Thu, 23 Dec 2010 08:47:15 +0200
Message-ID: <1293086835.22770.42.camel@apaila-ThinkPad-T410>
In-Reply-To: <1293043576.3120.1424.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0994827526774135543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On Wed, 2010-12-22 at 20:46 +0200, ext Aki Niemi wrote:
> Hi Antti,
> =

> On Wed, 2010-12-22 at 11:35 +0200, ext Antti Paila wrote:
> > ---
> >  doc/cell-info.txt |  110 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 files changed, 110 insertions(+), 0 deletions(-)
> >  create mode 100644 doc/cell-info.txt
> > =

> > diff --git a/doc/cell-info.txt b/doc/cell-info.txt
> > new file mode 100644
> > index 0000000..9144eb7
> > --- /dev/null
> > +++ b/doc/cell-info.txt
> > @@ -0,0 +1,110 @@
> > +Cell Info hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service		org.ofono
> > +Interface	org.ofono.CellInfo
> > +Object path	[variable prefix]/{modem0,modem1,...}
> > +
> > +Methods		a{sv}aa{sv} GetProperties()
> > +
> > +			Calling this procedure returns properties of serving
> > +			and neighbouring cells in GSM or WCDMA networks. This
> > +			information can be used to determine current location
> > +			using triangulation over neighbouring cell tower
> > +			locations and estimated distances.
> > +
> > +			The return value consists of two parts: 1) dictionary
> > +			of common information about network and serving cell 2)
> > +			array of dictionaries containing measurement results
> > +			of neighbouring cells. The contents of the dictionaries
> > +			follow the specification OMA-TS-ULP-V2_0-20100816-C for
> > +			user plane Location and is described in properties
> > +			section.
> > +
> > +Properties
> > +
> > +a{sv]		string Type
> > +
> > +			Radio access type.
> > +			Values: "GERAN", "UTRA-FDD
> =

> How about some brief explanation of what these mean? Also, missing end
> quotes on UTRA-FDD, and the naming convention has been to use lower case
> for string values.
> =

> Perhaps along these lines:
> =

> string Type
> =

> 	Radio access network type of neighbor cell information.
> =

> 	The possible values are:
> 		"geran"   Measurement results are for the GSM EDGE Radio
> 			  Access Network
> 		"utran"   Measurement results are for UMTS Radio Access
> 			  Network
> =


I'll include this to doc.

> > +		uint32 MCC
> > +			Mobile Country Code of serving cell. Possible values:
> > +			Values: 0...999"
> > +
> > +		uint32 MNC
> > +			Mobile Network Code of serving cell.
> > +			Values: 0...999"
> =

> These need to be MobileCountryCode and MobileNetworkCode, as elsewhere
> in the API. Also, why not string like in the network API?

If convention is to use full names, then so be it. However, MNC and MCC
are so widely used acronyms in 3GPP specifications and generally in
telecommunication that chances for confusing is minimal. The three
letter form is also more compact and more convenient to use.

What is the benefit of representing MNC and MCC as strings? Both codes
consist of digits so to me a natural representation is integer of some
sort.   =


> > +		uint32 LAC [GERAN]
> > +			Location area code of serving cell.
> > +			Values: 0...65535
> > +
> > +		uint32 CI [GERAN]
> > +			Cell Id of serving cell.
> > +			Values: 0...65535
> > +
> > +		uint32 TA [GERAN, OPTIONAL]
> > +			Timing advance.
> > +			Values: 0...63
> > +
> > +		uint32 UCID [UTRA-FDD]
> > +			Serving WCDMA unique cell ID.
> > +			Values: 0...268435455
> =

> For the LAC and CI, naming could be borrowed from the network API here
> as well. Though I understand the need to conform to the SUPL specs here.

This is up to discussion. Good argument for the use of acronyms is SUPL
specs and, for example, this doc that explains the content of each
field. Argument against is on the other hand ofono conventions that
should also be respected. Of course, conventions can be changed if seen
necessary.

Thanks for the comments.

Best Regards,
  Antti


--===============0994827526774135543==--

