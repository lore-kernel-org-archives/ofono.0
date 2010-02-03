Content-Type: multipart/mixed; boundary="===============2454604001051698693=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: Re: [RFC] [PATCH 0/2] HFP AG integration with PulseAudio
Date: Wed, 03 Feb 2010 16:30:03 -0200
Message-ID: <aa32413d1002031030s446edef6gea3d234bc440c170@mail.gmail.com>
In-Reply-To: <4B67A102.6090304@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2454604001051698693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 2, 2010 at 01:50, Zhenhua Zhang <zhenhua.zhang@intel.com> wro=
te:
> Hi Jprvita,
>
> On 02/02/2010 01:09 AM, Jo=C3=A3o Paulo Rechi Vita wrote:
>>
>> 2010/1/29 Jo=C3=A3o Paulo Rechi Vita<jprvita@gmail.com>:
>>
>>>
>>> Hi all,
>>>
>>> I'm trying to add support for the Handsfree Gateway role Gustavo just
>>> added
>>> to BlueZ and oFono. The BlueZ patches can be found on [1] and [2] and t=
he
>>> oFono part was just merged upstream.
>>>
>>> But when it comes to integrate them with Pulse, I'm getting a POLLHUP
>>> when
>>> trying to write on the fd. Also, it seems different gateways have
>>> different
>>> behaviours regarding when they connect the SCO link. Some phone connect
>>> them just after the RFCOMM link (some Nokia phones), when there is no
>>> call
>>> going on yet, and others just when a call is started (Android 1.5).
>>>
>>> Also, right now the same property (State) is beeing used to refer when
>>> the
>>> RFCOOM link is established (State=3DConnected) and when the SCO link is
>>> established (State=3DPlaying). Shouldn't this be handled by separate pr=
ops?
>>>
>>> And last but not least, is the new Media API intended to handle the aud=
io
>>> part of handsfree gateways too? If so, maybe we should use all this work
>>> as a prototype for latter integration with the new API.
>>>
>>> Any help on testing and getting this working together or comments on the
>>> topic would be appreciated.
>>>
>>> [1] http://www.spinics.net/lists/linux-bluetooth/msg04250.html
>>> [2] http://www.spinics.net/lists/linux-bluetooth/msg04251.html
>>>
>>> --
>>> Jo=C3=A3o Paulo Rechi Vita
>>> http://jprvita.wordpress.com/
>>>
>>>
>>>
>>
>> Just updating, this patch actually worked when testing with a
>> different adapter (Fujitsu-Siemens CSR-based). The adapter causing
>> problems was a Broadcom 2.1, the internal adapter of a Dell Mini10.
>> Also, suspending the source / sink actually doesn't interfere.
>>
>> I did a small video of the whole stuff: http://www.vimeo.com/9078799
>>
>> There are still some problems when testing against Nokia N900 and
>> 2660. After the "enable-modem" step, the RFCOMM link is connected and
>> the SCO just after that, leading module-bluetooth-discover to load
>> module-bluetooth-device. Sometimes after that the polling on the
>> stream fd get a POLLHUP and the module-bluetooth-device unloads
>> itself. Other times the POLLHUP doesn't happen and the remaining steps
>> go without any problem.
>>
>> Ideas on how to improve this scenario will be very helpful.
>>
>>
>
> The output from bluetoothd likes below:
>
> bluetoothd[21141]: Accepted AG connection from 00:BD:3A:D4:4E:53 for
> /org/bluez/21141/hci0/dev_00_BD_3A_D4_4E_53
> bluetoothd[21141]: Accepted SCO connection from 00:BD:3A:D4:4E:53
> bluetoothd[21141]: No matching connection found for handle 6
> bluetoothd[21141]: sco connection is released
>
> I think you should not load module-bluetooth-device until a voice call is
> started, no matter incoming or outgoing. Because PA may play music from
> other device at the same time. And bluetooth-device and loopback module a=
re
> loaded together. According to HFP v1.5 4.13, there are two cases for
> incoming call. And outgoing call is simpler than incoming call.
>
> If AG and HF both support in band ring tones, we should send a signal from
> oFono to PA when callsetup=3D1. If not, we should send it when call=3D1.
>
> I had a patch originally but I cannot find it now. :-(. The basic idea is=
 to
> add a filter in ciev_notify() to emit signal (CallStarted and CallEnded) =
to
> PA. And PA loads module once it got that signal. Maybe the signal name was
> bad and you could choose better one as you want. ;-)
>

I think loading module-bluetooth-device only when there is an active
call can be a good solution. But I'm concerned about other audio
events, i. e.: ringing, SMS notification etc.: doesn't the AG
establishes a SCO channel for the these events? Also, I don't think
pulse should listen to ofono signals, it should be agent-agnostic. But
a signal could be added to the agent interface in this case.

And I'm not sure if automatically loading module-loopback is a good
idea, I think we better expose through the UI how to handle the audio
stream. Some users may have a bunch of soundcards or some very weird
audio setup, and it's up to them to decide which soundcard to connect
the HFP stream.

-- =

Jo=C3=A3o Paulo Rechi Vita
http://jprvita.wordpress.com/

--===============2454604001051698693==--

