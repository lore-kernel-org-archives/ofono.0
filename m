Content-Type: multipart/mixed; boundary="===============1110018865854314398=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [RFCv3] Add message agent API
Date: Wed, 08 Sep 2010 18:39:55 +0300
Message-ID: <AANLkTimrsDCHVAyP-ZrjMEvv-o+X__qybDjhfA=Z009r@mail.gmail.com>
In-Reply-To: <1283954687.6640.35.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1110018865854314398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/9/8 Marcel Holtmann <marcel@holtmann.org>:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void RegisterAgent(object pa=
th, string type)
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Registers an agent to handle received messages.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
The object path defines the path of the agent that
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
will be called when a message is ready to be
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
dispatched. =C2=A0The type parameters accepts a MIME
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
type of the messages this agent is willing to
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
accept. =C2=A0Some common types include:
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "text/plain" - Regular text messages
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "text/x-vcard" - vCard objects
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "text/calendar" - vCalendar objects
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "application/vnd.oma.push" - WAP push
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "application/x-sms-agent" - Any datagram
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Wildcards are not allowed as the MIME subtype, but
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
registering an agent on a generic port is supported.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
For instance, to listen on port 5678, the agent
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
would need to register using type:
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "application/x-sms-agent;port=3D5678"
>
> so my obvious question here is, what kind of x-sms-agent type
> applications do you expect? The need for text, vcard, vcalendar and push
> messages is pretty clear. I still haven't figured out what other
> applications are out there that we want do support with this. Can you
> please give us some concert examples.

Example: a voice and video over IP client that doesn't drain the
battery in half a day. My server sends a wakeup over SMS on an
incoming call.

Example: a device lock service. I send a binary SMS to my stolen phone
on a well-known port containing a cryptographic token, causing my
phone to lock and/or wipe itself clean.

Fact is, SMS is still the most widely available and power-efficient
rendezvous service on a mobile phone. It would be silly not to support
it to its full potential.

> I think that everybody else has abandoned any other SMS message types.

Quite the contrary. Every other mobile telephony API out there that I
know of has the ability to send and receive binary messages on an
arbitrary port.

Cheers,
Aki

--===============1110018865854314398==--

