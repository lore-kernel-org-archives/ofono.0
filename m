Content-Type: multipart/mixed; boundary="===============3764857191496797307=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Sat, 28 May 2016 14:11:47 +0200
Message-ID: <57498B03.7080205@chini.tk>
In-Reply-To: <HK2PR04MB120320665835D1863933DB6DDE420@HK2PR04MB1203.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3764857191496797307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 27.05.2016 21:18, Jomon John wrote:
> Hi All,
>
>>> Did you load module-bluetooth-discover with headset=3Dofono as argument?
>>> Normally this should be sufficient to make it work. When the connection
>>> is established,
>> Yes, module-bluetooth-discover is loaded, also tried with "ofono" and "a=
uto" arguments, but nothing till now.
>>> pulseaudio automatically loads loopback modules for the phone. You might
>>> have to check if the modules have the correct source / sink.
>> Could you please provide further more details regrading the source sink =
setup.
>>> Additionally to observing the log files, you can debug what is going on
>>> by using dbus-monitor to see the messages on the dbus.
> Thanks, SCO transport is working now, even though i cant hear anything on=
 headset sco traffic is visible via btmon during phone call.The issues were,
>
> * The build system(Yocto) was not properly enabling the ofono backend for=
 pulseaudio, took some time to identify this.
> * Configured default.pa with proper module name name(module-bluez5-discov=
er) and arguments
> * device, module and card restore modules are causing issues, so disabled=
 it !!
>
> Currently trying to change volume with alsamixer is giving following mess=
age,
>
>      alsa-plugins-1.0.29/pulse/pulse.c:243:(pulse_connect) PulseAudio: Un=
able to connect: Connection refused
>      cannot open mixer: Connection refused
>
>
Did you check with "pacmd list-sinks" and "pacmd list-sources" if the =

bluetooth sink and source are
available? Did you check if loopback modules get loaded?
If they get loaded, please check if they are loaded correctly. There =

must be one module with source
set to your phone and sink set to your default sound device and one =

module in the other direction.
You should also see some output of the loopback modules in the =

pulseaudio log.

--===============3764857191496797307==--

