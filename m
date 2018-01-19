Content-Type: multipart/mixed; boundary="===============8462346022604929105=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Huawei MS2131
Date: Fri, 19 Jan 2018 16:18:47 +0100
Message-ID: <39634fd7-75ad-16c1-0df4-d15a1e42bcd9@monom.org>
In-Reply-To: <B5CD1B0BA251DD468958CC22781DD5372B3BCA@DEFTHW99EJ0MSX.ww902.siemens.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8462346022604929105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Xingxing,

On 01/19/2018 03:27 PM, He, Xingxing wrote:
> Hi Denis,
> =

> Applying usb-modeswith patch for switching MS2131 to PPP mode, without sw=
apping ports(mdm<->pcui), the modem finally registered network successfully:
>     [ org.ofono.NetworkRegistration ]
>          MobileCountryCode =3D 262
>          MobileNetworkCode =3D 02
>          Name =3D Vodafone.de
>          Status =3D registered
>          Technology =3D umts
>          Strength =3D 83
>          Mode =3D auto
>    [ org.ofono.ConnectionManager ]
>          Attached =3D 1
>          Powered =3D 1
>          Suspended =3D 0
>          RoamingAllowed =3D 0
>          Bearer =3D umts
> =

> However, when I tried "./activate-context", there was an error. The modem=
 is still failed to access internet. :(
> root(a)iot2000-ebs:/usr/lib/ofono/test# ./activate-context
> Error activating /huawei_0/context1: org.ofono.Error.NotImplemented: Impl=
ementation not provided.

IIRC, the MCC (MobileContryCode) and MNC (MobileNetworkCode) are not in =

the mobile-broadband-provider-info and therefore there is no automatic =

provisioning of the context. Not sure what happens when the context is =

not setup correctly.

Thanks,
Daniel

--===============8462346022604929105==--

