Content-Type: multipart/mixed; boundary="===============8135737016945990451=="
MIME-Version: 1.0
From: Jomon John <jomon.john@tataelxsi.co.in>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Tue, 07 Jun 2016 15:23:50 +0000
Message-ID: <HK2PR04MB1203AF81C3B84F501ABA2063DE5D0@HK2PR04MB1203.apcprd04.prod.outlook.com>
In-Reply-To: <5756CA7D.2010700@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8135737016945990451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
=C2=A0   =

On 07.06.2016 14:47, Jomon John wrote:
>>=C2=A0=C2=A0=C2=A0=C2=A0 =

>>> On 07.06.2016 12:11, Jomon John wrote:
>>>>> * Same for HFP, nothing related to bluez_* in pactl or pacmd outputs.=
 Again i can see the audio levels changing in pavucontrol (connected from e=
xternal machine with PULSE_SERVER) but only one side audio is working which=
 is from device side mic to other  end.=C2=A0=C2=A0 on the other side (call=
ing phone to device) the levels are changing but seems to be not routed to =
the default sink (since the levels are not changing in the default sink)
>>>>>
>>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Loaded "module-=
loopback" (index: #30; argument: "source=3D"bluez_source.CC_C3_EA_0A_15_90"=
 source_dont_move=3D"true" sink_input_properties=3D"media.role=3Dphone"").
>>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 card.c: Changed=
 profile of card 1 "bluez_card.CC_C3_EA_0A_15_90" to headset_audio_gateway
>>>>>
>>>>> some more information regarding the setup,
>>>>>
>>>>> * Everything is run as root user who is member of audio and pulse gro=
ups
>>>>> * PA daemon is not in system mode
>>>>> * ofono and bluez is available on dbus system bus but pulseaudio is o=
n dbus session bus (is this the right way ??)
>>>>> Is there only one loopback module? There should be two, one from the
>>>>> bluez source to the default sink and
>>>>> one from the default source to the bluez sink.
>>>> You were right, as per the logs the module-loopback loaded two times,
>>>>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] module.c:=
 Loaded "module-loopback" (index: #41; argument: "sink=3D"bluez_sink.CC_C3_=
EA_0A_15_90" sink_dont_move=3D"true" source_output_properties=3D"media.role=
=3Dphone"")
>>>>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] module.c:=
 Loaded "module-loopback" (index: #42; argument: "source=3D"bluez_source.CC=
_C3_EA_0A_15_90" source_dont_move=3D"true" sink_input_properties=3D"media.r=
ole=3Dphone"").
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =

>>>> The audio from default source is channeled to phone but i cant hear an=
y output audio from phone on the board while HFP session, so is there any w=
ay to control or verify the the source sink routing during the HFP session.
>>> What does pacmd list-cards show? Is the bluez device listed there?
>> Yes, the bluez device is listed in the output,
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index: 1
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: <bluez_card.CC_C3_EA_0A_=
15_90>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver: <module-bluez5-device.=
c>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 owner module: 24
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device.description =3D "Jo XT1033"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device.string =3D "CC:C3:EA:0A:17:97"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device.api =3D "bluez"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device.class =3D "sound"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device.bus =3D "bluetooth"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device.form_factor =3D "phone"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bluez.path =3D "/org/bluez/hci0/dev_CC_C3_EA_0A_15_90"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bluez.class =3D "0x5a020c"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bluez.alias =3D "Jo_XT1033"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 device.icon_name =3D "audio-card-bluetooth"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 profiles:
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 a2dp_source: High Fidelity Capture (A2DP Source) (priori=
ty 10, available: unknown)
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 headset_audio_gateway: Headset Audio Gateway (HSP/HFP) (=
priority 20, available: no)
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 off: Off (priority 0, available: yes)
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 active profile: <a2dp_source>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sources:
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bluez_source.CC_C3_EA_0A_15_90/#2: Jo XT1033
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ports:
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 phone-output: Phone (priority 0, latency offset 0 usec, =
available: no)
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properti=
es:
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =

>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 phone-input: Phone (priority 0, latency offset 0 usec, a=
vailable: unknown)
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properti=
es:
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =

>> Can you check (with pavucontrol or in the logs) if the loopback from the=
 phone goes to the correct sink?
>> As per the level changes shown in pavucontrol the audio from the other e=
nd of the phone reaching the bluez source, but level changes are not shown =
in the default sink, so i assume that the routing doesn't work between blue=
z source to default sink, also i  didnt find much info about this on logs, =
what should i look for ?
>>
>>> Do you see messages in the
>>> pulseaudio debug log from both loopback modules?
>> yes, Other than the module load messages i didn't find much (oh sure, di=
scarding all the "Could not peek into queue" and "Requesting rewind due to =
end of underrun" )
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] module.c: Loaded =
"module-loopback" (index: #41; argument: "sink=3D"bluez_sink.CC_C3_EA_0A_15=
_90" sink_dont_move=3D"true" source_output_properties=3D"media.role=3Dphone=
"").
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [bluetooth] module-loopback.c:=
 Max request changed
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [bluetooth] module-loopback.c:=
 Skipping 6218 bytes
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] module.c: Loaded =
"module-loopback" (index: #42; argument: "source=3D"bluez_source.CC_C3_EA_0=
A_15_90" source_dont_move=3D"true" sink_input_properties=3D"media.role=3Dph=
one"").
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] module-loopback.c=
: Loopback overall latency is 353.36 ms + 2.50 ms + 4.62 ms =3D 360.47 ms
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] module-loopback.c=
: Should buffer 96 bytes, buffered at minimum 0 bytes
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] module-loopback.c=
: Loopback overall latency is 854.23 ms + 13.00 ms + 16.09 ms =3D 883.32 ms
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] module-loopback.c=
: Should buffer 96 bytes, buffered at minimum 0 bytes
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] module-loopback.c=
: [bluez_sink.CC_C3_EA_0A_15_90] Updated sampling rate to 8000 Hz.
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [alsa-sink-HiFi wm8962-0] modu=
le-loopback.c: Max request changed
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [alsa-sink-HiFi wm8962-0] modu=
le-loopback.c: Max request changed
>>

>The loopback modules should provide messages every 10 seconds. There shoul=
d also be messages like
>[pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_15_90] Updated sam=
pling rate to 8000 Hz
>for the other loopback. =


Yes, such messages are there. =


>There you can see what sink is used for the second loopback. Underruns or =
"cannot peek into queue" messages should only occur at the startup of the m=
odules but not during normal operation. Could you post the relevant parts o=
f your log?

This part looks suspicious,

	D: [pulseaudio] module-loopback.c: Should buffer 96 bytes, buffered at min=
imum 48 bytes
	D: [pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_17_97] Updated =
sampling rate to 8000 Hz.
	I: [bluetooth] module-bluez5-device.c: FD error: POLLERR POLLHUP
	D: [bluetooth] module-bluez5-device.c: Audio stream torn down
	D: [pulseaudio] bluez5-util.c: Transport /card_1 state changed from playin=
g to idle
	D: [pulseaudio] card.c: Setting card bluez_card.CC_C3_EA_0A_17_97 profile =
headset_audio_gateway to availability status unknown
	D: [pulseaudio] module-bluetooth-policy.c: Setting card 'bluez_card.CC_C3_=
EA_0A_17_97' to profile 'off'
	D: [pulseaudio] module-rescue-streams.c: No evacuation sink found.
	I: [pulseaudio] source-output.c: Freeing output 7 "Peak detect"
	D: [bluetooth] sink.c: Requesting rewind due to started move


the complete log is pated @ http://pastebin.com/cddrcAxb =


With Regards,
John J
--===============8135737016945990451==--

