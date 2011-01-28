Content-Type: multipart/mixed; boundary="===============3791871460885760272=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [RFC 1/5] gprs: Update documentation for IPv6
Date: Fri, 28 Jan 2011 15:37:15 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC26B853@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <1296227058.1520.186.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3791871460885760272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =


> Hi Mika,
> =

> > > I am not sure it is a good idea to make ConnMan do that.
> > =

> > Why is that?
> =

> we need to chat with Samuel about this. I foresee a bunch of issues
> trying to handle two context properly. This needs a bit more deeper
> thinking on how things are done.

Ok. But again, can't really comment unless you guys come out with the actua=
l issues.

> > fact, I would already have trialed atmodem support for IPv6 =

> > but that was blocked because of the lack of IPV6CP support in =

> > oFono PPP implementation. Too bad.
> =

> We have a TODO item open for that. So far nobody really bothered,
> because either the hardware did not support it or the network did not.
> =

> But hey, patches are welcome ;)

I'm more interested in the core support at the moment. =


> > > My concern is also on how we handle the Tethering cases =

> > > properly. I have
> > > not yet spent enough time to think about it, but I have =

> concerns here.
> > =

> > Ok. Can you outline your concerns so we can talk about them?
> =

> We are currently Tethering to one specific service with the assumption
> that it maps to one interface of the kernel. If that assumption is not
> true anymore, then we have to re-think this. Not sure if we should be
> bothered.

IPv4 and IPv6 are completely orthogonal, so I don't really see the problem =
you're alluding to here.

> I have no clear answers at the moment.

I believe the main question really is "How to do tethering with IPv6?". Cle=
arly it needs to be thought out but I don't see why that work should block =
implementation of basic IPv6 access. You can start with IPv4 only tethering=
 and just ignore IPv6 in the beginning.

> > > So right now I would prefer to sit ipv6 out until we have =

> > > proper ipv4v6
> > > context support in the network and the modems.
> > =

> > I'd like to progress with this. We also have people who are =

> keen to help out on the connman side. Just sitting and =

> waiting for better times is not really an approach I'd prefer to take.
> > =

> > Currently, we only discussing whether the "Interface" =

> setting is needed separately in IPv4 and IPv6 settings or =

> not. That's a minor detail as far as I am concerned. For now, =

> allowing separate network interfaces for IPv4 and IPv6 is =

> convenient for testing the IPv6 support on current modems. If =

> it turns out to be hugely difficult to manage separate =

> interface on connman side, we can always restrict the =

> approach and drop support for older modems when rel8 modems =

> are available. =

> =

> So I like the ST-Ericsson approach where this details is abstracted in
> the modem firmware.

That's not an answer though, unless we only plan to support STE hardware in=
 oFono.

Br,

	MikaL

--===============3791871460885760272==--

