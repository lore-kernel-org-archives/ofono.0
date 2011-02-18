Content-Type: multipart/mixed; boundary="===============7862325319766208565=="
MIME-Version: 1.0
From: Antoine Reversat <a.reversat@gmail.com>
Subject: Modem "reboots" when trying to activate a ConnectionContext
Date: Fri, 18 Feb 2011 11:55:05 -0500
Message-ID: <AANLkTi=c51ThgpOH4v3NBXONO-ic7GYu+UqFsBw0x9_P@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7862325319766208565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is on an N900 running nitdroid gingerbread with a 2.6.35.9 kernel
and ofono 0.42

When I do this :

dbus-send --system --print-reply --dest=3Dorg.ofono /isimodem/context2
org.ofono.ConnectionContext.SetProperty string:"Active"
variant:boolean:true
I get back : Error org.ofono.Error.Failed: Operation failed

/isimodem/context2 is properly defined for my operator (Fido in canada).

And here's the log ofono gives me :

D/ofono   (  355):
external/ofono/drivers/isimodem/gprs-context.c:isi_gprs_activate_primary()
activate: gpds =3D 0x002c
D/ofono   (  355): PN_<UNKNOWN> (0xD9): UNKNOWN [id=3D0x00 utid=3D0x01 len=
=3D12]:
D/ofono   (  355):     * 01 00 00 01 6C 42 04 00 00 2C 04 00
  : .....lB...,..
D/Tethering(  435): gprs0 is not a tetherable iface, ignoring
D/ofono   (  355): PN_<UNKNOWN> (0xD9): UNKNOWN [id=3D0x01 utid=3D0x01 len=
=3D6]:
D/ofono   (  355):     * 01 01 00 00 00 00
  : .......
D/ofono   (  355): gisi: Unknown error: 0 RESP to 0x54af8 [res=3D0xD9,
id=3D0x01, utid=3D0x01]
D/ofono   (  355): PN_GPDS (0x31): GPDS_CONTEXT_ID_CREATE_REQ [id=3D0x02
utid=3D0x05 len=3D2]:
D/ofono   (  355):     * 05 02                                           : =
...
D/ofono   (  355): PN_GPDS (0x31): GPDS_CONTEXT_ID_CREATE_RESP
[id=3D0x03 utid=3D0x05 len=3D4]:
D/ofono   (  355):     * 05 03 00 01                                     : =
.....
D/ofono   (  355): gisi: Unknown error: 0 RESP to 0x521b8 [res=3D0x31,
id=3D0x03, utid=3D0x05]
D/ofono   (  355): PN_GPDS (0x31): GPDS_LL_CONFIGURE_REQ [id=3D0x00
utid=3D0x06 len=3D5]:
D/ofono   (  355):     * 06 00 00 00 02
  : ......
D/ofono   (  355): PN_GPDS (0x31): GPDS_CONTEXT_ID_CREATE_IND [id=3D0x04
utid=3D0x00 len=3D3]:
D/ofono   (  355):     * 00 04 00                                        : =
....
D/ofono   (  355): PN_GPDS (0x31): GPDS_LL_CONFIGURE_RESP [id=3D0x01
utid=3D0x06 len=3D4]:
D/ofono   (  355):     * 06 01 00 01                                     : =
.....
D/ofono   (  355): gisi: Unknown error: 0 RESP to 0x54af8 [res=3D0x31,
id=3D0x01, utid=3D0x06]
D/ofono   (  355): PN_GPDS (0x31): GPDS_CONTEXT_CONFIGURE_REQ [id=3D0x06
utid=3D0x07 len=3D31]:
D/ofono   (  355):     * 07 06 00 21 00 00 00 02 90 04 00 00 05 16 10
69 : ....!...........i
D/ofono   (  355):     * 6E 74 65 72 6E 65 74 2E 66 69 64 6F 2E 63 61
  : nternet.fido.ca
D/ofono   (  355): PN_GPDS (0x31): GPDS_CONTEXT_CONFIGURE_RESP
[id=3D0x07 utid=3D0x07 len=3D4]:
D/ofono   (  355):     * 07 07 00 01                                     : =
.....
D/ofono   (  355): gisi: Unknown error: 0 RESP to 0x521b8 [res=3D0x31,
id=3D0x07, utid=3D0x07]
D/ofono   (  355): PN_GPDS (0x31): GPDS_CONTEXT_AUTH_REQ [id=3D0x33
utid=3D0x08 len=3D18]:
D/ofono   (  355):     * 08 33 00 02 0B 0A 04 66 69 64 6F 0C 0A 04 66
69 : ..3.....fido...fi
D/ofono   (  355):     * 64 6F                                           : =
do
D/ofono   (  355):
external/ofono/plugins/nokia-gpio.c:phonet_status_cb() Link phonet0
(3) is down
D/ofono   (  355):
external/ofono/plugins/nokia-gpio.c:gpio_power_state_machine()
(POWER_EVENT_PHONET_LINK_DOWN) @ state POWER_STATE_ON
D/ofono   (  355):
external/ofono/plugins/nokia-gpio.c:gpio_power_set_state()
(POWER_STATE_ON_RESET) at (POWER_STATE_ON)
D/ofono   (  355):
external/ofono/plugins/nokia-gpio.c:gpio_power_set_state() Starting
modem restart timeout
D/ofono   (  355): external/ofono/plugins/n900.c:n900_power_cb() power
state POWER_STATE_ON_RESET
D/ofono   (  355): external/ofono/plugins/n900.c:report_powered() Reset
D/ofono   (  355): external/ofono/src/modem.c:modem_change_state() old
state: 3, new state: 0


Any ideas or other debug information you need ?

--===============7862325319766208565==--

