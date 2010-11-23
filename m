Content-Type: multipart/mixed; boundary="===============2401465861293656655=="
MIME-Version: 1.0
From: Simon LETHBRIDGE <simon.lethbridge@stericsson.com>
Subject: RE: [PATCH] doc: Add Location Services API
Date: Tue, 23 Nov 2010 18:16:20 +0100
Message-ID: <B4268AAFAFA3E244B5B0641D5914917048BCE1C1BF@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <129600E5E5FB004392DDC3FB599660D70104DAF2A3@irsmsx504.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2401465861293656655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

> -----Original Message-----
> From: Joly, Frederic [mailto:frederic.joly(a)intel.com]

> =

> For the option b, I would tend to not support you. I just recheck the
> 23.032 (Universal GeoGraphical Area Description), and the number of
> ways to express a position with velocity and uncertainty may not make
> the API simple.
> Just have a look for instance the +CMOLR's XML DTD location_parameters.
> :)
> Moreover, GPS vendors and other positioning professionals would find
> more logical to propose to use the WGS 84 datum for instance which is
> widely used and leave the burden to map the position to 3GPP style...
> =


With respect to the GAD shape in practise "Ellipsoid point with altitude
and uncertainty ellipsoid" is used.  The shapes "Polygon" and =

"Ellipsoid Arc" are not used and the other shapes are a subset of =

"Ellipsoid point with altitude and uncertainty ellipsoid".  =



Regards,

Simon

--===============2401465861293656655==--

