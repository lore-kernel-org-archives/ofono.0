Content-Type: multipart/mixed; boundary="===============5546298145825970765=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [RFC 1/5] gprs: Update documentation for IPv6
Date: Fri, 28 Jan 2011 14:55:44 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC26B7C8@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <1296224224.1520.175.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5546298145825970765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =


> I am not sure it is a good idea to make ConnMan do that.

Why is that?

> And to be honest for PPP, just doing IPv4 seems acceptable =

> since PPP is
> bad idea in the first place. It is a limitation I am willing =

> to accept.

Yeah, PPP is not really a requirement for us, although it would be convenie=
nt to have it for testing. As a matter of fact, I would already have triale=
d atmodem support for IPv6 but that was blocked because of the lack of IPV6=
CP support in oFono PPP implementation. Too bad.

> My concern is also on how we handle the Tethering cases =

> properly. I have
> not yet spent enough time to think about it, but I have concerns here.

Ok. Can you outline your concerns so we can talk about them?

> So right now I would prefer to sit ipv6 out until we have =

> proper ipv4v6
> context support in the network and the modems.

I'd like to progress with this. We also have people who are keen to help ou=
t on the connman side. Just sitting and waiting for better times is not rea=
lly an approach I'd prefer to take.

Currently, we only discussing whether the "Interface" setting is needed sep=
arately in IPv4 and IPv6 settings or not. That's a minor detail as far as I=
 am concerned. For now, allowing separate network interfaces for IPv4 and I=
Pv6 is convenient for testing the IPv6 support on current modems. If it tur=
ns out to be hugely difficult to manage separate interface on connman side,=
 we can always restrict the approach and drop support for older modems when=
 rel8 modems are available. =


Br,

	MikaL

--===============5546298145825970765==--

