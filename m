Content-Type: multipart/mixed; boundary="===============2016133916206736651=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 2/2] quectel: Power on/off with a gpio pulse
Date: Fri, 25 Sep 2020 08:43:15 +0200
Message-ID: <8e7096fe-c9b3-e6af-9450-6d5df3b3596a@geanix.com>
In-Reply-To: <a603596b-df00-a546-950c-8aae753e1806@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2016133916206736651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars and Janez,

On 24/09/2020 13.02, Martin Hundeb=C3=B8ll wrote:
> Hi Lars,
> =

> On 24/09/2020 12.38, poeschel(a)lemonage.de wrote:
>> From: Lars Poeschel <poeschel@lemonage.de>
>>
>> Current implementation uses a gpio level of 1 for powering on quectel
>> modems using a gpio and a level of 0 for powering off.
> =

> We actually implemented this on the M95 by keeping the POWER pin always =

> high, and then controlling power using the RESET pin. This avoids the =

> need for pulses, which I find simpler.

Sorry, this is not accurate. We control the regulator supplying the =

modem, not the reset pin.

// Martin
--===============2016133916206736651==--

