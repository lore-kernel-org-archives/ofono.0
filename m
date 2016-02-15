Content-Type: multipart/mixed; boundary="===============5603906830872269663=="
MIME-Version: 1.0
From: Near.Guo <skywindsea1@gmail.com>
Subject: how to run PDP establishment ?
Date: Mon, 15 Feb 2016 02:14:54 +0000
Message-ID: <loom.20160215T031348-872@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5603906830872269663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI

From network search result , I know "CGACT" for PDP establishment is =

removed long time ago  ,but I don't know how to establish PDP by using AT-
modem  ,could you help me ?

From my test :
1. I use ZTE dongle (AT modem) , it has CGATT (PS attach) =3D> CGDCONT =

(setting profile) and log stops at this stage , no "CGACT" follows
=3D=3Dlog=3D=3D
ofonod[16082]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() =

cid 1
ofonod[16082]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() =

cmd: AT+CGDCONT=3D1,"IP","uninet"
....no CGACT....


2.  I test by using phonesim , it has CGACT =

=3D=3D=3Dlog=3D=3D=3D
ofonod[12694]: > AT+CGDCONT=3D5,"IP",""\r
ofonod[12694]: < \r\nOK\r\n
ofonod[12694]: > AT+CGACT=3D1,5\r
ofonod[12694]: < \r\nOK\r\n
ofonod[12694]: src/gprs.c:pri_activate_callback() 0xd80a00



so could you know how to fix this ?

thanks


--===============5603906830872269663==--

