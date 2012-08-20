Content-Type: multipart/mixed; boundary="===============0659042398030390849=="
MIME-Version: 1.0
From: Lemoine Simon <simon.lemoine@dunasys.com>
Subject: sierra wireless MC8092
Date: Mon, 20 Aug 2012 11:15:12 +0200
Message-ID: <1345454112.7489.8.camel@dunasys010>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0659042398030390849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>Hi,
>
>I'm trying to use a Sierra Wireless MC8092 card with Ofono on an
>embedded system, but Ofono fail to setup the card because there are
>only five interfaces ttyUSB0 to ttyUSB4. =

>
>I have seen in function setup_sierra (plugins/udevng.c) that Ofono
>expects to have a NetworkInterface on the interface 7. =

>
>Does anybody know why the MC8092 doesn't have seven interfaces? Or
>which of the five interfaces could be the NetworkInterface?

It was because I haven't sierra_net driver in my kernel.

Now ofono finds the Network interface as usb0.
But I have an error with PIN authentication, and some AT commands return
ERROR, here is a part of the log I obtain :

ofonod[550]: plugins/udevng.c:setup_sierra() modem=3D/dev/ttyUSB3
app=3D/dev/ttyUSB4 net=3Dusb0 diag=3D/dev/ttyUSB1
ofonod[550]: src/modem.c:set_modem_property() modem 0xf6e38 property
Modem
ofonod[550]: src/modem.c:set_modem_property() modem 0xf6e38 property App
ofonod[550]: src/modem.c:set_modem_property() modem 0xf6e38 property
Diag
ofonod[550]: src/modem.c:set_modem_property() modem 0xf6e38 property
NetworkInterface
ofonod[550]: src/modem.c:ofono_modem_register() 0xf6e38
ofonod[550]: plugins/sierra.c:sierra_probe() 0xf6e38
ofonod[550]: src/modem.c:emit_modem_added() 0xf6e38
ofonod[550]: src/modem.c:call_modemwatches() 0xf6e38 added:1
ofonod[550]: plugins/hfp_ag.c:modem_watch() modem: 0xf6e38, added: 1
ofonod[550]: plugins/dun_gw.c:modem_watch() modem: 0xf6e38, added: 1
ofonod[550]: plugins/smart-messaging.c:modem_watch() modem: 0xf6e38,
added: 1
ofonod[550]: plugins/push-notification.c:modem_watch() modem: 0xf6e38,
added: 1
ofonod[550]: plugins/sierra.c:sierra_enable() 0xf6e38
ofonod[550]: src/modem.c:get_modem_property() modem 0xf6e38 property
Modem
ofonod[550]: plugins/sierra.c:open_device() Modem /dev/ttyUSB3
ofonod[550]: Modem: > ATE0 &C0 +CMEE=3D1\r
ofonod[550]: Modem: < ATE0 &C0 +CMEE=3D1\r\r\nOK\r\n
ofonod[550]: Modem: > AT+CFUN=3D4\r
ofonod[550]: Modem: < \r\nOK\r\n
ofonod[550]: plugins/sierra.c:cfun_enable()
ofonod[550]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[550]: plugins/sierra.c:sierra_pre_sim() 0xf6e38
ofonod[550]: Modem: > AT+GCAP\r
ofonod[550]: src/sim.c:ofono_sim_add_state_watch() 0xf6408
ofonod[550]: src/sim.c:ofono_sim_add_state_watch() 0xf6408
ofonod[550]: src/sim.c:ofono_sim_add_state_watch() 0xf6408
ofonod[550]: Modem: < \r\n+GCAP: +CGSM,+DS,+ES\r\n\r\nOK\r\n
ofonod[550]: Modem: > AT+CRSM=3D192,12258,0,0,255\r
ofonod[550]: Modem: < \r\n+CME ERROR: 3\r\n
ofonod[550]: Modem: > AT+CGMI\r
ofonod[550]: Modem: < \r\nSierra Wireless, Incorporated\r\n\r\nOK\r\n
ofonod[550]: Modem: > AT+CRSM=3D192,28421,0,0,255\r
ofonod[550]: Modem: < \r\n+CME ERROR: 3\r\n
ofonod[550]: Modem: > AT+CGMM\r
ofonod[550]: Modem: < \r\nMC8092\r\n\r\nOK\r\n
ofonod[550]: Modem: > AT+CRSM=3D192,12037,0,0,255\r
ofonod[550]: Modem: < \r\n+CME ERROR: 3\r\n
ofonod[550]: Modem: > AT+CGMR\r
ofonod[550]: Modem: < \r\nP1_0_0_8AP R1338 CNHKGDKCE01 2011/10/21
09:21:31\r\n\r\nOK\r\n
ofonod[550]: Modem: > AT+CPIN?\r
ofonod[550]: Modem: < \r\n+CME ERROR: 14\r\n
ofonod[550]: Querying PIN authentication state failed
ofonod[550]: Modem: > AT+CGSN\r
ofonod[550]: Modem: < \r\n351516050021187\r\n\r\nOK\r\n
ofonod[550]: Modem: < \r\n!STKC: 81\r\n

AT+CRSM=3D192,12258,0,0,255 return an error. I have tried to send "AT
+CRSM=3D192,12258,0,0,255" to the modem by using minicom and it returns no
error. Do you know why it returns an error when I'm using Ofono?

I have add a retry loop on "AT+CPIN?" request,@the third attempt the
request return OK but no other commands are sent.

Simon



--===============0659042398030390849==--

