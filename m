Content-Type: multipart/mixed; boundary="===============4702611045036937761=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 1/3] u8500: add plugin for u8500
Date: Tue, 01 Feb 2011 16:41:45 +0100
Message-ID: <1296574905.1520.270.camel@aeonflux>
In-Reply-To: <fabc1533cadfaf5d418d3d27833e7fe8d05a8739.1296569048.git.jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4702611045036937761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

>  Makefile.am         |    4 +
>  plugins/ofono.rules |    3 +
>  plugins/u8500.c     |  507 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 514 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/u8500.c

as mentioned in the other email. Put ofono.rules and udev.c changes into
one patch.

> diff --git a/Makefile.am b/Makefile.am
> index a38fcb9..4762cc8 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -110,6 +110,7 @@ builtin_sources +=3D $(gisi_sources) \
>  				drivers/isimodem/mtc.h \
>  				drivers/isimodem/debug.h \
>  				drivers/isimodem/isiutil.h \
> +				drivers/isimodem/version.h \
>  				drivers/isimodem/debug.c \
>  				drivers/isimodem/phonebook.c \
>  				drivers/isimodem/devinfo.c \

This does not belong here. Please be careful what is in your patches.

> @@ -144,6 +145,9 @@ builtin_sources +=3D plugins/isiusb.c
>  =

>  builtin_modules +=3D n900
>  builtin_sources +=3D plugins/n900.c plugins/nokia-gpio.h plugins/nokia-g=
pio.c
> +
> +builtin_modules +=3D u8500
> +builtin_sources +=3D plugins/u8500.c
>  endif
>  =

>  if ATMODEM
> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 111f071..333bff0 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -356,6 +356,9 @@ SUBSYSTEMS=3D=3D"usb", ENV{OFONO_DRIVER}=3D"isiusb", =
ENV{OFONO_ISI_ADDRESS}=3D"16"
>  # Nokia N900 modem
>  SUBSYSTEMS=3D=3D"hsi", ENV{OFONO_DRIVER}=3D"n900", ENV{OFONO_ISI_ADDRESS=
}=3D"108"
>  =

> +# STE u8500
> +KERNEL=3D=3D"shrm0", ENV{OFONO_DRIVER}=3D"u8500"
> +
>  LABEL=3D"ofono_isi_end"
>  =

>  SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"

Regards

Marcel



--===============4702611045036937761==--

