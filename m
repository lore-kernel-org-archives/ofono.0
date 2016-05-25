Content-Type: multipart/mixed; boundary="===============5293194623211074615=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Wed, 25 May 2016 11:30:38 -0500
Message-ID: <5745D32E.3050907@gmail.com>
In-Reply-To: <1464193368.13843.65.camel@iki.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5293194623211074615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Tanu,

On 05/25/2016 11:22 AM, Tanu Kaskinen wrote:
> On Wed, 2016-05-25 at 09:57 -0500, Denis Kenzior wrote:
>> Hi John,
>>
>> On 05/25/2016 06:01 AM, Jomon John wrote:
>>> Hi,
>>>
>>> I am trying to configure HFP with Bluez(5.34), Ofono(1.17) and
>>> pulseaudio(6) on a Freescale i.MX6 board using Linux 4.1.15 kernel,
>>> the idea is to use the target board in HFP/Handsfree Unit role. The
>>> bluetooth controller is a Pluggable USB Bluetooth Dongle (0a5c:21e8
>>> - BCM20702A0) with updated firmware.
>>>
>>> The procedure followed is,
>>>
>>> * Pair & connect with the android mobile phone with the bluetoothctl
>>> * Enable modem and dial number using ofono test scripts
>>>
>>> After this the call is being made but the audio routing fails with
>>> "Reject SCO : Agent not registered" message from oFono. While
>>> checking with btmon its found that the SCO Connect Request has been
>>> rejected with the reason of limited resources(0x0d).
>>>
>>> Can anyone help me to identify the root cause, I spent a lot of
>>> time trying different version combinations, loading firmware and
>>> checking logs but still nothing.
>>
>> This looks like a problem with PulseAudio configuration. oFono does not
>> handle SCO data, PulseAudio does that. In order to do that, PulseAudio
>> needs to register an agent with oFono. Then the SCO socket will be
>> established and the fd handed off to PulseAudio to process the audio dat=
a.
>>
>> I have no idea how this is accomplished in PulseAudio.  This question is
>> being asked fairly often recently.  Does PulseAudio have an
>> FAQ/documentation for this yet?
>
> In /etc/pulse/default.pa, add parameter headset=3Dofono to module-
> bluetooth-discover. That should be all that's needed at PulseAudio
> side.
>
> Denis, would you be willing to help me with the oFono parts, if I write
> a document explaining how to make bluetooth audio work with
> BlueZ5+PA+oFono?
>

Sure.

Regards,
-Denis


--===============5293194623211074615==--

