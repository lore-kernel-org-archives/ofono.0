Content-Type: multipart/mixed; boundary="===============2114857686633321417=="
MIME-Version: 1.0
From: Jomon John <jomon.john@tataelxsi.co.in>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Thu, 09 Jun 2016 16:59:52 +0000
Message-ID: <HK2PR04MB120399717B98807D708A5EABDE5F0@HK2PR04MB1203.apcprd04.prod.outlook.com>
In-Reply-To: <57571C38.3060206@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2114857686633321417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>>>>> What does pacmd list-cards show? Is the bluez device listed there?
>>>> Yes, the bluez device is listed in the output,
>>>>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index: 1
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: <bluez_car=
d.CC_C3_EA_0A_15_90>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver: <module-=
bluez5-device.c>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 owner module: 24
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device.description =3D "Jo XT1033"
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device.string =3D "CC:C3:EA:0A:17:97"
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device.api =3D "bluez"
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device.class =3D "sound"
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device.bus =3D "bluetooth"
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device.form_factor =3D "phone"
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bluez.path =3D "/org/bluez/hci0/dev_CC_C3=
_EA_0A_15_90"
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bluez.class =3D "0x5a020c"
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bluez.alias =3D "Jo_XT1033"
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device.icon_name =3D "audio-card-bluetoot=
h"
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 profiles:
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a2dp_source: High Fidelity Capture (A2DP =
Source) (priority 10, available: unknown)
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 headset_audio_gateway: Headset Audio Gate=
way (HSP/HFP) (priority 20, available: no)
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off: Off (priority 0, available: yes)
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 active profile: =
<a2dp_source>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sources:
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bluez_source.CC_C3_EA_0A_15_90/#2: Jo XT1=
033
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ports:
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phone-output: Phone (priority 0, latency =
offset 0 usec, available: no)
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 properties:
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =

>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phone-input: Phone (priority 0, latency o=
ffset 0 usec, available: unknown)
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 properties:

Now again 'pacmd list-cards' and other list commands doesn't shows the blue=
z source/sink in outputs during A2DP or HFP session, looks like something w=
eired happening.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =

>>>> Can you check (with pavucontrol or in the logs) if the loopback from t=
he phone goes to the correct sink?
>>>> As per the level changes shown in pavucontrol the audio from the other=
 end of the phone reaching the bluez source, but level changes are not show=
n in the default sink, so i assume that the routing doesn't work between bl=
uez source to default sink, also  i=C2=A0 didnt find much info about this o=
n logs, what should i look for ?
>>>>
>>>>> Do you see messages in the
>>>>> pulseaudio debug log from both loopback modules?
>>>> yes, Other than the module load messages i didn't find much (oh sure, =
discarding all the "Could not peek into queue" and "Requesting rewind due t=
o end of underrun" )
>>>>
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] mod=
ule.c: Loaded "module-loopback" (index: #41; argument: "sink=3D"bluez_sink.=
CC_C3_EA_0A_15_90" sink_dont_move=3D"true" source_output_properties=3D"medi=
a.role=3Dphone"").
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [bluetooth] modu=
le-loopback.c: Max request changed
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [bluetooth] modu=
le-loopback.c: Skipping 6218 bytes
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] mod=
ule.c: Loaded "module-loopback" (index: #42; argument: "source=3D"bluez_sou=
rce.CC_C3_EA_0A_15_90" source_dont_move=3D"true" sink_input_properties=3D"m=
edia.role=3Dphone"").
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] mod=
ule-loopback.c: Loopback overall latency is 353.36 ms + 2.50 ms + 4.62 ms =
=3D 360.47 ms
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] mod=
ule-loopback.c: Should buffer 96 bytes, buffered at minimum 0 bytes
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] mod=
ule-loopback.c: Loopback overall latency is 854.23 ms + 13.00 ms + 16.09 ms=
 =3D 883.32 ms
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] mod=
ule-loopback.c: Should buffer 96 bytes, buffered at minimum 0 bytes
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [pulseaudio] mod=
ule-loopback.c: [bluez_sink.CC_C3_EA_0A_15_90] Updated sampling rate to 800=
0 Hz.
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [alsa-sink-HiFi =
wm8962-0] module-loopback.c: Max request changed
>>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [alsa-sink-HiFi =
wm8962-0] module-loopback.c: Max request changed
>>>>
>>> The loopback modules should provide messages every 10 seconds. There sh=
ould also be messages like
>>> [pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_15_90] Updated =
sampling rate to 8000 Hz
>>> for the other loopback.
>> Yes, such messages are there.
>>
>>> There you can see what sink is used for the second loopback. Underruns =
or "cannot peek into queue" messages should only occur at the startup of th=
e modules but not during normal operation. Could you post the relevant part=
s of your log?
>> This part looks suspicious,
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: [pulseaudio] module-loopbac=
k.c: Should buffer 96 bytes, buffered at minimum 48 bytes
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: [pulseaudio] module-loopbac=
k.c: [bluez_sink.CC_C3_EA_0A_17_97] Updated sampling rate to 8000 Hz.
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I: [bluetooth] module-bluez5-d=
evice.c: FD error: POLLERR POLLHUP
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: [bluetooth] module-bluez5-d=
evice.c: Audio stream torn down
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: [pulseaudio] bluez5-util.c:=
 Transport /card_1 state changed from playing to idle
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: [pulseaudio] card.c: Settin=
g card bluez_card.CC_C3_EA_0A_17_97 profile headset_audio_gateway to availa=
bility status unknown
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: [pulseaudio] module-bluetoo=
th-policy.c: Setting card 'bluez_card.CC_C3_EA_0A_17_97' to profile 'off'
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: [pulseaudio] module-rescue-=
streams.c: No evacuation sink found.
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I: [pulseaudio] source-output.=
c: Freeing output 7 "Peak detect"
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D: [bluetooth] sink.c: Request=
ing rewind due to started move
>>
>>
>> the complete log is pated @ http://pastebin.com/cddrcAxb
>>
> Looking at the log it seems like there is no data coming from the bluez  =
sink. =


How did you identified this ?, could you please point the associated error =
message.

> Is there anything  in the bluetoothd log? =


I didn't found anything fishy, the full bluetoothd log is pated @ http://pa=
stebin.com/5MXugskH

> I've also seen that you load module-role-cork. Perhaps you should not
> use it at the moment, it might interfere if the stream does not have the =
correct role set.

Thank you, removed this.

Finally a clarification question regarding bluez_sink and bluez_source, the=
 input from default source (mic) goes to bluez_sink and output from bluez_s=
ource routed to default sink(headphone/speaker), hence the name sink input =
ans source output, is this right ? =

=20
--===============2114857686633321417==--

