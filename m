Content-Type: multipart/mixed; boundary="===============0803803005444941846=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH v2] ifx: Adding modem selftest to Infineon modem
Date: Sat, 18 Dec 2010 11:58:41 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9015A2476B7@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1292696739.2658.10.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0803803005444941846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > @@ -80,6 +82,18 @@ static const char *dlc_nodes[NUM_DLC] =3D { "/dev/tt=
yGSM1", "/dev/ttyGSM2",
> >  =

> >  static const char *none_prefix[] =3D { NULL };
> >  static const char *xdrv_prefix[] =3D { "+XDRV:", NULL };
> > +static const char *empty_prefix[] =3D { "", NULL };
> =

> This is still wrong. See my comment from the original email. I am not
> sure you really know what { "", NULL } means.

The response doesn't really have a proper prefix (see example below), this =
way the entire response ends up in the callback. Is there a better way? Giv=
en that there aren't any URC registered yet, it will not interfere with any=
 other response. It's obviously not a good idea to use it once the modem is=
 powered up.

at(a)vers:device_version_id()
CHIP ID =3D XXX
FLASH TYPE =3D YYY
FLASH ID =3D 0x898881
SmartiUE2 =3D 37664
RF PMU =3D 10548
PA PMU =3D 40244
RF ASM =3D 0
FEM PA =3D 21812
OK

Cheers,
Waldo

--===============0803803005444941846==--

