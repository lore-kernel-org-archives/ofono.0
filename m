Content-Type: multipart/mixed; boundary="===============3471195219337915847=="
MIME-Version: 1.0
From: Gustavo Padovan <gustavo@padovan.org>
Subject: Re: oFono DUN server issue
Date: Fri, 15 Jun 2012 00:11:39 -0300
Message-ID: <20120615031139.GC3538@joana>
In-Reply-To: <4FD9F380.2060202@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3471195219337915847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

* Guillaume Zajac <guillaume.zajac@linux.intel.com> [2012-06-14 16:21:52 =
+0200]:

> Hi,
> =

> I tested oFono DUN server to be sure it was still working with
> latest oFono version, however I have an issue with udev/udevng.
> =

> My current "phone like" configuration is:
>     - laptop with Ubuntu 11.10
>     - oFono + ConnMan running together (network-manager +
> modem-manager stopped)
>     - Huawei dongle for data connection
> =

> I am using a Windows 7 DUN client to connect to the laptop.
> =

> Binding with client is fine but when I try to dial to connect to the
> server with the DUN client I got this into oFono log:
> =

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
> =

> and the DUN client is getting a timeout error.
> =

> Does anybody have any idea about this issue?

I suggest you to also send bluetooth hcidump log. It look like the connecti=
on
attempt never arrives to ofono (new_connection() on plugins/bluetooth.c).

Does this work when you try to connect from a different DUN Client, like
dundee, or even trying to open the RFCOMM channel by hand using the rfcomm
tool?

	Gustavo

--===============3471195219337915847==--

