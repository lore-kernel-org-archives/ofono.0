Content-Type: multipart/mixed; boundary="===============3039093140217312790=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Ofono LTE modems and connman services
Date: Fri, 02 Mar 2018 16:29:25 +0100
Message-ID: <f258a9ee-dd66-280a-d840-a6b49d7d4a65@southpole.se>
In-Reply-To: <5b9c8dc7-630e-9452-9ed8-5a32ea364b55@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3039093140217312790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/01/2018 05:11 PM, Denis Kenzior wrote:
> Hi Jonas,

Hi Denis,

I've spent most of the day trying to make sense of this.  I'll send some =

new logs when I get a chance but I thought I'd just ask a couple of =

questions that popped up during the day:

i)  For LTE, does it really make sense for the Attached property to be =

set before the context is Active?  The two are intricately linked.

ii)  For LTE, I'm not sure we should call ofono_gprs_status_notify() =

when we are registered to the network.  Instead, I suspect we should =

just wait until cid_activated() gets called.  Is that sufficient?  It =

looks to be, mostly, in my eyes and didn't break terribly when I tried it.

iii)  Looking at src/gprs, couldn't we just set gprs->attached and =

gprs->driver_attached right away if we are registered on an LTE network. =

  It seems that conceptually that would be true...???  If we do that, I =

think we can drop most of the _ATTACHING flags which might make the code =

easier to understand.

iv)  Even if we do iii), I'm inclined to not set the Attached DBUS =

property until _cid_activated() returns, and then _after_ context Active =

instead of before.

v)  If we detach from the network, do things break conceptually if we =

set Attached=3Dfalse before setting context Active=3Dfalse?

A lot of the above comes from my understanding of what connman is trying =

to do:  if it sees the state as Attached and has no Active contexts then =

it starts trying to activate the first context.  Ideally, it would never =

see an inactive context for LTE, at least not in the Attached state. =

However, I may be missing something in my understanding of how this is =

intended to work, so any clarification would be appreciated.

/Jonas


>>
>> This is an explicit UMTS to LTE transition:
>>
>> {RadioSettings} [/quectelqmi_0] TechnologyPreference =3D lte
> =

> Okay, so you set the Technology preference and the modem goes into =

> disconnect and search mode
> =

>> {ConnectionManager} [/quectelqmi_0] Attached =3D False
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
>> {NetworkRegistration} [/quectelqmi_0] Status =3D searching
> =

> So far so good
> =

>> {NetworkRegistration} [/quectelqmi_0] Technology =3D lte
>> {NetworkOperator} [/quectelqmi_0/operator/24001] Status =3D available
>> {NetworkRegistration} [/quectelqmi_0] Name =3D
>> {ConnectionManager} [/quectelqmi_0] Attached =3D True
>> {NetworkRegistration} [/quectelqmi_0] Status =3D roaming
>> {NetworkRegistration} [/quectelqmi_0] LocationAreaCode =3D 65534
>> {NetworkRegistration} [/quectelqmi_0] CellId =3D 26710796
>> {NetworkOperator} [/quectelqmi_0/operator/24001] Status =3D current
>> {NetworkRegistration} [/quectelqmi_0] Name =3D 24001
>> {NetworkRegistration} [/quectelqmi_0] MobileCountryCode =3D 240
>> {NetworkRegistration} [/quectelqmi_0] MobileNetworkCode =3D 01
>> {NetworkRegistration} [/quectelqmi_0] Status =3D registered
>> {NetworkRegistration} [/quectelqmi_0] Name =3D Orange F
>> {NetworkOperator} [/quectelqmi_0/operator/24001] Name =3D TELIA
>> {NetworkRegistration} [/quectelqmi_0] Strength =3D 20
>> {NetworkRegistration} [/quectelqmi_0] Name =3D Orange F
>> {NetworkOperator} [/quectelqmi_0/operator/24001] Name =3D 24001
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =
=3D =

>> wwp0s20u1i4, Method =3D static, Address =3D 10.172.219.235, Netmask =3D =

>> 255.255.255.248, Gateway =3D 10.172.219.236, DomainNameServers =3D =

>> 194.51.3.56 194.51.3.56 }
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
>>
> =

> This actually looks fine.=C2=A0 I do wonder what an actual modem roam loo=
ks =

> like, without the technology preference interference.
> =

>>
>> Here's what connman does effects on the LTE to UMTS transition:
>>
>> {RadioSettings} [/quectelqmi_0] TechnologyPreference =3D umts
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
>> {ConnectionManager} [/quectelqmi_0] Attached =3D False
> =

> So we get detached, okay...
> =

>> {NetworkRegistration} [/quectelqmi_0] LocationAreaCode =3D 11
>> {NetworkRegistration} [/quectelqmi_0] CellId =3D 752047
>> {NetworkRegistration} [/quectelqmi_0] Technology =3D umts
> =

> Switch technology
> =

>> {ConnectionManager} [/quectelqmi_0] Attached =3D True
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =
=3D =

>> wwp0s20u1i4, Method =3D static, Address =3D 10.160.218.173, Netmask =3D =

>> 255.255.255.252, Gateway =3D 10.160.218.174, DomainNameServers =3D =

>> 194.51.3.56 194.51.3.56 }
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
> =

> Reattach and get our settings back, so far so good...
> =

>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
> =

> This part looks bizarre, is the modem deactivating the context for some =

> reason?
> =

>> ^[[F{ConnectionContext} [/quectelqmi_0/context1] Settings =3D { =

>> Interface =3D wwp0s20u1i4, Method =3D static, Address =3D 10.167.137.164=
, =

>> Netmask =3D 255.255.255.248, Gateway =3D 10.167.137.165, DomainNameServe=
rs =

>> =3D 194.51.3.56 194.51.3.56
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
> =

> And back to active
> =

>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
> =

> Back to inactive
> =

>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =
=3D =

>> wwp0s20u1i4, Method =3D static, Address =3D 10.173.100.170, Netmask =3D =

>> 255.255.255.252, Gateway =3D 10.173.100.169, DomainNameServers =3D =

>> 194.51.3.56 194.51.3.56 }
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =
=3D =

>> wwp0s20u1i4, Method =3D static, Address =3D 10.160.115.172, Netmask =3D =

>> 255.255.255.248, Gateway =3D 10.160.115.173, DomainNameServers =3D =

>> 194.51.3.56 194.51.3.56 }
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =
=3D =

>> wwp0s20u1i4, Method =3D static, Address =3D 10.167.11.161, Netmask =3D =

>> 255.255.255.252, Gateway =3D 10.167.11.162, DomainNameServers =3D =

>> 194.51.3.56 194.51.3.56 }
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D { Interface =
=3D =

>> wwp0s20u1i4, Method =3D static, Address =3D 10.173.65.6, Netmask =3D =

>> 255.255.255.252, Gateway =3D 10.173.65.5, DomainNameServers =3D =

>> 194.51.3.56 194.51.3.56 }
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D True
>> {ConnectionContext} [/quectelqmi_0/context1] Settings =3D {}
>> {ConnectionContext} [/quectelqmi_0/context1] Active =3D False
>>
>> ....eventually that settles down and the connection is established.
>>
> =

> I don't get this part actually.=C2=A0 ConnMan is only activating the cont=
ext =

> right?=C2=A0 What is deactivating it?
> =

> Regards,
> -Denis


--===============3039093140217312790==--

