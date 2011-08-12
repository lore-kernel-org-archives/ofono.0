Content-Type: multipart/mixed; boundary="===============8826099541682284878=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Underlying Bluetooth device of a modem
Date: Fri, 12 Aug 2011 09:05:15 -0700
Message-ID: <1313165117.3373.159.camel@aeonflux>
In-Reply-To: <20110812141626.GB4168@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8826099541682284878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> > > > > I am trying to set up a simple HFP demonstrator using =

> > > > > BlueZ+oFono+PulseAudio, with a dbus client that coordinates the t=
hree of =

> > > > > them. Being a simple prototype, the goal is to see how they behav=
e and =

> > > > > analyze how well it would all scale.
> > > > > =

> > > > > The first question that arises is quite simple. In a multi-phone =

> > > > > scenario (all of them connected to our PC using Bluetooth HFP), o=
Fono =

> > > > > properly lists all the phones as available modems. I would like t=
o know =

> > > > > whether these modems can be associated to their underlying blueto=
oth =

> > > > > device (mac address, bluez device dbus path, or whatever). I have=
 been =

> > > > > looking on the available modem properties but this seems not to b=
e =

> > > > > present. Could somebody confirm this or otherwise explain how it =
can be =

> > > > > done?
> > > > > =

> > > > > The purpose of my interest is that, depending on the use-case, th=
e final =

> > > > > user would have to choose the modem (or device) manually.
> > > > =

> > > > you would need to be a bit more specific on what the actual use case
> > > > entails here. How would selection work and how the user is involved=
 in
> > > > it. Depending on that, things should be done differently.
> > > > =

> > > > So besides that, some simple pieces that come to mind quickly are to
> > > > create a HFP devinfo atom driver that just exports the BD_ADDR as s=
erial
> > > > number.
> > > =

> > > Only the BD_ADDR is not enough, the device can paired with two or more
> > > adapters. Exports its DBUS path seems a best option.
> > > HFP plugin already keep the path for internal use, so its just a matt=
er of put
> > > it devinfo.
> > > Also, the modem path gives you the information you need. The numbers =
there are
> > > the adapter bd_addr followed by the remove device bd_add.
> > =

> > you can not get the BD_ADDR out of the device path. The device path is
> > arbitrary. And if anybody considers to misuse it, then I will add even
> > more random bits into it.
> =

> Yes, but I am talking about the oFono modem path, you can extract the bd_=
addr
> from there and call BlueZ api to discover the remove device path.
> But add the device path to modem devinfo is a best option, I just wanted =
to
> mention that this extraction is possible.

maybe I haven't made myself clear here. That is the kind of hacking in a
public API that we will not support. So this is not a solution. And once
you start thinking about it from a public API point of view, you will
realize this as well. It will just create a mess.

Regards

Marcel



--===============8826099541682284878==--

