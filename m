Content-Type: multipart/mixed; boundary="===============4709997330540827826=="
MIME-Version: 1.0
From: Gustavo Padovan <padovan@profusion.mobi>
Subject: Re: Underlying Bluetooth device of a modem
Date: Thu, 11 Aug 2011 19:19:19 -0300
Message-ID: <20110811221918.GH19699@joana>
In-Reply-To: <1312983556.3373.112.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4709997330540827826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Marcel Holtmann <marcel@holtmann.org> [2011-08-10 06:39:15 -0700]:

> Hi Mikel,
> =

> > I am trying to set up a simple HFP demonstrator using =

> > BlueZ+oFono+PulseAudio, with a dbus client that coordinates the three o=
f =

> > them. Being a simple prototype, the goal is to see how they behave and =

> > analyze how well it would all scale.
> > =

> > The first question that arises is quite simple. In a multi-phone =

> > scenario (all of them connected to our PC using Bluetooth HFP), oFono =

> > properly lists all the phones as available modems. I would like to know =

> > whether these modems can be associated to their underlying bluetooth =

> > device (mac address, bluez device dbus path, or whatever). I have been =

> > looking on the available modem properties but this seems not to be =

> > present. Could somebody confirm this or otherwise explain how it can be =

> > done?
> > =

> > The purpose of my interest is that, depending on the use-case, the fina=
l =

> > user would have to choose the modem (or device) manually.
> =

> you would need to be a bit more specific on what the actual use case
> entails here. How would selection work and how the user is involved in
> it. Depending on that, things should be done differently.
> =

> So besides that, some simple pieces that come to mind quickly are to
> create a HFP devinfo atom driver that just exports the BD_ADDR as serial
> number.

Only the BD_ADDR is not enough, the device can paired with two or more
adapters. Exports its DBUS path seems a best option.
HFP plugin already keep the path for internal use, so its just a matter of =
put
it devinfo.
Also, the modem path gives you the information you need. The numbers there =
are
the adapter bd_addr followed by the remove device bd_add.

	Gustavo

--===============4709997330540827826==--

