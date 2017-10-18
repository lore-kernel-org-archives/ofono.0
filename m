Content-Type: multipart/mixed; boundary="===============8613003425286744349=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Running ofono on Raspberry Pi and SIM800
Date: Wed, 18 Oct 2017 11:15:52 -0500
Message-ID: <ba886c7a-2ca9-3e91-b874-aba57df297d4@gmail.com>
In-Reply-To: <342291508320198@web43j.yandex.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8613003425286744349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arsenijs,

On 10/18/2017 04:49 AM, Pi=C4=8Dugins Arsenijs wrote:
> Hi!
> =

> I'm interested in running ofono on a Raspberry Pi (BCM2835, 1GHz), connec=
ted to a SIM800 modem over UART (the stable Pi UART, not the MiniUART). I a=
lso have RST, DTR and RESET signals connected to the Pi, and for sound I'm =
using analog audio outputs and inputs of the modem. Basically, I'm talking =
about using ofono in ZeroPhone project - https://hackaday.io/project/19035 .
> =

> For now, I'm interested in 1) notifications about voice call status (not =
concerning audio for now, as it's handled in hardware) 2) SMS and MMS suppo=
rt 3) 2G data connections (whatever available connection types are on 2G ne=
tworks) 4) USSD support. My questions are:
> =

> 1) Is ofono going to be suitable for my needs? I'm more than OK with usin=
g DBus and rolling my own user interface to it.

It supports everything except MMS.  That requires a separate MMS stack =

and is out of scope for oFono.  I don't know of any full-featured open =

source MMS stacks, but I'm probably not paying enough attention.  Maybe =

someone here can give you pointers.

You can take a look at the (now undeveloped) mmsd project to see how the =

MMS stack should interact with oFono:

https://git.kernel.org/pub/scm/network/ofono/mmsd.git/

> 2) How do I run ofono from command-line and tell it to connect to a speci=
fic serial port and use a specific ofono driver?

You write a driver for it and since it is a serial port modem, use udev =

rules to setup the TTY port accordingly.  See doc/sim900-modem.txt for =

an example.  The device detection magic is inside plugins/udevng.c and =

most modem drivers reside in plugins/*.  See the plugins/sim900.c, it =

may be close enough to the sim800 to get you started.

> 3) Do you foresee any necessary changes to ofono? For example, need to ma=
ke a sim800-specific driver?

The most likely answer is yes.  All new modems integrated into oFono =

required 'some' vendor/firmware specific handling.  However, it is not =

possible to answer that unless you have the modem control protocol =

specifications in hand.  If it is a standard AT command based modem, =

then the changes should be minimal.

> 4) I see that Sailfish phones are using ofono as the GSM backend. Did the=
y upstream their changes, or do they have a fork?

They have a fork.

> 5) I'm planning to work with SIM5320 modem in the future, and attempt usi=
ng its USB connection. I know it creates multiple serial ports, and support=
s streaming audio over one of them. Does ofono come into play here, does it=
 have some kind of provisions to convert this kind of audio input/output in=
to actual sound devices under Linux, or is that usually handled by other so=
ftware?

oFono does not handle the audio bits.  We can take care of sending the =

necessary AT commands to the device to configure the codec, etc.  But =

the actual audio processing belongs in your audio daemon.  E.g. =

PulseAudio or whatever.

Regards,
-Denis

--===============8613003425286744349==--

