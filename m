Content-Type: multipart/mixed; boundary="===============2779558709481683081=="
MIME-Version: 1.0
From: Kai Scharwies <kai@scharwies.de>
Subject: Qualcomm Gobi 2000 Modem Issues
Date: Thu, 07 Apr 2011 17:37:47 +0200
Message-ID: <BANLkTimhdWZCh-BFhs5OLRUyVreU6ufJPA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2779558709481683081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone.

I ran into two issues trying to setup a data connection with a Gobi 2000 ca=
rd.
The first one seems to be an error regarding simcard onlocking. After
enabling the modem test/list-modems shows the following, despite the
simcard is inserted correctly:

[ /gobi0 ]
    Features =3D sim
    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.SimManager
    Online =3D 0
    Model =3D Qualcomm Gobi 2000
    Revision =3D D1025-STUTABGD-3600  1  [Jan 14 2010 14:00:00]
    Serial =3D 353093033460401
    Manufacturer =3D Qualcomm Incorporated
    [ org.ofono.SimManager ]
        Present =3D 0

Our current workaround is quitting ofono and using minicom to unlock
the sim directly, then restarting ofono.
> at+cpin?
+CPIN: SIM PIN
OK

> at+cpin=3D"1234"
OK
$QCSIMSTAT: 1 SIM INIT COMPLETED

The second issue is not being able to activate an internet context:
(Network registration and attachment is alright)

test/enable-modem
Connecting modem /gobi0...
test/online-modem
Setting modem /gobi0 online...
test/list-contexts
[ /gobi0 ]
    [ /gobi0/context1 ]
        Username =3D
        Protocol =3D ip
        Name =3D Internet
        Settings =3D { }
        IPv6.Settings =3D { }
        Active =3D 0
        AccessPointName =3D internet.t-mobile
        Password =3D
        Type =3D internet

test/activate-context
Error activating /gobi0/context1: org.ofono.Error.NotImplemented:
Implementation not provided

If you could give me a little assisting on where to look, maybe I
would be able to contribute patches, too.

Best regards,
Kai

--===============2779558709481683081==--

