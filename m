Content-Type: multipart/mixed; boundary="===============6145762273906687126=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [RFCv3] Add message agent API
Date: Wed, 08 Sep 2010 20:57:54 +0300
Message-ID: <AANLkTi=Wj14B-LmdUQvnm2YMdLnd3X2sA97-eYKih==e@mail.gmail.com>
In-Reply-To: <1283964778.6640.65.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6145762273906687126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/9/8 Marcel Holtmann <marcel@holtmann.org>:
>> Example: a voice and video over IP client that doesn't drain the
>> battery in half a day. My server sends a wakeup over SMS on an
>> incoming call.
>
> isn't this most likely done better via WAP Push? Do you have any concert
> specification of an VoIP client doing this as SMS datagram.

Not better, just different. Surely this could be done via vCal as well.

>> Example: a device lock service. I send a binary SMS to my stolen phone
>> on a well-known port containing a cryptographic token, causing my
>> phone to lock and/or wipe itself clean.
>
> I think this is clear example where it should be done as an oFono plugin
> and not go via the user session.

Huh? What do you mean by user session?

And you can't seriously be suggesting these sort of applications end
up in the oFono source tree, or will be licensed under GPL. This is
exactly why we are using D-Bus after all, so that applications using
oFono can have any license, including proprietary.

>> Fact is, SMS is still the most widely available and power-efficient
>> rendezvous service on a mobile phone. It would be silly not to support
>> it to its full potential.
>
> Yes, SMS is nice, but I am trying to figure out what use cases we have
> that are done inside the user session and where it makes no sense to
> have a specific oFono plugin doing the proper task. Meaning what really
> needs user interaction or requires an application for it.
>
> I can only come up with some theoretical examples and potential
> applications. I like to see some applications that exist right now and
> use SMS in this way. That is my problem right now, I just can't find
> them. Since you spent some time thinking about real uses, do you have
> examples all existing application using SMS like this?

You asked for use cases, which is what I provided. Now you want an
actual real-world application? What's next, requiring over 250 000
downloads?

> Keep in mind that SMS are actually causing costs and we have to protect
> random application from sending or receiving random messages as well.

Are you saying there is some extra cost in running an agent that
handles SMSs, as opposed to silently dropping them? Keep in mind that
there is no ICMP in SMS, so there is absolutely nothing to stop
someone from sending SMSs to your phone on any port -- regardless of
whether your phone wants them.

>> > I think that everybody else has abandoned any other SMS message types.
>>
>> Quite the contrary. Every other mobile telephony API out there that I
>> know of has the ability to send and receive binary messages on an
>> arbitrary port.
>
> And is it actually in use. That telephony API can make coffee for me if
> it likes to, but if I am not using it, why bother?

There's a separate patch to add support for RFC2324. This not it.

Cheers,
Aki

--===============6145762273906687126==--

