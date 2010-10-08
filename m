Content-Type: multipart/mixed; boundary="===============3538255896083456401=="
MIME-Version: 1.0
From: Alexander A Khryukin <alexander@mezon.ru>
Subject: Re: huawei e1550
Date: Fri, 08 Oct 2010 16:43:41 +0400
Message-ID: <1286541821.22751.27.camel@mezon.ru>
In-Reply-To: <1286540446.22751.19.camel@mezon.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3538255896083456401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=D0=92 =D0=9F=D1=82=D0=BD, 08/10/2010 =D0=B2 16:20 +0400, Alexander A Khryu=
kin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi all.
> I have a huawei 1550 GSM-modem.
> When i plug it to usb =

> =

> =

> /usr/lib/ofono/test/list-modems =

> [ /huawei0 ]
>     Features =3D sim =

>     Powered =3D 1
>     Interfaces =3D org.ofono.SupplementaryServices org.ofono.CallBarring
> org.ofono.CallSettings org.ofono.CallForwarding org.ofono.MessageWaiting
> org.ofono.AudioSettings org.ofono.VoiceCallManager org.ofono.SimManager =

>     Online =3D 1
>     Model =3D E1550
>     Manufacturer =3D huawei
>     Serial =3D 353142033084081
>     Revision =3D 11.608.12.00.143
>     [ org.ofono.SupplementaryServices ]
>         State =3D idle
>     [ org.ofono.CallBarring ]
> =

>         VoiceOutgoing =3D disabled
>         VoiceIncoming =3D disabled
>     [ org.ofono.CallSettings ]
> =

> =

> All fine.
> In UX-interface i see section "3G" =

> but modem cant find operator's network
> =

> I compare with HUAWEI E620 USB modem
> When i plug it in UX i see my network "Megafon" and can connect.
> =

> If use ppp+usb_modeswitch modem working and can dial.


Hm, now network visible but when i press "Connect" =

ofonod put in log that modem was removed
and then process still loopback

http://pastie.org/1207567


plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/usb1/1-3/1-3:1.=
1/ttyUSB1/tty/ttyUSB1 (huawei)
ofonod[3510]: plugins/udev.c:add_huawei() modem 0x88b0cf8
ofonod[3510]: src/modem.c:get_modem_property() modem 0x88b0cf8 property
ModemRegistered
...
...
...
...
plugins/udev.c:remove_modem() /devices/pci0000:00/0000:00:1d.7/usb1/1-3/1-3=
:1.1/ttyUSB1/tty/ttyUSB1
ofonod[3510]:
plugins/udev.c:remove_modem() /devices/pci0000:00/0000:00:1d.7/usb1/1-3/1-3=
:1.2/ttyUSB2/tty/ttyUSB2




Remove and adding modem repeating and repeaing again.




--===============3538255896083456401==--

