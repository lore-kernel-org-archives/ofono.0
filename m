Content-Type: multipart/mixed; boundary="===============9108817105176371206=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] udevng: Add OFONO_PATHNAME property to set modem dbus
 path name
Date: Wed, 14 Feb 2018 11:04:37 -0600
Message-ID: <537fc659-a482-c828-e5aa-fed89350f132@gmail.com>
In-Reply-To: <20180213195338.30077-1-pespin@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9108817105176371206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pau,

On 02/13/2018 01:53 PM, Pau Espin Pedrol wrote:
> The current udevng.c implementation sets dbus path names for modems
> based on type and a number incremented seuqntially for each new modem
> found. As a result, the dbus path for a given device is non
> deterministic, since it depends on the devices available during ofono
> startup.

Why should it be deterministic?

> =

> Furthermore, if a modem crashes and reboots while in operation, then
> udev will trigger a remove event followed by a create event, and the
> same modem will now be given a different name (as the sequence number is
> bigger).

Yes, and?

> =

> This is non suitable for systems handling several modems which want to
> identify them easily based on its path.
> =


This sounds like a very specific non-real world usecase, right?  I mean =

why don't you simply compare the IMEI if you really care?

> This patch introduces a way to be able to set persistent names for
> specific devices while still permitting previous dynamic naming
> methodology.
> =

> One can set a persistent name using udev rules for the target device
> which set the OFONO_PATHNAME env property. If ofono finds this property
> set, it will use its value as the dbus path name for the modem.

I'm hesitant to take this patch as udev logic is already complex and =

this doesn't seem to be relevant for anyone else besides your test system.

> =

> Example:
> $ cat /etc/udev/rules.d/90-local.rules
> SUBSYSTEMS=3D=3D"usb", DEVPATH=3D=3D"/devices/pci0000:00/0000:00:1a.0/usb=
3/3-1/3-1.1/3-1.1.4/3-1.1.4.1/3-1.1.4.1.1", ENV{OFONO_PATHNAME}=3D"foo"
> =

> $ udevadm info -p /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.4=
/3-1.1.4.1/3-1.1.4.1.1
> ...
> E: OFONO_PATHNAME=3Dfoo
> ...
> =

> $ mdbus2 -s org.ofono
> /
> /bluetooth
> /bluetooth/profile
> /bluetooth/profile/dun_gw
> /bluetooth/profile/hfp_ag
> /bluetooth/profile/hfp_hf
> /foo

How are you making sure that dbus path is valid?   ofono_modem_create =

can fail after all...

> /mbm_0
> ---
>   plugins/udevng.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> =


Regards,
-Denis

--===============9108817105176371206==--

