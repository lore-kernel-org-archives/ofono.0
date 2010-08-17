Content-Type: multipart/mixed; boundary="===============2293500505064325160=="
MIME-Version: 1.0
From: Florian Mayer (Mayer Electronics) <Florian.Mayer@mayer-electronics.de>
Subject: ppp0 interface is not configured
Date: Tue, 17 Aug 2010 18:41:03 +0200
Message-ID: <4C6ABB9F.5080104@mayer-electronics.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2293500505064325160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

we currently test the PPP dialup with a Huawei EM770W modem. We can =

connect with create-context and activate context but the ppp device is =

not configured. connman says that the device is not connected. We use =

connman 0.55 and ofono 0.26.
What did we do wrong? The kernel is 2.6.35~pre5 from Meego 1.1 devel.

Regards
Florian Mayer
Mayer Electronics

# /usr/lib/ofono/test/list-modems
[ /huawei0 ]
    Features =3D sms gprs cbs net sim
    Powered =3D 1
    Interfaces =3D org.ofono.SmsManager org.ofono.DataConnectionManager =

org.ofono.CellBroadcast org.ofono.NetworkRegistration =

org.ofono.SupplementaryServices org.ofono.SimManager
    Online =3D 1
    Model =3D EM770W
    Manufacturer =3D huawei
    Serial =3D xyz
    Revision =3D 11.126.10.81.00
    [ org.ofono.SmsManager ]
        UseDeliveryReports =3D 0
        Bearer =3D cs-preferred
        ServiceCenterAddress =3D +491710760000
    [ org.ofono.DataConnectionManager ]
        Powered =3D 1
        Attached =3D 1
        PrimaryContexts =3D /huawei0/primarycontext1
        RoamingAllowed =3D 1
    [ org.ofono.CellBroadcast ]
        Topics =3D
        Powered =3D 1
    [ org.ofono.NetworkRegistration ]
        Status =3D registered
        Strength =3D 70
        Name =3D T-Mobile D
        Operators =3D /huawei0/operator/26201
        LocationAreaCode =3D 34591
        Mode =3D auto
        MobileCountryCode =3D 262
        CellId =3D 5950877
        MobileNetworkCode =3D 01
    [ org.ofono.SupplementaryServices ]
        State =3D idle
    [ org.ofono.SimManager ]
        SubscriberNumbers =3D
        LockedPins =3D
        SubscriberIdentity =3D xyz
        Present =3D 1
        PinRequired =3D none

# /usr/lib/ofono/test/list-contexts
[ /huawei0 ]
    [ /huawei0/primarycontext1 ]
        Username =3D
        Protocol =3D ip
        Name =3D 3G Connection
        Settings =3D { Interface=3Dppp0 Netmask=3D255.255.255.255 =

Method=3Dstatic DomainNameServers=3D193.254.160.1,10.74.83.22, =

Address=3D88.128.36.75 }
        Active =3D 1
        AccessPointName =3D internet.t-d1.de
        Password =3D
        Type =3D internet

# /usr/lib/connman/test/list-networks
....
[ /org/moblin/connman/device/262012020178698 ]
    [ /org/moblin/connman/device/262012020178698/primarycontext1 ]
        Device =3D /org/moblin/connman/device/262012020178698
        Strength =3D 70
        Connected =3D 0
        Name =3D T-Mobile D

# /usr/lib/connman/test/list-devices
....
[ /org/moblin/connman/device/262012020178698 ]
    Networks =3D /org/moblin/connman/device/262012020178698/primarycontext1
    Type =3D cellular
    Name =3D Cellular
    Powered =3D 1




--===============2293500505064325160==--

