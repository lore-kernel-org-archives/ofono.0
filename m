Content-Type: multipart/mixed; boundary="===============8437606011564391462=="
MIME-Version: 1.0
From: Joey Hewitt <joey@joeyhewitt.com>
Subject: Re: [PATCH 0/2] gobi: support SMD devices (smartphone SoC)
Date: Mon, 16 Apr 2018 11:18:19 -0600
Message-ID: <600567a6-6de5-814d-2f68-ded55692a1b8@joeyhewitt.com>
In-Reply-To: <C8CE41E8-67DD-47F0-BDA2-C5501C611FEC@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8437606011564391462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> I would still fix this upstream and only workaround devices blacklisted w=
ith a quirk.

I don't see how this would be possible. The issue with poll() lies in =

the kernel, not the device. I guess a patched kernel could somehow =

indicate that it supports poll() for writing, like an attr on the device =

node.

OK, there's probably a lot I don't know about rpmsg, and I don't =

currently have a device running this setup.

> This reminds me also why RPMSG is not actually exported as a socket in th=
e first. Creating a device node first and then using it later is always pro=
ne to race conditions. An alternative is to open the control character devi=
ce and turn it into a proper pipe for QMI. I would like to see some proper =
fixes in the RPMSG subsystem to allow for proper handling by a telephony da=
emon.
I don't understand; what is the race condition? oFono plus another =

client trying to use the same device?

How would the control device become a QMI pipe? As it stands today, I =

think all you can do with it is open and do that ioctl =

(https://github.com/torvalds/linux/blob/60cc43fc888428bb2f18f08997432d426a2=
43338/drivers/rpmsg/rpmsg_char.c#L451). =

How is the rpmsg endpoint char device not a proper pipe for QMI, =

compared to what you're envisioning?

It sounds like the userspace rpmsg system is not mature enough to do =

this the way you want. Will we have to wait until then to merge this?

Regards,
Joey

P.S. These patches should probably add the new subsystems to the hotplug =

code, not just the enumeration at startup.

--===============8437606011564391462==--

