Content-Type: multipart/mixed; boundary="===============3718804852513636652=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] udev: Add support for SpeedUp 7300 EVDO modem.
Date: Thu, 28 Jul 2011 14:08:00 +0200
Message-ID: <1311854881.8920.101.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938FA9A4C@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3718804852513636652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> > > diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> > > index f8e485b..ab21f57 100644
> > > --- a/plugins/ofono.rules
> > > +++ b/plugins/ofono.rules
> > > @@ -422,11 +422,15 @@ ATTRS{idVendor}=3D=3D"19d2", ENV{OFONO_DRIVER}=
=3D"zte"
> > >
> > >  ATTRS{idVendor}=3D=3D"19d2", ATTRS{serial}=3D=3D"1234567890ABCDEF",
> > ENV{ID_SERIAL_SHORT}=3D""
> > >
> > > -# SpeedUp
> > > -ATTRS{idVendor}=3D=3D"1c9e", ENV{OFONO_DRIVER}=3D"speedup"
> > > +# SpeedUp 7300
> > > +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00",
> > ENV{OFONO_DRIVER}=3D"speedupcdma"
> > > +
> > > +# SpeedUp 9800
> > > +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800",
> > ENV{OFONO_DRIVER}=3D"speedup"
> > >
> > >  ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF",
> > ENV{ID_SERIAL_SHORT}=3D""
> > =

> > did you send the usb-devices output for these dongles to confirm that
> > this serial number hack is still needed?
> =

> Here it is:
> =

> T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D02 Cnt=3D02 Dev#=3D 20 Spd=3D480 M=
xCh=3D 0
> D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D1c9e ProdID=3D9800 Rev=3D00.00
> S:  Manufacturer=3DUSB Modem
> S:  Product=3DUSB Modem
> S:  SerialNumber=3D1234567890ABCDEF
> C:  #Ifs=3D 5 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> I:  If#=3D 1 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> I:  If#=3D 3 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage
> I:  If#=3D 4 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage

are you sure that SpeedUp for GSM is just not a re-branded ZTE dongle.
They look as broken as the ZTE ones.

Same as SpeedUp for CDMA might be just a re-branded Huawei dongle.

Regards

Marcel



--===============3718804852513636652==--

