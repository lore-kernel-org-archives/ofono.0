Content-Type: multipart/mixed; boundary="===============6056364436284296165=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Tue, 07 Jun 2016 10:31:50 +0200
Message-ID: <57568676.6060603@chini.tk>
In-Reply-To: <HK2PR04MB1203E567264B6EC7E6F3B5D9DE5D0@HK2PR04MB1203.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6056364436284296165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07.06.2016 09:53, Jomon John wrote:
> Hi,
>
> On 27.05.2016 21:18, Jomon John wrote:
>>> Hi All,
>>>
>>>>> Did you load module-bluetooth-discover with headset=3Dofono as argume=
nt?
>>>>> Normally this should be sufficient to make it work. When the connecti=
on
>>>>> is established,
>>>> Yes, module-bluetooth-discover is loaded, also tried with "ofono" and =
"auto" arguments, but nothing till now.
>>>>> pulseaudio automatically loads loopback modules for the phone. You mi=
ght
>>>>> have to check if the modules have the correct source / sink.
>>>> Could you please provide further more details regrading the source sin=
k setup.
>>>>> Additionally to observing the log files, you can debug what is going =
on
>>>>> by using dbus-monitor to see the messages on the dbus.
>>> Thanks, SCO transport is working now, even though i cant hear anything =
on headset sco traffic is visible via btmon during phone call.The issues we=
re,
>>>
>>> * The build system(Yocto) was not properly enabling the ofono backend f=
or pulseaudio, took some time to identify this.
>>> * Configured default.pa with proper module name name(module-bluez5-disc=
over) and arguments
>>> * device, module and card restore modules are causing issues, so disabl=
ed it !!
>>>
>>> Currently trying to change volume with alsamixer is giving following me=
ssage,
>>>
>>>        alsa-plugins-1.0.29/pulse/pulse.c:243:(pulse_connect) PulseAudio=
: Unable to connect: Connection refused
>>>        cannot open mixer: Connection refused
>>>
>>>
>> Did you check with "pacmd list-sinks" and "pacmd list-sources" if the
>> bluetooth sink and source are
>> available? Did you check if loopback modules get loaded?
>> If they get loaded, please check if they are loaded correctly. There
>> must be one module with source
>> set to your phone and sink set to your default sound device and one
>> module in the other direction.
>> You should also see some output of the loopback modules in the
>> pulseaudio log.
> Thanks for the support, things are getting more and more interesting beca=
use now,
>
> * A2DP is working fine, but i cant find bluez source or sink in pacmd or =
pactl outputs, but same time the loading of module loopback with bluez_sour=
ce is shown in journalctl logs of pulseaudio.
>
>      module.c: Loaded "module-loopback" (index: #28; argument: "source=3D=
"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"true" sink_input_prope=
rties=3D"media.role=3Dmusic"").
Mh, that is strange, pacmd list-sources should definitely show the bluez =

source, you can see from
the arguments of the loopback module that the source exists.

>
> * Same for HFP, nothing related to bluez_* in pactl or pacmd outputs. Aga=
in i can see the audio levels changing in pavucontrol (connected from exter=
nal machine with PULSE_SERVER) but only one side audio is working which is =
from device side mic to other end. on the other side (calling phone to devi=
ce) the levels are changing but seems to be not routed to the default sink =
(since the levels are not changing in the default sink)
>
>      Loaded "module-loopback" (index: #30; argument: "source=3D"bluez_sou=
rce.CC_C3_EA_0A_15_90" source_dont_move=3D"true" sink_input_properties=3D"m=
edia.role=3Dphone"").
>      card.c: Changed profile of card 1 "bluez_card.CC_C3_EA_0A_15_90" to =
headset_audio_gateway
>
> some more information regarding the setup,
>
> * Everything is run as root user who is member of audio and pulse groups
> * PA daemon is not in system mode
> * ofono and bluez is available on dbus system bus but pulseaudio is on db=
us session bus (is this the right way ??)
>
>
Is there only one loopback module? There should be two, one from the =

bluez source to the default sink and
one from the default source to the bluez sink.


--===============6056364436284296165==--

