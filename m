Content-Type: multipart/mixed; boundary="===============1698855566126963905=="
MIME-Version: 1.0
From: Steven <liu-dj@neusoft.com>
Subject: Re: About Connection between PPP and linux Sockets
Date: Fri, 20 Aug 2010 08:57:49 +0800
Message-ID: <4C6DD30D.6010904@neusoft.com>
In-Reply-To: <1282215259.23399.171.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1698855566126963905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> I have a little question just as the title said?
>> In Ofono how to connect PPP to Linux socket, when we receive packet from =

>> network, how the packet go through the kernel to application=EF=BC=9F
>>
>> modem -->PPP-->? --> linux kernel(network part)--> socket --> applicatio=
n?
> =

> it is more like this:
> =

> modem -> TTY -> PPP -> TUN/TAP -> Kernel Net-Stack -> socket -> applicati=
on.
> =

> With the TTY being in kernel, the PPP being in userspace, and TUN/TAP
> etc. begin in the kernel again.
> =

> A future enhancement is to use the kernel PPP layer, but we haven't
> gotten there yet.

I got it, thanks

B.R

Steven
---------------------------------------------------------------------------=
------------------------
Confidentiality Notice: The information contained in this e-mail and any ac=
companying attachment(s) =

is intended only for the use of the intended recipient and may be confident=
ial and/or privileged of =

Neusoft Corporation, its subsidiaries and/or its affiliates. If any reader =
of this communication is =

not the intended recipient, unauthorized use, forwarding, printing,  storin=
g, disclosure or copying =

is strictly prohibited, and may be unlawful.If you have received this commu=
nication in error,please =

immediately notify the sender by return e-mail, and delete the original mes=
sage and all copies from =

your system. Thank you. =

---------------------------------------------------------------------------=
------------------------

--===============1698855566126963905==--

