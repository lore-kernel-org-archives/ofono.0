Content-Type: multipart/mixed; boundary="===============4463853958811520164=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Pi=C4=8Dugins?= Arsenijs <crimier@yandex.ru>
Subject: Re: Running ofono on Raspberry Pi and SIM800
Date: Wed, 18 Oct 2017 19:40:11 +0300
Message-ID: <84091508344811@web57j.yandex.ru>
In-Reply-To: <ba886c7a-2ca9-3e91-b874-aba57df297d4@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4463853958811520164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thank you, that was a great answer. I'll focus on one part for now:

Is it possible for me to run ofono from command-line, without involving ude=
v? I'm asking this because, in my application, I'm using the UART as a debu=
gging UART for first 30 seconds of phone's boot, then, if there's no activi=
ty (or other trigger set), I enable the GSM modem and run the GSM backend. =
Is there a reason why ofono is not capable to be run this way (provided it'=
s not capable of this)? Is there a way I can just do the setup that udev wo=
uld normally do, but manually? If so, where should I look for pointers - co=
de, documentation or somewhere else? (doc/sim900-modem.txt? plugins/udevng.=
c?)

Best regards,
Arsenijs.

18.10.2017, 19:15, "Denis Kenzior" <denkenz@gmail.com>:
> Hi Arsenijs,
>
> On 10/18/2017 04:49 AM, Pi=C4=8Dugins Arsenijs wrote:
>> =C2=A0Hi!
>>
>> =C2=A0I'm interested in running ofono on a Raspberry Pi (BCM2835, 1GHz),=
 connected to a SIM800 modem over UART (the stable Pi UART, not the MiniUAR=
T). I also have RST, DTR and RESET signals connected to the Pi, and for sou=
nd I'm using analog audio outputs and inputs of the modem. Basically, I'm t=
alking about using ofono in ZeroPhone project - https://hackaday.io/project=
/19035 .
>>
>> =C2=A0For now, I'm interested in 1) notifications about voice call statu=
s (not concerning audio for now, as it's handled in hardware) 2) SMS and MM=
S support 3) 2G data connections (whatever available connection types are o=
n 2G networks) 4) USSD support. My questions are:
>>
>> =C2=A01) Is ofono going to be suitable for my needs? I'm more than OK wi=
th using DBus and rolling my own user interface to it.
>
> It supports everything except MMS. That requires a separate MMS stack
> and is out of scope for oFono. I don't know of any full-featured open
> source MMS stacks, but I'm probably not paying enough attention. Maybe
> someone here can give you pointers.
>
> You can take a look at the (now undeveloped) mmsd project to see how the
> MMS stack should interact with oFono:
>
> https://git.kernel.org/pub/scm/network/ofono/mmsd.git/
>
>> =C2=A02) How do I run ofono from command-line and tell it to connect to =
a specific serial port and use a specific ofono driver?
>
> You write a driver for it and since it is a serial port modem, use udev
> rules to setup the TTY port accordingly. See doc/sim900-modem.txt for
> an example. The device detection magic is inside plugins/udevng.c and
> most modem drivers reside in plugins/*. See the plugins/sim900.c, it
> may be close enough to the sim800 to get you started.
>
>> =C2=A03) Do you foresee any necessary changes to ofono? For example, nee=
d to make a sim800-specific driver?
>
> The most likely answer is yes. All new modems integrated into oFono
> required 'some' vendor/firmware specific handling. However, it is not
> possible to answer that unless you have the modem control protocol
> specifications in hand. If it is a standard AT command based modem,
> then the changes should be minimal.
>
>> =C2=A04) I see that Sailfish phones are using ofono as the GSM backend. =
Did they upstream their changes, or do they have a fork?
>
> They have a fork.
>
>> =C2=A05) I'm planning to work with SIM5320 modem in the future, and atte=
mpt using its USB connection. I know it creates multiple serial ports, and =
supports streaming audio over one of them. Does ofono come into play here, =
does it have some kind of provisions to convert this kind of audio input/ou=
tput into actual sound devices under Linux, or is that usually handled by o=
ther software?
>
> oFono does not handle the audio bits. We can take care of sending the
> necessary AT commands to the device to configure the codec, etc. But
> the actual audio processing belongs in your audio daemon. E.g.
> PulseAudio or whatever.
>
> Regards,
> -Denis

--===============4463853958811520164==--

