Content-Type: multipart/mixed; boundary="===============2882322617005432692=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono LTE modems and connman services
Date: Thu, 01 Mar 2018 10:11:02 -0600
Message-ID: <5b9c8dc7-630e-9452-9ed8-5a32ea364b55@gmail.com>
In-Reply-To: <a2d778ca-a4b1-8b49-3c61-e800f3faeca1@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2882322617005432692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,
> =

> This is an explicit UMTS to LTE transition:
> =

> {RadioSettings} [/quectelqmi_0] TechnologyPreference =3D lte

Okay, so you set the Technology preference and the modem goes into =

disconnect and search mode

> {ConnectionManager} [/quectelqmi_0] Attached =3D False
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
> {NetworkRegistration} [/quectelqmi_0] Status =3D searching

So far so good

> {NetworkRegistration} [/quectelqmi_0] Technology =3D lte
> {NetworkOperator} [/quectelqmi_0/operator/24001] Status =3D available
> {NetworkRegistration} [/quectelqmi_0] Name =3D
> {ConnectionManager} [/quectelqmi_0] Attached =3D True
> {NetworkRegistration} [/quectelqmi_0] Status =3D roaming
> {NetworkRegistration} [/quectelqmi_0] LocationAreaCode =3D 65534
> {NetworkRegistration} [/quectelqmi_0] CellId =3D 26710796
> {NetworkOperator} [/quectelqmi_0/operator/24001] Status =3D current
> {NetworkRegistration} [/quectelqmi_0] Name =3D 24001
> {NetworkRegistration} [/quectelqmi_0] MobileCountryCode =3D 240
> {NetworkRegistration} [/quectelqmi_0] MobileNetworkCode =3D 01
> {NetworkRegistration} [/quectelqmi_0] Status =3D registered
> {NetworkRegistration} [/quectelqmi_0] Name =3D Orange F
> {NetworkOperator} [/quectelqmi_0/operator/24001] Name =3D TELIA
> {NetworkRegistration} [/quectelqmi_0] Strength =3D 20
> {NetworkRegistration} [/quectelqmi_0] Name =3D Orange F
> {NetworkOperator} [/quectelqmi_0/operator/24001] Name =3D 24001
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

> wwp0s20u1i4, Method =3D static, Address =3D 10.172.219.235, Netmask =3D =

> 255.255.255.248, Gateway =3D 10.172.219.236, DomainNameServers =3D =

> 194.51.3.56 194.51.3.56 }
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
> =


This actually looks fine.  I do wonder what an actual modem roam looks =

like, without the technology preference interference.

> =

> Here's what connman does effects on the LTE to UMTS transition:
> =

> {RadioSettings} [/quectelqmi_0] TechnologyPreference =3D umts
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
> {ConnectionManager} [/quectelqmi_0] Attached =3D False

So we get detached, okay...

> {NetworkRegistration} [/quectelqmi_0] LocationAreaCode =3D 11
> {NetworkRegistration} [/quectelqmi_0] CellId =3D 752047
> {NetworkRegistration} [/quectelqmi_0] Technology =3D umts

Switch technology

> {ConnectionManager} [/quectelqmi_0] Attached =3D True
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

> wwp0s20u1i4, Method =3D static, Address =3D 10.160.218.173, Netmask =3D =

> 255.255.255.252, Gateway =3D 10.160.218.174, DomainNameServers =3D =

> 194.51.3.56 194.51.3.56 }
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True

Reattach and get our settings back, so far so good...

> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False

This part looks bizarre, is the modem deactivating the context for some =

reason?

> ^[[F{ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =

> =3D wwp0s20u1i4, Method =3D static, Address =3D 10.167.137.164, Netmask =
=3D =

> 255.255.255.248, Gateway =3D 10.167.137.165, DomainNameServers =3D =

> 194.51.3.56 194.51.3.56
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True

And back to active

> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False

Back to inactive

> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

> wwp0s20u1i4, Method =3D static, Address =3D 10.173.100.170, Netmask =3D =

> 255.255.255.252, Gateway =3D 10.173.100.169, DomainNameServers =3D =

> 194.51.3.56 194.51.3.56 }
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

> wwp0s20u1i4, Method =3D static, Address =3D 10.160.115.172, Netmask =3D =

> 255.255.255.248, Gateway =3D 10.160.115.173, DomainNameServers =3D =

> 194.51.3.56 194.51.3.56 }
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

> wwp0s20u1i4, Method =3D static, Address =3D 10.167.11.161, Netmask =3D =

> 255.255.255.252, Gateway =3D 10.167.11.162, DomainNameServers =3D =

> 194.51.3.56 194.51.3.56 }
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

> wwp0s20u1i4, Method =3D static, Address =3D 10.173.65.6, Netmask =3D =

> 255.255.255.252, Gateway =3D 10.173.65.5, DomainNameServers =3D 194.51.3.=
56 =

> 194.51.3.56 }
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
> =

> ....eventually that settles down and the connection is established.
> =


I don't get this part actually.  ConnMan is only activating the context =

right?  What is deactivating it?

Regards,
-Denis

--===============2882322617005432692==--

