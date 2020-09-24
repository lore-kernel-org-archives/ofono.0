Content-Type: multipart/mixed; boundary="===============7181231452701887427=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 2/2] quectel: Power on/off with a gpio pulse
Date: Thu, 24 Sep 2020 13:02:48 +0200
Message-ID: <a603596b-df00-a546-950c-8aae753e1806@geanix.com>
In-Reply-To: <20200924103806.2518502-2-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7181231452701887427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 24/09/2020 12.38, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> Current implementation uses a gpio level of 1 for powering on quectel
> modems using a gpio and a level of 0 for powering off.

We actually implemented this on the M95 by keeping the POWER pin always =

high, and then controlling power using the RESET pin. This avoids the =

need for pulses, which I find simpler.

Can't the same be done for the EC21 ?

// Martin
--===============7181231452701887427==--

