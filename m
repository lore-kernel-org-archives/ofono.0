Content-Type: multipart/mixed; boundary="===============2189105504794355859=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Beno=C3=AEt?= Monin <benoit.monin@gmx.fr>
Subject: Re: [PATCH] hso: Set modem name based on udev network interface name
Date: Mon, 25 Oct 2010 13:35:21 +0200
Message-ID: <20101025120910.178860@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2189105504794355859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> De : Marcel Holtmann
> =

> Hi Benoit,
> =

> the friendly modem name is for devices that do have a friendly name,
> like Bluetooth headsets. Why do you wanna misuse the interface name
> here. I am a bit against this, because it leads to speculation and
> assumptions in userspace programs.
> =

Maybe I should give some details of what I'm trying to achieve. The
device we're building has 2 identical modems with fixed position on
USB. We also have the possibility to drive their power supply
independently and to swap the sim cards.

I need a way to know which one is modem A and which one is modem B
and I have no easy way of knowing the modem serial number or the
sim subscriber id beforehand. With an udev rule, I can easily set
a fixed name for the network interface of each modem. But under
ofono, I can't tell which modem is which. That's why I added this
"not-so-friendly" name.

Is there a way of knowing which physical modem ofono is refering to ?
I recognize that our case may not be the most common and I understand
that you don't want to abuse the Name property. Maybe exposing the
NetworkInterface as a modem property would be ok ? or exposing
a PhysicalName ?

--
Beno=C3=AEt.

--===============2189105504794355859==--

