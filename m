Content-Type: multipart/mixed; boundary="===============1017449961834298096=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Tue, 12 Mar 2013 13:13:19 -0500
Message-ID: <513F703F.40001@gmail.com>
In-Reply-To: <513DEFEC.2070208@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1017449961834298096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

>
> Any comments ? :(

Nope, the logs looked fine.

>
> Before, I tested with 1.6.
>
> And, today, I tried with 1.12.
>
> And, I've got some troubles at modem power up... During the 3 first
> start, ofono was blocked after sending a command. Here 2 pastes :
>
> ------------------------------
> [...]
> ofonod[13400]: drivers/atmodem/cbs.c:at_cbs_set_topics()
> ofonod[13400]: Data: > AT+CSCB=3D0,"4352-4356"\r
> ofonod[13400]: Data: < \r\nOK\r\n
> ofonod[13400]: Data: > AT+CRSM=3D192,28437\r
> ofonod[13400]: Data: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> ofonod[13400]: Data: > AT+CRSM=3D192,28436\r
> ------------------------------
>

No idea, it just stops responding

> ------------------------------
> [...]
> ofonod[10387]: src/network.c:ofono_netreg_status_notify() /simcom_0
> status 1 tech -1
> ofonod[10387]: src/cbs.c:cbs_location_changed() 1, -1, -1, -1, (null)(nul=
l)
> ofonod[10387]: Data: > AT+CRSM=3D192,28480\r
> ofonod[10387]: Data: < \r\n+CRSM: 144,0,""\r\n\r\nOK\r\n
> ofonod[10387]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90,
> 00, 0
> ofonod[10387]: Data: > AT+CMGF=3D?\r
> ------------------------------
>

Ditto

> As you can see, It's not always at the same moment. After that, I can't
> send AT command anymore, the modem seems to be locked.
>
> I try to debug this and found the CMUX and CMUXSRVPORT ports. I can have
> a DIAG port, so, I try to configure it. I stopped ofono, the modem and
> sent these commands :
>
> ------------------------------
> AT+CMUXSRVPORT=3D0, 0
> AT+CMUXSRVPORT=3D1, 5
> AT+CMUXSRVPORT=3D2, 1
> AT+CMUXSRVPORT=3D3, 1
>
> +CMUX=3D0
> ------------------------------
>
> ------------------------------
> AT+CMUXSRVPORT
> --------------
> < port >: virtual com port
> 0 =E2=80=93 3 currently support 4 virtual com ports index from 0 to 3
>
> < service >: valid service
> 0 =E2=80=93 DIAG Service
> 1 =E2=80=93 DATA(MODEM) Service
> 5 =E2=80=93 NMEA Service
> ------------------------------
>
> And now, each time I start ofono and power up the modem, it works. No
> lock. Hum, I'm disapointed. I didn't think theses commands could fix the
> problem. And, no messages in diag or NMEA tty. Hum... And moreover, now
> all SMS I send are received. No failure. So good news, but, I'm troubled.
>
> After grepping on ofono source, I see some driver plugins do a CMUX set
> (calipso, phonesim). Maybe, I need to execute a CMUX set ??? It can be
> important ?
>

CMUX is used on devices with 1 physical serial port.  It is used to =

enter into so-called Multiplexing mode, a binary protocol that runs =

multiple logical AT ports over a single physical port.  Refer to 3GPP =

27.010.  I do not know whether your hardware supports multiplexing or =

not.  If the modem is detected with multiple serial ports, then likely =

it does not require messing with CMUX.

Regards,
-Denis

--===============1017449961834298096==--

