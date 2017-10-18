Content-Type: multipart/mixed; boundary="===============1757955538196932375=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Pi=C4=8Dugins?= Arsenijs <crimier@yandex.ru>
Subject: Running ofono on Raspberry Pi and SIM800
Date: Wed, 18 Oct 2017 12:49:58 +0300
Message-ID: <342291508320198@web43j.yandex.ru>
In-Reply-To: <mailman.19.1508266802.24405.ofono@ofono.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1757955538196932375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I'm interested in running ofono on a Raspberry Pi (BCM2835, 1GHz), connecte=
d to a SIM800 modem over UART (the stable Pi UART, not the MiniUART). I als=
o have RST, DTR and RESET signals connected to the Pi, and for sound I'm us=
ing analog audio outputs and inputs of the modem. Basically, I'm talking ab=
out using ofono in ZeroPhone project - https://hackaday.io/project/19035 .

For now, I'm interested in 1) notifications about voice call status (not co=
ncerning audio for now, as it's handled in hardware) 2) SMS and MMS support=
 3) 2G data connections (whatever available connection types are on 2G netw=
orks) 4) USSD support. My questions are:

1) Is ofono going to be suitable for my needs? I'm more than OK with using =
DBus and rolling my own user interface to it.
2) How do I run ofono from command-line and tell it to connect to a specifi=
c serial port and use a specific ofono driver? =

3) Do you foresee any necessary changes to ofono? For example, need to make=
 a sim800-specific driver?
4) I see that Sailfish phones are using ofono as the GSM backend. Did they =
upstream their changes, or do they have a fork?
5) I'm planning to work with SIM5320 modem in the future, and attempt using=
 its USB connection. I know it creates multiple serial ports, and supports =
streaming audio over one of them. Does ofono come into play here, does it h=
ave some kind of provisions to convert this kind of audio input/output into=
 actual sound devices under Linux, or is that usually handled by other soft=
ware?

Best regards,
Arsenijs.

--===============1757955538196932375==--

