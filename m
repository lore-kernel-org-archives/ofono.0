Content-Type: multipart/mixed; boundary="===============5745676999193734000=="
MIME-Version: 1.0
From: Markus Hubig <mhubig@imko.de>
Subject: Re: oFono support for the Telit GC864-QUAD V2 serial port GSM/GPRS
 modem
Date: Wed, 17 Oct 2012 21:13:56 +0200
Message-ID: <20121017210322.617A1550-242D-48C9-854C-9E1733EB9FB3.mhubig@imko.de>
In-Reply-To: <507EB3DD.4000307@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5745676999193734000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2012 at 08:34:21AM -0500, Denis Kenzior wrote:
> On 10/17/2012 06:28 AM, Markus Hubig wrote:
> >1. The one-and-only way to tell oFono to use a modem is by udev rules li=
ke
> >   this: KERNEL=3D=3D"ttyUSB0", ENV{OFONO_DRIVER}=3D"calypso"
> >
> Not the 'only' way, but that is the preferred way.  The KERNEL=3D=3D
> line tells udev the device to use and OFONO_DRIVER part tells what
> modem driver to use (e.g. one from plugins/)

e.g. means there are other places where drivers can be found. What exactly
makes some blob.c a oFono driver? And what's the minimal API I have to
implement to make a working driver?

> >So in order to write a driver to support the GC864, what would be a good
> >starting point? Add support for serial port CMUX to the telit driver?
> >
> I would create a brand new modem driver, perhaps using calypso as
> the starting point and go from there.

Hm OK i'll give it at try. But the few docs I found refer havily to the sim=
ple
oFono-API but were can I find it? Inside doc's?

> >Looking forward for some advice ...
> >
> IRC is also a good place to get (quick) questions answered.

Unfortunately every time I'm on IRC everybody else seems to be asleep ... ;=
-(

Thank you, Markus

--===============5745676999193734000==--

