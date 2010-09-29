Content-Type: multipart/mixed; boundary="===============6820566865997577827=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/7] Add message agent interface documentation
Date: Wed, 29 Sep 2010 23:10:09 +0900
Message-ID: <1285769409.3417.33.camel@aeonflux>
In-Reply-To: <AANLkTik1EtJMwkX-pdMbnNikwaRPkj00Cbz1xeGMVVYA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6820566865997577827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > I just don't see text message going directly to the SMS application.
> > That application has to integrate with the storage.
> >
> > The UI needs to do too much work if it has to track SMS coming from an
> > agent, SMS inside the history and have to keep matching them up for the
> > user to display them nicely.
> >
> > Even for outgoing SMS the UI can just listen and follow Tracker's
> > information about the SMS. Same as for incoming ones.
> >
> > So in the end the signals are just here for some simple easy
> > demonstration. And we could actually remove them. Beside the
> > ImmediateMessage one of course. Since that doesn't need to be spooled
> > anyway. If you miss it then it is too late already anyway.
> =

> Telepathy-ring is the agent here. It needs to receive incoming SMSs
> and send outgoing ones. It needs to receive vCard and vCalendar
> objects as well as sending them. It needs to track outgoing messages,
> and map their statuses to Telepathy.

and how does it track outgoing messages? It can only tack outgoing
messages that it sends itself. How can it track outgoing messages from
other pieces of the system?

> History of messages (and calls) is stored elsewhere, most likely
> tracker by the call and messaging framework. What telepathy-ring needs
> is a simple and reliable way of talking to oFono. This is what my
> patches were trying to provide.
> =

> I don't understand what the hard to understand part here is. We won't
> use tracker for telepathy-ring to talk to oFono, that is for sure.
> Sure, I can rewrite these patches as a plugin, but that doesn't make
> it any simpler or better. Just different and more complicated in fact.
> For instance, now telepathy-ring would need to register two agents
> instead of one.

I don't think that just stuffing everything in telepathy-ring is a good
idea. You can of course do that, but that is not the only piece of
software in the system using oFono.

oFono is not a system where its only purpose it to make Telepathy happy.
It can be used perfectly fine without Telepathy and that is a valid use
case for oFono.

If you wanna bloat Telepathy and telepathy-ring into something huge that
is suppose to do everything, then that is fine, but it is not done at
the expense of oFono and other potential users of the oFono API.

> > And yes, the history of SMS is needed. See my comments above.
> =

> No, the agent (telepathy-ring here) doesn't need to use history, if
> the agent interface works as it should. That is, messages get queued
> if no agent is there to handle them, or something similar to that
> effect.

How do you handle outgoing messages? Especially outgoing messages send
by other pieces in your system.

> >> > What we did not like is being able to register multiple agents.  So
> >> > instead we decided that using explicit APIs for this is better.
> >>
> >> Explicit API for what? Don't your proposal allow multiple agents as
> >> well?
> >
> > How many applications do you expect to handle vCards and vCalendars. I
> > see one and that is the contacts application.
> =

> Still, your proposal allows multiple agents to register, same as mine.

Either way is fine here. This will be figured out later on. Maybe
multiple agents will make actually sense in some cases. We will see.

> > Same for WAP Push notifications. That is either the separate WAP Push
> > daemon or the MMS application/stack.
> >
> > Having multiple agents sounds nice on paper, but I don't see the real
> > use case inside a system. You really don't wanna receive a vCard or
> > vCalendar twice. That would confuse the user.
> =

> If this is the case, then I don't see a real need for the
> RegisterAgent() and UnregisterAgent() methods at all. Static
> registration by providing configuration files at a well known location
> works much better, since then package management can then enforce
> singleton status for such agents.

And that is what we will be not doing. I already told you that we tried
this with BlueZ and it failed horrible. I am not repeating that mistake.
The blind usage of D-Bus activation is not a good idea. In addition you
have the system vs session bus boundaries.

Regards

Marcel



--===============6820566865997577827==--

