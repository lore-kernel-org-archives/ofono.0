Content-Type: multipart/mixed; boundary="===============1518974348503510442=="
MIME-Version: 1.0
From: Deng, Ying An <ying.an.deng@intel.com>
Subject: RE: [PATCH 2/3] udev:  add support for Olive HSDPA modem
Date: Fri, 12 Aug 2011 08:49:17 +0800
Message-ID: <CE59C043D0EC3349B2BF41C0EC72229B12D228FE6A@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1313077104-13397-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1518974348503510442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf
> Of Philippe Nunes
> Sent: Thursday, August 11, 2011 11:38 PM
> To: ofono(a)ofono.org
> Subject: [PATCH 2/3] udev: add support for Olive HSDPA modem
> =

> ---
>  plugins/ofono.rules |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
> =

> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 82232d9..a361e70 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -376,9 +376,12 @@ ATTRS{idVendor}=3D=3D"1c9e",
> ATTRS{idProduct}=3D=3D"9800", ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
>  ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"00",
> ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
>  ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9e00",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
> =

> -# SpeedUp 8000
> -ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"03",
> ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
> -ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
> +# SpeedUp
> +ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1005",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"03",
> ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
> +ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1005",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"01", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"
> +
> +ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"01",
> ENV{OFONO_SPEEDUP_TYPE}=3D"modem"
> +ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"03", ENV{OFONO_SPEEDUP_TYPE}=3D"aux"

Dear Philippe,
The modem port shall be 03 and aux port shall be 01 for 2020: 1008 (SU8000)=
 modem.

> =

>  # Olive
>  ATTRS{idVendor}=3D=3D"201e", ATTRS{idProduct}=3D=3D"2009",
> ENV{ID_USB_INTERFACE_NUM}=3D=3D"00",
> ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
> @@ -434,8 +437,8 @@ ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9=
800",
> ENV{OFONO_DRIVER}=3D"speedup"
> =

>  ATTRS{idVendor}=3D=3D"1c9e", ATTRS{serial}=3D=3D"1234567890ABCDEF",
> ENV{ID_SERIAL_SHORT}=3D""
> =

> -# SpeedUp 8000
> -ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008",
> ENV{OFONO_DRIVER}=3D"speedup"
> +# SpeedUp
> +ATTRS{idVendor}=3D=3D"2020", ENV{OFONO_DRIVER}=3D"speedup"
> =

>  ATTRS{idVendor}=3D=3D"2020", ATTRS{serial}=3D=3D"1234567890ABCDEF",
> ENV{ID_SERIAL_SHORT}=3D""
> =

> --
> 1.7.1
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============1518974348503510442==--

