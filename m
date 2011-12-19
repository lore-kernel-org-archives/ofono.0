Content-Type: multipart/mixed; boundary="===============2604326886299390095=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 5/5] udev: Add rules to support SpeedUp 9800 dongle
Date: Sun, 18 Dec 2011 21:52:13 -0800
Message-ID: <1324273933.1965.103.camel@aeonflux>
In-Reply-To: <1322569281-10908-6-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2604326886299390095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>  plugins/ofono.rules |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 7f284d4..9e7a651 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -29,6 +29,10 @@ ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"01=
24", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
>  ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"00", ENV{OFONO_LABEL}=3D"modem"
>  ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"03", ENV{OFONO_LABEL}=3D"aux"
>  =

> +# SpeedUp 9800
> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"modem"
> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"02", ENV{OFONO_LABEL}=3D"aux"
> +
>  LABEL=3D"ofono_tty_end"
>  =

>  SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"

same applies here. See my other comment.

And btw. does anybody bothered to look into the inf files from the
Windows driver to figure out what the actual assignments are?

Regards

Marcel



--===============2604326886299390095==--

