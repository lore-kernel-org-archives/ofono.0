Content-Type: multipart/mixed; boundary="===============6842778464566303046=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: ppp
Date: Thu, 12 Nov 2009 19:42:10 +0100
Message-ID: <4AFC5702.50406@gmail.com>
In-Reply-To: <200911121237.30698.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6842778464566303046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Denis Kenzior wrote:
> Hi Ryan,
> =

>> Hello,
>>
>> We need a ppp interface for our modem. I was told on the chat forum that
>> a tap/tun device was to be used. Has anyone else started with this or
>> thought how to implement this?
> =

> We're currently working on a userspace ppp implementation that will integ=
rate =

> with GAtChat.  The goal here is to make it integrate well with the curren=
t =

> multiplexed channel capability in GAtMux/GatChat and not need to involve =
an =

> external daemon.
> =


Wow. So ofono will not use the kernel space ppp and implement the ppp =

stack in userspace?

>> After reading briefly the code from pppd, the implementation, for a
>> first draft, is pretty straight forward (w/o encryption, etc. in
>> userspace). "Just" dial the apn, and hand over the tty fd to ppp via ioc=
tl.
>>
> =

> Unfortunately it is not that simple.  pppd requires a proper kernel file =

> descriptor to hand off to the kernel ppp line discipline.  In our userspa=
ce =

> implementation that is not the case.  1 kernel file descriptor is shared =
by =

> potentially many GAtChat channels using a multiplexing protocol.  Hence w=
hy we =

> can't reuse the kernel implementation.
> =


Yea. That's right.

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============6842778464566303046==--

