Content-Type: multipart/mixed; boundary="===============1347268004249875209=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/5] udev: Add rules to support ZTE MF668 dongle
Date: Sun, 18 Dec 2011 21:49:30 -0800
Message-ID: <1324273770.1965.100.camel@aeonflux>
In-Reply-To: <1322569281-10908-2-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1347268004249875209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>  plugins/ofono.rules |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 30a1b7e..c7fac57 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -15,6 +15,15 @@ KERNEL=3D=3D"shrm0", ENV{OFONO_DRIVER}=3D"u8500"
>  =

>  LABEL=3D"ofono_isi_end"
>  =

> +SUBSYSTEM!=3D"tty", GOTO=3D"ofono_tty_end"
> +KERNEL!=3D"ttyUSB[0-9]*", GOTO=3D"ofono_tty_end"
> +
> +# ZTE
> +ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"02", ENV{OFONO_LABEL}=3D"modem"
> +ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
> +
> +LABEL=3D"ofono_tty_end"
> +

what are we trying to fix here. Please include /proc/bus/usb/devices or
usb-devices and some oFono debug lines that show that without this we
are doing a wrong assignment.

Regards

Marcel



--===============1347268004249875209==--

