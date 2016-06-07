Content-Type: multipart/mixed; boundary="===============6019408198492098805=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Tue, 07 Jun 2016 21:10:48 +0200
Message-ID: <57571C38.3060206@chini.tk>
In-Reply-To: <HK2PR04MB1203AF81C3B84F501ABA2063DE5D0@HK2PR04MB1203.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6019408198492098805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07.06.2016 17:23, Jomon John wrote:
> Hi,
>      =

> On 07.06.2016 14:47, Jomon John wrote:
>>>       =

>>>> On 07.06.2016 12:11, Jomon John wrote:
>>>>>> * Same for HFP, nothing related to bluez_* in pactl or pacmd outputs=
. Again i can see the audio levels changing in pavucontrol (connected from =
external machine with PULSE_SERVER) but only one side audio is working whic=
h is from device side mic to other  end.   on the other side (calling phone=
 to device) the levels are changing but seems to be not routed to the defau=
lt sink (since the levels are not changing in the default sink)
>>>>>>
>>>>>>            Loaded "module-loopback" (index: #30; argument: "source=
=3D"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"true" sink_input_pr=
operties=3D"media.role=3Dphone"").
>>>>>>            card.c: Changed profile of card 1 "bluez_card.CC_C3_EA_0A=
_15_90" to headset_audio_gateway
>>>>>>
>>>>>> some more information regarding the setup,
>>>>>>
>>>>>> * Everything is run as root user who is member of audio and pulse gr=
oups
>>>>>> * PA daemon is not in system mode
>>>>>> * ofono and bluez is available on dbus system bus but pulseaudio is =
on dbus session bus (is this the right way ??)
>>>>>> Is there only one loopback module? There should be two, one from the
>>>>>> bluez source to the default sink and
>>>>>> one from the default source to the bluez sink.
>>>>> You were right, as per the logs the module-loopback loaded two times,
>>>>>
>>>>>           [pulseaudio] module.c: Loaded "module-loopback" (index: #41=
; argument: "sink=3D"bluez_sink.CC_C3_EA_0A_15_90" sink_dont_move=3D"true" =
source_output_properties=3D"media.role=3Dphone"")
>>>>>
>>>>>           [pulseaudio] module.c: Loaded "module-loopback" (index: #42=
; argument: "source=3D"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"=
true" sink_input_properties=3D"media.role=3Dphone"").
>>>>>          =

>>>>> The audio from default source is channeled to phone but i cant hear a=
ny output audio from phone on the board while HFP session, so is there any =
way to control or verify the the source sink routing during the HFP session.
>>>> What does pacmd list-cards show? Is the bluez device listed there?
>>> Yes, the bluez device is listed in the output,
>>>
>>>          index: 1
>>>          name: <bluez_card.CC_C3_EA_0A_15_90>
>>>          driver: <module-bluez5-device.c>
>>>          owner module: 24
>>>          properties:
>>>                  device.description =3D "Jo XT1033"
>>>                  device.string =3D "CC:C3:EA:0A:17:97"
>>>                  device.api =3D "bluez"
>>>                  device.class =3D "sound"
>>>                  device.bus =3D "bluetooth"
>>>                  device.form_factor =3D "phone"
>>>                  bluez.path =3D "/org/bluez/hci0/dev_CC_C3_EA_0A_15_90"
>>>                  bluez.class =3D "0x5a020c"
>>>                  bluez.alias =3D "Jo_XT1033"
>>>                  device.icon_name =3D "audio-card-bluetooth"
>>>          profiles:
>>>                  a2dp_source: High Fidelity Capture (A2DP Source) (prio=
rity 10, available: unknown)
>>>                  headset_audio_gateway: Headset Audio Gateway (HSP/HFP)=
 (priority 20, available: no)
>>>                  off: Off (priority 0, available: yes)
>>>          active profile: <a2dp_source>
>>>          sources:
>>>                  bluez_source.CC_C3_EA_0A_15_90/#2: Jo XT1033
>>>          ports:
>>>                  phone-output: Phone (priority 0, latency offset 0 usec=
, available: no)
>>>                          properties:
>>>                                  =

>>>                  phone-input: Phone (priority 0, latency offset 0 usec,=
 available: unknown)
>>>                          properties:
>>>                                          =

>>> Can you check (with pavucontrol or in the logs) if the loopback from th=
e phone goes to the correct sink?
>>> As per the level changes shown in pavucontrol the audio from the other =
end of the phone reaching the bluez source, but level changes are not shown=
 in the default sink, so i assume that the routing doesn't work between blu=
ez source to default sink, also i  didnt find much info about this on logs,=
 what should i look for ?
>>>
>>>> Do you see messages in the
>>>> pulseaudio debug log from both loopback modules?
>>> yes, Other than the module load messages i didn't find much (oh sure, d=
iscarding all the "Could not peek into queue" and "Requesting rewind due to=
 end of underrun" )
>>>
>>>          [pulseaudio] module.c: Loaded "module-loopback" (index: #41; a=
rgument: "sink=3D"bluez_sink.CC_C3_EA_0A_15_90" sink_dont_move=3D"true" sou=
rce_output_properties=3D"media.role=3Dphone"").
>>>          [bluetooth] module-loopback.c: Max request changed
>>>          [bluetooth] module-loopback.c: Skipping 6218 bytes
>>>          [pulseaudio] module.c: Loaded "module-loopback" (index: #42; a=
rgument: "source=3D"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"tru=
e" sink_input_properties=3D"media.role=3Dphone"").
>>>          [pulseaudio] module-loopback.c: Loopback overall latency is 35=
3.36 ms + 2.50 ms + 4.62 ms =3D 360.47 ms
>>>          [pulseaudio] module-loopback.c: Should buffer 96 bytes, buffer=
ed at minimum 0 bytes
>>>          .
>>>          .
>>>          [pulseaudio] module-loopback.c: Loopback overall latency is 85=
4.23 ms + 13.00 ms + 16.09 ms =3D 883.32 ms
>>>          [pulseaudio] module-loopback.c: Should buffer 96 bytes, buffer=
ed at minimum 0 bytes
>>>          [pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_15_90]=
 Updated sampling rate to 8000 Hz.
>>>          [alsa-sink-HiFi wm8962-0] module-loopback.c: Max request chang=
ed
>>>          [alsa-sink-HiFi wm8962-0] module-loopback.c: Max request chang=
ed
>>>
>> The loopback modules should provide messages every 10 seconds. There sho=
uld also be messages like
>> [pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_15_90] Updated s=
ampling rate to 8000 Hz
>> for the other loopback.
> Yes, such messages are there.
>
>> There you can see what sink is used for the second loopback. Underruns o=
r "cannot peek into queue" messages should only occur at the startup of the=
 modules but not during normal operation. Could you post the relevant parts=
 of your log?
> This part looks suspicious,
>
> 	D: [pulseaudio] module-loopback.c: Should buffer 96 bytes, buffered at m=
inimum 48 bytes
> 	D: [pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_17_97] Update=
d sampling rate to 8000 Hz.
> 	I: [bluetooth] module-bluez5-device.c: FD error: POLLERR POLLHUP
> 	D: [bluetooth] module-bluez5-device.c: Audio stream torn down
> 	D: [pulseaudio] bluez5-util.c: Transport /card_1 state changed from play=
ing to idle
> 	D: [pulseaudio] card.c: Setting card bluez_card.CC_C3_EA_0A_17_97 profil=
e headset_audio_gateway to availability status unknown
> 	D: [pulseaudio] module-bluetooth-policy.c: Setting card 'bluez_card.CC_C=
3_EA_0A_17_97' to profile 'off'
> 	D: [pulseaudio] module-rescue-streams.c: No evacuation sink found.
> 	I: [pulseaudio] source-output.c: Freeing output 7 "Peak detect"
> 	D: [bluetooth] sink.c: Requesting rewind due to started move
>
>
> the complete log is pated @ http://pastebin.com/cddrcAxb
>
Looking at the log it seems like there is no data coming from the bluez =

sink. Is there anything
in the bluetoothd log? I've also seen that you load module-role-cork. =

Perhaps you should not
use it at the moment, it might interfere if the stream does not have the =

correct role set.

--===============6019408198492098805==--

