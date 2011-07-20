Content-Type: multipart/mixed; boundary="===============5121432922630929922=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v2] plugins: update ofono rule and udev for using
 speedupcdma
Date: Wed, 20 Jul 2011 13:02:21 +0200
Message-ID: <1311159743.21109.207.camel@aeonflux>
In-Reply-To: <1311159081-13961-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5121432922630929922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> -# SpeedUp
> -ATTRS{idVendor}=3D=3D"1c9e", ENV{OFONO_DRIVER}=3D"speedup"
> +# SpeedUp 7300
> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00", ENV{OFONO_DRI=
VER}=3D"speedupcdma"
> +
> +# SpeedUp 9800
> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{OFONO_DRI=
VER}=3D"speedup"
>  =

> -ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{=
ID_SERIAL_SHORT}=3D""
> +ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ATTRS{serial}=
=3D=3D"1234567890ABCDEF", ENV{ID_SERIAL_SHORT}=3D""

is the serial number really fake. Adding the content of usb-devices
script for this specific modem would help here.

Or has this just been copied over from the Huawei entries and we missed
it in the review?
 =

>  ATTRS{idVendor}=3D=3D"2020", ENV{OFONO_DRIVER}=3D"speedup"
>  =

> diff --git a/plugins/udev.c b/plugins/udev.c
> index a28bea7..b50ca2f 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -793,6 +793,8 @@ done:
>  		add_linktop(modem, udev_device);
>          else if (g_strcmp0(driver, "speedup") =3D=3D 0)
>  		add_speedup(modem, udev_device);
> +	else if (g_strcmp0(driver, "speedupcdma") =3D=3D 0)
> +		add_speedup(modem, udev_device);

Coding style mistake here. Tabs vs spaces.

Regards

Marcel



--===============5121432922630929922==--

