Content-Type: multipart/mixed; boundary="===============0773793949349180399=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix set default baud rate to 115200
Date: Tue, 05 Jan 2010 10:32:25 -0600
Message-ID: <201001051032.26241.denkenz@gmail.com>
In-Reply-To: <8B81FACE836F9248894A7844CC0BA814176735A7E6@shzsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0773793949349180399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Hi,
> =

> I found N900 could not be powered on by atgen driver due to baud rate
>  problem. If I add 'Baud=3D115200' into modem.conf, everything is fine. In
>  gatchat/gattty.c, the default baud rate is B0 which looks not correct, so

gattty code sets the serial port into raw mode if no options are given.  Th=
ese =

days it is hard to find a real serial port device that actually needs the =

options setup properly.  Most simply work in raw mode.

>  I wonder whether we should set the default baud rate to some values like
>  minicom does.
> =

> My proposed fix was attached.

The fix should really be inside atgen.c, as it logically belongs there.  Yo=
u =

can make atgen use 'sane' defaults for true serial devices, but then you ne=
ed =

to add capability to put the modem into 'raw' mode.

Regards,
-Denis

--===============0773793949349180399==--

