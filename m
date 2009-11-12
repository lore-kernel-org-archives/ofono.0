Content-Type: multipart/mixed; boundary="===============1227511050786376583=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ppp
Date: Thu, 12 Nov 2009 12:37:30 -0600
Message-ID: <200911121237.30698.denkenz@gmail.com>
In-Reply-To: <4AFC1478.9070801@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1227511050786376583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> Hello,
>
> We need a ppp interface for our modem. I was told on the chat forum that
> a tap/tun device was to be used. Has anyone else started with this or
> thought how to implement this?

We're currently working on a userspace ppp implementation that will integra=
te =

with GAtChat.  The goal here is to make it integrate well with the current =

multiplexed channel capability in GAtMux/GatChat and not need to involve an =

external daemon.

>
> After reading briefly the code from pppd, the implementation, for a
> first draft, is pretty straight forward (w/o encryption, etc. in
> userspace). "Just" dial the apn, and hand over the tty fd to ppp via ioct=
l.
>

Unfortunately it is not that simple.  pppd requires a proper kernel file =

descriptor to hand off to the kernel ppp line discipline.  In our userspace =

implementation that is not the case.  1 kernel file descriptor is shared by =

potentially many GAtChat channels using a multiplexing protocol.  Hence why=
 we =

can't reuse the kernel implementation.

Regards,
-Denis

--===============1227511050786376583==--

