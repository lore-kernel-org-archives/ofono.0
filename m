Content-Type: multipart/mixed; boundary="===============6114066443413765222=="
MIME-Version: 1.0
From: Jomon John <jomon.john@tataelxsi.co.in>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Tue, 07 Jun 2016 07:53:20 +0000
Message-ID: <HK2PR04MB1203E567264B6EC7E6F3B5D9DE5D0@HK2PR04MB1203.apcprd04.prod.outlook.com>
In-Reply-To: <57498B03.7080205@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6114066443413765222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 27.05.2016 21:18, Jomon John wrote:
>> Hi All,
>>
>>>> Did you load module-bluetooth-discover with headset=3Dofono as argumen=
t?
>>>> Normally this should be sufficient to make it work. When the connection
>>>> is established,
>>> Yes, module-bluetooth-discover is loaded, also tried with "ofono" and "=
auto" arguments, but nothing till now.
>>>> pulseaudio automatically loads loopback modules for the phone. You mig=
ht
>>>> have to check if the modules have the correct source / sink.
>>> Could you please provide further more details regrading the source sink=
 setup.
>>>> Additionally to observing the log files, you can debug what is going on
>>>> by using dbus-monitor to see the messages on the dbus.
>> Thanks, SCO transport is working now, even though i cant hear anything o=
n headset sco traffic is visible via btmon during phone call.The issues wer=
e,
>>
>> * The build system(Yocto) was not properly enabling the ofono backend fo=
r pulseaudio, took some time to identify this.
>> * Configured default.pa with proper module name name(module-bluez5-disco=
ver) and arguments
>> * device, module and card restore modules are causing issues, so disable=
d it !!
>>
>> Currently trying to change volume with alsamixer is giving following mes=
sage,
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alsa-plugins-1.0.29/pulse/pulse.c:243:(pul=
se_connect) PulseAudio: Unable to connect: Connection refused
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cannot open mixer: Connection refused
>>
>>
> Did you check with "pacmd list-sinks" and "pacmd list-sources" if the =

> bluetooth sink and source are
> available? Did you check if loopback modules get loaded?
> If they get loaded, please check if they are loaded correctly. There =

> must be one module with source
> set to your phone and sink set to your default sound device and one =

> module in the other direction.
> You should also see some output of the loopback modules in the =

> pulseaudio log.

Thanks for the support, things are getting more and more interesting becaus=
e now,

* A2DP is working fine, but i cant find bluez source or sink in pacmd or pa=
ctl outputs, but same time the loading of module loopback with bluez_source=
 is shown in journalctl logs of pulseaudio.

    module.c: Loaded "module-loopback" (index: #28; argument: "source=3D"bl=
uez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"true" sink_input_properti=
es=3D"media.role=3Dmusic"").

* Same for HFP, nothing related to bluez_* in pactl or pacmd outputs. Again=
 i can see the audio levels changing in pavucontrol (connected from externa=
l machine with PULSE_SERVER) but only one side audio is working which is fr=
om device side mic to other end. on the other side (calling phone to device=
) the levels are changing but seems to be not routed to the default sink (s=
ince the levels are not changing in the default sink)

    Loaded "module-loopback" (index: #30; argument: "source=3D"bluez_source=
.CC_C3_EA_0A_15_90" source_dont_move=3D"true" sink_input_properties=3D"medi=
a.role=3Dphone"").
    card.c: Changed profile of card 1 "bluez_card.CC_C3_EA_0A_15_90" to hea=
dset_audio_gateway

some more information regarding the setup,

* Everything is run as root user who is member of audio and pulse groups
* PA daemon is not in system mode =

* ofono and bluez is available on dbus system bus but pulseaudio is on dbus=
 session bus (is this the right way ??)

Please advice,

With regards,
John J


--===============6114066443413765222==--

