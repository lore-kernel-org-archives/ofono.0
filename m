Content-Type: multipart/mixed; boundary="===============7083026213883000987=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 02/12] gprs: driver interface changes for IPv6
Date: Mon, 07 Feb 2011 09:55:30 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2985A8@008-AM1MPN1-001.mgdnok.nokia.com>
In-Reply-To: <4D4C364D.90201@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7083026213883000987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for the comments. =


> > +enum ofono_gprs_addrconf {
> > +	OFONO_GPRS_ADDRCONF_NONE,
> > +	OFONO_GPRS_ADDRCONF_STATIC,
> > +	OFONO_GPRS_ADDRCONF_DHCP,
> > +};
> > +
> =

> What exactly is the _NONE addrconf for?  And why don't we use =

> a gboolean
> here like before?

Neither "static" nor "DHCP" makes sense for IPv6. If we have an IPv6 only c=
ontext, the "Method" property will not show up at all.

I also wanted to leave the door open for additional address configuration p=
rotocols in case e.g. IPv6 capable modems with virtual ethernet intefaces r=
equire some weird quirks. I also felt this was a bit cleaner, although that=
 is a matter of opinion, of course.

Normally, IPv6 addresses and routes are autoconfigured using IPv6 stateless=
 address autoconfiguration followed optionally by DHCPv6 to get additional =
settings. The kernel actually starts stateless address autoconfiguration im=
mediately when the interface is configured up (which oFono does), assuming =
the interface already has a link-local IPv6 address (which all Ethernet int=
erface do have, as it is calculated from the MAC address and added automati=
cally).

Point-to-point interfaces, on the other, require the link-local address to =
be added manually to the interface before the autoconfiguration can happen.=
 oFono should probably add the address to be consistent with Ethernet inter=
faces.

The upshot would be that IPv6 could be autoconfigured immediately without c=
onnman's intervention. IPv6 does not have private address spaces, so in the=
ory connman does not really have to care about IPv6 addresses and routes. H=
owever, the optional DHCPv6 step would probably be controlled by connman. C=
onfiguration of IPv6 tethering would be another optional followup step cont=
rolled by connman.

On the other hand, if we want connman to be fully in charge, we could chang=
e oFono to always leave the network interface down and let connman do every=
thing. Marcels input on this would be welcome as well.

Regards,

	MikaL

--===============7083026213883000987==--

