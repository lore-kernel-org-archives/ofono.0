Content-Type: multipart/mixed; boundary="===============8588458081378807000=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [RFC] [PATCH 0/2] HFP AG integration with PulseAudio
Date: Thu, 04 Feb 2010 11:21:09 +0800
Message-ID: <4B6A3D25.2040508@intel.com>
In-Reply-To: <aa32413d1002031030s446edef6gea3d234bc440c170@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8588458081378807000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jprvita,

On 02/04/2010 02:30 AM, Jo=C3=A3o Paulo Rechi Vita wrote:
>>>
>>> Just updating, this patch actually worked when testing with a
>>> different adapter (Fujitsu-Siemens CSR-based). The adapter causing
>>> problems was a Broadcom 2.1, the internal adapter of a Dell Mini10.
>>> Also, suspending the source / sink actually doesn't interfere.
>>>
>>> I did a small video of the whole stuff: http://www.vimeo.com/9078799
>>>
>>> There are still some problems when testing against Nokia N900 and
>>> 2660. After the "enable-modem" step, the RFCOMM link is connected and
>>> the SCO just after that, leading module-bluetooth-discover to load
>>> module-bluetooth-device. Sometimes after that the polling on the
>>> stream fd get a POLLHUP and the module-bluetooth-device unloads
>>> itself. Other times the POLLHUP doesn't happen and the remaining steps
>>> go without any problem.
>>>
>>> Ideas on how to improve this scenario will be very helpful.
>>>
>>>
>>
>> The output from bluetoothd likes below:
>>
>> bluetoothd[21141]: Accepted AG connection from 00:BD:3A:D4:4E:53 for
>> /org/bluez/21141/hci0/dev_00_BD_3A_D4_4E_53
>> bluetoothd[21141]: Accepted SCO connection from 00:BD:3A:D4:4E:53
>> bluetoothd[21141]: No matching connection found for handle 6
>> bluetoothd[21141]: sco connection is released
>>
>> I think you should not load module-bluetooth-device until a voice call is
>> started, no matter incoming or outgoing. Because PA may play music from
>> other device at the same time. And bluetooth-device and loopback module =
are
>> loaded together. According to HFP v1.5 4.13, there are two cases for
>> incoming call. And outgoing call is simpler than incoming call.
>>
>> If AG and HF both support in band ring tones, we should send a signal fr=
om
>> oFono to PA when callsetup=3D1. If not, we should send it when call=3D1.
>>
>> I had a patch originally but I cannot find it now. :-(. The basic idea i=
s to
>> add a filter in ciev_notify() to emit signal (CallStarted and CallEnded)=
 to
>> PA. And PA loads module once it got that signal. Maybe the signal name w=
as
>> bad and you could choose better one as you want. ;-)
>>
>
> I think loading module-bluetooth-device only when there is an active
> call can be a good solution. But I'm concerned about other audio
> events, i. e.: ringing, SMS notification etc.: doesn't the AG
> establishes a SCO channel for the these events? Also, I don't think
> pulse should listen to ofono signals, it should be agent-agnostic. But
> a signal could be added to the agent interface in this case.

Yeah. Maybe you are right. PA should not listen to ofono signal directly =

but through an agent signal to make it more generic. AFAK, SMS =

notification doesn't require SCO. Upper app could simply watch the =

property changes from oFono.

> And I'm not sure if automatically loading module-loopback is a good
> idea, I think we better expose through the UI how to handle the audio
> stream. Some users may have a bunch of soundcards or some very weird
> audio setup, and it's up to them to decide which soundcard to connect
> the HFP stream.
>

I am not audio expert but AFAK PA has variant policies to control which =

audio stream should be feeded into the speaker/mic. Loading =

module-bluetooth-device is only the 1st step to create source/sink. I =

think the voicecall have the higher priority than other steam like =

music, etc. And yes, loading module-loopback could be decided by PA policy.

Thanks.
Zhenhua.


--===============8588458081378807000==--

