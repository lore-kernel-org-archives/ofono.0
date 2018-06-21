Content-Type: multipart/mixed; boundary="===============4528563072389485927=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Pi=C4=8Dugins?= Arsenijs <crimier@yandex.ru>
Subject: Developing a SIM800 plugin - further questions
Date: Fri, 22 Jun 2018 02:37:33 +0300
Message-ID: <67311529624253@web6g.yandex.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4528563072389485927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm now working on a SIM800 plugin, specifically, for a UART-connected SIM8=
00
and a Raspberry Pi Zero. There are minor adjustments that we need to make, =
so
we've copied the SIM900 plugin to make sure that we can make adjustments in
a clean way (and also compare it to a known-working SIM900 setup). I, too, =
was
affected by the latest SIM900-related breakage - right now I'm compiling to=
 check
if it's resolved in current git master.

Some questions I have are:

- Is it possible to compile a plugin standalone and then only distribute th=
at
plugin? I'm wondering because Raspbian repositories already ship ofono, and
given that ofono already has a plugin infrastructure, it seems counterintui=
tive
to distribute a separate version of ofono through our repositories just bec=
ause
we've added a plugin. I'm asking because it seems that plugins also need to=
 be
hard-coded in the plugins/udevng.c file - so I'd need to recompile ofono ev=
en if
I compile the plugin separately... or not? (as we're using udev to enable t=
he
right plugin, as far as I can tell:
https://github.com/ZeroPhone/ofono-config/blob/master/51-ofono.rules) Is it
something that could be influenced by the new -p command-line option of ofo=
nod
instead? (which I found after compiling git master and running ofonod --hel=
p).
- judging by lsof output, ofono doesn't open the serial port until Powered =
is
set to true (which is what we need), but does not close the serial port aft=
er
setting Powered to false (which is undesirable for us, since, unfortunately,
that same port might be used for debugging). Why? Is it something can be
influenced by a plugin?
- Latest git master fails to compile on Raspberry Pi, due to

#pragma GCC diagnostic ignored "-Wrestrict"

in drivers/rilmodem/call-forwarding.c and
drivers/rilmodem/network-registration.c . I can provide error output if
necessary. Is it something expected?

Cheers!
Arsenijs

--===============4528563072389485927==--

