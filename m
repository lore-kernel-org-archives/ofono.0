Content-Type: multipart/mixed; boundary="===============2703643429502009250=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2] plugin: Add ste modem initd integration
Date: Mon, 03 Jan 2011 13:55:16 -0800
Message-ID: <1294091716.5852.32.camel@aeonflux>
In-Reply-To: <AANLkTi=NHj7dk2ZT6Wve-WMyftbQZPGRwg==Lq5kAm54@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2703643429502009250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > is this the full API or only part of it. If it is just a part of it,
> > please send the full API for the daemon. Just looking at this piece, I
> > am not really thinking that this is a good API. It is actually pretty
> > much broken :(
> =

> Ok, here's an updated version of the Modem Init Daemon DBus API.
> I hope this is aligned with what we discussed on the IRC.
> =

> STE Modem Init Deamon Manager
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Service	com.stericsson.modeminit
> Interface	com.stericsson.modeminit.Manager
> Object path	/
> =

> Methods	array{object,dict} GetModems()
> =

> 			Get array of STE Modem objects and their state and
> 			properties (out signature 'a(oa{sv})').
> =

> 			The method should only be call once per application.
> 			Further changes shall be monitored via StateChange
> 			signals.

You also need the following signals:

	ModemAdded(object, dict)

	ModemRemoved(object)

> STE Modem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Service	com.stericsson.modeminit
> Interface	com.stericsson.modeminit.Modem
> Object path	variable
> =

> Signals	StateChange(string State)
> =

> 			The modems state sent from when
> 			a modem state change occurs. State is the only
> 			dynamic property in this Interface.

I would personally just go straight for PropertyChanged signal here and
not bother with StateChanged. It is actually "...Changed" since at that
time the state has already changed ;)

> Properties	string State [readonly]
> =

> 			The modems state is dynamic can can have the following
> 			values:
> 			"booting"   Modem is powered up (flashed version)
> 				    or Modem is powered up and firmware upload
> 				    is completed. (flashless version)
> 			"upgrading" Firmware upgrade on going
> 				    or Flashing manager under execution -
> 				    modem in service mode.
> 			"on"     Modem has booted and is ready for use.
> 				    This implies that all AT channels are
> 				    available, the modem might be in
> 				    e.g. flight mode.
> 			"dumping"  Modem has crashed and dump is ongoing
> 			"off"       Modem is powered off.

I personally would call it "ready" instead of "on" since the modem is
actually on, it is just not ready yet.

> 		string CaifAtInterface [readonly]
> =

> 			CAIF Link Layer interface to be used for
> 			AT channels for a modem.

I would really just call this "Interface" to make it simpler. Don't
think that you are expecting more than just CAIF interface here anyway.

And in addition if we can have the modem serial number here as "Serial"
as well would be good. Even it is is not right away available, you can
signal a change via PropertyChanged signal.

That way we can construct a proper modem object path inside oFono. I
really rather use the serial number and only fallback to the interface
name.

Regards

Marcel



--===============2703643429502009250==--

