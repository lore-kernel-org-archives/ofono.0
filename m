Content-Type: multipart/mixed; boundary="===============2346546169910457734=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono support for the Telit GC864-QUAD V2 serial port GSM/GPRS
 modem
Date: Wed, 17 Oct 2012 13:44:54 -0500
Message-ID: <507EFCA6.1080905@gmail.com>
In-Reply-To: <20121017210322.617A1550-242D-48C9-854C-9E1733EB9FB3.mhubig@imko.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2346546169910457734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On 10/17/2012 02:13 PM, Markus Hubig wrote:
> On Wed, Oct 17, 2012 at 08:34:21AM -0500, Denis Kenzior wrote:
>> On 10/17/2012 06:28 AM, Markus Hubig wrote:
>>> 1. The one-and-only way to tell oFono to use a modem is by udev rules l=
ike
>>>    this: KERNEL=3D=3D"ttyUSB0", ENV{OFONO_DRIVER}=3D"calypso"
>>>
>> Not the 'only' way, but that is the preferred way.  The KERNEL=3D=3D
>> line tells udev the device to use and OFONO_DRIVER part tells what
>> modem driver to use (e.g. one from plugins/)
>
> e.g. means there are other places where drivers can be found. What exactly
> makes some blob.c a oFono driver? And what's the minimal API I have to
> implement to make a working driver?
>

No, modem drivers are only found in plugins/.  However, there are other =

ways of creating modems besides udev.  However, that is not really =

relevant to this discussion.

The bare minimum API would be probe and remove.  However, that is not =

very useful :)

>>> So in order to write a driver to support the GC864, what would be a good
>>> starting point? Add support for serial port CMUX to the telit driver?
>>>
>> I would create a brand new modem driver, perhaps using calypso as
>> the starting point and go from there.
>
> Hm OK i'll give it at try. But the few docs I found refer havily to the s=
imple
> oFono-API but were can I find it? Inside doc's?
>

The docs are referring to application APIs which are exposed via D-Bus. =

  These are found in the doc/ directory.  There isn't a howto / tutorial =

on how to write a brand new modem driver, however just about everything =

can be figured out by poking around in plugins/.

>>> Looking forward for some advice ...
>>>
>> IRC is also a good place to get (quick) questions answered.
>
> Unfortunately every time I'm on IRC everybody else seems to be asleep ...=
 ;-(
>

Maybe you're in the wrong hemisphere? :)  Most of the (still active) =

people are in the U.S. timezones.

Regards,
-Denis

--===============2346546169910457734==--

