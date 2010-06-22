Content-Type: multipart/mixed; boundary="===============4459474070079839899=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: commit a7690918 "huawei: Import huawei rules" broke Huawei E1552
Date: Tue, 22 Jun 2010 11:23:12 +0300
Message-ID: <87iq5btr0v.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4459474070079839899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

after commit a7690918 "huawei: Import huawei rules" my Huawei E1552
modem doesn't work anymore. The commit has this change:

-SUBSYSTEMS=3D=3D"usb", ATTRS{bInterfaceNumber}=3D=3D"?*", ENV{OFONO_IFACE_=
NUM}=3D"$attr{bInterfaceNumber}"
+SUBSYSTEMS=3D=3D"usb", ATTRS{bInterfaceNumber}=3D=3D"ff", ENV{OFONO_IFACE_=
NUM}=3D"$attr{bInterfaceNumber}"

After I change "ff" back to "?*" my modem works again. What's the reason
behind this change? Can we revert it back?

-- =

Kalle Valo

--===============4459474070079839899==--

