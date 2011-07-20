Content-Type: multipart/mixed; boundary="===============1218521820654513328=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v2] plugins: update ofono rule and udev for using
 speedupcdma
Date: Wed, 20 Jul 2011 13:47:37 +0200
Message-ID: <1311162458.21109.210.camel@aeonflux>
In-Reply-To: <4E26B6FD.7030904@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1218521820654513328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> >> -# SpeedUp
> >> -ATTRS{idVendor}=3D=3D"1c9e", ENV{OFONO_DRIVER}=3D"speedup"
> >> +# SpeedUp 7300
> >> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{OFONO_=
DRIVER}=3D"speedupcdma"
> >> +
> >> +# SpeedUp 9800
> >> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{OFONO_=
DRIVER}=3D"speedup"
> >>
> >> -ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF", E=
NV{ID_SERIAL_SHORT}=3D""
> >> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ATTRS{seri=
al}=3D=3D"1234567890ABCDEF", ENV{ID_SERIAL_SHORT}=3D""
> > is the serial number really fake. Adding the content of usb-devices
> > script for this specific modem would help here.
> >
> > Or has this just been copied over from the Huawei entries and we missed
> > it in the review?
> =

> Sorry I committed a wrong patch, I will send you the right version of =

> this patch later.
> This serial, is not a fake, in using usb-devices with the dongle I got =

> before usb_modeswitch:
> =

> T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D 84 Spd=3D480 M=
xCh=3D 0
> D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D1c9e ProdID=3D9800 Rev=3D00.00
> S:  Manufacturer=3DUSB Modem
> S:  Product=3DUSB Modem
> S:  SerialNumber=3D1234567890ABCDEF
> C:  #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage
> I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage

this is a fake serial number, but that is fine, it is before the mode
switch to TTY mode. I care about the serial number after mode switch.

Regards

Marcel



--===============1218521820654513328==--

