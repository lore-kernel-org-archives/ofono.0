Content-Type: multipart/mixed; boundary="===============4058203476822207770=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Tue, 07 Jun 2016 15:22:05 +0200
Message-ID: <5756CA7D.2010700@chini.tk>
In-Reply-To: <HK2PR04MB120317EDB383E9ADC491182CDE5D0@HK2PR04MB1203.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4058203476822207770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07.06.2016 14:47, Jomon John wrote:
>     =

>> On 07.06.2016 12:11, Jomon John wrote:
>>>> * Same for HFP, nothing related to bluez_* in pactl or pacmd outputs. =
Again i can see the audio levels changing in pavucontrol (connected from ex=
ternal machine with PULSE_SERVER) but only one side audio is working which =
is from device side mic to other end.   on the other side (calling phone to=
 device) the levels are changing but seems to be not routed to the default =
sink (since the levels are not changing in the default sink)
>>>>
>>>>          Loaded "module-loopback" (index: #30; argument: "source=3D"bl=
uez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"true" sink_input_properti=
es=3D"media.role=3Dphone"").
>>>>          card.c: Changed profile of card 1 "bluez_card.CC_C3_EA_0A_15_=
90" to headset_audio_gateway
>>>>
>>>> some more information regarding the setup,
>>>>
>>>> * Everything is run as root user who is member of audio and pulse grou=
ps
>>>> * PA daemon is not in system mode
>>>> * ofono and bluez is available on dbus system bus but pulseaudio is on=
 dbus session bus (is this the right way ??)
>>>> Is there only one loopback module? There should be two, one from the
>>>> bluez source to the default sink and
>>>> one from the default source to the bluez sink.
>>> You were right, as per the logs the module-loopback loaded two times,
>>>
>>>         [pulseaudio] module.c: Loaded "module-loopback" (index: #41; ar=
gument: "sink=3D"bluez_sink.CC_C3_EA_0A_15_90" sink_dont_move=3D"true" sour=
ce_output_properties=3D"media.role=3Dphone"")
>>>
>>>         [pulseaudio] module.c: Loaded "module-loopback" (index: #42; ar=
gument: "source=3D"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"true=
" sink_input_properties=3D"media.role=3Dphone"").
>>>        =

>>> The audio from default source is channeled to phone but i cant hear any=
 output audio from phone on the board while HFP session, so is there any wa=
y to control or verify the the source sink routing during the HFP session.
>> What does pacmd list-cards show? Is the bluez device listed there?
> Yes, the bluez device is listed in the output,
>
> 	index: 1
> 	name: <bluez_card.CC_C3_EA_0A_15_90>
> 	driver: <module-bluez5-device.c>
> 	owner module: 24
> 	properties:
> 		device.description =3D "Jo XT1033"
> 		device.string =3D "CC:C3:EA:0A:17:97"
> 		device.api =3D "bluez"
> 		device.class =3D "sound"
> 		device.bus =3D "bluetooth"
> 		device.form_factor =3D "phone"
> 		bluez.path =3D "/org/bluez/hci0/dev_CC_C3_EA_0A_15_90"
> 		bluez.class =3D "0x5a020c"
> 		bluez.alias =3D "Jo_XT1033"
> 		device.icon_name =3D "audio-card-bluetooth"
> 	profiles:
> 		a2dp_source: High Fidelity Capture (A2DP Source) (priority 10, availabl=
e: unknown)
> 		headset_audio_gateway: Headset Audio Gateway (HSP/HFP) (priority 20, av=
ailable: no)
> 		off: Off (priority 0, available: yes)
> 	active profile: <a2dp_source>
> 	sources:
> 		bluez_source.CC_C3_EA_0A_15_90/#2: Jo XT1033
> 	ports:
> 		phone-output: Phone (priority 0, latency offset 0 usec, available: no)
> 			properties:
> 				=

> 		phone-input: Phone (priority 0, latency offset 0 usec, available: unkno=
wn)
> 			properties:
> 					=

>> Can you check (with pavucontrol
>> or in the logs) if the loopback from the phone goes to the correct sink?
> As per the level changes shown in pavucontrol the audio from the other en=
d of the phone reaching the bluez source, but level changes are not shown i=
n the default sink, so i assume that the routing doesn't work between bluez=
 source to default sink, also i didnt find much info about this on logs, wh=
at should i look for ?
>
>> Do you see messages in the
>> pulseaudio debug log from both loopback modules?
> yes, Other than the module load messages i didn't find much (oh sure, dis=
carding all the "Could not peek into queue" and "Requesting rewind due to e=
nd of underrun" )
>
> 	[pulseaudio] module.c: Loaded "module-loopback" (index: #41; argument: "=
sink=3D"bluez_sink.CC_C3_EA_0A_15_90" sink_dont_move=3D"true" source_output=
_properties=3D"media.role=3Dphone"").
> 	[bluetooth] module-loopback.c: Max request changed
> 	[bluetooth] module-loopback.c: Skipping 6218 bytes
> 	[pulseaudio] module.c: Loaded "module-loopback" (index: #42; argument: "=
source=3D"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"true" sink_in=
put_properties=3D"media.role=3Dphone"").
> 	[pulseaudio] module-loopback.c: Loopback overall latency is 353.36 ms + =
2.50 ms + 4.62 ms =3D 360.47 ms
> 	[pulseaudio] module-loopback.c: Should buffer 96 bytes, buffered at mini=
mum 0 bytes
> 	.
> 	.
> 	[pulseaudio] module-loopback.c: Loopback overall latency is 854.23 ms + =
13.00 ms + 16.09 ms =3D 883.32 ms
> 	[pulseaudio] module-loopback.c: Should buffer 96 bytes, buffered at mini=
mum 0 bytes
> 	[pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_15_90] Updated s=
ampling rate to 8000 Hz.
> 	[alsa-sink-HiFi wm8962-0] module-loopback.c: Max request changed
> 	[alsa-sink-HiFi wm8962-0] module-loopback.c: Max request changed
>
>
The loopback modules should provide messages every 10 seconds. There =

should also be
messages like

[pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_15_90] Updated samp=
ling rate to 8000 Hz

for the other loopback. There you can see what sink is used for the =

second loopback.
Underruns or "cannot peek into queue" messages should only occur at the =

startup of the
modules but not during normal operation. Could you post the relevant =

parts of your log?


--===============4058203476822207770==--

