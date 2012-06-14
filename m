Content-Type: multipart/mixed; boundary="===============7586039192126190785=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono DUN server issue
Date: Thu, 14 Jun 2012 18:09:42 -0500
Message-ID: <4FDA6F36.6060602@gmail.com>
In-Reply-To: <20120615031139.GC3538@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7586039192126190785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

>> ofonod[20340]: plugins/udevng.c:remove_device()
>> /sys/devices/virtual/tty/rfcomm0
>> ofonod[20340]: plugins/udev.c:remove_modem() /devices/virtual/tty/rfcomm0

Actually this looks highly suspicious to me.  What would still be using =

RFCOMM tty emulation?

> Does this work when you try to connect from a different DUN Client, like
> dundee, or even trying to open the RFCOMM channel by hand using the rfcomm
> tool?

An sdptool dump before starting oFono would be useful as well.

Regards,
-Denis

--===============7586039192126190785==--

