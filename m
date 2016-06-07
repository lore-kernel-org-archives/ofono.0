Content-Type: multipart/mixed; boundary="===============2335296743905646481=="
MIME-Version: 1.0
From: Jomon John <jomon.john@tataelxsi.co.in>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Tue, 07 Jun 2016 10:11:33 +0000
Message-ID: <HK2PR04MB1203116528FABA746A4E8849DE5D0@HK2PR04MB1203.apcprd04.prod.outlook.com>
In-Reply-To: <57568676.6060603@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2335296743905646481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
=C2=A0   =

Thank you for the help,

>>> Did you check with "pacmd list-sinks" and "pacmd list-sources" if the
>>> bluetooth sink and source are
>>> available? Did you check if loopback modules get loaded?
>>> If they get loaded, please check if they are loaded correctly. There
>>> must be one module with source
>>> set to your phone and sink set to your default sound device and one
>>> module in the other direction.
>>> You should also see some output of the loopback modules in the
>>> pulseaudio log.
>> Thanks for the support, things are getting more and more interesting bec=
ause now,
>>
>> * A2DP is working fine, but i cant find bluez source or sink in pacmd or=
 pactl outputs, but same time the loading of module loopback with bluez_sou=
rce is shown in journalctl logs of pulseaudio.
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 module.c: Loaded "module-loopback" (index:=
 #28; argument: "source=3D"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=
=3D"true" sink_input_properties=3D"media.role=3Dmusic"").

>Mh, that is strange, pacmd list-sources should definitely show the bluez =

>source, you can see from
>the arguments of the loopback module that the source exists.

Is this anyway related to dbus configuration or selected bus (ssystem vs se=
ssion) ?  =


>> * Same for HFP, nothing related to bluez_* in pactl or pacmd outputs. Ag=
ain i can see the audio levels changing in pavucontrol (connected from exte=
rnal machine with PULSE_SERVER) but only one side audio is working which is=
 from device side mic to other end.  on the other side (calling phone to de=
vice) the levels are changing but seems to be not routed to the default sin=
k (since the levels are not changing in the default sink)
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Loaded "module-loopback" (index: #30; argu=
ment: "source=3D"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"true" =
sink_input_properties=3D"media.role=3Dphone"").
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 card.c: Changed profile of card 1 "bluez_c=
ard.CC_C3_EA_0A_15_90" to headset_audio_gateway
>>
>> some more information regarding the setup,
>>
>> * Everything is run as root user who is member of audio and pulse groups
>> * PA daemon is not in system mode
>> * ofono and bluez is available on dbus system bus but pulseaudio is on d=
bus session bus (is this the right way ??)

>Is there only one loopback module? There should be two, one from the =

>bluez source to the default sink and
>one from the default source to the bluez sink.

You were right, as per the logs the module-loopback loaded two times, =


     [pulseaudio] module.c: Loaded "module-loopback" (index: #41; argument:=
 "sink=3D"bluez_sink.CC_C3_EA_0A_15_90" sink_dont_move=3D"true" source_outp=
ut_properties=3D"media.role=3Dphone"")

     [pulseaudio] module.c: Loaded "module-loopback" (index: #42; argument:=
 "source=3D"bluez_source.CC_C3_EA_0A_15_90" source_dont_move=3D"true" sink_=
input_properties=3D"media.role=3Dphone"").
    =

The audio from default source is channeled to phone but i cant hear any out=
put audio from phone on the board while HFP session, so is there any way to=
 control or verify the the source sink routing during the HFP session.

With Regards,

John J
--===============2335296743905646481==--

