Content-Type: multipart/mixed; boundary="===============8893299020570473452=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 3/7] Add message agent interface documentation
Date: Wed, 29 Sep 2010 15:45:30 +0300
Message-ID: <AANLkTik1EtJMwkX-pdMbnNikwaRPkj00Cbz1xeGMVVYA@mail.gmail.com>
In-Reply-To: <1285753964.3417.19.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8893299020570473452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/9/29 Marcel Holtmann <marcel@holtmann.org>:
> I just don't see text message going directly to the SMS application.
> That application has to integrate with the storage.
>
> The UI needs to do too much work if it has to track SMS coming from an
> agent, SMS inside the history and have to keep matching them up for the
> user to display them nicely.
>
> Even for outgoing SMS the UI can just listen and follow Tracker's
> information about the SMS. Same as for incoming ones.
>
> So in the end the signals are just here for some simple easy
> demonstration. And we could actually remove them. Beside the
> ImmediateMessage one of course. Since that doesn't need to be spooled
> anyway. If you miss it then it is too late already anyway.

Telepathy-ring is the agent here. It needs to receive incoming SMSs
and send outgoing ones. It needs to receive vCard and vCalendar
objects as well as sending them. It needs to track outgoing messages,
and map their statuses to Telepathy.

History of messages (and calls) is stored elsewhere, most likely
tracker by the call and messaging framework. What telepathy-ring needs
is a simple and reliable way of talking to oFono. This is what my
patches were trying to provide.

I don't understand what the hard to understand part here is. We won't
use tracker for telepathy-ring to talk to oFono, that is for sure.
Sure, I can rewrite these patches as a plugin, but that doesn't make
it any simpler or better. Just different and more complicated in fact.
For instance, now telepathy-ring would need to register two agents
instead of one.

> And yes, the history of SMS is needed. See my comments above.

No, the agent (telepathy-ring here) doesn't need to use history, if
the agent interface works as it should. That is, messages get queued
if no agent is there to handle them, or something similar to that
effect.

>> > What we did not like is being able to register multiple agents. =C2=A0=
So
>> > instead we decided that using explicit APIs for this is better.
>>
>> Explicit API for what? Don't your proposal allow multiple agents as
>> well?
>
> How many applications do you expect to handle vCards and vCalendars. I
> see one and that is the contacts application.

Still, your proposal allows multiple agents to register, same as mine.

> Same for WAP Push notifications. That is either the separate WAP Push
> daemon or the MMS application/stack.
>
> Having multiple agents sounds nice on paper, but I don't see the real
> use case inside a system. You really don't wanna receive a vCard or
> vCalendar twice. That would confuse the user.

If this is the case, then I don't see a real need for the
RegisterAgent() and UnregisterAgent() methods at all. Static
registration by providing configuration files at a well known location
works much better, since then package management can then enforce
singleton status for such agents.

Cheers,
Aki

--===============8893299020570473452==--

