Content-Type: multipart/mixed; boundary="===============3874142472651149362=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: Running ofono on n900 natively
Date: Tue, 01 Jun 2010 16:29:28 +0300
Message-ID: <AANLkTinDzCCNl-KiHw-WPgYNfsOUQxCY1CyZob5HvO79@mail.gmail.com>
In-Reply-To: <AANLkTimOMrft_pm55xVLQ5ZUbVls0fNWXmH9phLlI6iF@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3874142472651149362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

2010/6/1 Nicola Mfb <nicola.mfb@gmail.com>:
> I'm trying to run ofono on n900 natively, with debian sid installed on
> an external SD card (not using meego just to have an easy build
> environment directly on the device, kernel, modules and firmware
> copied from maemo pr 1.2).
>
> I activated the phonet0 with the command:
>
> /mnt/initfs/sbin/phonet -a 0x6C -i phonet0
>
> With version 0.21 phonet is detected as down:

[snip]

> With version 0.20 phonet is detected up but fails on the mtc driver:

With Pekka's recent patches, oFono is now following link up/down.
Previously it was following the interface up/down events only. But
doesn't really matter, as the modem isn't properly initialized, and
won't work.

> Anyway booting maemo and running the same 0.20 executable in chroot
> works, so I think my debian deploy misses something userspace.
>
> Any hints?

You are missing the proprietary ssc-daemon component.

> Another question, will ofono be able to start phonet without closed
> userspace tools?

Yes.

Pekka is working on an N900 modem plugin for oFono that will take care
of powering the modem HW, and properly initializing it. Now that the
offline patches are upstream, Pekka can hopefully send the N900 plugin
patches soon, too.

Pekka?

Cheers,
Aki

--===============3874142472651149362==--

