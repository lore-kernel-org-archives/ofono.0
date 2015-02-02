Content-Type: multipart/mixed; boundary="===============4386847549910828836=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: bluetooth headset and ofono
Date: Mon, 02 Feb 2015 14:34:34 +0100
Message-ID: <54CF7CEA.9010106@chini.tk>
In-Reply-To: <1422877911.2744.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4386847549910828836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

can someone help me with the problem below? Is ofono supposed
to expose an audio card when a headset is connected? If so, could
you explain how this happens?
I am not using SELinux and have ofono and pulse compiled from a
recent source. The rest of the system is Debian unstable witch ships
Bluez version 5.23.

If this is not the right place to ask such questions please tell me, I
never received any response to my previous mails.

Regards
              Georg

On 02.02.2015 12:51, Tanu Kaskinen wrote:
> On Sun, 2015-02-01 at 16:26 +0100, Georg Chini wrote:
>> Hello,
>>
>> I am still fighting to get my bluetooth headset working properly
>> with the ofono backend. I cannot get HFP to work with pulse.
>>
>> When I run ofonod and phonesim and switch on my headset
>> it seems to connect fine. A card turns up in pulseaudio but the
>> HFP profile is not available there. Trying to switch to the profile
>> leads to "not connected" messages in the log.
>> In phonesim I can simulate a call. If I do so, I get a ring in the
>> headset and can pick up the call. I am not sure if there is any
>> audio, I hear silence. If I am playing back with the a2dp_sink
>> profile at the same time, the a2dp audio is muted (but continues
>> playing).
>>
>> Looking at the code I wonder if the HFP profile of a headset can
>> ever get available. The ofono backend listens for "CardAdded" or
>> "CardRemoved" DBUS-messages, but it seems that the "CardAdded"
>> signal is never emitted by ofono when a headset connects.
>> There is only a call to the associated function when a phone
>> connects and nowhere else in the code.
>> Or is there another way pulse is notified that the profile is available?
>> Did someone get it working and can tell me what I am doing wrong?
> Last time I tried I think I had a similar problem (the CardAdded signal
> was never sent). On the BlueZ mailing list I was instructed to disable
> SELinux. I did that, but then I got distracted by something else, and I
> never continued my efforts of getting PulseAudio to work with oFono on
> my machine.
>
> If you're using SELinux, and you're compiling some of the stack
> (PulseAudio, oFono, BlueZ) yourself, SELinux might be your problem. Try
> disabling it. (I don't remember the exact command to do that, but
> hopefully your favorite search engine will help you with that.)
>


--===============4386847549910828836==--

