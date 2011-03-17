Content-Type: multipart/mixed; boundary="===============7500817435127648702=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Thu, 17 Mar 2011 09:53:54 -0500
Message-ID: <4D822082.3070302@gmail.com>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC2D2145@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7500817435127648702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 03/17/2011 03:58 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Denis, Marcel,
> =

> I'll respond just once, since you both commented on pretty much the same =
topics.
> =

>>> I notice that your version of the patches are not forming =

>> the IPv6 link-local address and configuring it on the network =

>> interface. That's ok, as long as connman takes care of it, =

>> but it does mean that Ethernet interfaces, which always have =

>> a link-local address, will autoconfigure immediately while =

>> point-to-point interfaces will only autoconfigure when =

>> connman sets the link-local address on them. We talked about =

>> this with Marcel and at the time concluded that it would make =

>> more sense to keep things consistent by having oFono =

>> configure the link-local address on the point-to-point =

>> interfaces. I had this implemented in my later patch sets.
> =

> [Denis]
>> Samuel felt strongly that this should be done by ConnMan.  =

>> There's still
>> some questions left around this area.  Namely whether we =

>> should prevent
>> auto-configuration or not, etc.
> =

> Disabling IPv6 stateless address would be a bold move indeed, since it is=
 declared mandatory in both IETF and 3GPP standards. Please see [RFC4294] a=
nd [3GPP 23.060]. The section "Dynamic IPv6 Address Allocation" in 23.060 i=
s very clear on how IPv6 address allocation in 3GPPP networks is done. See =
also the section about IPv6 prefix delegation (relevant to IPv6 tethering) =
and applicable parts of 24.008.
> =


This still needs to be figured out.  We are aware that autoconfiguration
is mandatory in 3GPP.  However, this seems to be going against 27.007.
So in the end both might be required.

<snip>

>>> 	void ofono_gprs_context_set_ipv6_prefix_length(struct =

>> ofono_gprs_context *gc,
>>>                                                 unsigned =

>> char length);
>>> 	void ofono_gprs_context_set_ipv6_gateway(struct =

>> ofono_gprs_context *gc,
>>>                                                 const char =

>> *gateway);
>>>
>>> I'm not sure these are really needed, which is why I =

>> dropped these from subsequent patches. This information is =

>> not received from the cellular network as part of context =

>> activation signalling. On-link prefixes, routes and default =

>> gateways are received as part of the standard IPv6 stateless =

>> address autoconfiguration when the interfaces is brought up. =

>> The only reason to have these would if a specific modem with =

>> a virtual ethernet interface deviates from the standard =

>> address configuration practises for some reasons.
>>
> =

> [Denis]
>> At least the gateway is reported separately for IPv4 and =

>> IPv6.  Refer to
>> 27.007 Section 10.1.23 "PDP Context Read Dynamic Parameters".
> =

> [Marcel]
>> The AT commands are pretty clear in that they give us actually a
>> netmask.
> =

> True at first glance. However, please note the following:
> =

> 1) The netmask and gateway values returned here are invented by the modem=
. They do not come from the network, because they are not carried anywhere =
in the signalling messages related to PDP context activation. Stateless IPv=
6 address autoconfiguration (potentially followed by DHCPv6) is the only wa=
y to get the real information from the network.
> =

> 2) AT+CGPADDR and AT+CGCONTRDP were introduced in 3GPP rel8 and they are =
both optional. I.e. pre-rel8 equipment does not have them and rel8+ equipme=
nt is not required to have them. In particular, they are not required for a=
 modem to be able to support IPv6, so you cannot rely on these commands bei=
ng implemented in the modem.
> =

> 3) IPv6 stateless address autoconfiguration is mandatory in 3GPP standard=
s, as well as in IETF standards. There's no two ways about it.
> =

> Granted, AT+CGPADDR and AT+GCCONTRDP may be useful for supporting some qu=
irky modems, as already seen with IPv4 and virtual ethernet interfaces. Lac=
king a concrete example for such a modem I don't see much point in adding t=
hese methods yet, though.

Optional means nothing in 3GPP 27.007, half that spec is marked as
optional.  And I've already seen CGPADDR in the wild...

As I mentioned before, it might be that the modem performs the
autoconfiguration and DHCPv6 steps for us.  We might not even be able to
turn this behavior off.  Re-running the autoconfiguration and DHCPv6 on
the host side is a waste of time at that point.

In the end oFono's philosophy is to always err on the side of 27.007.
So far this strategy has never been (completely) wrong.

<snip>

> [Denis]
>> However, you might be right and that 27.007 is not a good =

>> reflection of
>> reality.  This has happened before ;)
> =

> It is not. 27.007 is just an interface specification for modem vendords. =
It does not specify the behaviour and protocols between a UE and the networ=
k. You really need to look at 23.060 and 24.008. It will save you some hass=
le in the future.
>

You're right of course, 27.007 is sometimes very far from the protocol.
 Unfortunately oFono doesn't work with the core protocols, but with 27.007.

Regards,
-Denis

--===============7500817435127648702==--

