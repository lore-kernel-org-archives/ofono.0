Content-Type: multipart/mixed; boundary="===============4784547087225146922=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: bluetooth headset and ofono
Date: Mon, 02 Feb 2015 16:37:31 +0100
Message-ID: <54CF99BB.7020908@chini.tk>
In-Reply-To: <54CF9589.70109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4784547087225146922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02.02.2015 16:19, Denis Kenzior wrote:
> Hi Georg,
>
> On 02/02/2015 07:34 AM, Georg Chini wrote:
>> Hello,
>>
>> can someone help me with the problem below? Is ofono supposed
>> to expose an audio card when a headset is connected? If so, could
>> you explain how this happens?
>> I am not using SELinux and have ofono and pulse compiled from a
>> recent source. The rest of the system is Debian unstable witch ships
>> Bluez version 5.23.
>
> I have no idea what SELinux would have to do with anything...
>
>>
>> If this is not the right place to ask such questions please tell me, I
>> never received any response to my previous mails.
>>
>> Regards
>>               Georg
>>
>> On 02.02.2015 12:51, Tanu Kaskinen wrote:
>>> On Sun, 2015-02-01 at 16:26 +0100, Georg Chini wrote:
>>>> Hello,
>>>>
>>>> I am still fighting to get my bluetooth headset working properly
>>>> with the ofono backend. I cannot get HFP to work with pulse.
>>>>
>>>> When I run ofonod and phonesim and switch on my headset
>>>> it seems to connect fine. A card turns up in pulseaudio but the
>
> What exactly are you trying to do? Phonesim can only simulate modem =

> signaling.  It will _not_ generate audio.  I should also point out =

> that oFono does not support audio for HFP AG role with BlueZ 5.
>
> Only HFP Handsfree role with BlueZ5/PulseAudio is supported.
>
>>>> HFP profile is not available there. Trying to switch to the profile
>>>> leads to "not connected" messages in the log.
>>>> In phonesim I can simulate a call. If I do so, I get a ring in the
>>>> headset and can pick up the call. I am not sure if there is any
>>>> audio, I hear silence. If I am playing back with the a2dp_sink
>>>> profile at the same time, the a2dp audio is muted (but continues
>>>> playing).
>>>>
>>>> Looking at the code I wonder if the HFP profile of a headset can
>>>> ever get available. The ofono backend listens for "CardAdded" or
>>>> "CardRemoved" DBUS-messages, but it seems that the "CardAdded"
>>>> signal is never emitted by ofono when a headset connects.
>>>> There is only a call to the associated function when a phone
>>>> connects and nowhere else in the code.
>
> Yes, as I said previously, what you're trying to do is not supported.
>
> Regards,
> -Denis
Hello Denis,

thanks a lot for the information! That was what I was looking for.

Regards
              Georg

--===============4784547087225146922==--

