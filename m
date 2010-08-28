Content-Type: multipart/mixed; boundary="===============3771561030475037746=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Connecting with Huawei E226
Date: Sat, 28 Aug 2010 08:21:09 +0200
Message-ID: <1282976469.6841.83.camel@localhost.localdomain>
In-Reply-To: <AANLkTikjhDsmvG==d4f9D=Zic+CXjGgUyJvfk1Fmv3Za@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3771561030475037746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Thiago,

> >> I don't know if it is related, but I'm getting lots of error messages
> >> from option driver:
> >>
> >> option: option_instat_callback: error -2
> >>
> >> They appear as soon as the modem is detected (after eject /dev/sr0).
> >
> > Sounds like a kernel bug. Which one are you using?
> =

> 2.6.33.5
> =

> > However show us your /proc/bus/usb/devices content for this modem.
> =

> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  6 Spd=3D480 M=
xCh=3D 0
> D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D19d2 ProdID=3D0031 Rev=3D 0.00
> C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D4ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D4ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50 Driver=
=3Dusb-storage
> E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:  Ad=3D84(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D2ms
> E:  Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D4ms
> =

> From lsusb:
> =

> Bus 001 Device 006: ID 19d2:0031 ONDA Communication S.p.A.

so for sure the udev rule for your modem was missing. I added that one
now.

If the option driver is causing a problem, then I don't know. However I
am using a 2.6.33.6 F13 kernel without any problems.

Regards

Marcel



--===============3771561030475037746==--

