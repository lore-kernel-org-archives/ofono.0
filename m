Content-Type: multipart/mixed; boundary="===============5995542036606418681=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add support of Huawei EM770 modem
Date: Wed, 10 Feb 2010 16:37:31 -0600
Message-ID: <201002101637.32713.denkenz@gmail.com>
In-Reply-To: <1EC975D79B8B1F4BBDC50EA54418A00412219846A9@shzsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5995542036606418681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> There are two known parts of code that may have problem and need your
>  comments. 1. Once connecting this modem to PC via USB, we can get 5 tty
>  ports: ttyUSB0, ttyUSB1, ttyUSB2, ttyUSB3 and ttyUSB4. The correct way to
>  talk to this modem is using ttyUSB2. I'm not sure if I handled this
>  correctly in file udev.c. 2. When creating the modem, a global modem id

So Andrew had it exactly correct, you can't just use ttyUSB2 here.  Most =

devices have other udev attributes you can examine for what type of port it =

is, to help you pick the right one.  Perhaps examination of 'udevadm info --
attribute-walk --path=3D<device>' might be in order?

>  will be appended to the name of it while constructing the path. This mod=
em
>  has name "huawei_em770", thus the path becomes things like
>  "/huawei_em7700" or "/huawei_em7701". This looks strange. Need I change
>  the name of this modem, or can we use some smarter way to append the mod=
em
>  id?

We should be using the udev short serial from the device.  For some reason =

this seems to be failing on the EM770.  Can you check whether get_serial =

returns NULL for this device?

Regards,
-Denis

--===============5995542036606418681==--

