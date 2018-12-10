Content-Type: multipart/mixed; boundary="===============5541694761368677160=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: GPIO power management
Date: Mon, 10 Dec 2018 15:14:02 +0100
Message-ID: <a3c380cc-9431-248f-2de6-9a5328432027@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5541694761368677160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I previously submitted pacthes[1] for the Quectel M95 modem, and now =

finally have the time needed to address the review comments.

In the meantime, my hardware has changed (modem chip remains the same =

though), and so I would like to add more generic power management the =

ofono driver.

I would assume that I cannot be the first with the urge to control modem =

power using GPIOs (found one example in ofono/plugins/nokia-gpio.c), so =

it might make sense to add GPIO helper in a common object, and use =

libgpiod in there?

If that would be acceptable, a way to configure such GPIO numbers/names =

is needed. Should this be done with an OFONO_CONFIG env attribute in the =

udev rules?

Actually, I face a similar configuration issue with UART flow control. =

My first board uses the M95 modem without flow control, and the new =

board enables flow control. This should also be a configuration =

parameter somewhere in the stack.

[1] https://lists.ofono.org/pipermail/ofono/2018-August/018293.html

-- =

Kind regards,
Martin Hundeb=C3=B8ll

--===============5541694761368677160==--

