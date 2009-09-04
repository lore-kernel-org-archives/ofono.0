Content-Type: multipart/mixed; boundary="===============1930063454631874505=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: TI Calypso Driver
Date: Thu, 03 Sep 2009 23:32:50 -0500
Message-ID: <200909032332.51432.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1930063454631874505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys,

I submitted a preliminary driver for TI Calypso based devices (e.g. OpenMok=
o =

Freerunner).  It works well enough that I can power up / down the modem, =

register to the network, scan operators, etc.  Voice calls & SMS features =

should also work.

Simply insert the following lines into modem.conf to enable this device:
[calypso]
Driver=3Dcalypso
Device=3D/dev/ttySAC0

Regards,
-Denis

--===============1930063454631874505==--

