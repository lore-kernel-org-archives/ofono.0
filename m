Content-Type: multipart/mixed; boundary="===============1743888130752384220=="
MIME-Version: 1.0
From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: Some experiments with the SIMCOM SIM5216E modem on a ARM926 board
Date: Fri, 13 Jan 2012 04:19:46 +0100
Message-ID: <4F0FA2D2.9000601@eclis.ch>
In-Reply-To: <4F0FA169.5010607@eclis.ch>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1743888130752384220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> T: Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D 3 Spd=3D12 MxCh=
=3D 0
> D: Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D 1
> P: Vendor=3D05c6 ProdID=3D9000 Rev=3D 0.00
> S: Manufacturer=3DSimTech, Incorporated
> S: Product=3DSimTech SIM5216
> C:* #Ifs=3D 5 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E: Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
> E: Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E: Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
> E: Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E: Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
> E: Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
> I:* If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E: Ad=3D84(I) Atr=3D03(Int.) MxPS=3D 64 Ivl=3D5ms
> E: Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
> E: Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
> I:* If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Doption
> E: Ad=3D86(I) Atr=3D03(Int.) MxPS=3D 64 Ivl=3D5ms
> E: Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms
> E: Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms

I didn't noticed that SIMCOM responded to my request while I edited my =

last mail. Here is the interface usage according to them:

the USB interface index is:
0-       DIAG
1-       NMEA
2-       AT
3-       MODEM
4-       Ethernet
So, the port index 2 and port index 3 exposes a working AT command =

interface.

Jean-Christian

--===============1743888130752384220==--

