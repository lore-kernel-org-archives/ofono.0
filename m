Content-Type: multipart/mixed; boundary="===============2944661398917645443=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: AT commands not being parsed correctly from Samsung Wave HFP
Date: Thu, 06 Oct 2011 19:45:18 +0200
Message-ID: <4E8DE92E.30902@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2944661398917645443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

He are having some trouble with the Samsung Wave, apparently because the =

AT commands are not being parsed correctly. Here you have the log from =

oFono:

ofonod[12078]: plugins/hfp_hf.c:hfp_enable() 0x1aa8f90
ofonod[12078]: > AT+BRSF=3D118\r
ofonod[12078]: < \r\n+BRSF: 481\r\n
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: > AT+CIND=3D?\r
ofonod[12078]: < \r\n+CIND: =

("call",(0,1)),("callsetup",(0-3)),("service",(0,1)),("signal",(0-5)),("roa=
m",(0,1)),("battchg",(0-5)),("callheld",(0-2))\r\n
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: > AT+CIND?\r
ofonod[12078]: < \r\n+CIND: 0,0,1,5,0,1,0\r\n
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: > AT+CMER=3D3,0,0,1\r
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: > AT+CHLD=3D?\r
ofonod[12078]: < \r\n+CHLD: (0,1,1x,2,2x,3,4)\r\n
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[12078]: plugins/hfp_hf.c:hfp_pre_sim() 0x1aa8f90
ofonod[12078]: drivers/hfpmodem/call-volume.c:hfp_call_volume_probe()
ofonod[12078]: drivers/hfpmodem/handsfree.c:hfp_handsfree_probe()
ofonod[12078]: src/modem.c:modem_change_state() old state: 1, new state: 2
ofonod[12078]: plugins/hfp_hf.c:hfp_post_sim() 0x1aa8f90
ofonod[12078]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[12078]: Service level connection established
ofonod[12078]: > AT+CMEE=3D1\r
ofonod[12078]: drivers/hfpmodem/call-volume.c:hfp_call_volume_register()
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: > AT+CLIP=3D1\r
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: > AT+CCWA=3D1\r
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: drivers/hfpmodem/voicecall.c:hfp_voicecall_initialized() =

hfp_voicecall_init: registering to notifications
ofonod[12078]: > AT+CIND?\r
ofonod[12078]: < \r\n+CIND: 0,0,1,5,0,1,0\r\n
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: > AT+VGS=3D7\r
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: > AT+VGM=3D7\r
ofonod[12078]: < \r\nOK\r\n
ofonod[12078]: > AT+CLCC\r
ofonod[12078]: < \r\n\r\nOK\r\n\r\n


It seems that, after the last line, no other AT commands are parsed =

correctly. Any ideas of what's wrong?

Cheers,

Mikel


--===============2944661398917645443==--

