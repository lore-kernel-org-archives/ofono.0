Content-Type: multipart/mixed; boundary="===============7655187077594976521=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Thu, 09 Jun 2016 21:37:18 +0200
Message-ID: <479afd11-edb1-4944-8ba3-86d26e74f9cf@chini.tk>
In-Reply-To: <HK2PR04MB120399717B98807D708A5EABDE5F0@HK2PR04MB1203.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7655187077594976521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09.06.2016 18:59, Jomon John wrote:
> Hi,
>
>>>>>> What does pacmd list-cards show? Is the bluez device listed there?
>>>>> Yes, the bluez device is listed in the output,
>>>>>
>>>>>            index: 1
>>>>>            name: <bluez_card.CC_C3_EA_0A_15_90>
>>>>>            driver: <module-bluez5-device.c>
>>>>>            owner module: 24
>>>>>            properties:
>>>>>                    device.description =3D "Jo XT1033"
>>>>>                    device.string =3D "CC:C3:EA:0A:17:97"
>>>>>                    device.api =3D "bluez"
>>>>>                    device.class =3D "sound"
>>>>>                    device.bus =3D "bluetooth"
>>>>>                    device.form_factor =3D "phone"
>>>>>                    bluez.path =3D "/org/bluez/hci0/dev_CC_C3_EA_0A_15=
_90"
>>>>>                    bluez.class =3D "0x5a020c"
>>>>>                    bluez.alias =3D "Jo_XT1033"
>>>>>                    device.icon_name =3D "audio-card-bluetooth"
>>>>>            profiles:
>>>>>                    a2dp_source: High Fidelity Capture (A2DP Source) (=
priority 10, available: unknown)
>>>>>                    headset_audio_gateway: Headset Audio Gateway (HSP/=
HFP) (priority 20, available: no)
>>>>>                    off: Off (priority 0, available: yes)
>>>>>            active profile: <a2dp_source>
>>>>>            sources:
>>>>>                    bluez_source.CC_C3_EA_0A_15_90/#2: Jo XT1033
>>>>>            ports:
>>>>>                    phone-output: Phone (priority 0, latency offset 0 =
usec, available: no)
>>>>>                            properties:
>>>>>                                    =

>>>>>                    phone-input: Phone (priority 0, latency offset 0 u=
sec, available: unknown)
>>>>>                            properties:
> Now again 'pacmd list-cards' and other list commands doesn't shows the bl=
uez source/sink in outputs during A2DP or HFP session, looks like something=
 weired happening.

Mh, this is really strange. I have no idea. Do I understand right that =

you can sometimes see them and sometimes not?
Have you tried a recent pulseaudio version?

>                     =

>>>>> Can you check (with pavucontrol or in the logs) if the loopback from =
the phone goes to the correct sink?
>>>>> As per the level changes shown in pavucontrol the audio from the othe=
r end of the phone reaching the bluez source, but level changes are not sho=
wn in the default sink, so i assume that the routing doesn't work between b=
luez source to default sink, also  i  didnt find much info about this on lo=
gs, what should i look for ?
>>>>>
>>>>>> Do you see messages in the
>>>>>> pulseaudio debug log from both loopback modules?
>>>>> yes, Other than the module load messages i didn't find much (oh sure,=
 discarding all the "Could not peek into queue" and "Requesting rewind due =
to end of underrun" )
>>>>>
>>>>>            [pulseaudio] module.c: Loaded "module-loopback" (index: #4=
1; argument: "sink=3D"bluez_sink.CC_C3_EA_0A_15_90" sink_dont_move=3D"true"=
 source_output_properties=3D"media.role=3Dphone"").
>>>>>            [bluetooth] module-loopback.c: Max request changed
>>>>>            [bluetooth] module-loopback.c: Skipping 6218 bytes
>>>>>            [pulseaudio] module.c: Loaded "module-loopback" (index: #4=
2; argument: "source=3D"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=3D=
"true" sink_input_properties=3D"media.role=3Dphone"").
>>>>>            [pulseaudio] module-loopback.c: Loopback overall latency i=
s 353.36 ms + 2.50 ms + 4.62 ms =3D 360.47 ms
>>>>>            [pulseaudio] module-loopback.c: Should buffer 96 bytes, bu=
ffered at minimum 0 bytes
>>>>>            .
>>>>>            .
>>>>>            [pulseaudio] module-loopback.c: Loopback overall latency i=
s 854.23 ms + 13.00 ms + 16.09 ms =3D 883.32 ms
>>>>>            [pulseaudio] module-loopback.c: Should buffer 96 bytes, bu=
ffered at minimum 0 bytes
>>>>>            [pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_15=
_90] Updated sampling rate to 8000 Hz.
>>>>>            [alsa-sink-HiFi wm8962-0] module-loopback.c: Max request c=
hanged
>>>>>            [alsa-sink-HiFi wm8962-0] module-loopback.c: Max request c=
hanged
>>>>>
>>>> The loopback modules should provide messages every 10 seconds. There s=
hould also be messages like
>>>> [pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_15_90] Updated=
 sampling rate to 8000 Hz
>>>> for the other loopback.
>>> Yes, such messages are there.
>>>
>>>> There you can see what sink is used for the second loopback. Underruns=
 or "cannot peek into queue" messages should only occur at the startup of t=
he modules but not during normal operation. Could you post the relevant par=
ts of your log?
>>> This part looks suspicious,
>>>
>>>          D: [pulseaudio] module-loopback.c: Should buffer 96 bytes, buf=
fered at minimum 48 bytes
>>>          D: [pulseaudio] module-loopback.c: [bluez_sink.CC_C3_EA_0A_17_=
97] Updated sampling rate to 8000 Hz.
>>>          I: [bluetooth] module-bluez5-device.c: FD error: POLLERR POLLH=
UP
>>>          D: [bluetooth] module-bluez5-device.c: Audio stream torn down
>>>          D: [pulseaudio] bluez5-util.c: Transport /card_1 state changed=
 from playing to idle
>>>          D: [pulseaudio] card.c: Setting card bluez_card.CC_C3_EA_0A_17=
_97 profile headset_audio_gateway to availability status unknown
>>>          D: [pulseaudio] module-bluetooth-policy.c: Setting card 'bluez=
_card.CC_C3_EA_0A_17_97' to profile 'off'
>>>          D: [pulseaudio] module-rescue-streams.c: No evacuation sink fo=
und.
>>>          I: [pulseaudio] source-output.c: Freeing output 7 "Peak detect"
>>>          D: [bluetooth] sink.c: Requesting rewind due to started move
>>>
>>>
>>> the complete log is pated @ http://pastebin.com/cddrcAxb
>>>
>> Looking at the log it seems like there is no data coming from the bluez =
 sink.
> How did you identified this ?, could you please point the associated erro=
r message.

It is rather the absence of messages in the log. You only get regular =

reports from one
loopback module. The fact that the messages from the second loopback are =

missing
shows that this module is hanging somehow. I have seen this, when the =

module does
not receive data, but there may also be another cause for it.

>
>> Is there anything  in the bluetoothd log?
> I didn't found anything fishy, the full bluetoothd log is pated @ http://=
pastebin.com/5MXugskH
>
>> I've also seen that you load module-role-cork. Perhaps you should not
>> use it at the moment, it might interfere if the stream does not have the=
 correct role set.
> Thank you, removed this.
>
> Finally a clarification question regarding bluez_sink and bluez_source, t=
he input from default source (mic) goes to bluez_sink and output from bluez=
_source routed to default sink(headphone/speaker), hence the name sink inpu=
t ans source output, is this right ?
>   =

Personally I find the names "sink input" and "source output" somewhat =

confusing. The source output
is the connector of a stream to the source and the sink input the =

connector to the sink.
Since a sink can play back multiple streams at the same time, multiple =

sink inputs can be connected
to one sink. Likewise the signal of a source can go to multiple =

destinations, so a source can be connected
to multiple source outputs.
In your case you have:

bluez_source -> (source_output_1 -> loopback_1 -> sink_input_1) .-> =

default_sink

and

PC mic -> (source_output_2 -> loopback_2 -> sink_input_2) -> bluez_sink

where the parts within the brackets all belong to module-loopback.

--===============7655187077594976521==--

