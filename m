Content-Type: multipart/mixed; boundary="===============1230993551802169014=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Bluetooth headset and ofono
Date: Thu, 01 Jan 2015 22:36:39 +0100
Message-ID: <54A5BDE7.9030208@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1230993551802169014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I have trouble getting my bluetooth headset to work with ofono and =

pulseaudio.
My mobile phones connect without problems and work fine.

First, I do not have a modem in my system, so I installed phonesim. =

Bluez Version
is 5.23 (Debian unstable), pulseaudio and ofono are compiled from =

current git.
When I run phonesim and power on the modem I see that UUID 0x111f is =

available.
When I power on my headset (which is already paired and trusted and HSP =

works
OK with the pulseaudio native backend) it is connected, but I cannot use =

the HFP
profile. Log messages from ofono are:

plugins/hfp_ag_bluez5.c:profile_new_connection() Profile handler =

NewConnection
plugins/hfp_ag_bluez5.c:profile_new_connection() =

/org/bluez/hci0/dev_0C_E0_E4_31_23_2D
plugins/hfp_ag_bluez5.c:profile_new_connection() Picked modem 0x1d64640 =

for emulator
src/emulator.c:ofono_emulator_create() modem: 0x1d64640, type: 1
src/emulator.c:ofono_emulator_register() 0x1d52220, 14

And when I disconnect the headset, I get:

src/emulator.c:emulator_disconnect() 0x1d52220
src/emulator.c:emulator_unregister() 0x1d52220
src/emulator.c:emulator_remove() atom: 0x1d669c0
plugins/hfp_ag_bluez5.c:io_hup_cb() Remove =

/org/bluez/hci0/dev_0C_E0_E4_31_23_2D
plugins/hfp_ag_bluez5.c:connection_destroy() fd 15

I see no D-Bus messages at all, I would expect something similar to the =

messages
I get when I connect my mobile. Headset is a Plantronics Backbeat Pro.

In pulseaudio the headset turns up, but only the a2dp profile is =

useable. The a2dp profile
is connected after HFP. When I try to switch to HFP, pulsaudio says the =

HFP profile is not
connected.

Any idea what I am doing wrong?

Regards
              Georg

--===============1230993551802169014==--

