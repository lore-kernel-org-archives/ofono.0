Content-Type: multipart/mixed; boundary="===============8438701918675506977=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPIO power management
Date: Mon, 10 Dec 2018 11:27:08 -0600
Message-ID: <3b3c087f-7207-0b62-43ad-68d5b7644df2@gmail.com>
In-Reply-To: <a3c380cc-9431-248f-2de6-9a5328432027@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8438701918675506977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 12/10/2018 08:14 AM, Martin Hundeb=C3=B8ll wrote:
> Hi,
> =

> I previously submitted pacthes[1] for the Quectel M95 modem, and now =

> finally have the time needed to address the review comments.
> =

> In the meantime, my hardware has changed (modem chip remains the same =

> though), and so I would like to add more generic power management the =

> ofono driver.
> =

> I would assume that I cannot be the first with the urge to control modem =

> power using GPIOs (found one example in ofono/plugins/nokia-gpio.c), so =


Maybe not the first, but nobody has brought this up for oh ~8 years or =

so.  So might as well treat yourself as the first ;)

> it might make sense to add GPIO helper in a common object, and use =

> libgpiod in there?

We will not be adding any further dependencies on GLib based libraries =

for oFono as GLib use is going to be deprecated over time (in favor of =

ell).  This is especially true for a small library like libgpiod.

So this has to be done either inside oFono itself or preferably as a set =

of class(es) inside ell.

> =

> If that would be acceptable, a way to configure such GPIO numbers/names =

> is needed. Should this be done with an OFONO_CONFIG env attribute in the =

> udev rules?

That is ultimately up to the driver.  Serial devices have to rely on =

udev rules or configuration files, so either should be fine.

> =

> Actually, I face a similar configuration issue with UART flow control. =

> My first board uses the M95 modem without flow control, and the new =

> board enables flow control. This should also be a configuration =

> parameter somewhere in the stack.

This is really up to the driver.  Do note that GAtChat itself is =

ignorant of flow control.  So you can enable this on the uart, but =

that's about it.

> =

> [1] https://lists.ofono.org/pipermail/ofono/2018-August/018293.html
> =


Regards,
-Denis

--===============8438701918675506977==--

