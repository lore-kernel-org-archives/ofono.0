Content-Type: multipart/mixed; boundary="===============2103482522244356589=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] Add agent API to message atom
Date: Tue, 31 Aug 2010 10:04:54 -0500
Message-ID: <4C7D1A16.1090400@gmail.com>
In-Reply-To: <1283258260.7452.13.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2103482522244356589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

>>> This of course means that we need a bit more intelligent matching of the
>>> handled types. In general I am against the overhead of regex for this. I
>>> prefer glob style matching with just * and ?. That should be good
>>> enough. If you really need regex pattern matching then then I think a
>>> specialized oFono plugin with its own APIs is the way to go.
>>
>> This was basically what I was thinking, too, with the addition of ^
>> and $ for matching at the end or beginning of a message.
> =

> within GLib we have glob pattern matching functions, but nothing that
> additionally takes ^ and $. Why do you think this would be useful and
> needed? How many message agents to you expect to be running that are not
> using port numbers? Do you have some examples messages in mind?
> =


I'm still not seeing the usefulness of glob/regex matching for text
messages.  Are we dealing with some legacy SMS format, like RFC 2822
compatibility?  If so, making specific API might be better.

>>>> +Methods              void ImmediateMessage(string message, dict info)
>>>> +
>>>> +                     New immediate (class 0) SMS received.  Info has =
Sender,
>>>> +                     LocalSentTime, and SentTime information.  Sender
>>>> +                     address is given in string format.  LocalSentTim=
e and
>>>> +                     SentTime are given in string form using ISO8601 =
format.
>>>
>>> Should these really be delivered via an agent?
>>
>> Why not?
> =

> These class 0 message are special and I think the home screen applet can
> just use the current D-Bus signal to deal with them. I don't think that
> we need special handling for them.
> =


I agree with Marcel here, immediate messages are destined for the home
screen and are not even tracked in history.

>>>> +             void IncomingMessage(string message, dict info)
>>>> +
>>>> +                     New incoming text SMS received.  Info has Sender,
>>>> +                     LocalSentTime, and SentTime information.
>>>> +
>>>> +             void IncomingPush(array{byte} message, dict info)
>>>> +
>>>> +                     New incoming push message received.  Info has Se=
nder,
>>>> +                     LocalSentTime, SentTime, and ApplicationId infor=
mation.
>>>> +
>>>> +             void IncomingApplication(array{byte} message, dict info)
>>>> +
>>>> +                     New incoming application message received.  Info=
 has
>>>> +                     Sender, LocalSentTime, SentTime, DestinationPort=
, and
>>>> +                     SourcePort information.
>>>
>>> Why the difference between Push and Application. The dict could be
>>> easily used here to differentiate.
>>
>> True. And in fact we discussed this in IRC with Denis a bit and
>> decided that separating WAP push makes little sense overall. If the
>> agent needs to decode the WSP anyway, we're not providing much value
>> add in oFono just decoding the X-Wap-Application-Id header field. So
>> the agent might as well just use the application ports to register.
> =

> Personally I like the idea of doing the whole WSP decoding inside oFono,
> but if we have WAP Push over IP transport and the WAP Push daemon has to
> do the decoding again anyway, this seems to be not a good idea.

I said almost the same thing on IRC ;)

Someone also mentioned sending of binary SMS messages.  I want to avoid
giving applications ability to do that over D-Bus completely.  There are
only a few of these that are required, namely Send VCard and Send VCal,
so a dedicated set of methods would be better.  If we go in this
direction, then receiving VCards and VCals should also have dedicated
DBus API.

This leaves App/Port addressing useful for WSPs and maybe carrier
specific Visual Voicemail messages.  Given that, I'm not entirely
convinced RegisterApplicationAgent is a good idea...

Regards,
-Denis



--===============2103482522244356589==--

