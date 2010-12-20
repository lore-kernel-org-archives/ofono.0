Content-Type: multipart/mixed; boundary="===============3029916635181020742=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PATCH: Enable udev-based autodetection of calypso modem on
 Freerunner
Date: Mon, 20 Dec 2010 17:39:55 -0600
Message-ID: <4D0FE94B.1010502@gmail.com>
In-Reply-To: <87ipyud6tb.fsf@ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3029916635181020742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On 12/15/2010 04:12 PM, Neil Jerram wrote:
> Hi all,
> =

> With the patch below, ofono-0.36 (the current Debian unstable version)
> detects the calypso modem on my freerunner.  (Whereas without it, it
> doesn't.)

We prefer if you use git send-email to format the patch for submission.
 For now I applied your patch without the ofono.rules changes.

> =

> I don't feel confident that the ofono.rules change is in its nicest
> possible form, and (IIUC) it's dependent on these earlier rules in
> /lib/udev/rules.d/55-openmoko-gta01-gta02.rules on my phone:
> =

> # Samsung UARTS
> KERNEL=3D=3D"s3c2410_serial[0-9]",   NAME=3D"ttySAC%n"
> KERNEL=3D=3D"ttySAC[0-9]",   NAME=3D"ttySAC%n"
> =

> Given that the actual udev DB entry, under 2.6.34, is:
> =

> P: /devices/platform/s3c2440-uart.0/tty/ttySAC0
> N: ttySAC0
> S: char/204:64
> E: UDEV_LOG=3D3
> E: DEVPATH=3D/devices/platform/s3c2440-uart.0/tty/ttySAC0
> E: MAJOR=3D204
> E: MINOR=3D64
> E: DEVNAME=3D/dev/ttySAC0
> E: SUBSYSTEM=3Dtty
> E: DEVLINKS=3D/dev/char/204:64
> =


I think the better way would be to drop a udev rule directly into
/etc/udev.d or similar.  The rule should be as simple as:
KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"calypso"

Let me know if this works for you and I can add a comment in the calypso
plugin.

Reg

--===============3029916635181020742==--

