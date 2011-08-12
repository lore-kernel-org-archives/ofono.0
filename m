Content-Type: multipart/mixed; boundary="===============1396622316444684731=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Underlying Bluetooth device of a modem
Date: Fri, 12 Aug 2011 09:03:21 -0700
Message-ID: <1313165002.3373.157.camel@aeonflux>
In-Reply-To: <4E44D463.7060503@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1396622316444684731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

> >>>> I am trying to set up a simple HFP demonstrator using
> >>>> BlueZ+oFono+PulseAudio, with a dbus client that coordinates the thre=
e of
> >>>> them. Being a simple prototype, the goal is to see how they behave a=
nd
> >>>> analyze how well it would all scale.
> >>>>
> >>>> The first question that arises is quite simple. In a multi-phone
> >>>> scenario (all of them connected to our PC using Bluetooth HFP), oFono
> >>>> properly lists all the phones as available modems. I would like to k=
now
> >>>> whether these modems can be associated to their underlying bluetooth
> >>>> device (mac address, bluez device dbus path, or whatever). I have be=
en
> >>>> looking on the available modem properties but this seems not to be
> >>>> present. Could somebody confirm this or otherwise explain how it can=
 be
> >>>> done?
> >>>>
> >>>> The purpose of my interest is that, depending on the use-case, the f=
inal
> >>>> user would have to choose the modem (or device) manually.
> >>> you would need to be a bit more specific on what the actual use case
> >>> entails here. How would selection work and how the user is involved in
> >>> it. Depending on that, things should be done differently.
> >>>
> >>> So besides that, some simple pieces that come to mind quickly are to
> >>> create a HFP devinfo atom driver that just exports the BD_ADDR as ser=
ial
> >>> number.
> >> Only the BD_ADDR is not enough, the device can paired with two or more
> >> adapters. Exports its DBUS path seems a best option.
> >> HFP plugin already keep the path for internal use, so its just a matte=
r of put
> >> it devinfo.
> >> Also, the modem path gives you the information you need. The numbers t=
here are
> >> the adapter bd_addr followed by the remove device bd_add.
> > you can not get the BD_ADDR out of the device path. The device path is
> > arbitrary. And if anybody considers to misuse it, then I will add even
> > more random bits into it.
> >
> Yes, I was assuming that ofono did not intentionally guarantee to encode =

> this kind of information in the dbus path. Exposing the needed =

> information explicitly seemed more clear.
> =

> Considering the case pointed out by Gustavo about two adapters paired to =

> the same device, I agree that the device path is the appropriate choice.
> =

> Besides, do you think exposing this information can be interesting for =

> the upstream project? Do you believe that this is a special use-case? I =

> mean that any bluetooth-centered application would probably like to know =

> the relationship between the modems and the devices.

I have no interest in exposing a BlueZ D-Bus object path within oFono.
So this is not an option.

If you really end up with two Bluetooth adapters in your system and both
of them paired to the same headset, you will have first to solve the
user interaction within BlueZ, before you get to oFono. If you wanna
export the headset's BD_ADDR via oFono's serial number and maybe the
headset's name via model information, then that is fine, but do not try
to get smart by handing some constructed internal objects around. That
will end up in a big mess quickly.

Regards

Marcel



--===============1396622316444684731==--

