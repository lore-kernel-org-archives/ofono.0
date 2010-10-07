Content-Type: multipart/mixed; boundary="===============0393650177468291328=="
MIME-Version: 1.0
From: Alexander A Khryukin <alexander@mezon.ru>
Subject: airplus MCD-650
Date: Thu, 07 Oct 2010 14:13:46 +0400
Message-ID: <1286446426.22751.4.camel@mezon.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0393650177468291328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all.I have a modem airplus MCD-650 =


lsusb

Bus 002 Device 055: ID 1edf:6004


/etc/ofono/modem.conf
[atgen]
Driver=3Datgen
Device=3D/dev/ttyACM0
Baud=3D460800


when i plug modem in ofonod see =


ofonod[3925]: src/modem.c:ofono_modem_create() name: (null), type: atgen
ofonod[3925]: src/modem.c:set_modem_property() modem 0x82aaed8 property
Path
ofonod[3925]: src/modem.c:set_modem_property() modem 0x82aaed8 property
Registered
ofonod[3925]:
plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.=
0/tty/ttyACM0 (atgen)

/usr/lib/ofono/test/list-modems =



[ /atgen1 ]
    Interfaces =3D =

    Powered =3D 0
    Features =3D =

    Online =3D 0

[ /atgen ]
    Interfaces =3D =

    Powered =3D 0
    Features =3D =

    Online =3D 0


/usr/lib/ofono/test/enable-modem /atgen
Connecting modem /atgen...

Connecting to modem succesfull



/usr/lib/ofono/test/list-modems =


[ /atgen1 ]
    Interfaces =3D =

    Powered =3D 0
    Features =3D =

    Online =3D 0

[ /atgen ]
    Interfaces =3D org.ofono.VoiceCallManager org.ofono.SimManager =

    Powered =3D 1
    Features =3D sim =

    Online =3D 0
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 112 911 000 08 110 999 118 119 =

    [ org.ofono.SimManager ]
        SubscriberNumbers =3D =

        LockedPins =3D =

        PinRequired =3D none
        Present =3D 1




Looks like i sim manager.
Modem not working.
Whats wrong and how to fix it?



--===============0393650177468291328==--

