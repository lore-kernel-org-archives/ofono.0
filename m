Content-Type: multipart/mixed; boundary="===============0112345843996839009=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Some experiments with the SIMCOM SIM5216E modem on a ARM926 board
Date: Thu, 12 Jan 2012 06:12:01 +0100
Message-ID: <1326345121.6454.243.camel@aeonflux>
In-Reply-To: <4F0E5CAD.5070703@eclis.ch>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0112345843996839009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jean-Christian,

> Thanks for your valuable response. Here is an update of the situation.
> =

> >> The modem is connected by the USB and report: vendor=3D0x05c6
> >> product=3D0x9000. This seem to indicate that it use a Qualcomm chip. It
> >> expose 5 serial interfaces, where the 2 and 3 (starting from 0) are for
> >> the AT commands. Since the "atgen" driver is no more, I tested it with
> >> the "g1" driver. It was only a guess and I would like to know if an
> >> other driver is a better choice.
> >
> > you really want to have a custom modem plugin for this chip. It is
> > pretty easy to develop this. Modem plugins are dirt simple to write and
> > that is intentional of course :)
> >
> > I think there was some kind of SIMCOM patch (or similar enough) posted
> > on the mailing list some weeks ago.
> =

> It's a mystery for me if Simcom do there own software or only use the =

> Qualcamm one. The chipset of this modem is the QSC6270 and I expected =

> that ofono already have something appropriate. I suspect the "g1" driver =

> to be a close match and if fact it work already quite well. Are you =

> willing to accept a new modem plugin that is basically a copy of the "g1"=
 ?

I expect a new modem plugin for the sim900. So that approach is fine.

However using the g1 driver as a base is a bad example. That driver is
bit-rotting a lot.

> The "sim900" patch is still not accepted and, I as far as I understand, =

> it don't handle as many feature as the "g1" in the post_sim(). I don't =

> known yet if the two products are close enough to be handled by the same =

> driver. I have asked Simcom about this question an I hope that there =

> will give some indication.

Let me ask this differently. What are the GSM/UMTS features that you
actually need for your product?

> > With USB as transport you really wanna do modem detection via udev. So
> > you might wanna get this solved with uclibc.
> =

> After some additional work I was getting udev working on the target. But =

> understanding how the udev ofono rules should be written for a composite =

> device is really hard. I did not found an example on how this should be =

> done to set both OFONO_DRIVER _and_ OFONO_LABEL. I was also confused by =

> the fact that there is two plugins that handles the udev events: udev =

> and udevng.

Send the section for your device from /sys/kernel/debug/usb/devices. I
can have a look then.

> Should I insist with the udev rules, or something like this (but the =

> "g1") is ok ?

We need something proper. I help you with that. Just need the devices
endpoint descriptors.

> > For the backtrace() support, I am pretty disappointed that uclibc does
> > not support this. It is a fundamental piece that you especially want in
> > embedded system. So this is strange to me.
> >
> > Instead of us working around it, it might be better to get uclibc fixed
> > to support this. On the other hand I am open to look at patches to make
> > this optional.
> =

> I discovered that the last version of uClibc have now the libubactrace. =

> So I updated to it. I can propose this really simple patch to assert the =

> presence of the backtrace call:
> =

>  From 662640e0afb2eb38d896c2673b3afe4c5a280737 Mon Sep 17 00:00:00 2001
> From: Jean-Christian de Rivaz <jc@eclis.ch>
> Date: Wed, 11 Jan 2012 11:39:22 +0100
> Subject: [PATCH] Add autoconfigure rule to search for backtrace().
> =

> Add autoconfigure rule to search for backtrace().
> On system with the uClibc, it can be into the libubacktrace.

This is kinda stupid, but okay.

> ---
>   configure.ac |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/configure.ac b/configure.ac
> index 4115e34..b07544e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -67,6 +67,10 @@ AC_CHECK_FUNC(signalfd, dummy=3Dyes,
>   AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
>   			AC_MSG_ERROR(dynamic linking loader is required))
> =

> +AC_SEARCH_LIBS([backtrace], [execinfo ubacktrace], [], [
> +			AC_MSG_ERROR(backtrace support is required)
> +])
> +

Looks fine to me actually. Send a patch for it.

Regards

Marcel



--===============0112345843996839009==--

