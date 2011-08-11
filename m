Content-Type: multipart/mixed; boundary="===============3242390166111996537=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Underlying Bluetooth device of a modem
Date: Thu, 11 Aug 2011 15:39:40 -0700
Message-ID: <1313102382.3373.145.camel@aeonflux>
In-Reply-To: <20110811221918.GH19699@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3242390166111996537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> > > I am trying to set up a simple HFP demonstrator using =

> > > BlueZ+oFono+PulseAudio, with a dbus client that coordinates the three=
 of =

> > > them. Being a simple prototype, the goal is to see how they behave an=
d =

> > > analyze how well it would all scale.
> > > =

> > > The first question that arises is quite simple. In a multi-phone =

> > > scenario (all of them connected to our PC using Bluetooth HFP), oFono =

> > > properly lists all the phones as available modems. I would like to kn=
ow =

> > > whether these modems can be associated to their underlying bluetooth =

> > > device (mac address, bluez device dbus path, or whatever). I have bee=
n =

> > > looking on the available modem properties but this seems not to be =

> > > present. Could somebody confirm this or otherwise explain how it can =
be =

> > > done?
> > > =

> > > The purpose of my interest is that, depending on the use-case, the fi=
nal =

> > > user would have to choose the modem (or device) manually.
> > =

> > you would need to be a bit more specific on what the actual use case
> > entails here. How would selection work and how the user is involved in
> > it. Depending on that, things should be done differently.
> > =

> > So besides that, some simple pieces that come to mind quickly are to
> > create a HFP devinfo atom driver that just exports the BD_ADDR as serial
> > number.
> =

> Only the BD_ADDR is not enough, the device can paired with two or more
> adapters. Exports its DBUS path seems a best option.
> HFP plugin already keep the path for internal use, so its just a matter o=
f put
> it devinfo.
> Also, the modem path gives you the information you need. The numbers ther=
e are
> the adapter bd_addr followed by the remove device bd_add.

you can not get the BD_ADDR out of the device path. The device path is
arbitrary. And if anybody considers to misuse it, then I will add even
more random bits into it.

Regards

Marcel



--===============3242390166111996537==--

