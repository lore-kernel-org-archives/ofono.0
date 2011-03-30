Content-Type: multipart/mixed; boundary="===============8202207042636849823=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 0/1] isimodem: fix network registration for older modems
Date: Wed, 30 Mar 2011 09:29:31 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2D9F01@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <1301385151.17991.1.camel@claudio-ThinkPad-R61>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8202207042636849823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

> Thank you so much for your support and help, please let us =

> know once you
> have the patch.

I posted a few patches yesterday, which should improve things.

> > > is it possible to know the list of supported mobile phone as =

> > > 3g modem ?
> > =

> > We don't have a list of supported phones as such as we're =

> not systematically tesing oFono against old Nokia phones. The =

> isiusb plugin is primarily a development aid, allowing us to =

> test isimodem drivers on a PC instead of on-target. There are =

> some limitations in using the isimodem driver over USB this =

> way. All functionality may not be available with all phones. =

> Mostly it works fine, though.
> =

> I see. =

> =

> Since each phone can potentially use a different way to talk to the pc
> (Android: rndis, Nokia: AT commands / PPP interface over USB if I
> understand it correctly), we are trying to understand which of these
> methods (hence which phone family) is preferable to be used/supported
> with connman / oFono.
> Do you have any suggestion for us?

My advice is to use whatever works for you. Currently, oFono recognizes Nok=
ia phones only via the isiusb plugin, so that is pretty much the only optio=
n. However, most Nokia phones also support AT commands over USB ACM and sho=
uld be relatively easy to get working with oFono, if you're willing to writ=
e a new plugin or modify the current nokia plugin for Nokia USB modems to i=
nclude support for Nokia phones. Patches are welcome.

Br,

	MikaL

--===============8202207042636849823==--

