Content-Type: multipart/mixed; boundary="===============0398081675264336758=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Motorola motmdm support
Date: Sun, 30 Dec 2018 16:06:24 -0600
Message-ID: <5950f965-effa-25ca-3533-de1b95923aa5@gmail.com>
In-Reply-To: <20181230212253.GG6707@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0398081675264336758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

>> How are you handling data connections?  PPP? Or is there some other prot=
ocol
>> to transfer packets back and forth?
> =

> All the data connections in this case are done using QMI over USB.
> =

> And that probably explains why I have not seen any data related
> stuff on ts 27.010.

Ew.  So is everything related to packet services is running over QMI?

When Pavel explained that he wanted to use the weird squiggly AT =

commands, I assumed you wanted to run the packet services over AT as well.

> =

>>>> - GNSS/GPS is intended to be handled via oFono LocationReporting API. =
 I
>>>> would recommend integrating this as intended...
>>>
>>> We have a standard kernel GNSS API now :) And we have /dev/gnss0
>>> already working for droid 4.
>>
>> That's great.  But I think my recommendation still stands.  You want GPS
>> state to be synchronized with the overall modem state, etc...
> =

> Hmm sounds like ofono would benefit from using /dev/gnss0 in the
> long run though. I guess the situation is similar to having
> multiple computer mouse drivers earlier with their own interfaces
> vs standard /dev/input :)

Yep, agreed.  I already tried to nudge Pavel to propose something.

> =

>> I believe the utilities you mention should be good enough to decode the
>> basics.  I think someone has even tested these on a real network at some
>> point.  But the people working on CDMA have not contributed since ~2011,=
 so
>> I have no idea about the state of that code.  I was considering removing=
 it
>> given that CDMA is essentially defunct (or will be in a few years).
> =

> OK, sounds like we might need the CDMA PDU features for few more
> years though.

That's fine, as long as someone is actually using these.  Right now it =

is unmaintained code.

> =

> Oh, I think I forgot to answer your question regarding PM,
> there's nothing that the user space needs to except to avoid
> polling the /dev/motmdm* devices unnecessarily. And to type
> AT+SCRN=3D0 on /dev/motmdm1 when no notifications for signal
> strength and network status are needed.
> =


Right, but since /dev/motmdm1 would in theory belong exclusively to =

oFono, you probably still need some way of sending the screen 'off' =

command.  So in effect you're integrating power management with the =

telephony stack.

Regards,
-Denis

--===============0398081675264336758==--

