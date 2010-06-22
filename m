Content-Type: multipart/mixed; boundary="===============4905439436900999097=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: commit a7690918 "huawei: Import huawei rules" broke Huawei E1552
Date: Tue, 22 Jun 2010 15:08:08 +0200
Message-ID: <1277212088.2301.155.camel@localhost.localdomain>
In-Reply-To: <87iq5btr0v.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4905439436900999097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> after commit a7690918 "huawei: Import huawei rules" my Huawei E1552
> modem doesn't work anymore. The commit has this change:
> =

> -SUBSYSTEMS=3D=3D"usb", ATTRS{bInterfaceNumber}=3D=3D"?*", ENV{OFONO_IFAC=
E_NUM}=3D"$attr{bInterfaceNumber}"
> +SUBSYSTEMS=3D=3D"usb", ATTRS{bInterfaceNumber}=3D=3D"ff", ENV{OFONO_IFAC=
E_NUM}=3D"$attr{bInterfaceNumber}"
> =

> After I change "ff" back to "?*" my modem works again. What's the reason
> behind this change? Can we revert it back?

I have a similar problem with an E1800 I bought in Italy a few days ago.
Might be an issue with a specific kernel version, but I didn't look into
the details so far.

Regards

Marcel




--===============4905439436900999097==--

