Content-Type: multipart/mixed; boundary="===============3662920272068483038=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: ppp problem
Date: Mon, 24 Jan 2011 11:56:17 +0100
Message-ID: <1295866577.2676.21.camel@aeonflux>
In-Reply-To: <a08dc9.a078.12db705a4b0.Coremail.hyqzyf@163.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3662920272068483038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> I have got a problem about 3G connectrion from ofono, does anyone have
> idea to resolve it? =

> The  modem is huawei EM560. =

> =

> Here is the log:
> =

> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
> Path
> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
> Registered
> ofonod[940]:
> plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:00.7/usb1/1-1/1-1.=
2/1-1.2:2.1/tty/ttyACM0 (huawei)
> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
> ModemRegistered
> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
> PcuiRegistered
> ofonod[940]: plugins/udev.c:add_huawei() add_huaweiingggggggggg by hyq
> ofonod[940]: plugins/udev.c:add_huawei() name =3DOFONO_HUAWEI_TYPE by
> hyq
> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
> Modem
> ofonod[940]: src/modem.c:set_modem_property() m odem 0x8d49058
> property ModemRegistered
> ofonod[940]: plugins/udev.c:add_huawei() after ofono_modem_register by
> hyq ppp=3D1 pcui=3D0
> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
> Path
> ofonod[940]:
> plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:00.7/usb1/1-1/1-1.=
2/1-1.2:2.3/tty/ttyACM1 (huawei)
> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
> ModemRegistered
> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
> PcuiRegistered
> ofonod[940]: plugins/udev.c:add_huawei() add_huaweiingggggggggg by hyq
> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
> HasVoice
> ofonod[940]: plugins/udev.c:add_huawei() after ofono_modem_register by
> hyq ppp=3D1 pcui=3D0
> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
> Path
> ofonod[940]:
> plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:00.7/usb1/1-1/1-1.=
2/1-1.2:2.7/tty/ttyACM2 (huawei)
> ofonod[940]: src/modem.c:g et_modem_property() modem 0x8d49058
> property ModemRegistered
> ofonod[940]: src/modem.c:get_modem_property() modem 0x8d49058 property
> PcuiRegistered
> ofonod[940]: plugins/udev.c:add_huawei() name =3DOFONO_HUAWEI_TYPE by
> hyq
> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
> Pcui
> ofonod[940]: src/modem.c:set_modem_property() modem 0x8d49058 property
> PcuiRegistered
> =

> [root(a)localhost test]# ./activate-context =

> Entering new phase: 1
> Entering new phase: 3
> Entering new phase: 4
> ofonod[815]: drivers/atmodem/gprs-context.c:ppp_connect() =

> ofonod[815]: IP: 0.0.0.0
> ofonod[815]: DNS: 0.0.0.0, 0.0.0.0
> ofonod[815]: src/gprs.c:pri_activate_callback() 0xa063660 ppp0

no idea what goes wrong here, but the network or your modem firmware
basically tells you that the IP address is not set.

Run with OFONO_PPP_DEBUG=3D1 and see if it gives you more details.

Regards

Marcel



--===============3662920272068483038==--

