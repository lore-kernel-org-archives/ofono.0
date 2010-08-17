Content-Type: multipart/mixed; boundary="===============7447733876045364002=="
MIME-Version: 1.0
From: Florian Mayer (Mayer Electronics) <Florian.Mayer@mayer-electronics.de>
Subject: Re: ppp0 interface is not configured
Date: Tue, 17 Aug 2010 19:24:26 +0200
Message-ID: <4C6AC5CA.5020503@mayer-electronics.de>
In-Reply-To: <1282063530.23399.123.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7447733876045364002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann schrieb:
> Hi Florian,
>
>   =

>> we currently test the PPP dialup with a Huawei EM770W modem. We can =

>> connect with create-context and activate context but the ppp device is =

>> not configured. connman says that the device is not connected. We use =

>> connman 0.55 and ofono 0.26.
>> What did we do wrong? The kernel is 2.6.35~pre5 from Meego 1.1 devel.
>>     =

>
> I never tested this with the EM777W modem, but with the Huawei modems I
> have it works just fine.
>
> Especially if it shows the DataConnectionManager interface since then
> you have this properly setup and running.
>
>   =

>>     [ org.ofono.DataConnectionManager ]
>>         Powered =3D 1
>>         Attached =3D 1
>>         PrimaryContexts =3D /huawei0/primarycontext1
>>         RoamingAllowed =3D 1
>>     [ org.ofono.NetworkRegistration ]
>>         Status =3D registered
>>         Strength =3D 70
>>         Name =3D T-Mobile D
>>         Operators =3D /huawei0/operator/26201
>>         LocationAreaCode =3D 34591
>>         Mode =3D auto
>>         MobileCountryCode =3D 262
>>         CellId =3D 5950877
>>         MobileNetworkCode =3D 01
>>     =

>
>   =

>> # /usr/lib/ofono/test/list-contexts
>> [ /huawei0 ]
>>     [ /huawei0/primarycontext1 ]
>>         Username =3D
>>         Protocol =3D ip
>>         Name =3D 3G Connection
>>         Settings =3D { Interface=3Dppp0 Netmask=3D255.255.255.255 =

>> Method=3Dstatic DomainNameServers=3D193.254.160.1,10.74.83.22, =

>> Address=3D88.128.36.75 }
>>         Active =3D 1
>>         AccessPointName =3D internet.t-d1.de
>>         Password =3D
>>         Type =3D internet
>>     =

>
> This looks like an active Internet context. How did you activate this
> one. Via ConnMan or via activate-context test script. If via the script,
> then I think that ConnMan is not picking this up. I think that is a bug
> in ConnMan.
>
> What does list-services from ConnMan says? The devices and networks are
> actually irrelevant.
>   =

Hello,

thanks for the fast reply.
Yes I activated the context with the ofono activate-context script. I =

tested this method some time ago with connman 0.54 and ofono 0.24. There =

it worked.
Here is the result of connman list-services:
[ /profile/default/cellular_262012020178698_primarycontext1 ]
    AutoConnect =3D false
    Strength =3D 74
    Name =3D T-Mobile D
    SetupRequired =3D true
    Nameservers =3D [ ]
    Proxy =3D { }
    Favorite =3D false
    Domains.Configuration =3D [ ]
    State =3D idle
    IPv4 =3D { }
    Nameservers.Configuration =3D [ ]
    Mode =3D gprs
    Domains =3D [ ]
    Ethernet =3D { }
    Roaming =3D 0
    IPv4.Configuration =3D { }
    Type =3D cellular
    Immutable =3D false
    LoginRequired =3D false

How can I activate the the service from connman side via command line?
To get it right: each created context in ofono (and in the modem) is a =

service for connman, right?
I have to provide some hardware testing scripts for my customer. They =

want to do it automated.

Regards
Florian

> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>
>   =



--===============7447733876045364002==--

