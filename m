Content-Type: multipart/mixed; boundary="===============0181219332851536307=="
MIME-Version: 1.0
From: Alexander A Khryukin <alexander@mezon.ru>
Subject: huawei e1550
Date: Fri, 08 Oct 2010 16:20:46 +0400
Message-ID: <1286540446.22751.19.camel@mezon.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0181219332851536307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all.
I have a huawei 1550 GSM-modem.
When i plug it to usb =



/usr/lib/ofono/test/list-modems =

[ /huawei0 ]
    Features =3D sim =

    Powered =3D 1
    Interfaces =3D org.ofono.SupplementaryServices org.ofono.CallBarring
org.ofono.CallSettings org.ofono.CallForwarding org.ofono.MessageWaiting
org.ofono.AudioSettings org.ofono.VoiceCallManager org.ofono.SimManager =

    Online =3D 1
    Model =3D E1550
    Manufacturer =3D huawei
    Serial =3D 353142033084081
    Revision =3D 11.608.12.00.143
    [ org.ofono.SupplementaryServices ]
        State =3D idle
    [ org.ofono.CallBarring ]

        VoiceOutgoing =3D disabled
        VoiceIncoming =3D disabled
    [ org.ofono.CallSettings ]


All fine.
In UX-interface i see section "3G" =

but modem cant find operator's network

I compare with HUAWEI E620 USB modem
When i plug it in UX i see my network "Megafon" and can connect.

If use ppp+usb_modeswitch modem working and can dial.



--===============0181219332851536307==--

