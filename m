Content-Type: multipart/mixed; boundary="===============4873070616941812598=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH 2/2] quectel: Power on/off with a gpio pulse
Date: Fri, 25 Sep 2020 10:11:59 +0200
Message-ID: <20200925081159.guef4opj4ydecdhl@lem-wkst-02.lemonage>
In-Reply-To: <8e7096fe-c9b3-e6af-9450-6d5df3b3596a@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4873070616941812598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 08:43:15AM +0200, Martin Hundeb=C3=B8ll wrote:
> Hi Lars and Janez,
> =

> On 24/09/2020 13.02, Martin Hundeb=C3=B8ll wrote:
> > Hi Lars,
> > =

> > On 24/09/2020 12.38, poeschel(a)lemonage.de wrote:
> > > From: Lars Poeschel <poeschel@lemonage.de>
> > > =

> > > Current implementation uses a gpio level of 1 for powering on quectel
> > > modems using a gpio and a level of 0 for powering off.
> > =

> > We actually implemented this on the M95 by keeping the POWER pin always
> > high, and then controlling power using the RESET pin. This avoids the
> > need for pulses, which I find simpler.
> =

> Sorry, this is not accurate. We control the regulator supplying the modem,
> not the reset pin.

But this is bad also. The modem does a lot of things after you tell it
to power-off for example unregistering from the network gracefully. It
also might save some settings it uses internally or whatever.

You are using a way that does not seem to be intended by the vendor and
it reading the hardware design document it is also not obvious to me.
The obivous way to me is just using the PWR_KEY pin that every supported
quectel modem in ofono provides ready to use. And doing a pulse on this
is also not very hard.

I am open to discuss if we should power-off the modem with the pulse or
use the AT+QPOWD at command instead, but for power-on I think the pulse
is the way to go.

By the way this is not specific to the M95 or EC21. This does apply to
all ofono-supported quectel modems.

For me I don't have the choice. I have to support the pulse-approach
somehow, either ofono accepts it upstream or I have to maintain it as a
private patch, as I have to support a hardware that is built as is.
I can imagine the same somehow applies to you. The question is now: What
to do ?
I would like to see the pulse-approach in ofono as a default. We can
then work out a way to configure the level-solution you need maybe as a
new envionment option ?
What do others think ?

Regards,
Lars
--===============4873070616941812598==--

