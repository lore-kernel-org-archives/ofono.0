Content-Type: multipart/mixed; boundary="===============3628439683313676935=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/5] udev: Add rules to support ZTE MF190 dongle
Date: Sun, 18 Dec 2011 21:50:17 -0800
Message-ID: <1324273817.1965.101.camel@aeonflux>
In-Reply-To: <1322569281-10908-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3628439683313676935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>  plugins/ofono.rules |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index c7fac57..079db07 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -22,6 +22,9 @@ KERNEL!=3D"ttyUSB[0-9]*", GOTO=3D"ofono_tty_end"
>  ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"02", ENV{OFONO_LABEL}=3D"modem"
>  ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0017", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
>  =

> +ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"04", ENV{OFONO_LABEL}=3D"modem"
> +ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
> +
>  LABEL=3D"ofono_tty_end"
>  =

>  SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"

same here. The modem AUX port is always the second TTY and the modem TTY
is always the last one. Where is this not true?

Regards

Marcel



--===============3628439683313676935==--

