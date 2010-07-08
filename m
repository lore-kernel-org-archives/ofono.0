Content-Type: multipart/mixed; boundary="===============5977887742617762227=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 11/15] emulator: Register mandatory AT command handlers
Date: Thu, 08 Jul 2010 10:26:04 -0300
Message-ID: <1278595564.10421.18.camel@localhost.localdomain>
In-Reply-To: <899f9aec76a576bcf883c873ef7aa96f@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5977887742617762227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > Marcel is right. Here I fake most AT commands like +CFUN to make DUN
> > client happy. We don't need to power on/off real modem at all. See
> > gatchat/test-server.c for similar implementation.
> =

> That depends much what you're trying to achieve. If you only care about
> Dial-Up Networking, that might work. But if you care about passing various
> some kinds of certification testing, AT commands _must_ work _correctly_.
> =

> So I doubt oFono will get away with this in the medium term.

we are clearly and on purpose splitting Bluetooth Dialup support from
generic Serial Port Profile support.

For the serial port for certification testing you will NOT be able to
use dialup channel. Also I doubt that you wanna do the certification
testing over Bluetooth. I assume that will most likely be done via USB
with the device in some special R&D mode.

Regards

Marcel



--===============5977887742617762227==--

