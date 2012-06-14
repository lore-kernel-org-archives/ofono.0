Content-Type: multipart/mixed; boundary="===============7850575945435377708=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono DUN server issue
Date: Thu, 14 Jun 2012 07:43:12 -0500
Message-ID: <4FD9DC60.8070907@gmail.com>
In-Reply-To: <4FD9F380.2060202@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7850575945435377708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 06/14/2012 09:21 AM, Guillaume Zajac wrote:
> Hi,
>
> I tested oFono DUN server to be sure it was still working with latest
> oFono version, however I have an issue with udev/udevng.
>
> My current "phone like" configuration is:
> - laptop with Ubuntu 11.10
> - oFono + ConnMan running together (network-manager + modem-manager
> stopped)
> - Huawei dongle for data connection
>
> I am using a Windows 7 DUN client to connect to the laptop.
>
> Binding with client is fine but when I try to dial to connect to the
> server with the DUN client I got this into oFono log:
>
> ...
> ofonod[20340]: plugins/udev.c:udev_event() subsystem tty add
> ofonod[20340]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[20340]: plugins/udev.c:udev_event() subsystem tty move
> ofonod[20340]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[20340]: plugins/udev.c:udev_event() subsystem tty move
> ofonod[20340]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[20340]: plugins/udevng.c:remove_device()
> /sys/devices/virtual/tty/rfcomm0
> ofonod[20340]: plugins/udev.c:udev_event() subsystem tty remove
> ofonod[20340]: plugins/udev.c:remove_modem() /devices/virtual/tty/rfcomm0
> ofonod[20340]: plugins/udev.c:udev_event() subsystem tty finished
> ofonod[20340]: plugins/udevng.c:check_modem_list()
> ...
>
> and the DUN client is getting a timeout error.
>
> Does anybody have any idea about this issue?
>

Likely the culprit is this line inside __dundee_bluetooth_init

         err =3D bluetooth_register_uuid(DUN_GW_UUID, &dun_profile);

It should probably use the UUID of the DUN client, not the gateway.

Regards,
-Denis

--===============7850575945435377708==--

