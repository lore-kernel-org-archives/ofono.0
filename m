Content-Type: multipart/mixed; boundary="===============8545592627422711242=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Ofono LTE modems and connman services
Date: Thu, 01 Mar 2018 16:48:09 +0100
Message-ID: <a2d778ca-a4b1-8b49-3c61-e800f3faeca1@southpole.se>
In-Reply-To: <dfeca1c1-e4ab-a42c-f9b2-92d69b100d55@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8545592627422711242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/01/2018 04:11 PM, Denis Kenzior wrote:
> Hi Jonas,
> =

>> Ofono does something like this on a tech transition to LTE:
>>
>> Active: false
>> Attached: false
>> ...
>> Attached: true
>> Active: true
>>
> =

> This is from 3G to LTE or the initial registration to LTE?=C2=A0 Do you h=
ave =

> an ofono-monitor log handy?

This is an explicit UMTS to LTE transition:

{RadioSettings} [/quectelqmi_0] TechnologyPreference =3D lte
{ConnectionManager} [/quectelqmi_0] Attached =3D False
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
{ConnectionContext} [/quectelqmi_0/context1] Active =3D False
{NetworkRegistration} [/quectelqmi_0] Status =3D searching
{NetworkRegistration} [/quectelqmi_0] Technology =3D lte
{NetworkOperator} [/quectelqmi_0/operator/24001] Status =3D available
{NetworkRegistration} [/quectelqmi_0] Name =3D
{ConnectionManager} [/quectelqmi_0] Attached =3D True
{NetworkRegistration} [/quectelqmi_0] Status =3D roaming
{NetworkRegistration} [/quectelqmi_0] LocationAreaCode =3D 65534
{NetworkRegistration} [/quectelqmi_0] CellId =3D 26710796
{NetworkOperator} [/quectelqmi_0/operator/24001] Status =3D current
{NetworkRegistration} [/quectelqmi_0] Name =3D 24001
{NetworkRegistration} [/quectelqmi_0] MobileCountryCode =3D 240
{NetworkRegistration} [/quectelqmi_0] MobileNetworkCode =3D 01
{NetworkRegistration} [/quectelqmi_0] Status =3D registered
{NetworkRegistration} [/quectelqmi_0] Name =3D Orange F
{NetworkOperator} [/quectelqmi_0/operator/24001] Name =3D TELIA
{NetworkRegistration} [/quectelqmi_0] Strength =3D 20
{NetworkRegistration} [/quectelqmi_0] Name =3D Orange F
{NetworkOperator} [/quectelqmi_0/operator/24001] Name =3D 24001
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

wwp0s20u1i4, Method =3D static, Address =3D 10.172.219.235, Netmask =3D =

255.255.255.248, Gateway =3D 10.172.219.236, DomainNameServers =3D =

194.51.3.56 194.51.3.56 }
{ConnectionContext} [/quectelqmi_0/context1] Active =3D True


Here's what connman does effects on the LTE to UMTS transition:

{RadioSettings} [/quectelqmi_0] TechnologyPreference =3D umts
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
{ConnectionContext} [/quectelqmi_0/context1] Active =3D False
{ConnectionManager} [/quectelqmi_0] Attached =3D False
{NetworkRegistration} [/quectelqmi_0] LocationAreaCode =3D 11
{NetworkRegistration} [/quectelqmi_0] CellId =3D 752047
{NetworkRegistration} [/quectelqmi_0] Technology =3D umts
{ConnectionManager} [/quectelqmi_0] Attached =3D True
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

wwp0s20u1i4, Method =3D static, Address =3D 10.160.218.173, Netmask =3D =

255.255.255.252, Gateway =3D 10.160.218.174, DomainNameServers =3D =

194.51.3.56 194.51.3.56 }
{ConnectionContext} [/quectelqmi_0/context1] Active =3D True
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
{ConnectionContext} [/quectelqmi_0/context1] Active =3D False
^[[F{ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =

=3D wwp0s20u1i4, Method =3D static, Address =3D 10.167.137.164, Netmask =3D =

255.255.255.248, Gateway =3D 10.167.137.165, DomainNameServers =3D =

194.51.3.56 194.51.3.56 }
{ConnectionContext} [/quectelqmi_0/context1] Active =3D True
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
{ConnectionContext} [/quectelqmi_0/context1] Active =3D False
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

wwp0s20u1i4, Method =3D static, Address =3D 10.173.100.170, Netmask =3D =

255.255.255.252, Gateway =3D 10.173.100.169, DomainNameServers =3D =

194.51.3.56 194.51.3.56 }
{ConnectionContext} [/quectelqmi_0/context1] Active =3D True
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
{ConnectionContext} [/quectelqmi_0/context1] Active =3D False
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

wwp0s20u1i4, Method =3D static, Address =3D 10.160.115.172, Netmask =3D =

255.255.255.248, Gateway =3D 10.160.115.173, DomainNameServers =3D =

194.51.3.56 194.51.3.56 }
{ConnectionContext} [/quectelqmi_0/context1] Active =3D True
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
{ConnectionContext} [/quectelqmi_0/context1] Active =3D False
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

wwp0s20u1i4, Method =3D static, Address =3D 10.167.11.161, Netmask =3D =

255.255.255.252, Gateway =3D 10.167.11.162, DomainNameServers =3D =

194.51.3.56 194.51.3.56 }
{ConnectionContext} [/quectelqmi_0/context1] Active =3D True
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
{ConnectionContext} [/quectelqmi_0/context1] Active =3D False
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =3D =

wwp0s20u1i4, Method =3D static, Address =3D 10.173.65.6, Netmask =3D =

255.255.255.252, Gateway =3D 10.173.65.5, DomainNameServers =3D 194.51.3.56 =

194.51.3.56 }
{ConnectionContext} [/quectelqmi_0/context1] Active =3D True
{ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
{ConnectionContext} [/quectelqmi_0/context1] Active =3D False

....eventually that settles down and the connection is established.


> =

>> When ofono does Attached: true, connman starts trying to set the =

>> context active which seems to result in InProgress.=C2=A0 connman doesn'=
t =

>> seem to like the InProgress response and tries again, which ends up =

>> pounding the modem hard with "set active" messages until =

>> read_settings() returns (on the modem side) and the modem becomes =

>> Active (automatically) for real.
> =

> That sounds like connman isn't taking InProgress into consideration =

> properly.

> =

>>
>> Similarly, on a transition from LTE to 3G, connman also tries to =

>> activate the context hundreds of times before it settles.=C2=A0 This =

>> behaviour is harder to understand:=C2=A0 connman has explicitly requeste=
d =

>> the activation here and should know that it's in progress...
> =

> ofono-monitor log by any chance?=C2=A0 I'm not sure why a switch from LTE=
 to =

> 3G would cause any changes to Active/Attached states.=C2=A0 It should sim=
ply =

> twiddle the NetworkRegistration state and that's it, unless the modem is =

> reporting things it shouldn't.
> =


Maybe... take at look at the first ofono log above and see what the =

network registration state is doing... that's what's causing the =

unattached state, I think.

/Jonas

>>
>> What I think might be an issue here is the interplay between Attached =

>> and Active.=C2=A0 For LTE, Attached and Active are synonymous...(???) =

>> connman should not be setting Active for these at all.
> =

> ConnMan doesn't keep track of the NetworkRegistration state, so it =

> doesn't really know about LTE...
> =

>>
>> Could ofono have Active set to true before Attached gets set true for =

>> the LTE context case so that connman never sees the context as =

>> Active:false?=C2=A0 Or is there a better way to handle this?
> =

> I don't think that would make sense from an API consistency perspective.
> =

> Regards,
> -Denis


--===============8545592627422711242==--

