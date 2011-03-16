Content-Type: multipart/mixed; boundary="===============0224995580421054102=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Wed, 16 Mar 2011 08:41:52 -0700
Message-ID: <1300290112.2055.48.camel@aeonflux>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC2D1C1E@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0224995580421054102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> > So during OSTS Samuel, Marcel and I sat down and tried to =

> > figure out the
> > IPv6 stuff.  Based on this discussion and your implementation =

> > I pushed a
> > series of patches implementing IPv6 and dual-stack contexts.  I have
> > taken (and later re-worked) some of your patches so you get =

> > credit here
> > as well.
> =

> Thanks for pushing the patches. I notice that these are based on my initi=
al set of patches rather than the later ones. A few comments, since I had s=
ome reasons for the changes I did in later patches.
> =

> I notice that your version of the patches are not forming the IPv6 link-l=
ocal address and configuring it on the network interface. That's ok, as lon=
g as connman takes care of it, but it does mean that Ethernet interfaces, w=
hich always have a link-local address, will autoconfigure immediately while=
 point-to-point interfaces will only autoconfigure when connman sets the li=
nk-local address on them. We talked about this with Marcel and at the time =
concluded that it would make more sense to keep things consistent by having=
 oFono configure the link-local address on the point-to-point interfaces. I=
 had this implemented in my later patch sets.

our conclusion was actually that we will disable IPv6 auto-configuration
and expect IP address information given to us by the hardware.

> A few comments on the driver API:
> =

> 	void ofono_gprs_context_set_ipv4_address(struct ofono_gprs_context *gc,
>                                                 const char *address,
>                                                 gboolean static_ip);

We could do that.

> What's the expected behaviour if this is called with a valid IP address a=
nd static_ip =3D FALSE? I think you could just drop the boolean flag and as=
sume a statically configured address if this method is called by the driver=
, otherwise do DHCP.
> =

> 	void ofono_gprs_context_set_ipv4_dns_servers(struct ofono_gprs_context *=
gc,
>                                                 const char **dns);
> =

> 	void ofono_gprs_context_set_ipv6_dns_servers(struct ofono_gprs_context *=
gc,
>                                                 const char **dns);
> =

> I would propose to have just a single method for setting all DNS servers.
> =

> Having separate lists for IPv4 and IPv6 DNS servers made sense in my firs=
t patch set, because a dual context could be emulated with separate IPv4 an=
d IPv6 contexts and those DNS servers might have been behind different netw=
ork interfaces. However, now this just creates additional complexity for th=
e drivers. A dual context will get a list of DNS server addresses, which ma=
y contain IPv4 addresses, IPv6 addresses or both. Now the driver has to sor=
t them into two separate lists for IPv4 and IPv6. Note that you can make A =
and AAAA queries to any server, so there is no particular reason to separat=
e the lists based on address family.

Right now I like to keep them separated for a bit more consistent API,
but yes essentially it makes no difference what the DNS servers are for
since they can be clearly differentiated by its address type.

> 	void ofono_gprs_context_set_ipv6_prefix_length(struct ofono_gprs_context=
 *gc,
>                                                 unsigned char length);
> 	void ofono_gprs_context_set_ipv6_gateway(struct ofono_gprs_context *gc,
>                                                 const char *gateway);
> =

> I'm not sure these are really needed, which is why I dropped these from s=
ubsequent patches. This information is not received from the cellular netwo=
rk as part of context activation signalling. On-link prefixes, routes and d=
efault gateways are received as part of the standard IPv6 stateless address=
 autoconfiguration when the interfaces is brought up. The only reason to ha=
ve these would if a specific modem with a virtual ethernet interface deviat=
es from the standard address configuration practises for some reasons.

Looking at AT command based modems, then these are needed. I don't see
any auto-configuration with these. The prefix length and gateway
information come from the modem.

> Current USB modem sticks don't seem to have IPv6 support, so I'd propose =
to just drop these and add an API later if it turns out to be necessary. If=
 USB sticks do this propertly, they'll just proxy router advertisements and=
 neighbor discovery messages over the virtual ethernet interface and any ad=
ditional address configuration settings won't be needed.
> =

> If you decide to keep these, prefix length should probably default to 64 =
and be always shown in the settings.

The AT commands are pretty clear in that they give us actually a
netmask.

Our success rate with testing IPv6 on a real network with current
hardware was rather limited.

Regards

Marcel



--===============0224995580421054102==--

