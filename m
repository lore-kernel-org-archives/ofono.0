Content-Type: multipart/mixed; boundary="===============1739015639106527913=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: oFono DUN server issue
Date: Mon, 18 Jun 2012 12:04:37 +0200
Message-ID: <4FDEFD35.1080006@linux.intel.com>
In-Reply-To: <4FDA6F36.6060602@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1739015639106527913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo and Denis.

On 15/06/2012 01:09, Denis Kenzior wrote:
> Hi Gustavo,
>
>>> ofonod[20340]: plugins/udevng.c:remove_device()
>>> /sys/devices/virtual/tty/rfcomm0
>>> ofonod[20340]: plugins/udev.c:remove_modem() =

>>> /devices/virtual/tty/rfcomm0
>
> Actually this looks highly suspicious to me.  What would still be =

> using RFCOMM tty emulation?
>
>> Does this work when you try to connect from a different DUN Client, like
>> dundee, or even trying to open the RFCOMM channel by hand using the =

>> rfcomm
>> tool?
>
> An sdptool dump before starting oFono would be useful as well.
>

Thanks for your help both of you.
I have investigated deeper into this issue with Fr=C3=A9d=C3=A9ric Danis, a=
nd we =

have found that Bluez is publishing a Dial Up Networking Service, =

although oFono is not launched.

Service Name: Dial-up Networking
Service RecHandle: 0x10006
Service Class ID List:
   "Dialup Networking" (0x1103)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 1


When I launch also oFono I have 2 DUN services.

When I try to connect with DUN client it seems we are passing through =

BlueZ DUN service and not the oFono one.
This is explaining the traces with rfcomm0 I have sent.

So DUN service is published by BlueZ using pnat plugin.
The workaround I have found to test oFono DUN server is to disable the =

plugin into BlueZ and then oFono DUN server is working fine.
Now I still don't understand how I could have tested it properly one =

year ago without this workaround.

Kind regards,
Guillaume




--===============1739015639106527913==--

