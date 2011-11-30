Content-Type: multipart/mixed; boundary="===============6843630657455168403=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono with serial modem
Date: Wed, 30 Nov 2011 03:15:48 -0600
Message-ID: <4ED5F444.3090401@gmail.com>
In-Reply-To: <CAC+thW1qhfujn7NDmcWKHiY-BXtUYfvYE12VQdfHwL-k=B7SJg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6843630657455168403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On 12/02/2011 04:52 AM, Andrea Galbusera wrote:
> Hi! I'm new to the list and ofono project. In these days I'm trying to
> figure out if ofono can help me with some embedded projects involving
> M2M GPRS connections on serial modems.
> I have a few questions I was not able to give an answer to, neither
> from wiki nor from doc files in source code. Hope not to bother with
> too newbish questions here!
> =

> 1. Are non-hot-pluggable serial modem supported by ofono? I believe
> they should run with the atmodem driver: is this correct?

Yes they are, however they are still detected via udev and require a
proper modem driver. 'atmodem' is a collection of atom drivers that
implement generic 27.007 functionality.  The difference should be
explained nicely in the presentations posted on the site.

See the calypso modem driver in plugins/calypso.c for an example as well
as doc/calypso-modem.txt for an example udev rule.

> =

> 2. Is udev detection the only way to let ofono know about a modem? If
> I'm not wrong, I read about support for some kind of static
> configuration in the past (modem.conf file), but it seems gone in
> these days. I'm definitely fine with udev: just need some hints on how
> to setup a rule to let ofono know I have a pretty standard AT modem
> on, say, ttyS0. I looked at ofono.rules, but I think it deals mainly
> with usb modem.

A udev rule like:
KERNEL=3D=3D"ttyS0", ENV{OFONO_DRIVER}=3D"your_driver"

should be all that is needed.

> =

> 3. ofono looks very promising for its integration with d-bus. I'm
> looking forward to be able to have different applications to manage
> GPRS context activation/deactivation while, i.e., monitoring signal
> strength and maybe asynchronous notifications by the modem itself. Are
> these tasks in the ofono's scope or not?

Yes all the things you have listed are possible.

> =

> Thanks in advance for any clarifications!
> =


Regards,
-Denis

--===============6843630657455168403==--

