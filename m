Content-Type: multipart/mixed; boundary="===============7925403643143021546=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Getting started (serial GPRS modem)
Date: Wed, 12 Sep 2012 08:35:39 -0500
Message-ID: <50508FAB.2030609@gmail.com>
In-Reply-To: <CAK2MJLqFZqRqk8e-PKE9xQU9NuRE8ZpwbnH9tYdW5_wGnwT_rg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7925403643143021546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Erik,

> I picked a driver at random. What I was looking for was basically to see
> if I could at least see some trace of AT commands being sent. I'll care a=
bout
> if they are the right ones when I understand how stuff work. Something
> apparently understood that it should use the port I specified. What happe=
ns
> next? I understand that list-modems ends up doing some dbus magic
> in src/manager.c but I haven't really figured out more. Any hints on debu=
gging
> except running ofono with the -d option? Should I be using some dbus
> tracing utility? I have no experience *at all* of using dbus myself. i ba=
sically
> know more or less what it is but not more than that.

There's d-feet and the like for tracing D-Bus, however most everything =

can be done using the included test scripts in ofono/test.  e.g. =

monitor-ofono, list-modems, etc.

The modem detection logic is handled in plugins/udevng.c and =

plugins/udev.c  You want to modify the latter which takes care of serial =

tty based devices.  Create a new modem driver and add it to the =

add_modem function.  Your udev changes seem fine.

> Hm. I wouldn't say GPRS *requires* multiplexing. I've written a GSM0710 M=
UX
> code before and I know that my current modem supports it (I even made sure
> to get the specification for it when we selected this modem) but surely i=
t's
> possible to set up a GPRS connection without it, even though such a setup
> is quite limited.

For all practical purposes it does, unless you feel like giving even =

basic things like signal strength reporting while the context is active. =

  You can try to write a driver without it, and it should even work. =

However, oFono has multiplexing support already assuming your modem is =

07.10 compliant.  See plugins/calypso.c on how to setup the multiplexer.

>
> I found Android's reference-ril code (not trying to offend anyone, not su=
re
> about any potential religious wars going on here) which seems really
> simple. I'll see if that might suit my immediate needs better. But I have=
n't
> written off ofono yet.
>
> I suppose what I'm looking for is a really quick way of doing what I can =
do
> with chat and pppd but with potential of doing much more in the future.
>

I doubt you can enable a modem faster with any other stack out there =

today.  You do need to write about 500 lines of code for a new modem =

driver though ;)

Regards,
-Denis

--===============7925403643143021546==--

