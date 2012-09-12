Content-Type: multipart/mixed; boundary="===============2236498548745552176=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Getting started (serial GPRS modem)
Date: Tue, 11 Sep 2012 23:49:28 -0500
Message-ID: <50501458.3050003@gmail.com>
In-Reply-To: <CAK2MJLofabWuABc8vOnZ+tF_p4nMHugoMoSYTmK1wm0KFE3+EQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2236498548745552176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Erik,

On 09/11/2012 08:17 AM, Erik wrote:
> Hi!
>
> I've been looking at ofono for quite some time now. A couple of years
> ago I wrote a lot of code to interface a GPRS modem. Now I need to do
> basically the same again and I wonder if ofono would be a good idea to us=
e.
>
> The modem is not supported by ofono out of the box (no driver for it in
> the tree).
>
> First of all, I must say that I really miss some kind of "getting
> started" information on the home page. Maybe I have just not found it.
> Is there such a thing?
>

Formal getting started documentation is lacking at the moment. =

Documentation contributions are always welcome ;)

There are plenty of working examples to learn from however.

> Second, the modem is a serial GPRS modem connected through a serial
> line. This has to be farily common. Isn't there a simple way of just
> testing ofono without adding udev rules, writing drivers, etc? What I
> would like is basically to start ofonod with a path to the serial
> device, telling it to use only standard (not device-specific) AT commands.

We have tried that, unfortunately we have yet to encounter a piece of =

hardware that can be driven entirely using standard AT commands.  There =

are too many vendor commands and behavioral quirks that have to be =

accounted for.

>
> I don't think what I'd like to do is possible. So I added an udev rule
> in the form of:
>
> KERNEL=3D=3D"ttyUSB*", ENV{OFONO_DRIVER}=3D"nokia"

Are you picking a driver at random or is it indeed a Nokia modem?

>
> This gives me some indication that something happens when I start ofonod:
>
> ofonod[21742]: plugins/udev.c:add_modem()
> /devices/pci0000:00/0000:00:06.0/usb2/2-2/2-2:1.0/ttyUSB0/tty/ttyUSB0
> (atmodem)
>
> How do I proceed from here?
>
> test/llist-modems gives me nothing.
>
> Do the existing drivers check that the modem is actually a modem of that
> type (nokia in this case)?

No, but the list of modem drivers that support a serial port is only a =

subset of all the drivers available.  See add_modem() function in =

plugins/udev.c for more details.  The subset is currently limited to =

ifx, calypso, tc65, wavecom, sim900 and a few others.  These devices are =

true serial port devices and frequently require multiplexing, etc.

>
> I am not looking for anything fancy. I basically only want to set up a
> GPRS connection and maybe do operator selection.
> No voice, no SMS, nothing more.

If you're wanting GPRS on a true serial port based device, then you =

definitely need to write your own modem driver for it.  GPRS requires =

multiple AT ports to drive successfully which requires multiplexing =

(e.g. via CMUX).  Multiplexing details are frequently vendor-specific, =

so these have to be handled in your driver.

Regards,
-Denis

--===============2236498548745552176==--

