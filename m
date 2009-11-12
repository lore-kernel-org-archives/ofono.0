Content-Type: multipart/mixed; boundary="===============7666381045696639623=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: ppp
Date: Thu, 12 Nov 2009 14:58:16 +0100
Message-ID: <4AFC1478.9070801@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7666381045696639623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We need a ppp interface for our modem. I was told on the chat forum that =

a tap/tun device was to be used. Has anyone else started with this or =

thought how to implement this?

After reading briefly the code from pppd, the implementation, for a =

first draft, is pretty straight forward (w/o encryption, etc. in =

userspace). "Just" dial the apn, and hand over the tty fd to ppp via ioctl.

Steps (borrowed from pppd):

1. Dial the apn (in ofonod).
2. Some synchronization code.
3. hand over tty fd to ppp driver via ioctl. the IP.

I know i am simplifying the process.

Is this the way to go?


Regards,
Ryan

--===============7666381045696639623==--

