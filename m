Content-Type: multipart/mixed; boundary="===============1006888728743332732=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 11:13:35 -0500
Message-ID: <201003301113.36166.denkenz@gmail.com>
In-Reply-To: <80fd4e751003300834t57552977r2355e01810ff8964@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1006888728743332732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> Sure.
> =

> I want Powered-1 that controls the atoms. Atoms should be loaded when
> modem is in responsive state and removed when, e.g., modem reboots.
> This we can do now, iow, if you connect a Nokia phone via USB, oFono
> can follow its state via the MTC indications it sends on top of the
> phonet link running over USB.
> =

> I want Powered-2 that controls the modem power. When ofonod starts in
> N900, it should power up the internal modem. When ofonod terminates
> itself, it should shut down modem nicely before calling exit().

So I think I finally understood.  What you're trying to achieve is modem =

presence detection / removal.  The equivalent of what udev / modemconf plug=
ins =

do for oFono.  Except that your modem is always present and you need to pow=
er =

it up / down.

The answer is that exposing this as a property is not going to happen becau=
se =

it is fundamentally wrong.  And in effect it already is exposed, e.g. the f=
act =

that modem object is present in oFono.  You have several options here:

- Create an oFono plugin to listen to an external daemon and create/destroy =

the modem object appropriately
- Create an oFono plugin that will replace the external daemon and =

create/destroy the modem object appropriately
- Implement this properly in the kernel driver and signal device presence v=
ia =

netlink / udev / etc

Regards,
-Denis

--===============1006888728743332732==--

