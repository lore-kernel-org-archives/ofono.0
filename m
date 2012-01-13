Content-Type: multipart/mixed; boundary="===============0664188511303019969=="
MIME-Version: 1.0
From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: Some experiments with the SIMCOM SIM5216E modem on a ARM926 board
Date: Fri, 13 Jan 2012 04:13:45 +0100
Message-ID: <4F0FA169.5010607@eclis.ch>
In-Reply-To: <1326345121.6454.243.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0664188511303019969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> It's a mystery for me if Simcom do there own software or only use the
>> Qualcamm one. The chipset of this modem is the QSC6270 and I expected
>> that ofono already have something appropriate. I suspect the "g1" driver
>> to be a close match and if fact it work already quite well. Are you
>> willing to accept a new modem plugin that is basically a copy of the "g1=
" ?
>
> I expect a new modem plugin for the sim900. So that approach is fine.
>
> However using the g1 driver as a base is a bad example. That driver is
> bit-rotting a lot.

Ok, I didn't known that. Maybe the SIMCOM5216 need the same =

"bit-rotting" as the g1. We will see.

> Let me ask this differently. What are the GSM/UMTS features that you
> actually need for your product?

Power control, SIM pin code, manual or automatic operator selection, =

signal strength indication, Voice call dial/receive/hangup, SMS =

send/receive, and GPRS TCP/IP link.

>>> With USB as transport you really wanna do modem detection via udev. So
>>> you might wanna get this solved with uclibc.
>>
>> After some additional work I was getting udev working on the target. But
>> understanding how the udev ofono rules should be written for a composite
>> device is really hard. I did not found an example on how this should be
>> done to set both OFONO_DRIVER _and_ OFONO_LABEL. I was also confused by
>> the fact that there is two plugins that handles the udev events: udev
>> and udevng.
>
> Send the section for your device from /sys/kernel/debug/usb/devices. I
> can have a look then.

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  3 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D05c6 ProdID=3D9000 Rev=3D 0.00
S:  Manufacturer=3DSimTech, Incorporated
S:  Product=3DSimTech SIM5216
C:* #Ifs=3D 5 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
E:  Ad=3D84(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D5ms
E:  Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
E:  Ad=3D86(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D5ms
E:  Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms

The SIMCOM documentation say:

USB interface is mapped to five virtual ports: =E2=80=9CSIMTECH USB Modem=
=E2=80=9D, =

=E2=80=9CSIMTECH NMEA Device=E2=80=9D, =E2=80=9CSIMTECH ATCOM Device=E2=80=
=9D, =E2=80=9CSIMTECH Diagnostics =

interface=E2=80=9D and =E2=80=9CSIMTECH Wireless Ethernet Adapter=E2=80=9D.=
 UART, =E2=80=9CSIMTECH USB =

Modem=E2=80=9D and =E2=80=9CSIMTECH ATCOM Device=E2=80=9D could respond to =
AT command, and URC =

report to these three ports at the same time, but user could set =

dedicated port to receive URC (Unsolicited Result Code).

But experiment show that only the If#=3D2 and If#=3D3 are able to handle th=
e =

AT commands, so I suspect that the doc don't list them in the good =

order. I was unable to see anything on the other interfaces. The If#=3D1 =

even hang microcom if I try to send any char on it. The If#=3D3 was the =

only one that the Linux USB cdc_acm driver was ok to recognize as a =

serial port:

usb 1-1: new full speed USB device number 5 using ohci
ohci ohci.0: GetPortStatus(1)
usb 1-1: skipped 5 descriptors after interface
usb 1-1: skipped 5 descriptors after interface
usb 1-1: skipped 5 descriptors after interface
usb 1-1: skipped 6 descriptors after interface
usb 1-1: default language 0x0409
usb 1-1: udev 5, busnum 1, minor =3D 4
usb 1-1: New USB device found, idVendor=3D05c6, idProduct=3D9000
usb 1-1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D0
usb 1-1: Product: SimTech SIM5216
usb 1-1: Manufacturer: SimTech, Incorporated
usb 1-1: usb_probe_device
usb 1-1: configuration #1 chosen from 1 choice
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
cdc_acm 1-1:1.0: usb_probe_interface
cdc_acm 1-1:1.0: usb_probe_interface - got id
cdc_acm 1-1:1.0: Control and data interfaces are not separated!
cdc_acm 1-1:1.0: This needs exactly 3 endpoints
cdc_acm: probe of 1-1:1.0 failed with error -22
usb 1-1: adding 1-1:1.1 (config #1, interface 1)
cdc_acm 1-1:1.1: usb_probe_interface
cdc_acm 1-1:1.1: usb_probe_interface - got id
cdc_acm 1-1:1.1: Control and data interfaces are not separated!
cdc_acm 1-1:1.1: This needs exactly 3 endpoints
cdc_acm: probe of 1-1:1.1 failed with error -22
usb 1-1: adding 1-1:1.2 (config #1, interface 2)
cdc_acm 1-1:1.2: usb_probe_interface
cdc_acm 1-1:1.2: usb_probe_interface - got id
cdc_acm 1-1:1.2: Control and data interfaces are not separated!
cdc_acm 1-1:1.2: This needs exactly 3 endpoints
cdc_acm: probe of 1-1:1.2 failed with error -22
usb 1-1: adding 1-1:1.3 (config #1, interface 3)
cdc_acm 1-1:1.3: usb_probe_interface
cdc_acm 1-1:1.3: usb_probe_interface - got id
cdc_acm 1-1:1.3: Control and data interfaces are not separated!
cdc_acm 1-1:1.3: ttyACM0: USB ACM device
usb 1-1: adding 1-1:1.4 (config #1, interface 4)
cdc_acm 1-1:1.4: usb_probe_interface
cdc_acm 1-1:1.4: usb_probe_interface - got id
cdc_acm 1-1:1.4: Zero length descriptor references
cdc_acm: probe of 1-1:1.4 failed with error -22
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
ohci ohci.0: GetPortStatus(1)

I disabled the cdc_acm driver because I finally found that this commit =

add the device from the Linux USB option driver:

http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dcom=
mitdiff;h=3Dec0cd94d881ca89cc9fb61d00d0f4b2b52e605b3;hp=3D46b1848360c8e634e=
0b063932a1261062fa0f7d6

It simply provides 5 serial ports 'ttyUSB#'. I was using the ttyUSB3 for =

my experiments.

>> I discovered that the last version of uClibc have now the libubactrace.
>> So I updated to it. I can propose this really simple patch to assert the
>> presence of the backtrace call:
>>

> Looks fine to me actually. Send a patch for it.

Done.

Jean-Christian

--===============0664188511303019969==--

