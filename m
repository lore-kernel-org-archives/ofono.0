Content-Type: multipart/mixed; boundary="===============0358678233726924000=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 1/5] gprs: Update documentation for IPv6
Date: Fri, 28 Jan 2011 15:17:04 +0100
Message-ID: <1296224224.1520.175.camel@aeonflux>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC26B6DE@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0358678233726924000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> > > +   For combined IPv4v6 context (3GPP rel 8) the
> > > +   same network interface may be used for both
> > > +   IPv4 and IPv6. IPv4 and IPv6 may also be
> > > +   offered via separate network interfaces.
> > > +
> > =

> > I think it would be nice if we could keep only one interface here.
> > It's a bit messy that the difference between R7 and R8
> > networks will be visible to the users like this.
> =

> By users I assume you mean connman?
> =

> > So when in a R7 network the uplink traffic should be filtered into the
> > right ipv4 and ipv6 pdp-connection automagically.
> > I know STE will support this in the modem firmware.
> =

> It's cool that STE firmware can do that. However, for modems that don't (=
most of them), I frankly don't see any particular reason to try to bond the=
 bearers within the kernel. That would just bring more complexity to the ke=
rnel drivers without providing any real benefit. The Linux networking stack=
 will handle separate interfaces just fine. The IPv4 default route can poin=
t to one interface and IPv6 routes can point to another and everything will=
 just work.
> =

> Naturally connman will need to understand about the separate interfaces i=
n order to configure them properly but that is a minor pain compared to doi=
ng bonding separately in each modem interface driver within the kernel.

I am not sure it is a good idea to make ConnMan do that. For IFX, I was
actually considering just piping the two RawIP streams into one network
interface. That seems easy enough.

And to be honest for PPP, just doing IPv4 seems acceptable since PPP is
bad idea in the first place. It is a limitation I am willing to accept.

My concern is also on how we handle the Tethering cases properly. I have
not yet spent enough time to think about it, but I have concerns here.

So right now I would prefer to sit ipv6 out until we have proper ipv4v6
context support in the network and the modems.

Regards

Marcel



--===============0358678233726924000==--

