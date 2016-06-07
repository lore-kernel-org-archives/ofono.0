Content-Type: multipart/mixed; boundary="===============1078811903237070785=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Tue, 07 Jun 2016 12:55:33 +0200
Message-ID: <5756A825.2000902@chini.tk>
In-Reply-To: <HK2PR04MB1203116528FABA746A4E8849DE5D0@HK2PR04MB1203.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1078811903237070785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07.06.2016 12:11, Jomon John wrote:
>
>> * Same for HFP, nothing related to bluez_* in pactl or pacmd outputs. Ag=
ain i can see the audio levels changing in pavucontrol (connected from exte=
rnal machine with PULSE_SERVER) but only one side audio is working which is=
 from device side mic to other end.  on the other side (calling phone to de=
vice) the levels are changing but seems to be not routed to the default sin=
k (since the levels are not changing in the default sink)
>>
>>        Loaded "module-loopback" (index: #30; argument: "source=3D"bluez_=
source.CC_C3_EA_0A_15_90" source_dont_move=3D"true" sink_input_properties=
=3D"media.role=3Dphone"").
>>        card.c: Changed profile of card 1 "bluez_card.CC_C3_EA_0A_15_90" =
to headset_audio_gateway
>>
>> some more information regarding the setup,
>>
>> * Everything is run as root user who is member of audio and pulse groups
>> * PA daemon is not in system mode
>> * ofono and bluez is available on dbus system bus but pulseaudio is on d=
bus session bus (is this the right way ??)
>> Is there only one loopback module? There should be two, one from the
>> bluez source to the default sink and
>> one from the default source to the bluez sink.
> You were right, as per the logs the module-loopback loaded two times,
>
>       [pulseaudio] module.c: Loaded "module-loopback" (index: #41; argume=
nt: "sink=3D"bluez_sink.CC_C3_EA_0A_15_90" sink_dont_move=3D"true" source_o=
utput_properties=3D"media.role=3Dphone"")
>
>       [pulseaudio] module.c: Loaded "module-loopback" (index: #42; argume=
nt: "source=3D"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"true" si=
nk_input_properties=3D"media.role=3Dphone"").
>      =

> The audio from default source is channeled to phone but i cant hear any o=
utput audio from phone on the board while HFP session, so is there any way =
to control or verify the the source sink routing during the HFP session.
>
>
What does pacmd list-cards show? Is the bluez device listed there? Can =

you check (with pavucontrol
or in the logs) if the loopback from the phone goes to the correct sink? =

Do you see messages in the
pulseaudio debug log from both loopback modules?

--===============1078811903237070785==--

