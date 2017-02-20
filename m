Content-Type: multipart/mixed; boundary="===============8663610705466159963=="
MIME-Version: 1.0
From: Eric Grunt <gruntblue@gmail.com>
Subject: Confusion about ublox toby-L2 IP configuration
Date: Mon, 20 Feb 2017 17:26:56 +0200
Message-ID: <CADB9fJGeP9CZn2Bt_t0zjEunxZKXvjzT9vaNK6fQop0xAenALw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8663610705466159963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I originally posted this to the connman list
and I was asked to take over the topic to ofono list.
https://lists.01.org/pipermail/connman/2017-January/021440.html

In interaction with ofono 1.18, connman 1.33 configures IPs for ublox
toby-L2 like this:

/*
 +UIPADDR: 1,"usb0:0","10.230.77.23","255.255.255.255","",""
 +CGCONTRDP: 1,0,"event.vodafone.de
","10.230.77.232.255.255.255.255","10.230.77.232","139.7.30.125","139.7.30.=
126","0.0.0.0","0.0.0.0",0
*/

wwan0     Link encap:Ethernet  HWaddr b6:90:aa:61:a0:79
          inet addr:10.230.77.232  Bcast:10.230.77.232  Mask:255.255.255.255
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6 errors:0 dropped:0 overruns:0 frame:0
          TX packets:10 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:384 (384.0 B)  TX bytes:908 (908.0 B)

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
0.0.0.0         10.230.77.232   0.0.0.0         UG    0      0        0
wwan0
10.230.77.232   0.0.0.0         255.255.255.255 UH    0      0        0
wwan0
139.7.30.125    10.230.77.232   255.255.255.255 UGH   0      0        0
wwan0
139.7.30.126    10.230.77.232   255.255.255.255 UGH   0      0        0
wwan0

So it basically configures itself as gateway for everything
and also writes 139.7.30.125 and 139.7.30.126 to the routing table,
alltough those are supposed to be used for dns resolution.
With the configuration above, neither pinging the ublox router
(192.168.1.1)  nor the outside internet (8.8.8.8) is working (100% packet
loss)

While the ublox NetworkingModes Manual [1] considers the IP returned with
UIPADDR as to be used as gateway (when using ublox in bridged mode) ofono
does not even query it.
ofono also configures ublox actively into bridging mode (while it states,
that it does not yet support router mode).

Is the above configuration supposed to work with toby-L2 in bridging mode?
If so, could you give me a hint what might have gone wrong?


When attempting a manual configuration (using the same AT commands as ofono
[2]), pinging the outside internet is possible, allthough the fun does not
last very long (few minutes).
(additionally pinging the ublox router only works when using ip aliases
like described in [1], which connman doesn't seem to support)

ifconfig wwan0 10.230.77.232 netmask 255.255.255.255 pointopoint
10.230.77.23 up
route add default gw 10.230.77.23

results in

wwan0     Link encap:Ethernet  HWaddr 62:dd:4b:67:6c:00
          inet addr:10.249.48.81  Bcast:10.255.255.255  Mask:255.255.255.255
          inet6 addr: fe80::60dd:4bff:fe67:6c00/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:5 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:308 (308.0 B)  TX bytes:772 (772.0 B)

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
0.0.0.0         10.249.48.174   0.0.0.0         UG    0      0        0
wwan0
10.249.48.174   0.0.0.0         255.255.255.255 UH    0      0        0
wwan0

[1]
https://www.u-blox.com/sites/default/files/TOBY-L2-NetworkingModes_AppNote_=
(UBX-14000479).pdf
(Appendix B, Router/Bridge mode configuration in Linux)
[2] AT commands used by ofono:
 AT
 ATE0 +CMEE=3D1
 AT+CFUN=3D4
 AT+UBMCONF=3D2
 AT+GCAP
 AT+CRSM=3D192,12258
 AT+CGMI
 AT+CRSM=3D176,12258,0,0,10
 AT+CGMM
 AT+CRSM=3D192,28421
 AT+CGMR
 AT+CRSM=3D176,28421,0,0,6
 AT+CGSN
 AT+CRSM=3D192,12037
 AT+CRSM=3D176,12037,0,0,6
 AT+CPIN?
 AT+UPINCNT
 AT+CRSM=3D192,28590
 AT+CRSM=3D192,28589
 AT+CRSM=3D176,28589,0,0,4
 AT+CRSM=3D192,28438
 AT+CRSM=3D192,28472
 AT+CRSM=3D176,28472,0,0,8
 AT+CRSM=3D192,28502
 AT+CRSM=3D176,28502,0,0,3
 AT+CIMI
 AT+CGDCONT=3D?
 AT+CRSM=3D192,28480
 AT+CFUN=3D1
 AT+CGREG=3D?
 AT+CRSM=3D178,28480,1,4,24
 AT+CREG=3D?
 AT+CGREG=3D2
 AT+CGAUTO=3D0
 AT+CGEREP=3D2,1
 AT+CRSM=3D178,28480,2,4,24
 AT+CREG=3D2
 AT+UREG=3D1
 AT+CRSM=3D178,28480,3,4,24
 AT+CIND=3D?
 AT+CRSM=3D192,28489
 AT+CIND=3D0,1,0,0,0,0,0,0,0,0,0,0
 AT+CMER=3D?
 AT+CRSM=3D192,20256
 AT+CMER=3D1,0,0,1
 AT+CREG?
 AT+CRSM=3D192,28613
 AT+CRSM=3D192,28437
 AT
 AT+COPS=3D3,2
 AT+COPS?
 AT+CIND?
 AT+CGATT=3D1
 AT+COPS=3D3,0
 AT+COPS?
 AT+CGREG?
 AT+CGDCONT=3D1,"IP","event.vodafone.de"
 AT+CGACT=3D1,1
 AT+CGCONTRDP=3D1
 AT+CGDCONT?

--===============8663610705466159963==--

