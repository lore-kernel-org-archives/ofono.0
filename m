Content-Type: multipart/mixed; boundary="===============8339386923478271410=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] Add support of Huawei EM770 modem
Date: Fri, 12 Feb 2010 02:53:51 +0100
Message-ID: <fb249edb1002111753v24cb1b5i10a38a1b02baf08a@mail.gmail.com>
In-Reply-To: <1EC975D79B8B1F4BBDC50EA54418A004125A3D3709@shzsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8339386923478271410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11 February 2010 06:54, Gu, Yang <yang.gu@intel.com> wrote:
> In oFono code, "device4" represents the modem, while "device1" is the ude=
v_device when calling function add_huawei_em770(modem, udev_device). When I=
 check if it's ttyUSB2 or not in my code, I think I'm checking the device1 =
and its sysname (Showed as KERNEL in device1, but not the one showed in /de=
v directory), and in the context of this modem (device4). I do believe ther=
e may be some other ttyUSB2 in the system, for example, we have another em7=
70 modem pluged in. But these two ttyUSB2 are in different context. I ever =
tried to change the name showed in /dev directory by writing some udev rule=
s, but this sysname (KERNEL) seems stable (It's still ttyUSB2). Is it possi=
ble this sysname gets changed under some circumstance expect the kernel or =
driver changes? If not, I still think it's safe and convenient to check thi=
s value here.

Honestly I don't know.  But the whole /dev path may change between
kernel versions, for example I believe "ttyUSB" was "ttyU" a long time
ago (I'm not 100% sure).  So in my opinion the safe way is to compare
the "bInetrfaceNumber" and "configuration" of the parent devices to
"02" and "Huawei  Configuration".

Best regards

--===============8339386923478271410==--

