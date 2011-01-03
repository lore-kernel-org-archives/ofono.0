Content-Type: multipart/mixed; boundary="===============1342131079881836539=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCHv2] plugin: Add ste modem initd integration
Date: Mon, 03 Jan 2011 22:42:02 +0100
Message-ID: <AANLkTi=NHj7dk2ZT6Wve-WMyftbQZPGRwg==Lq5kAm54@mail.gmail.com>
In-Reply-To: <1293072490.9439.11.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1342131079881836539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

> is this the full API or only part of it. If it is just a part of it,
> please send the full API for the daemon. Just looking at this piece, I
> am not really thinking that this is a good API. It is actually pretty
> much broken :(

Ok, here's an updated version of the Modem Init Daemon DBus API.
I hope this is aligned with what we discussed on the IRC.

STE Modem Init Deamon Manager
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Service	com.stericsson.modeminit
Interface	com.stericsson.modeminit.Manager
Object path	/

Methods	array{object,dict} GetModems()

			Get array of STE Modem objects and their state and
			properties (out signature 'a(oa{sv})').

			The method should only be call once per application.
			Further changes shall be monitored via StateChange
			signals.

STE Modem
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Service	com.stericsson.modeminit
Interface	com.stericsson.modeminit.Modem
Object path	variable

Signals	StateChange(string State)

			The modems state sent from when
			a modem state change occurs. State is the only
			dynamic property in this Interface.

Properties	string State [readonly]

			The modems state is dynamic can can have the following
			values:
			"booting"   Modem is powered up (flashed version)
				    or Modem is powered up and firmware upload
				    is completed. (flashless version)
			"upgrading" Firmware upgrade on going
				    or Flashing manager under execution -
				    modem in service mode.
			"on"     Modem has booted and is ready for use.
				    This implies that all AT channels are
				    available, the modem might be in
				    e.g. flight mode.
			"dumping"  Modem has crashed and dump is ongoing
			"off"       Modem is powered off.

		string CaifAtInterface [readonly]

			CAIF Link Layer interface to be used for
			AT channels for a modem.

Regards,
Sjur

--===============1342131079881836539==--

