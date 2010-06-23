Content-Type: multipart/mixed; boundary="===============6694831163185365838=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: commit a7690918 "huawei: Import huawei rules" broke Huawei E1552
Date: Wed, 23 Jun 2010 09:23:57 +0300
Message-ID: <87aaqmtgg2.fsf@potku.valot.fi>
In-Reply-To: <201006220947.05022.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6694831163185365838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Kalle,

Hi Denis,

>> after commit a7690918 "huawei: Import huawei rules" my Huawei E1552
>> modem doesn't work anymore. The commit has this change:
>> =

>> -SUBSYSTEMS=3D=3D"usb", ATTRS{bInterfaceNumber}=3D=3D"?*",
>>  ENV{OFONO_IFACE_NUM}=3D"$attr{bInterfaceNumber}" +SUBSYSTEMS=3D=3D"usb",
>>  ATTRS{bInterfaceNumber}=3D=3D"ff",
>>  ENV{OFONO_IFACE_NUM}=3D"$attr{bInterfaceNumber}"
>
> This has now been fixed upstream.

I tested the current git version and I can confirm it works now. Thank
you for fixing this.

-- =

Kalle Valo

--===============6694831163185365838==--

