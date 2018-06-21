Content-Type: multipart/mixed; boundary="===============0403343164430138173=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Developing a SIM800 plugin - further questions
Date: Thu, 21 Jun 2018 18:54:00 -0500
Message-ID: <e82fb537-45e4-ab86-517f-bfcd4b6a5147@gmail.com>
In-Reply-To: <67311529624253@web6g.yandex.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0403343164430138173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arsenijs,

On 06/21/2018 06:37 PM, Pi=C4=8Dugins Arsenijs wrote:
> I'm now working on a SIM800 plugin, specifically, for a UART-connected SI=
M800
> and a Raspberry Pi Zero. There are minor adjustments that we need to make=
, so
> we've copied the SIM900 plugin to make sure that we can make adjustments =
in
> a clean way (and also compare it to a known-working SIM900 setup). I, too=
, was
> affected by the latest SIM900-related breakage - right now I'm compiling =
to check
> if it's resolved in current git master.

How different is sim800 to sim900?  I would hate to have lots of plugins =

which are only different by a few lines of code...

> =

> Some questions I have are:
> =

> - Is it possible to compile a plugin standalone and then only distribute =
that
> plugin? I'm wondering because Raspbian repositories already ship ofono, a=
nd
> given that ofono already has a plugin infrastructure, it seems counterint=
uitive
> to distribute a separate version of ofono through our repositories just b=
ecause

You could, but it is usually far more trouble than it is worth.  Just =

get your driver upstream and then upstream maintains and includes it as =

part of official releases going forward.

You also can't really utilize the concept of 'vendor quirks' doing it =

this way.  So your plugin would need to reuse existing atom drivers as =

is or implement a brand new version of them and ship them.

> we've added a plugin. I'm asking because it seems that plugins also need =
to be
> hard-coded in the plugins/udevng.c file - so I'd need to recompile ofono =
even if
> I compile the plugin separately... or not? (as we're using udev to enable=
 the
> right plugin, as far as I can tell:
> https://github.com/ZeroPhone/ofono-config/blob/master/51-ofono.rules) Is =
it
> something that could be influenced by the new -p command-line option of o=
fonod
> instead? (which I found after compiling git master and running ofonod --h=
elp).

out-of-tree plugins generally need their own detection logic.  But since =

this is a tty based device, the existing logic would still work...

-p/-P options are really meant for developer / debugging.  Ideally =

whatever you do should not depend on the use of these command line options.

> - judging by lsof output, ofono doesn't open the serial port until Powere=
d is
> set to true (which is what we need), but does not close the serial port a=
fter
> setting Powered to false (which is undesirable for us, since, unfortunate=
ly,
> that same port might be used for debugging). Why? Is it something can be
> influenced by a plugin?

oFono by itself does nothing with serial ports, the drivers do.  So it =

would seem your driver is misbehaving.

> - Latest git master fails to compile on Raspberry Pi, due to
> =

> #pragma GCC diagnostic ignored "-Wrestrict"
> =

> in drivers/rilmodem/call-forwarding.c and
> drivers/rilmodem/network-registration.c . I can provide error output if
> necessary. Is it something expected?

This is the fallout GCC8 support.  Feel free to start a separate thread =

and report these in full.

Regards,
-Denis

--===============0403343164430138173==--

