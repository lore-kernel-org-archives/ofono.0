Content-Type: multipart/mixed; boundary="===============7382580026414723751=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: HFP HF - Reject SCO Issue
Date: Wed, 25 May 2016 18:30:53 +0200
Message-ID: <5745D33D.40703@chini.tk>
In-Reply-To: <5745BD55.3030108@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7382580026414723751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 25.05.2016 16:57, Denis Kenzior wrote:
> Hi John,
>
> On 05/25/2016 06:01 AM, Jomon John wrote:
>> Hi,
>>
>> I am trying to configure HFP with Bluez(5.34), Ofono(1.17) and =

>> pulseaudio(6) on a Freescale i.MX6 board using Linux 4.1.15 kernel, =

>> the idea is to use the target board in HFP/Handsfree Unit role. The =

>> bluetooth controller is a Pluggable USB Bluetooth Dongle (0a5c:21e8 - =

>> BCM20702A0) with updated firmware.
>>
>> The procedure followed is,
>>
>> * Pair & connect with the android mobile phone with the bluetoothctl
>> * Enable modem and dial number using ofono test scripts
>>
>> After this the call is being made but the audio routing fails with =

>> "Reject SCO : Agent not registered" message from oFono. While =

>> checking with btmon its found that the SCO Connect Request has been =

>> rejected with the reason of limited resources(0x0d).
>>
>> Can anyone help me to identify the root cause, I spent a lot of time =

>> trying different version combinations, loading firmware and checking =

>> logs but still nothing.
>

Did you load module-bluetooth-discover with headset=3Dofono as argument?
Normally this should be sufficient to make it work. When the connection =

is established,
pulseaudio automatically loads loopback modules for the phone. You might =

have
to check if the modules have the correct source / sink.
Additionally to observing the log files, you can debug what is going on =

by using
dbus-monitor to see the messages on the dbus.

> This looks like a problem with PulseAudio configuration. oFono does =

> not handle SCO data, PulseAudio does that. In order to do that, =

> PulseAudio needs to register an agent with oFono. Then the SCO socket =

> will be established and the fd handed off to PulseAudio to process the =

> audio data.
>
> I have no idea how this is accomplished in PulseAudio.  This question =

> is being asked fairly often recently.  Does PulseAudio have an =

> FAQ/documentation for this yet?
>

Unfortunately there is no HowTo as far as I know. Most stuff you find on =

the net is outdated.

> Regards,
> -Denis
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


--===============7382580026414723751==--

