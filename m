Content-Type: multipart/mixed; boundary="===============8319115910238005284=="
MIME-Version: 1.0
From: Antoine Reversat <a.reversat@gmail.com>
Subject: Re: Modem "reboots" when trying to activate a ConnectionContext
Date: Fri, 18 Feb 2011 13:45:20 -0500
Message-ID: <AANLkTi=yOzoBL-GK=mPsGhFG9TFs+vB0h8cuNzB5hdZS@mail.gmail.com>
In-Reply-To: <AANLkTi=c51ThgpOH4v3NBXONO-ic7GYu+UqFsBw0x9_P@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8319115910238005284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If I'm not mistaken I might have found what's wrong : it seems the
subblock length are wrong.

Fro example in GPDS_CONTEXT_CONFIGURE_REQ the second subblock
(GPDS_APN_INFO) contains a length of 0x16 which is 22 bytes. Except
the length is 19 bytes. Is this right or am I missing something ? It
is also the case for GPDS_CONTEXT_AUTH_REQ.

On Fri, Feb 18, 2011 at 11:55 AM, Antoine Reversat <a.reversat@gmail.com>=
 wrote:
> This is on an N900 running nitdroid gingerbread with a 2.6.35.9 kernel
> and ofono 0.42
>
> When I do this :
>
> dbus-send --system --print-reply --dest=3Dorg.ofono /isimodem/context2
> org.ofono.ConnectionContext.SetProperty string:"Active"
> variant:boolean:true
> I get back : Error org.ofono.Error.Failed: Operation failed
>
> /isimodem/context2 is properly defined for my operator (Fido in canada).
>
> And here's the log ofono gives me :
>
> D/ofono =C2=A0 ( =C2=A0355):
> external/ofono/drivers/isimodem/gprs-context.c:isi_gprs_activate_primary()
> activate: gpds =3D 0x002c
> D/ofono =C2=A0 ( =C2=A0355): PN_<UNKNOWN> (0xD9): UNKNOWN [id=3D0x00 utid=
=3D0x01 len=3D12]:
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 01 00 00 01 6C 42 04 00 00 2=
C 04 00
> =C2=A0: .....lB...,..
> D/Tethering( =C2=A0435): gprs0 is not a tetherable iface, ignoring
> D/ofono =C2=A0 ( =C2=A0355): PN_<UNKNOWN> (0xD9): UNKNOWN [id=3D0x01 utid=
=3D0x01 len=3D6]:
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 01 01 00 00 00 00
> =C2=A0: .......
> D/ofono =C2=A0 ( =C2=A0355): gisi: Unknown error: 0 RESP to 0x54af8 [res=
=3D0xD9,
> id=3D0x01, utid=3D0x01]
> D/ofono =C2=A0 ( =C2=A0355): PN_GPDS (0x31): GPDS_CONTEXT_ID_CREATE_REQ [=
id=3D0x02
> utid=3D0x05 len=3D2]:
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 05 02 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : ...
> D/ofono =C2=A0 ( =C2=A0355): PN_GPDS (0x31): GPDS_CONTEXT_ID_CREATE_RESP
> [id=3D0x03 utid=3D0x05 len=3D4]:
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 05 03 00 01 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : .....
> D/ofono =C2=A0 ( =C2=A0355): gisi: Unknown error: 0 RESP to 0x521b8 [res=
=3D0x31,
> id=3D0x03, utid=3D0x05]
> D/ofono =C2=A0 ( =C2=A0355): PN_GPDS (0x31): GPDS_LL_CONFIGURE_REQ [id=3D=
0x00
> utid=3D0x06 len=3D5]:
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 06 00 00 00 02
> =C2=A0: ......
> D/ofono =C2=A0 ( =C2=A0355): PN_GPDS (0x31): GPDS_CONTEXT_ID_CREATE_IND [=
id=3D0x04
> utid=3D0x00 len=3D3]:
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 00 04 00 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: ....
> D/ofono =C2=A0 ( =C2=A0355): PN_GPDS (0x31): GPDS_LL_CONFIGURE_RESP [id=
=3D0x01
> utid=3D0x06 len=3D4]:
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 06 01 00 01 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : .....
> D/ofono =C2=A0 ( =C2=A0355): gisi: Unknown error: 0 RESP to 0x54af8 [res=
=3D0x31,
> id=3D0x01, utid=3D0x06]
> D/ofono =C2=A0 ( =C2=A0355): PN_GPDS (0x31): GPDS_CONTEXT_CONFIGURE_REQ [=
id=3D0x06
> utid=3D0x07 len=3D31]:
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 07 06 00 21 00 00 00 02 90 0=
4 00 00 05 16 10
> 69 : ....!...........i
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 6E 74 65 72 6E 65 74 2E 66 6=
9 64 6F 2E 63 61
> =C2=A0: nternet.fido.ca
> D/ofono =C2=A0 ( =C2=A0355): PN_GPDS (0x31): GPDS_CONTEXT_CONFIGURE_RESP
> [id=3D0x07 utid=3D0x07 len=3D4]:
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 07 07 00 01 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : .....
> D/ofono =C2=A0 ( =C2=A0355): gisi: Unknown error: 0 RESP to 0x521b8 [res=
=3D0x31,
> id=3D0x07, utid=3D0x07]
> D/ofono =C2=A0 ( =C2=A0355): PN_GPDS (0x31): GPDS_CONTEXT_AUTH_REQ [id=3D=
0x33
> utid=3D0x08 len=3D18]:
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 08 33 00 02 0B 0A 04 66 69 6=
4 6F 0C 0A 04 66
> 69 : ..3.....fido...fi
> D/ofono =C2=A0 ( =C2=A0355): =C2=A0 =C2=A0 * 64 6F =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : do
> D/ofono =C2=A0 ( =C2=A0355):
> external/ofono/plugins/nokia-gpio.c:phonet_status_cb() Link phonet0
> (3) is down
> D/ofono =C2=A0 ( =C2=A0355):
> external/ofono/plugins/nokia-gpio.c:gpio_power_state_machine()
> (POWER_EVENT_PHONET_LINK_DOWN) @ state POWER_STATE_ON
> D/ofono =C2=A0 ( =C2=A0355):
> external/ofono/plugins/nokia-gpio.c:gpio_power_set_state()
> (POWER_STATE_ON_RESET) at (POWER_STATE_ON)
> D/ofono =C2=A0 ( =C2=A0355):
> external/ofono/plugins/nokia-gpio.c:gpio_power_set_state() Starting
> modem restart timeout
> D/ofono =C2=A0 ( =C2=A0355): external/ofono/plugins/n900.c:n900_power_cb(=
) power
> state POWER_STATE_ON_RESET
> D/ofono =C2=A0 ( =C2=A0355): external/ofono/plugins/n900.c:report_powered=
() Reset
> D/ofono =C2=A0 ( =C2=A0355): external/ofono/src/modem.c:modem_change_stat=
e() old
> state: 3, new state: 0
>
>
> Any ideas or other debug information you need ?
>

--===============8319115910238005284==--

