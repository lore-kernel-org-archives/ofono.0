Content-Type: multipart/mixed; boundary="===============2981536421494289125=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [RFC 1/5] gprs: Update documentation for IPv6
Date: Fri, 28 Jan 2011 14:00:15 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC26B6DE@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <AANLkTi=wAzXyb7uqCCY-7sqhgoi_bSQeQAR1Kt6WoyVt@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2981536421494289125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > + =C2=A0 For combined IPv4v6 context (3GPP rel 8) the
> > + =C2=A0 same network interface may be used for both
> > + =C2=A0 IPv4 and IPv6. IPv4 and IPv6 may also be
> > + =C2=A0 offered via separate network interfaces.
> > +
> =

> I think it would be nice if we could keep only one interface here.
> It's a bit messy that the difference between R7 and R8
> networks will be visible to the users like this.

By users I assume you mean connman?

> So when in a R7 network the uplink traffic should be filtered into the
> right ipv4 and ipv6 pdp-connection automagically.
> I know STE will support this in the modem firmware.

It's cool that STE firmware can do that. However, for modems that don't (mo=
st of them), I frankly don't see any particular reason to try to bond the b=
earers within the kernel. That would just bring more complexity to the kern=
el drivers without providing any real benefit. The Linux networking stack w=
ill handle separate interfaces just fine. The IPv4 default route can point =
to one interface and IPv6 routes can point to another and everything will j=
ust work.

Naturally connman will need to understand about the separate interfaces in =
order to configure them properly but that is a minor pain compared to doing=
 bonding separately in each modem interface driver within the kernel.

Br,

	MikaL

--===============2981536421494289125==--

