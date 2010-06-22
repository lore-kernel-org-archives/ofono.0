Content-Type: multipart/mixed; boundary="===============7584719238826024942=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: commit a7690918 "huawei: Import huawei rules" broke Huawei E1552
Date: Tue, 22 Jun 2010 09:47:04 -0500
Message-ID: <201006220947.05022.denkenz@gmail.com>
In-Reply-To: <87iq5btr0v.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7584719238826024942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Hi,
> =

> after commit a7690918 "huawei: Import huawei rules" my Huawei E1552
> modem doesn't work anymore. The commit has this change:
> =

> -SUBSYSTEMS=3D=3D"usb", ATTRS{bInterfaceNumber}=3D=3D"?*",
>  ENV{OFONO_IFACE_NUM}=3D"$attr{bInterfaceNumber}" +SUBSYSTEMS=3D=3D"usb",
>  ATTRS{bInterfaceNumber}=3D=3D"ff",
>  ENV{OFONO_IFACE_NUM}=3D"$attr{bInterfaceNumber}"

This has now been fixed upstream.

Thanks,
-Denis

--===============7584719238826024942==--

