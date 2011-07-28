Content-Type: multipart/mixed; boundary="===============2462415508555530119=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] udev: Add support for SpeedUp 7300 EVDO modem.
Date: Thu, 28 Jul 2011 13:52:59 +0200
Message-ID: <1311853980.8920.93.camel@aeonflux>
In-Reply-To: <1311853801-16489-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2462415508555530119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index f8e485b..ab21f57 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -422,11 +422,15 @@ ATTRS{idVendor}=3D=3D"19d2", ENV{OFONO_DRIVER}=3D"z=
te"
>  =

>  ATTRS{idVendor}=3D=3D"19d2", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{=
ID_SERIAL_SHORT}=3D""
>  =

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

>  ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{=
ID_SERIAL_SHORT}=3D""

did you send the usb-devices output for these dongles to confirm that
this serial number hack is still needed?
 =

> +# SpeedUp 8000
>  ATTRS{idVendor}=3D=3D"2020", ENV{OFONO_DRIVER}=3D"speedup"

While you are changing this here anyway, please include the product ID
as well.

>  =

>  ATTRS{idVendor}=3D=3D"2020", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{=
ID_SERIAL_SHORT}=3D""

Same here.

Regards

Marcel



--===============2462415508555530119==--

