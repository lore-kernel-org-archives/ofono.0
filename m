Content-Type: multipart/mixed; boundary="===============7174386557304386694=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Some experiments with the SIMCOM SIM5216E modem on a ARM926 board
Date: Fri, 13 Jan 2012 04:51:31 +0100
Message-ID: <1326426691.6454.255.camel@aeonflux>
In-Reply-To: <4F0FA169.5010607@eclis.ch>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7174386557304386694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jean-Christian,

> >> It's a mystery for me if Simcom do there own software or only use the
> >> Qualcamm one. The chipset of this modem is the QSC6270 and I expected
> >> that ofono already have something appropriate. I suspect the "g1" driv=
er
> >> to be a close match and if fact it work already quite well. Are you
> >> willing to accept a new modem plugin that is basically a copy of the "=
g1" ?
> >
> > I expect a new modem plugin for the sim900. So that approach is fine.
> >
> > However using the g1 driver as a base is a bad example. That driver is
> > bit-rotting a lot.
> =

> Ok, I didn't known that. Maybe the SIMCOM5216 need the same =

> "bit-rotting" as the g1. We will see.
> =

> > Let me ask this differently. What are the GSM/UMTS features that you
> > actually need for your product?
> =

> Power control, SIM pin code, manual or automatic operator selection, =

> signal strength indication, Voice call dial/receive/hangup, SMS =

> send/receive, and GPRS TCP/IP link.

so essentially you need everything. I hope that the voice call
implementation of SIM COM modem is proper. Otherwise you end up with
higher power consumption. We can talk about that later.

> >>> With USB as transport you really wanna do modem detection via udev. So
> >>> you might wanna get this solved with uclibc.
> >>
> >> After some additional work I was getting udev working on the target. B=
ut
> >> understanding how the udev ofono rules should be written for a composi=
te
> >> device is really hard. I did not found an example on how this should be
> >> done to set both OFONO_DRIVER _and_ OFONO_LABEL. I was also confused by
> >> the fact that there is two plugins that handles the udev events: udev
> >> and udevng.
> >
> > Send the section for your device from /sys/kernel/debug/usb/devices. I
> > can have a look then.
> =

> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  3 Spd=3D12   =
MxCh=3D 0
> D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D05c6 ProdID=3D9000 Rev=3D 0.00
> S:  Manufacturer=3DSimTech, Incorporated
> S:  Product=3DSimTech SIM5216
> C:* #Ifs=3D 5 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> I:* If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:  Ad=3D84(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D5ms
> E:  Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> I:* If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E:  Ad=3D86(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D5ms
> E:  Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> =

> The SIMCOM documentation say:
> =

> USB interface is mapped to five virtual ports: =E2=80=9CSIMTECH USB Modem=
=E2=80=9D, =

> =E2=80=9CSIMTECH NMEA Device=E2=80=9D, =E2=80=9CSIMTECH ATCOM Device=E2=
=80=9D, =E2=80=9CSIMTECH Diagnostics =

> interface=E2=80=9D and =E2=80=9CSIMTECH Wireless Ethernet Adapter=E2=80=
=9D. UART, =E2=80=9CSIMTECH USB =

> Modem=E2=80=9D and =E2=80=9CSIMTECH ATCOM Device=E2=80=9D could respond t=
o AT command, and URC =

> report to these three ports at the same time, but user could set =

> dedicated port to receive URC (Unsolicited Result Code).

So lets figure out which one is the NMEA port and which one is the
QCDM/DIAG port. Use gatchat/test-qcdm --device <tty> and see which one
responds. That one is the QCDM port and the other is the NMEA port.

I bet that interface #4 is actually some form of CDC Ethernet for
highspeed data transfers. So that you do not have to use PPP. Might
wanna ask SIM COM about it.

Once we know the interface mapping, it is pretty easy to add support for
plugins/udevng.c for this hardware.

Regards

Marcel



--===============7174386557304386694==--

