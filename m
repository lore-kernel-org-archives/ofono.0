Content-Type: multipart/mixed; boundary="===============8587428173012987392=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Support for GSM data cards
Date: Thu, 03 Sep 2009 01:47:11 -0700
Message-ID: <1251967631.1266.155.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8587428173012987392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys,

so I started working on udev integration and auto-detection and pushed a
few new drivers into the upstream oFono repository. It know has drivers
for Android/HTC G1, Ericsson MBM, Option HSO, Novatel and Huawai modems.
An example of three devices attached to the same system would look then
like this:

[ /mbm2 ]
    Powered =3D 1
    Interfaces =3D org.ofono.SmsManager org.ofono.NetworkRegistration =

    Model =3D F3507g
    Manufacturer =3D Ericsson
    Serial =3D 0115xxxxxxxxxx
    Revision =3D R1B003
    [ org.ofono.SmsManager ]
        ServiceCenterAddress =3D +17057969300
    [ org.ofono.NetworkRegistration ]
        Status =3D registered
        Operator =3D ROGERS
        AvailableOperators =3D /mbm2/operator/302720 =

        LocationAreaCode =3D 65080
        CellId =3D 1305559

[ /huawei1 ]
    Powered =3D 1
    Interfaces =3D org.ofono.NetworkRegistration =

    Model =3D E160
    Manufacturer =3D huawei
    Serial =3D 3538xxxxxxxxxx
    Revision =3D 11.604.18.01.00
    [ org.ofono.NetworkRegistration ]
        Status =3D roaming
        Operator =3D CAN Rogers Wirel
        AvailableOperators =3D /huawei1/operator/302720 =


[ /hso0 ]
    Powered =3D 1
    Interfaces =3D org.ofono.SmsManager org.ofono.NetworkRegistration =

    Model =3D GlobeTrotter HSDPA Modem
    Manufacturer =3D Option N.V.
    Serial =3D 3597xxxxxxxxxx
    Revision =3D 2.5.13Hd (Date: Feb 18 2008, Time: 18:32:40)
    [ org.ofono.SmsManager ]
        ServiceCenterAddress =3D +491710760000
    [ org.ofono.NetworkRegistration ]
        Status =3D roaming
        Operator =3D Rogers Wireless - T-Mobile D
        AvailableOperators =3D /hso0/operator/302720 =

        LocationAreaCode =3D 16100
        CellId =3D 47738

All of the drivers are far from finished. The best working one is the
Ericsson MBM right now. I even managed to send a text message via the
SMS interface. When trying that with an Option device the AT parser
hangs itself. So we need some quirk there. Everybody is welcome to debug
it and send a patch.

The Novatel and Huawei devices, don't seem to support SMS. Or they do
and don't report it correctly. Also the Novatel card has problems with
the network registration. It refuses to work. This needs also to be
debugged.

If the drivers network registration does work, then it looks nicely like
the following output:

[ /mbm2 ]
    [ /mbm2/operator/302720 ]
        Status =3D current
        MobileNetworkCode =3D 720
        Technology =3D UTRAN
        Name =3D ROGERS
        MobileCountryCode =3D 302

[ /huawei1 ]
    [ /huawei1/operator/302720 ]
        Status =3D current
        MobileNetworkCode =3D 720
        Technology =3D UTRAN
        Name =3D CAN Rogers Wirel
        MobileCountryCode =3D 302

[ /hso0 ]
    [ /hso0/operator/302720 ]
        Status =3D current
        MobileNetworkCode =3D 720
        Technology =3D GSM
        Name =3D Rogers Wireless - T-Mobile D
        MobileCountryCode =3D 302

The MBM device contains a local SIM card and the other two are actually
roaming.

The goal for these data cards should be to support text messaging and
GPRS (once we defined and implemented that interface). Any help is more
than welcome.

Regards

Marcel



--===============8587428173012987392==--

