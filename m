Content-Type: multipart/mixed; boundary="===============2403756167979320281=="
MIME-Version: 1.0
From: yanni <neelslotter@vodamail.co.za>
Subject: test script to establish 3G connection
Date: Fri, 21 Jan 2011 19:27:07 +0200
Message-ID: <1295630827.2272.4.camel@yanni-laptop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2403756167979320281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I'm looking for an example how to active 3G connection(ppp) with Huawei
E180.
not sure if these step's should work:
1)/ofono-0.39/test# ./enable-modem =

Connecting modem /huawei0...
2)/ofono-0.39/test# ./online-modem =

Setting modem /huawei0 online...
3)/ofono-0.39/test# ./list-modems =

[ /huawei0 ]
    Features =3D sms gprs cbs net rat sim =

    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.SmartMessaging org.ofono.PushNotification
org.ofono.MessageManager org.ofono.ConnectionManager
org.ofono.CellBroadcast org.ofono.NetworkRegistration
org.ofono.SupplementaryServices org.ofono.Phonebook
org.ofono.RadioSettings org.ofono.SimManager =

    Online =3D 1
4)./create-internet-context internet
5)./list-contexts
[ /huawei0 ]./list-contexts
[ /huawei0 ]
    [ /huawei0/context1 ]
        Username =3D =

        Protocol =3D ip
        Name =3D Internet
        Settings =3D { }
        Active =3D 0
        AccessPointName =3D internet
        Password =3D =

        Type =3D internet
6)./process-context-settings , no output
    [ /huawei0/context1 ]
        Username =3D =

        Protocol =3D ip
        Name =3D Internet
        Settings =3D { }
        Active =3D 0
        AccessPointName =3D internet
        Password =3D =

        Type =3D internet
./process-context-settings "Receive no output here??...."

Thanks =



--===============2403756167979320281==--

