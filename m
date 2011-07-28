Content-Type: multipart/mixed; boundary="===============1555378306893812063=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] udev: assign "huaweicdma" OFONO_DRIVER for E156 dongle
Date: Thu, 28 Jul 2011 22:12:24 +0200
Message-ID: <1311883944.8920.118.camel@aeonflux>
In-Reply-To: <1311864599-10607-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1555378306893812063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>  plugins/ofono.rules |  217 +++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 216 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index f8e485b..94eb061 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -412,7 +412,222 @@ ATTRS{idVendor}=3D=3D"1199", ENV{OFONO_DRIVER}=3D"s=
ierra"
>  ATTRS{idVendor}=3D=3D"1199", ATTRS{serial}=3D=3D"1234567890ABCDEF", ENV{=
ID_SERIAL_SHORT}=3D""
>  =

>  # HUAWEI Technology
> -ATTRS{idVendor}=3D=3D"12d1", ENV{OFONO_DRIVER}=3D"huawei"
> +
> +# Generic 0x1001
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1001", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +# Generic 0x1003
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1003", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1401", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1405", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1406", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1408", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1409", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"140a", ENV{OFONO_DRI=
VER}=3D"huawei"
> +
> +# E156
> +ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"140b", ENV{OFONO_DRI=
VER}=3D"huaweicdma"

just make this one special and have it overwrite the previous one. No
need for touching everything.

Regards

Marcel



--===============1555378306893812063==--

