Content-Type: multipart/mixed; boundary="===============8809024617478290888=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Thu, 17 Mar 2011 08:58:02 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2D2145@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <4D80DD32.6020400@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8809024617478290888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, Marcel,

I'll respond just once, since you both commented on pretty much the same to=
pics.

> > I notice that your version of the patches are not forming =

> the IPv6 link-local address and configuring it on the network =

> interface. That's ok, as long as connman takes care of it, =

> but it does mean that Ethernet interfaces, which always have =

> a link-local address, will autoconfigure immediately while =

> point-to-point interfaces will only autoconfigure when =

> connman sets the link-local address on them. We talked about =

> this with Marcel and at the time concluded that it would make =

> more sense to keep things consistent by having oFono =

> configure the link-local address on the point-to-point =

> interfaces. I had this implemented in my later patch sets.

[Denis]
> Samuel felt strongly that this should be done by ConnMan.  =

> There's still
> some questions left around this area.  Namely whether we =

> should prevent
> auto-configuration or not, etc.

Disabling IPv6 stateless address would be a bold move indeed, since it is d=
eclared mandatory in both IETF and 3GPP standards. Please see [RFC4294] and=
 [3GPP 23.060]. The section "Dynamic IPv6 Address Allocation" in 23.060 is =
very clear on how IPv6 address allocation in 3GPPP networks is done. See al=
so the section about IPv6 prefix delegation (relevant to IPv6 tethering) an=
d applicable parts of 24.008.

> > Having separate lists for IPv4 and IPv6 DNS servers made =

> sense in my first patch set, because a dual context could be =

> emulated with separate IPv4 and IPv6 contexts and those DNS =

> servers might have been behind different network interfaces. =

> However, now this just creates additional complexity for the =

> drivers. A dual context will get a list of DNS server =

> addresses, which may contain IPv4 addresses, IPv6 addresses =

> or both. Now the driver has to sort them into two separate =

> lists for IPv4 and IPv6. Note that you can make A and AAAA =

> queries to any server, so there is no particular reason to =

> separate the lists based on address family.

[Denis]
> We waffled on this one, but it seemed better to keep it symmetric with
> the way ConnMan API is setup for IPv6.  For AT modems that support
> dual-stack, the IPv4 and IPv6 information is returned =

> separately anyway,
> so for the majority of the drivers separating the details is =

> more efficient.

Sounds like connman has some unnecessary complexity here as well. A single =
DNS server list really should be sufficient. Not a big deal, though, as lon=
g as connman combines the lists at some point and gives the whole thing to =
the DNS resolver.

> > 	void ofono_gprs_context_set_ipv6_prefix_length(struct =

> ofono_gprs_context *gc,
> >                                                 unsigned =

> char length);
> > 	void ofono_gprs_context_set_ipv6_gateway(struct =

> ofono_gprs_context *gc,
> >                                                 const char =

> *gateway);
> > =

> > I'm not sure these are really needed, which is why I =

> dropped these from subsequent patches. This information is =

> not received from the cellular network as part of context =

> activation signalling. On-link prefixes, routes and default =

> gateways are received as part of the standard IPv6 stateless =

> address autoconfiguration when the interfaces is brought up. =

> The only reason to have these would if a specific modem with =

> a virtual ethernet interface deviates from the standard =

> address configuration practises for some reasons.
> =


[Denis]
> At least the gateway is reported separately for IPv4 and =

> IPv6.  Refer to
> 27.007 Section 10.1.23 "PDP Context Read Dynamic Parameters".

[Marcel]
> The AT commands are pretty clear in that they give us actually a
> netmask.

True at first glance. However, please note the following:

1) The netmask and gateway values returned here are invented by the modem. =
They do not come from the network, because they are not carried anywhere in=
 the signalling messages related to PDP context activation. Stateless IPv6 =
address autoconfiguration (potentially followed by DHCPv6) is the only way =
to get the real information from the network.

2) AT+CGPADDR and AT+CGCONTRDP were introduced in 3GPP rel8 and they are bo=
th optional. I.e. pre-rel8 equipment does not have them and rel8+ equipment=
 is not required to have them. In particular, they are not required for a m=
odem to be able to support IPv6, so you cannot rely on these commands being=
 implemented in the modem.

3) IPv6 stateless address autoconfiguration is mandatory in 3GPP standards,=
 as well as in IETF standards. There's no two ways about it.

Granted, AT+CGPADDR and AT+GCCONTRDP may be useful for supporting some quir=
ky modems, as already seen with IPv4 and virtual ethernet interfaces. Lacki=
ng a concrete example for such a modem I don't see much point in adding the=
se methods yet, though.

[Denis]
> For IPv6 we decided to go with prefix length to keep symmetry with
> connman, even though 27.007 reports a netmask. Drivers will need to
> convert between IPv6 netmask and prefix length, so this might =

> have to be
> addressed in the future.

Actually, the latest versions of 27.007 introduce the AT+CGPIAF command, wh=
ich allows the use of proper textual representations for IPv6 addresses and=
 prefixes. Looks like it is finally dawning on the AT spec writers that IPv=
6 is actually very different from IPv4. ;)

[Denis]
> However, you might be right and that 27.007 is not a good =

> reflection of
> reality.  This has happened before ;)

It is not. 27.007 is just an interface specification for modem vendords. It=
 does not specify the behaviour and protocols between a UE and the network.=
 You really need to look at 23.060 and 24.008. It will save you some hassle=
 in the future.

[Marcel]
> Our success rate with testing IPv6 on a real network with current
> hardware was rather limited.

That is obvious.

Regards,

	MikaL

--===============8809024617478290888==--

