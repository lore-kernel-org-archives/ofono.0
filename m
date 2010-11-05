Content-Type: multipart/mixed; boundary="===============2829555662469476617=="
MIME-Version: 1.0
From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [RFC] plugin/ste: Use D-Bus API from Modem Init Daemon for
 autoconfig.
Date: Fri, 05 Nov 2010 11:29:29 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C105791945B03437@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <1288883948.9615.94.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2829555662469476617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > This patch introduces auto discovery of ST-Ericsson modems.
> > ST-Ericsson modems are managed by a Modem Init Daemon which
> > is responsible for start/stop/restart flashing etc. The
> > STE plugin monitors the modem state exposed from the
> > Modem Init Damon Dbus API. When the modem is in state "on"
> > the STE modem is created and registered.
> >
> > The reason for not using the standard udev paradigm is that
> > the CAIF device is up before the modem is ready to setup AT channels.
> > For flashless modems CAIF is used as part of the boot. The Modem Init
> > Daemon is managing the flashless boot procedure and sets the State to
> > "on" when the modem is available.
> =

> so I don't like this at all. This looks pretty nasty and like an ugly
> hack to get something working.
> =

> Please show us what Modem Init Daemon is actually doing.

As mentioned above the Modem Init Daemon is responsible for:
- Toggling the different GPIOs, powering the modem on/off.
- Boot the modem and upload the firmware in several stages. =

  a) Initial Z-Protocol, for handshaking the modem
  b) PROTROM boot protocol to upload modem firmware.
  c) CAIF Remote File System protocol for further
     firmware loading (modules)
  d) CAIF Remote File System protocol for serving modem file system.
- Monitoring the GPIOs for modem restart and act upon this.
- Enabling/Disabling the CAIF Link Layer Interface according to
  the modem state (GPIO).
- Monitoring Thermal and Battery Warnings URC over AT =

  and acting upon this.
- In case of modem crash, the crash-dump from the modem
  must be downloaded to host. This needs to be synchronized
  so that the reboot of the modem is not started before
  the dump is complete.
- Modem Init daemon has to expose an API in for:
	o triggering restart
	o signal modem status
	o initiate upgrade

The Modem Init Daemon will be available in product quality under Apache Lic=
ense,
and will be in use for several platforms (not just MeeGo) and modem version=
s.

The issue we have is that when the CAIF Link Layer Interface is up
it does not necessarily mean that the Modem is fully started.
So we need to have a way to synchronize other services and modem clients
when the modem is ready. The other services that needs this ready notificat=
ion
are: oFono, Remote File Manager, Logging Daemon. On other platforms than Me=
eGo
there are AT based clients such as Audio, AGPS, RIL as well.

We definitely need a synchronization mechanism between Modem Init Daemon
and the other services, so we decided to use a D-Bus API for the =

Modem Init Daemon to expose the modem state and an API for initiating
power-off, upgrade and reboot. =


Regards,
Sjur

--===============2829555662469476617==--

