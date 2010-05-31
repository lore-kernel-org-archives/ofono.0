Content-Type: multipart/mixed; boundary="===============6987676678120057947=="
MIME-Version: 1.0
From: Florian Steinel <florian.steinel@googlemail.com>
Subject: Re: [PATCH 1/1] Huawei E176: Mark primary and secondary device at
 ofono.rules TODO: Fix sim_add detection, add E1552 idProduct to ofono.rules
Date: Mon, 31 May 2010 17:57:33 +0000
Message-ID: <AANLkTikiMMCpVcXEqAxL0iinBknLbrO7283op_-I1ygD@mail.gmail.com>
In-Reply-To: <87hblo2r0o.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6987676678120057947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

2010/5/31, Kalle Valo <kalle.valo@canonical.com>:
> Hi Florian,
>
> thank you for the patch.
>
> I'm curious, did you test ofono with Huawei E176? Did it work? Did you
> have any problems?
I have testet ofono with Huawei E176, enabled the modem with the
enable-modem script and it doesn't register the sim-card.
The EventChannel logs:
May 30 17:29:34 server ofonod[27315]: > ATE0\r
May 30 17:29:34 server ofonod[27315]: EventChannel: <
\r\n^BOOT:20496466,0,2,0,25\r\n
May 30 17:29:34 server ofonod[27315]: < \r\nOK\r\n
May 30 17:29:34 server ofonod[27315]: EventChannel: <
\r\n^RSSI:99\r\n\r\n^SRVST:0\r\n\r\n^MODE:0,0\r\n\r\n^RSSI:10\r\n\r\n^SRVST=
:1\r\n\r\n^MODE:5,4\r\n\r\n^RSSI:7\r\n\r\n^BOOT:20496466,0,0,0,25\r\n\r\n^R=
SSI:11\r\n\r\n^BOOT:20496466,0,0,0,25\r\n\r

> I think adding usb ids to the rules file for each Huawei product is a
> maintenance problem. There are so many devices out there, that handling
> the usb ids for all of them is difficult.
>
> I personally would prefer a solution which would dynamically probe the
> ports and choose them based on results. I believe modemmanager does
> something like this, but I haven't looked in detail.

I will try to implemt the fix mentioned in this thread,

Florian Steinel

--===============6987676678120057947==--

