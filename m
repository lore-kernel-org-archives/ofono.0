Content-Type: multipart/mixed; boundary="===============5899739444671833803=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: Re: [PATCH] udevng: Add OFONO_PATHNAME property to set modem dbus
 path name
Date: Wed, 14 Feb 2018 19:15:43 +0100
Message-ID: <8a76763c-0667-8730-f612-f3c998183cd2@sysmocom.de>
In-Reply-To: <537fc659-a482-c828-e5aa-fed89350f132@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5899739444671833803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 14/02/18 18:04, Denis Kenzior wrote:
> =

> This sounds like a very specific non-real world usecase, right?=C2=A0 I m=
ean =

> why don't you simply compare the IMEI if you really care?

First of all, I like thinking that I'm part of the real world!

As far as I understand the IMEI is available in =

org.ofono.Modem.GetProperties "Serial" property. To be able to access =

this information, I need to previously power on the modem (SetProperty =

Powered true), otherwise it doesn't show up.
Which means that for an ofono user, it is a requirement to power on the =

modem and thus use it before being able to identify it.

Simple case: Several modems attached to a PC, in order to find the one =

I'm interested in I need to power on all of them and find which one =

matches a given IMEI. Really? Do I need this if I know where is my =

device always physically attached? Are you going through all your =

network interfaces and check against its MAC address to find the one you =

are interested in? Or you configure your network manager based on =

interface names? Would you enjoy it if your enp0s25 interface was =

suddenly named enp1s67? Specially if you have iptables rules, I bet =

that's going to be funny.

More complex case (my scenario): Again, I repeat: To identify a modem, =

as of now, you seem to require to power it on (use it, change its state) =

before identifying it. Now think of a system which has a config file =

with modems available on the system (with its dbus paths) and a =

resources database of modems (and other types of resources) currently in =

use. Now imagine several processes reserving any specific subset of =

modems with specific capabilities (in parallel) against the resources =

database, then using them and among the use cases they power off and =

power them on. Even if you have locking mechanism in the database, it's =

a nightmare, because again, you must use a modem before identifying it, =

meaning you either race condition with other processes using the modem =

you are identifying (eg. by powering it on, or leaving it powered on =

after identifying it, or while powering it off after identifying while =

other process is starting to use it).

Then the easy way: Each modem is assigned a unique persistent path, and =

that's the one always being presented and used. No need to identify it, =

I already know which modem is which. If I have several system setups, I =

can assign same names in all systems for easy use, etc.

So the question should be better: Why should it NOT be deterministic?


> =

> How are you making sure that dbus path is valid?=C2=A0=C2=A0 ofono_modem_=
create =

> can fail after all...

Yes, it can fail while validating the path (dbus_validate_path) which is =

expected if a bad OFONO_PATHMNAME is supplied. If it's fine for you, I =

can add an error message there stating that dbus_validate_path failed =

and printing the pathname. Agree?

-- =

- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte

--===============5899739444671833803==--

