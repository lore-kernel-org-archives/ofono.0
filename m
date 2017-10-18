Content-Type: multipart/mixed; boundary="===============1034212372950233977=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Running ofono on Raspberry Pi and SIM800
Date: Wed, 18 Oct 2017 11:53:24 -0500
Message-ID: <080ef647-33b2-c6cd-7a9c-8d0004eecd96@gmail.com>
In-Reply-To: <84091508344811@web57j.yandex.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1034212372950233977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arsenijs,

Just FYI, we don't top-post on this mailing list.

On 10/18/2017 11:40 AM, Pi=C4=8Dugins Arsenijs wrote:
> Thank you, that was a great answer. I'll focus on one part for now:
> =

> Is it possible for me to run ofono from command-line, without involving u=
dev? I'm asking this because, in my application, I'm using the UART as a de=
bugging UART for first 30 seconds of phone's boot, then, if there's no acti=
vity (or other trigger set), I enable the GSM modem and run the GSM backend=
. Is there a reason why ofono is not capable to be run this way (provided i=
t's not capable of this)? Is there a way I can just do the setup that udev =
would normally do, but manually? If so, where should I look for pointers - =
code, documentation or somewhere else? (doc/sim900-modem.txt? plugins/udevn=
g.c?)

oFono can be started any time you wish.  udev is just normally used to =

detect the hardware.  Either via probing the USB bus, or in the case of =

serial devices via external configuration (e.g. udev rules).  Without =

udev oFono would not know what TTY corresponds to the modem.  E.g. on =

some platforms it may be ttyS0 and others it would be /dev/ttySAC0, or =

whatever.

The oFono plugins / modem drivers are free to do anything they want.  So =

if you want to hardcode the behavior, that is fine.  You can always =

implement your own detection logic.  For example plugins/phonesim.c uses =

a config file, plugins/rildev.c uses getenv.  The possibilities are endless.

udev is the preferred approach, other approaches might not be palatable =

to upstream.

In terms of documentation or pointers, it really depends on your =

hardware setup.  If you have a traditional AT command based modem with a =

multiplexer, then take a look at doc/calypso-modem.txt and =

plugins/calypso.c.  This is the modem used on the original Freerunner.

If you have multiplexing handled by the kernel, then the SIM900 docs / =

plugin might be applicable.

> =

> Best regards,
> Arsenijs.
> =


Regards,
-Denis

--===============1034212372950233977==--

