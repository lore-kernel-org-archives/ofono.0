Content-Type: multipart/mixed; boundary="===============1853647857540509652=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC] plugin/ste: Use D-Bus API from Modem Init Daemon for
 autoconfig.
Date: Tue, 16 Nov 2010 12:06:50 +0100
Message-ID: <AANLkTimHbn4ZRBA-3xvem6TFiKS4EinWywovh4=h4Vud@mail.gmail.com>
In-Reply-To: <1289454064.3266.42.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1853647857540509652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

>> We definitely need a synchronization mechanism between Modem Init Daemon
>> and the other services, so we decided to use a D-Bus API for the
>> Modem Init Daemon to expose the modem state and an API for initiating
>> power-off, upgrade and reboot.
>
> do you have a link to the D-Bus of this daemon? I would prefer if you
> publish it first or at least the part of it used here.

This is an extract of the Modem Init Daemon D-Bus API.
Should I could put this the git for reference e.g. in drivers/stemodem/?

Modem Init Deamon
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Service	com.stericsson.modeminit
Interface	com.stericsson.modeminit.Modem
Object path	/

Methods

		string GetState()

			Return the current state of the modem.

Signals	 StateChange(string status)

			The modems state sent from Modem Init Daemon when
			a modem state change occurs.

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
			"off"	    Modem is powered off.

> Also you can not squeeze this into plugins/ste.c as you have done. You
> need to have a separate plugin that does modem detection. Like we do
> with udev for other modems.

Sure, I'll move this to another file.

> I am also not sure that we do need this kind of D-Bus API. For example
> using the differentiation between IFF_UP, IFF_RUNNING and IFF_LOWER_UP
> could be easily used to define which parts of an interface are up and
> initialized.
>
> We do something similar with wpa_supplicant and WiFi in Linux. Have you
> looked at doing this properly with kernel available flags instead of
> just forcing another D-Bus API and daemon?

I have played around with this quite a few hours, and this is what I have f=
ound:
If you set the operstate to DORMANT and do UP on the device,
the device will be IFF_UP and  IFF_RUNNING not set. In this state the device
can still transmit and receive packets.

However as far as I can gather udev does not inform about operstate changes.
Instead the operstate changes would have to be monitored using RTNL.
In oFono we would then have to monitor link state event in order to catch
operstate changes similar to what is done in gisi/netlink. Based on the
operstate the CAIF Link Layer interface could then trigger registration and
start of the ste driver in oFono. The ModemInitDaemon would have to use
RTNL to set the CAIF Link Layer operstate.

To me this seems like a more complex solution involving more code lines,
than the suggested D-BUS API solution. I don't know if it is just me, but
architecturally I think is cleaner to communicate directly to the
Modem Init Daemon using D-Bus, rather than having ModemInitDaemon
setting the operstate on the CAIF device using RTNL, and then having
oFono taking information from both udev and RTNL in order know the
state set by the Modem Init Daemon.

Regards,
Sjur

--===============1853647857540509652==--

