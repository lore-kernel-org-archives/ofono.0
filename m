Content-Type: multipart/mixed; boundary="===============6463993968588707103=="
MIME-Version: 1.0
From: Gustavo Padovan <padovan@profusion.mobi>
Subject: Re: Underlying Bluetooth device of a modem
Date: Fri, 12 Aug 2011 11:16:26 -0300
Message-ID: <20110812141626.GB4168@joana>
In-Reply-To: <1313102382.3373.145.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6463993968588707103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2011-08-11 15:39:40 -0700]:

> Hi Gustavo,
> =

> > > > I am trying to set up a simple HFP demonstrator using =

> > > > BlueZ+oFono+PulseAudio, with a dbus client that coordinates the thr=
ee of =

> > > > them. Being a simple prototype, the goal is to see how they behave =
and =

> > > > analyze how well it would all scale.
> > > > =

> > > > The first question that arises is quite simple. In a multi-phone =

> > > > scenario (all of them connected to our PC using Bluetooth HFP), oFo=
no =

> > > > properly lists all the phones as available modems. I would like to =
know =

> > > > whether these modems can be associated to their underlying bluetoot=
h =

> > > > device (mac address, bluez device dbus path, or whatever). I have b=
een =

> > > > looking on the available modem properties but this seems not to be =

> > > > present. Could somebody confirm this or otherwise explain how it ca=
n be =

> > > > done?
> > > > =

> > > > The purpose of my interest is that, depending on the use-case, the =
final =

> > > > user would have to choose the modem (or device) manually.
> > > =

> > > you would need to be a bit more specific on what the actual use case
> > > entails here. How would selection work and how the user is involved in
> > > it. Depending on that, things should be done differently.
> > > =

> > > So besides that, some simple pieces that come to mind quickly are to
> > > create a HFP devinfo atom driver that just exports the BD_ADDR as ser=
ial
> > > number.
> > =

> > Only the BD_ADDR is not enough, the device can paired with two or more
> > adapters. Exports its DBUS path seems a best option.
> > HFP plugin already keep the path for internal use, so its just a matter=
 of put
> > it devinfo.
> > Also, the modem path gives you the information you need. The numbers th=
ere are
> > the adapter bd_addr followed by the remove device bd_add.
> =

> you can not get the BD_ADDR out of the device path. The device path is
> arbitrary. And if anybody considers to misuse it, then I will add even
> more random bits into it.

Yes, but I am talking about the oFono modem path, you can extract the bd_ad=
dr
from there and call BlueZ api to discover the remove device path.
But add the device path to modem devinfo is a best option, I just wanted to
mention that this extraction is possible.

	Gustavo

--===============6463993968588707103==--

