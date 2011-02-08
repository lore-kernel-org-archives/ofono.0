Content-Type: multipart/mixed; boundary="===============1849757171483893199=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 02/12] gprs: driver interface changes for IPv6
Date: Tue, 08 Feb 2011 08:36:34 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC29913D@008-AM1MPN1-001.mgdnok.nokia.com>
In-Reply-To: <1297105757.1520.436.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1849757171483893199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =


Thanks for the comments.

> > Normally, IPv6 addresses and routes are autoconfigured =

> using IPv6 stateless address autoconfiguration followed =

> optionally by DHCPv6 to get additional settings. The kernel =

> actually starts stateless address autoconfiguration =

> immediately when the interface is configured up (which oFono =

> does), assuming the interface already has a link-local IPv6 =

> address (which all Ethernet interface do have, as it is =

> calculated from the MAC address and added automatically).
> > =

> > Point-to-point interfaces, on the other, require the =

> link-local address to be added manually to the interface =

> before the autoconfiguration can happen. oFono should =

> probably add the address to be consistent with Ethernet interfaces.
> =

> I am not sure we really wanna be consistent with how Ethernet works
> since we are not actually Ethernet.
> =

> So I can see benefits for having ConnMan control the =

> link-local in case
> of point-to-point, but then I also do see the benefit oFono doing it.
> =

> We might have to spin of ideas and see what is the most =

> logical one and
> what works best. Especially also in the context of LTE support in the
> future.

I agree. The pragmatic way would be to just choose one option now and see h=
ow that works for us. We can revisit the issue later when we understand the=
 requirements better.

> > The upshot would be that IPv6 could be autoconfigured =

> immediately without connman's intervention. IPv6 does not =

> have private address spaces, so in theory connman does not =

> really have to care about IPv6 addresses and routes. However, =

> the optional DHCPv6 step would probably be controlled by =

> connman. Configuration of IPv6 tethering would be another =

> optional followup step controlled by connman.
> =

> Yes, DHCPv6 step needs to be done by ConnMan. We do not have DHCPv6
> support right now. We only plan to use it for extra settings like
> proxies, timeservers etc.
> =

> > On the other hand, if we want connman to be fully in =

> charge, we could change oFono to always leave the network =

> interface down and let connman do everything. Marcels input =

> on this would be welcome as well.
> =

> This is something we need to figure out. And of course this =

> all needs to
> be aligned with IPv4 and IPv6. Right now we are treating this =

> similar to
> how wpa_supplicant for WiFi does this.
> =

> So going back to potential LTE and IMS support; if that runs IPv6 then
> it might make sense to just autoconfigure it without ConnMan
> interaction.

Ok. If you agree, I'll add link-local address configuration to my patches f=
or all IPv6 contexts for the time being. Autonomous autoconfiguration is in=
 accordance with IPv6 philosophy anyway. Might as well see how far it takes=
 us. We can always move to a connman controlled approach later if that turn=
s out to be necessary.

Regards,

	MikaL

--===============1849757171483893199==--

