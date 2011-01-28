Content-Type: multipart/mixed; boundary="===============8112102556496971058=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 1/5] gprs: Update documentation for IPv6
Date: Fri, 28 Jan 2011 16:04:18 +0100
Message-ID: <1296227058.1520.186.camel@aeonflux>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC26B7C8@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8112102556496971058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> > I am not sure it is a good idea to make ConnMan do that.
> =

> Why is that?

we need to chat with Samuel about this. I foresee a bunch of issues
trying to handle two context properly. This needs a bit more deeper
thinking on how things are done.

> > And to be honest for PPP, just doing IPv4 seems acceptable =

> > since PPP is
> > bad idea in the first place. It is a limitation I am willing =

> > to accept.
> =

> Yeah, PPP is not really a requirement for us, although it would be conven=
ient to have it for testing. As a matter of fact, I would already have tria=
led atmodem support for IPv6 but that was blocked because of the lack of IP=
V6CP support in oFono PPP implementation. Too bad.

We have a TODO item open for that. So far nobody really bothered,
because either the hardware did not support it or the network did not.

But hey, patches are welcome ;)

> > My concern is also on how we handle the Tethering cases =

> > properly. I have
> > not yet spent enough time to think about it, but I have concerns here.
> =

> Ok. Can you outline your concerns so we can talk about them?

We are currently Tethering to one specific service with the assumption
that it maps to one interface of the kernel. If that assumption is not
true anymore, then we have to re-think this. Not sure if we should be
bothered.

But then again, on the other hand for IPv6 Tethering, don't wanna use
NAT anyway. So that might be not an issue after all. This really needs
some more thinking. I have no clear answers at the moment.

> > So right now I would prefer to sit ipv6 out until we have =

> > proper ipv4v6
> > context support in the network and the modems.
> =

> I'd like to progress with this. We also have people who are keen to help =
out on the connman side. Just sitting and waiting for better times is not r=
eally an approach I'd prefer to take.
> =

> Currently, we only discussing whether the "Interface" setting is needed s=
eparately in IPv4 and IPv6 settings or not. That's a minor detail as far as=
 I am concerned. For now, allowing separate network interfaces for IPv4 and=
 IPv6 is convenient for testing the IPv6 support on current modems. If it t=
urns out to be hugely difficult to manage separate interface on connman sid=
e, we can always restrict the approach and drop support for older modems wh=
en rel8 modems are available. =


So I like the ST-Ericsson approach where this details is abstracted in
the modem firmware.

Regards

Marcel



--===============8112102556496971058==--

