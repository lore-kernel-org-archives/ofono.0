Content-Type: multipart/mixed; boundary="===============8210265200772326438=="
MIME-Version: 1.0
From: Florian Steinel <florian.steinel@gmail.com>
Subject: Huawei E176 - not online
Date: Sun, 18 Jul 2010 13:04:41 +0200
Message-ID: <20100718110441.GA20371@h02.hostsharing.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8210265200772326438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I can't get my Huawei E176 USB Stick into the online state.

Maybe commit cc6a43c477c1310643279139ba6808799a8c637e removed to much code?
(rssi_notify)

OFONO_AT_DEBUG=3D1 ofonod -n -d '*' 2>atlog
./enable_modem

./list-modem output:
[ /huawei0 ]
    Features =3D sim =

    Powered =3D 1
    Interfaces =3D org.ofono.SimManager =

    Online =3D 0
    Model =3D E176
    Manufacturer =3D huawei
    Serial =3D ***************
    Revision =3D 11.104.14.01.55
    [ org.ofono.SimManager ]
        Present =3D 0



atlog output:

ofonod[15261]: oFono version 0.25
ofonod[15261]: Pcui:< \r\n^BOOT:********,0,2,0,25\r\n
ofonod[15261]: Pcui:> ATE0\r
ofonod[15261]: Pcui:< \r\n^RSSI:99\r\n\r\n^SRVST:0\r\n\r\n^MODE:0,0\r\n\r\n=
^RSSI:10\r\n\r\n^SRVST:1\r\n\r\n^MODE:5,4\r\n\r\n^BOOT:********,0,0,0,25\r\=
n\r\nOK\r\n
ofonod[15261]: Pcui:> AT+CFUN=3D1\r
ofonod[15261]: Pcui:< \r\nOK\r\n
ofonod[15261]: Pcui:> AT^SYSINFO\r
ofonod[15261]: Pcui:< \r\n^SYSINFO:1,0,1,5,0,,4\r\n\r\nOK\r\n
ofonod[15261]: Pcui:> AT+CGMI\r
ofonod[15261]: Pcui:< \r\nhuawei\r\n\r\nOK\r\n
ofonod[15261]: Pcui:> AT+CGMM\r
ofonod[15261]: Pcui:< \r\nE176\r\n\r\nOK\r\n
ofonod[15261]: Pcui:> AT+CGMR\r
ofonod[15261]: Pcui:< \r\n11.104.14.01.55\r\n\r\nOK\r\n
ofonod[15261]: Pcui:> AT+CGSN\r
ofonod[15261]: Pcui:< \r\n***************\r\n\r\nOK\r\n
ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n
ofonod[15261]: Pcui:< \r\n^BOOT:********,0,0,0,25\r\n

Florian Steinel

--===============8210265200772326438==--

