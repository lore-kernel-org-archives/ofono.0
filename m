Content-Type: multipart/mixed; boundary="===============2564673467678310156=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 02/12] gprs: driver interface changes for IPv6
Date: Mon, 07 Feb 2011 11:09:17 -0800
Message-ID: <1297105757.1520.436.camel@aeonflux>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC2985A8@008-AM1MPN1-001.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2564673467678310156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> > > +enum ofono_gprs_addrconf {
> > > +	OFONO_GPRS_ADDRCONF_NONE,
> > > +	OFONO_GPRS_ADDRCONF_STATIC,
> > > +	OFONO_GPRS_ADDRCONF_DHCP,
> > > +};
> > > +
> > =

> > What exactly is the _NONE addrconf for?  And why don't we use =

> > a gboolean
> > here like before?
> =

> Neither "static" nor "DHCP" makes sense for IPv6. If we have an IPv6 only=
 context, the "Method" property will not show up at all.
> =

> I also wanted to leave the door open for additional address configuration=
 protocols in case e.g. IPv6 capable modems with virtual ethernet intefaces=
 require some weird quirks. I also felt this was a bit cleaner, although th=
at is a matter of opinion, of course.
> =

> Normally, IPv6 addresses and routes are autoconfigured using IPv6 statele=
ss address autoconfiguration followed optionally by DHCPv6 to get additiona=
l settings. The kernel actually starts stateless address autoconfiguration =
immediately when the interface is configured up (which oFono does), assumin=
g the interface already has a link-local IPv6 address (which all Ethernet i=
nterface do have, as it is calculated from the MAC address and added automa=
tically).
> =

> Point-to-point interfaces, on the other, require the link-local address t=
o be added manually to the interface before the autoconfiguration can happe=
n. oFono should probably add the address to be consistent with Ethernet int=
erfaces.

I am not sure we really wanna be consistent with how Ethernet works
since we are not actually Ethernet.

So I can see benefits for having ConnMan control the link-local in case
of point-to-point, but then I also do see the benefit oFono doing it.

We might have to spin of ideas and see what is the most logical one and
what works best. Especially also in the context of LTE support in the
future.

> The upshot would be that IPv6 could be autoconfigured immediately without=
 connman's intervention. IPv6 does not have private address spaces, so in t=
heory connman does not really have to care about IPv6 addresses and routes.=
 However, the optional DHCPv6 step would probably be controlled by connman.=
 Configuration of IPv6 tethering would be another optional followup step co=
ntrolled by connman.

Yes, DHCPv6 step needs to be done by ConnMan. We do not have DHCPv6
support right now. We only plan to use it for extra settings like
proxies, timeservers etc.

> On the other hand, if we want connman to be fully in charge, we could cha=
nge oFono to always leave the network interface down and let connman do eve=
rything. Marcels input on this would be welcome as well.

This is something we need to figure out. And of course this all needs to
be aligned with IPv4 and IPv6. Right now we are treating this similar to
how wpa_supplicant for WiFi does this.

So going back to potential LTE and IMS support; if that runs IPv6 then
it might make sense to just autoconfigure it without ConnMan
interaction.

Regards

Marcel



--===============2564673467678310156==--

