Content-Type: multipart/mixed; boundary="===============4189386651317342630=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: query
Date: Thu, 30 Jul 2015 16:21:21 -0500
Message-ID: <55BA9551.6000900@gmail.com>
In-Reply-To: <222E70FA67D72A4FB8EEDF5AF01724ACCF2637@BGSMSX102.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4189386651317342630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ram,

On 07/30/2015 07:49 AM, Kallumari Nagaraja Rao, RammohanX wrote:
> Hi Denis,
>
> Can't we use the existing ofono UBLOX driver to work with serial interfac=
es instead of USB interface ?
>

Not in its current form, no.

USB devices generally come pre-multiplexed.  What this means is that =

they expose multiple AT ports (e.g. ttyACM1, ttyACM2, etc).  oFono =

requires two if the modem uses PPP (which the ublox driver is currently =

using).  This is necessary as a second control port is needed for =

control while another is being occupied by PPP packets.

Serial devices use a single serial port and will require some form of =

multiplexing in order to enable properly.  Most support 07.10/27.010 =

multiplexing via AT+CMUX.

Your options are to write a new modem driver for your device, or extend =

the ublox driver to handle serial devices.  Refer to plugins/ifx.c or =

plugins/calypso.c for an example of a driver that uses multiplexing.

Regards,
-Denis

--===============4189386651317342630==--

