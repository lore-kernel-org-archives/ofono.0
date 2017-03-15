Content-Type: multipart/mixed; boundary="===============5648454891916904216=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Telit LE910V1 - LTE only modem
Date: Wed, 15 Mar 2017 18:35:53 +0000
Message-ID: <d0f4d648-97b3-8310-1105-e98114d419ba@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5648454891916904216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am working on enabling a Telit LE910-SVG modem with ofono. It is LE910 V1=
 which is completely different to LE910 V2. This is a modem which only has =
LTE data, no GSM/UMTS, no CDMA.
I have hit a problem as it appears to register only to a GPRS network - not=
 to a "normal" one:

AT+CREG?
+CREG: 2,0

AT+CGREG?
+CGREG: 2,1,"3B01","E6A903",7,3D

I am using atmodem and it does not even check +CGREG when it gets +CREG: 2,=
0:

ofonod[2909]: Aux: > AT+CREG?\r
ofonod[2909]: Aux: < \r\n+CREG: 2,0\r\n\r\nOK\r\n
ofonod[2909]: ../git/src/network.c:ofono_netreg_status_notify() /telit_0 st=
atus 0 tech -1
ofonod[2909]: ../git/src/network.c:current_operator_callback() 0x56851870, 0
ofonod[2909]: ../git/src/gprs.c:netreg_status_changed() 0
ofonod[2909]: ../git/src/gprs.c:gprs_netreg_update() attach: 0, driver_atta=
ched: 0


Has such a modem been used with ofono before?

I would appreciate any pointers how to tackle this issue.
Thanks.

Lukasz

--===============5648454891916904216==--

