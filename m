Content-Type: multipart/mixed; boundary="===============7260116995584845464=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2] plugin: Add ste modem initd integration
Date: Tue, 04 Jan 2011 01:49:24 -0800
Message-ID: <1294134564.5852.96.camel@aeonflux>
In-Reply-To: <AANLkTinFfW79MZ=-z0qxpXmJ=T+cxo_oERAzX9FKyZPb@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7260116995584845464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > what about potential USB based CAIF devices?
> Good question, but in a Bridge Setup for a phone this will not really
> be devices that come and go.
> I belive it will still be a fixed HW setup where the Modem Init Daemon
> will have static knowledge of the
> USB modems. But I'll discuss this with my coleagues tomorrow.
> In case of true USB dongles the modem should look pretty much
> identical to MBM USB dongles.

I personally would prefer that USB devices just expose CAIF directly.
The whole handling of multiple hardcoded TTY and network interface is
only sub-optimal.

I know it is kinda nice to use standard USB class drivers, but the
flexibility that CAIF actually gives you goes away.

From my point of view, it should be similar to Phonet/ISI over USB. At
least on Linux we have a CAIF subsystem ;)

> >I would just ask to send the property changed signal for the serial
> >number before sending the signal for on/ready.
> It will require a re-design of the state machine in the Modem Init Daemon,
> but I'll check into this tomorrow.
> =

> Here is the latest version of the Dbus API:
> =

> STE Modem Init Deamon Manager
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Service		com.stericsson.modeminit
> Interface	com.stericsson.modeminit.ModemManager

Just call it com.stericsson.modeminit.Manager. That gives you the chance
to also include other methods/signals later on if needed.

> Object path	/
> =

> Methods		array{object,dict} GetModems()
> =

> 			Get array of STE Modem objects and their state and
> 			properties (out signature 'a(oa{sv})').
> =

> 			The method should only be call once per application.
> 			Further changes shall be monitored via StateChange
> 			signals.
> =

> STE Modem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> Service		com.stericsson.modeminit
> Interface	com.stericsson.modeminit.Modem
> Object path	variable
> =

> Signals		PropertyChanged(string property, variant value)
> =

> 			This signal indicates a changed value of the given
> 			property.
> =

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
> 			"on"	    Modem has booted and is ready for use.
> 				    This implies that all AT channels are
> 				    available, the modem might be in
> 				    e.g. flight mode.
> 				    NOTE: Consider change name to "ready"
> =

> 			"dumping"  Modem has crashed and dump is ongoing
> 			"off"	    Modem is powered off.
> =

> 		string AtInterface[readonly]
> =

> 			CAIF Link Layer interface to be used for
> 			AT channels for a modem.

Why is there an "At" in here? I know that mainly only AT command
channels will be used, but the CAIF interface can be also used to
request debug channels and other things. So I would just call it
Interface only to say what's the interface name is to bind to.

> 		string Serial[optional,readonly]
> =

> 			Serial Number or IMEI for the Modem. The Serial will
> 			not be available until the modem can open an AT channel.

Otherwise, this looks a lot simpler and cleaner.

Regards

Marcel



--===============7260116995584845464==--

