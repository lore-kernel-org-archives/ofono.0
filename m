Content-Type: multipart/mixed; boundary="===============1581055140338070458=="
MIME-Version: 1.0
From: DJDAS <djdas@djdas.net>
Subject: Re: How to talk with FreeRunner?
Date: Tue, 20 Oct 2009 11:05:11 +0200
Message-ID: <4ADD7D47.6090502@djdas.net>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001B11DDFC4@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1581055140338070458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Gu, Yang ha scritto:
> Very glad to hear this! Definitely I'm also interested with your steps to=
 build oFono, and get it work within FR. By the way, which OS and version a=
re you using?
>
> Regards,
> -Yang
>   =


Hi,
it's quite simple (joking :P)! We prepared a VirtualBOX VM (starting =

from one prepared by a member of the Openmoko community list) with a =

toolchain similar to the one described in the OM wiki page mentioned =

earlier in this thread but rebuilt from OpenEmbedded git repository. =

After this I downloaded the sources (tried both stable release and git =

snapshots) and it's a matter of ./configure && make && make install ;)
If the list policy will let me send attachments I can send you the =

package for the 0.7 version.
The test environment is a prototype we realized from scratch (distro =

name: Neophysis, prototype code name: Armeniacum-RC2) and it's the core =

with nothing more than the rootfs with some basic libraries, busybox, =

monolithic kernel 2.6.29, dbus and, obviously, ofonod starting quite =

after kernel boot. The startup time is about 15 secs with a X window =

system without window managers (but we can provide a simple matchbox =

package or, since yesterday ;) Echinos).
Our target is to have a system booting in less than 35-40 secs with all =

the phone system up and running.
At the moment I tested the phone functionalities (calling and receiving =

simple voice calls, sending and receiving sms) using dbus commands from =

the console and it works very well with the modem registered (no PIN in =

the SIM) in about 15-20 secs.
I was wondering if someone can provide us a simple C application to test =

all the phone functionalities (OTOA the dbus notifications) because we =

are very busy at the moment (we work on Neophysis on our spare time and =

are about 10 people divided in development, graphics, system engineering =

and documentation) and have no time to write down a proto in C language, =

I saw in the sources the test applications are written in Python but we =

haven't build the Python package yet so a C app would be very useful.
Thank you in advance, bye.


--===============1581055140338070458==--

