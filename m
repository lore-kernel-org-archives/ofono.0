Content-Type: multipart/mixed; boundary="===============9204142049000816678=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: RE: [PATCH 11/15] emulator: Register mandatory AT command handlers
Date: Thu, 08 Jul 2010 16:23:41 +0200
Message-ID: <10180baccc529013508c7e6c4a8a0f27@chewa.net>
In-Reply-To: <1278595564.10421.18.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9204142049000816678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 08 Jul 2010 10:26:04 -0300, Marcel Holtmann <marcel@holtmann.org>
wrote:
>> > Marcel is right. Here I fake most AT commands like +CFUN to make DUN
>> > client happy. We don't need to power on/off real modem at all. See
>> > gatchat/test-server.c for similar implementation.
>>
>> That depends much what you're trying to achieve. If you only care about
>> Dial-Up Networking, that might work. But if you care about passing
> various
>> some kinds of certification testing, AT commands _must_ work
> _correctly_.
>>
>> So I doubt oFono will get away with this in the medium term.
> =

> we are clearly and on purpose splitting Bluetooth Dialup support from
> generic Serial Port Profile support.
> =

> For the serial port for certification testing you will NOT be able to
> use dialup channel.

I think it's quite the opposite. In my understanding, some tests do require
DUN. Obviously you loose the ability to send AT commands while PPP is
active.

> Also I doubt that you wanna do the certification testing over Bluetooth.

Sure, but that's hardly relevant. I assume oFono will need to support both
BlueTooth and USB, not just BlueTooth. I don't see any reason why it would
have two different AT server implementations. (As a side note, N900 does
use the exact same AT commands server for USB CDC ACM and BT DUN.)

> I assume that will most likely be done via USB

Yes.

> with the device in some special R&D mode.

No. Except for possibly being inside a Faraday cage, there's nothing
special.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============9204142049000816678==--

