Content-Type: multipart/mixed; boundary="===============5417170396838680262=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/3] oFono rules update
Date: Tue, 23 Aug 2011 09:13:13 -0700
Message-ID: <1314115995.3373.211.camel@aeonflux>
In-Reply-To: <4E53C6BA.9010807@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5417170396838680262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Phillipe,

> >> Based on the latest usb_modeswitch rules, some 3G dongles require
> >> to modify the ofono rules to be supported correctly (tests done in Ind=
ia)
> >>
> >>
> >> Philippe Nunes (3):
> >>    udev: use ttyUSB3 for ZTE K3570 modem port.
> >>    udev:  add support for Olive HSDPA modem
> >>    udev: Use ttyUSB4 for Huawei E367 Pcui port
> >>
> >>   plugins/ofono.rules |   17 ++++++++++-------
> >>   1 files changed, 10 insertions(+), 7 deletions(-)
> >
> > I think you are way too late with these changes. We are not using
> > plugins/udev.c for Huawei and ZTE device detection anymore. I fixed this
> > all up and plugins/udevng.c should do proper automatic detection.
> >
> > Please check if this works properly for you or if you have problems.
> >
> =

> =

> Hi Marcel,
> =

> I just experienced a case where the automatic detection brings a =

> difference with the previous implementation.
> =

> Using the dongle ZTE MF190 (DefaultProduct=3D 0x0149 TargetProduct=3D =

> 0x0124), udevng.c is assigning the modem port to ttyUSB3 whereas ttyUSB4 =

> was assigned with the previous udev.c based on the previous ofono.rules.
> =

> In practice, the port com ttyUSB3 is not responsive (I checked also with =

> minicom) so we can't manage to connect a data call (see ofono logs in =

> attachment). Using the previous combination udev.c  + ofono.rules, if =

> the modem port assigned to ttyUSB4 is responsive, we are however facing =

> with an other issue:
> =

> ofonod[23908]: plugins/zte.c:zte_post_online() 0x9e2a470
> ofonod[23908]: Aux: > AT+CREG=3D?\r
> ofonod[23908]: Aux: < \r\nOK\r\n
> ofonod[23908]: Unable to initialize Network Registration
> ofonod[23908]: src/network.c:netreg_remove() atom: 0x9e29cf0
> =

> =

> So, we can't go ahead for the data call since the network is not =

> registered. But this is an other issue we would need to fix I guess =

> specifically for this dongle.
> =

> Here, I just wanted to raise a potential issue regarding the modem port =

> com assignment for ZTE dongles:
> =

> Indeed, according the previous ofono.rules, we were assigning ttyUSB4 as =

> modem port for 2 product Ids:
> =

> ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0121", =

> ENV{ID_USB_INTERFACE_NUM}=3D=3D"04", ENV{OFONO_ZTE_TYPE}=3D"modem"
> ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0121", =

> ENV{ID_USB_INTERFACE_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
> =

> ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", =

> ENV{ID_USB_INTERFACE_NUM}=3D=3D"04", ENV{OFONO_ZTE_TYPE}=3D"modem"
> ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", =

> ENV{ID_USB_INTERFACE_NUM}=3D=3D"01", ENV{OFONO_ZTE_TYPE}=3D"aux"
> =

> but looking to udevng.c and particularly the function 'setup_zte', the =

> modem port can't be assigned anymore to ttyUSB4.
> =

> static gboolean setup_zte(struct modem_info *modem)
> {
> 	...
> =

> 	if (g_strcmp0(info->number, "00") =3D=3D 0)
> 		qcdm =3D info->devnode;
> 	else if (g_strcmp0(info->number, "01") =3D=3D 0)
> 		aux =3D info->devnode;
> 	else if (g_strcmp0(info->number, "02") =3D=3D 0)
> 		mdm =3D info->devnode;
> 	else if (g_strcmp0(info->number, "03") =3D=3D 0)
> 		mdm =3D info->devnode;
> 	}
> }
> =

> So, I wonder if the condition:
> 	=

> 	else if (g_strcmp0(info->number, "04") =3D=3D 0)
> =

> is voluntarily missing or not.

it might be missing. What does usb-devices say and how many TTY is this
one actually creating. If it creates indeed 5 TTY and the fourth TTY is
on interface number 04, then yes this should be added.

The general rule for ZTE is that the modem interface is suppose to be on
the last interface. Not sure if this is always true, but with all my
devices it was. And we could still overwrite this with a udev rule if we
have to.

Regards

Marcel



--===============5417170396838680262==--

