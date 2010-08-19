Content-Type: multipart/mixed; boundary="===============2472380740314593788=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: About Connection between PPP and linux Sockets
Date: Thu, 19 Aug 2010 12:54:19 +0200
Message-ID: <1282215259.23399.171.camel@localhost.localdomain>
In-Reply-To: <4C6CF9E7.6080206@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2472380740314593788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steven,

> I have a little question just as the title said?
> In Ofono how to connect PPP to Linux socket, when we receive packet from =

> network, how the packet go through the kernel to application=EF=BC=9F
> =

> modem -->PPP-->? --> linux kernel(network part)--> socket --> application?

it is more like this:

modem -> TTY -> PPP -> TUN/TAP -> Kernel Net-Stack -> socket -> application.

With the TTY being in kernel, the PPP being in userspace, and TUN/TAP
etc. begin in the kernel again.

A future enhancement is to use the kernel PPP layer, but we haven't
gotten there yet.

Regards

Marcel



--===============2472380740314593788==--

