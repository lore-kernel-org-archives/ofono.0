Content-Type: multipart/mixed; boundary="===============1615520125095185993=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Underlying Bluetooth device of a modem
Date: Wed, 10 Aug 2011 06:39:15 -0700
Message-ID: <1312983556.3373.112.camel@aeonflux>
In-Reply-To: <4E42455D.9030102@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1615520125095185993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

> I am trying to set up a simple HFP demonstrator using =

> BlueZ+oFono+PulseAudio, with a dbus client that coordinates the three of =

> them. Being a simple prototype, the goal is to see how they behave and =

> analyze how well it would all scale.
> =

> The first question that arises is quite simple. In a multi-phone =

> scenario (all of them connected to our PC using Bluetooth HFP), oFono =

> properly lists all the phones as available modems. I would like to know =

> whether these modems can be associated to their underlying bluetooth =

> device (mac address, bluez device dbus path, or whatever). I have been =

> looking on the available modem properties but this seems not to be =

> present. Could somebody confirm this or otherwise explain how it can be =

> done?
> =

> The purpose of my interest is that, depending on the use-case, the final =

> user would have to choose the modem (or device) manually.

you would need to be a bit more specific on what the actual use case
entails here. How would selection work and how the user is involved in
it. Depending on that, things should be done differently.

So besides that, some simple pieces that come to mind quickly are to
create a HFP devinfo atom driver that just exports the BD_ADDR as serial
number.

Regards

Marcel



--===============1615520125095185993==--

