Content-Type: multipart/mixed; boundary="===============5329951038162764856=="
MIME-Version: 1.0
From: Simon LETHBRIDGE <simon.lethbridge@stericsson.com>
Subject: RE: [RFCv2] doc: Assisted Satellite Navigation API and Agent API
Date: Wed, 26 Jan 2011 15:52:57 +0100
Message-ID: <B4268AAFAFA3E244B5B0641D5914917048CAFD0262@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <4CF4FAC9.5080200@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5329951038162764856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

Sorry that it has taken so long for me to reply.

> > +AssistedSatelliteNavigation hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> What do you think of naming this AssistedNavigation?  I think the
> current name might be a bit too long.
> =

That is a possibility.  The terminology used in the 3GGP specs is Global Sa=
tellite Navigation System (GNSS) for the technology.  The terms "Position M=
easurement Procedure" and "Assistance Data Delivery Procedure" are used in =
RRLP, for the procedures. I have some concern
that it may be difficult to relate the oFono terminology to that used in th=
e 3GPP standards.

There are other positioning technologies such as EOTD and OTDOA that are no=
t satellite based, although hopefully it would be obvious that these would =
be handled entirely in the modem.

My preference for a short name would be GNSS, since this term is used exten=
sively in the 3gpp recommendations, although it has the disadvantage of bei=
ng an abbreviation. If "Assisted Satellite Navigation" is too long then I s=
uppose "Global Satellite Navigation System" would be too long too.

Generic terms like "Positioning" would be problematic since the supplementa=
ry service positioning procedures like MOLR (Mobile Originated Location Req=
uest) are not covered by this API.

Regards,

Simon

--===============5329951038162764856==--

