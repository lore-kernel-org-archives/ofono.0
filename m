Content-Type: multipart/mixed; boundary="===============3118940632519683695=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC] plugin/ste: Use D-Bus API from Modem Init Daemon for
 autoconfig.
Date: Thu, 11 Nov 2010 14:41:04 +0900
Message-ID: <1289454064.3266.42.camel@aeonflux>
In-Reply-To: <81C3A93C17462B4BBD7E272753C105791945B03437@EXDCVYMBSTM005.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3118940632519683695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > > This patch introduces auto discovery of ST-Ericsson modems.
> > > ST-Ericsson modems are managed by a Modem Init Daemon which
> > > is responsible for start/stop/restart flashing etc. The
> > > STE plugin monitors the modem state exposed from the
> > > Modem Init Damon Dbus API. When the modem is in state "on"
> > > the STE modem is created and registered.
> > >
> > > The reason for not using the standard udev paradigm is that
> > > the CAIF device is up before the modem is ready to setup AT channels.
> > > For flashless modems CAIF is used as part of the boot. The Modem Init
> > > Daemon is managing the flashless boot procedure and sets the State to
> > > "on" when the modem is available.
> > =

> > so I don't like this at all. This looks pretty nasty and like an ugly
> > hack to get something working.
> > =

> > Please show us what Modem Init Daemon is actually doing.
> =

> As mentioned above the Modem Init Daemon is responsible for:
> - Toggling the different GPIOs, powering the modem on/off.
> - Boot the modem and upload the firmware in several stages. =

>   a) Initial Z-Protocol, for handshaking the modem
>   b) PROTROM boot protocol to upload modem firmware.
>   c) CAIF Remote File System protocol for further
>      firmware loading (modules)
>   d) CAIF Remote File System protocol for serving modem file system.
> - Monitoring the GPIOs for modem restart and act upon this.
> - Enabling/Disabling the CAIF Link Layer Interface according to
>   the modem state (GPIO).
> - Monitoring Thermal and Battery Warnings URC over AT =

>   and acting upon this.
> - In case of modem crash, the crash-dump from the modem
>   must be downloaded to host. This needs to be synchronized
>   so that the reboot of the modem is not started before
>   the dump is complete.
> - Modem Init daemon has to expose an API in for:
> 	o triggering restart
> 	o signal modem status
> 	o initiate upgrade
> =

> The Modem Init Daemon will be available in product quality under Apache L=
icense,
> and will be in use for several platforms (not just MeeGo) and modem versi=
ons.
> =

> The issue we have is that when the CAIF Link Layer Interface is up
> it does not necessarily mean that the Modem is fully started.
> So we need to have a way to synchronize other services and modem clients
> when the modem is ready. The other services that needs this ready notific=
ation
> are: oFono, Remote File Manager, Logging Daemon. On other platforms than =
MeeGo
> there are AT based clients such as Audio, AGPS, RIL as well.
> =

> We definitely need a synchronization mechanism between Modem Init Daemon
> and the other services, so we decided to use a D-Bus API for the =

> Modem Init Daemon to expose the modem state and an API for initiating
> power-off, upgrade and reboot. =


do you have a link to the D-Bus of this daemon? I would prefer if you
publish it first or at least the part of it used here.

Also you can not squeeze this into plugins/ste.c as you have done. You
need to have a separate plugin that does modem detection. Like we do
with udev for other modems.

I am also not sure that we do need this kind of D-Bus API. For example
using the differentiation between IFF_UP, IFF_RUNNING and IFF_LOWER_UP
could be easily used to define which parts of an interface are up and
initialized.

We do something similar with wpa_supplicant and WiFi in Linux. Have you
looked at doing this properly with kernel available flags instead of
just forcing another D-Bus API and daemon?

Regards

Marcel



--===============3118940632519683695==--

