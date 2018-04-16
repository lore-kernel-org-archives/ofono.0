Content-Type: multipart/mixed; boundary="===============0030803612052405340=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/2] gobi: support SMD devices (smartphone SoC)
Date: Mon, 16 Apr 2018 20:16:23 +0200
Message-ID: <AA42F87E-35F4-4D2E-BB2A-09EFE7433D8C@holtmann.org>
In-Reply-To: <600567a6-6de5-814d-2f68-ded55692a1b8@joeyhewitt.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0030803612052405340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joey,

>> I would still fix this upstream and only workaround devices blacklisted =
with a quirk.
> =

> I don't see how this would be possible. The issue with poll() lies in the=
 kernel, not the device. I guess a patched kernel could somehow indicate th=
at it supports poll() for writing, like an attr on the device node.
> =

> OK, there's probably a lot I don't know about rpmsg, and I don't currentl=
y have a device running this setup.

it is a kernel bug for sure and should be fixed there. Not supporting POLLO=
UT properly is just bad.

>> This reminds me also why RPMSG is not actually exported as a socket in t=
he first. Creating a device node first and then using it later is always pr=
one to race conditions. An alternative is to open the control character dev=
ice and turn it into a proper pipe for QMI. I would like to see some proper=
 fixes in the RPMSG subsystem to allow for proper handling by a telephony d=
aemon.
> I don't understand; what is the race condition? oFono plus another client=
 trying to use the same device?
> =

> How would the control device become a QMI pipe? As it stands today, I thi=
nk all you can do with it is open and do that ioctl (https://github.com/tor=
valds/linux/blob/60cc43fc888428bb2f18f08997432d426a243338/drivers/rpmsg/rpm=
sg_char.c#L451). How is the rpmsg endpoint char device not a proper pipe fo=
r QMI, compared to what you're envisioning?
> =

> It sounds like the userspace rpmsg system is not mature enough to do this=
 the way you want. Will we have to wait until then to merge this?

Sadly, I have seen this before where it is not fully thought through. It co=
uld be really great and race free, but seems right now it is only half done=
. So I would start improving RPMSG subsystem.

We can look into working around older kernels (with tons of comments on why=
), but first I would like to see if we can do this properly. So that we don=
=E2=80=99t have to workaround our own workaround once the kernel behaves be=
tter.

Regards

Marcel


--===============0030803612052405340==--

