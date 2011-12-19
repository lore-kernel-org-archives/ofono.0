Content-Type: multipart/mixed; boundary="===============6224482383785383251=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/5] udev: Add rules to support Speedup 7300 dongle
Date: Sun, 18 Dec 2011 21:51:23 -0800
Message-ID: <1324273883.1965.102.camel@aeonflux>
In-Reply-To: <1322569281-10908-5-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6224482383785383251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>  plugins/ofono.rules |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 079db07..7f284d4 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -25,6 +25,10 @@ ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"00=
17", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
>  ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"04", ENV{OFONO_LABEL}=3D"modem"
>  ATTRS{idVendor}=3D=3D"19d2", ATTRS{idProduct}=3D=3D"0124", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
>  =

> +# SpeedUp 7300
> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"00", ENV{OFONO_LABEL}=3D"modem"
> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{ID_USB_IN=
TERFACE_NUM}=3D=3D"03", ENV{OFONO_LABEL}=3D"aux"
> +
>  LABEL=3D"ofono_tty_end"
>  =

>  SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"

since the SpeedUp modem seem to be fully broken, we better just only do
label assignment and create a plugins/ofono-speedup.rules. I do not
wanna intermix this just because of total broken hardware.

Regards

Marcel



--===============6224482383785383251==--

