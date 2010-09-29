Content-Type: multipart/mixed; boundary="===============6688650320073819127=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/7] Add message agent interface documentation
Date: Wed, 29 Sep 2010 18:52:44 +0900
Message-ID: <1285753964.3417.19.camel@aeonflux>
In-Reply-To: <1285739770.3863.59.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6688650320073819127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > >  doc/message-api.txt |   51 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  1 files changed, 51 insertions(+), 0 deletions(-)
> > > =

> > > diff --git a/doc/message-api.txt b/doc/message-api.txt
> > > index 9e8d02f..5bdc98d 100644
> > > --- a/doc/message-api.txt
> > > +++ b/doc/message-api.txt
> > > @@ -38,6 +38,29 @@ Methods		dict GetProperties()
> > >  			message could be queued successfully, this method
> > >  			returns an object path to the created Message object.
> > >  =

> > > +		void RegisterAgent(object path)
> > > +
> > > +			Registers an agent to handle received messages.
> > > +
> > > +			The object path defines the path of the agent that
> > > +			will be called when either a text message, a vCard
> > > +			object or a vCalendar object is ready to be
> > > +			dispatched.
> > > +
> > > +			Possible Errors: [service].Error.InvalidArguments
> > > +					 [service].Error.InvalidFormat
> > > +					 [service].Error.InUse
> > =

> > So me and Marcel had a very long talk about this.  We are basically fine
> > using an Agent for text messaging (however, we agreed that it isn't
> > really necessary, the signals and history cover all realistic use cases=
).
> =

> So you agree to an agent interface for receiving SMSs only? Because
> there is no usable API to history, so you can't offer that as an
> alternative.

please see my comments about the history integration. That is something
we have to tackle pretty soon the right way. Currently it is just
hacking around it.

So we need to have an oFono history plugin that talks to tracker
directly via a Tracker API on the system D-Bus. This needs to be done
similar on how we handle the integration of ConnMan and pacrunner for
the proxy configuration.

The oFono history plugin needs to track when Tracker becomes available
and if, then send the spooled history and keep sending it until Tracker
gets off the bus.

This way we have Tracker having always the history. And Tracker can be
autostarted via D-Bus activation or whatever method when the UI actually
becomes available. And the UI should retrieve SMS and call history
directly from Tracker.

With this design, we can also properly secure the SMS and call history
and ensure that nothing gets into the wrong hands.

And if the preferred storage method is not Tracker, then that is fine as
well. It can be just anther history plugin talking to a different
system.

> My preference would've been a single agent for all text(ish) messages,
> though.
> =

> There's also no need for separate signal handlers and history lookup, if
> the agent interface also does spooling, or can otherwise guarantee the
> agent always receives the messages.

I just don't see text message going directly to the SMS application.
That application has to integrate with the storage.

The UI needs to do too much work if it has to track SMS coming from an
agent, SMS inside the history and have to keep matching them up for the
user to display them nicely.

Even for outgoing SMS the UI can just listen and follow Tracker's
information about the SMS. Same as for incoming ones.

So in the end the signals are just here for some simple easy
demonstration. And we could actually remove them. Beside the
ImmediateMessage one of course. Since that doesn't need to be spooled
anyway. If you miss it then it is too late already anyway.

> Also, telepathy-ring won't have any use for call history; call history
> is stored by the UIs along with the history of other types of calls. As
> for messages, the history interface is not needed if the main message
> interface works as it should.

I think this is wrong. Call history needs to be stored in Tracker and
then either the UI or Telepathy can access it via Tracker.

And yes, the history of SMS is needed. See my comments above.

> > What we did not like is being able to register multiple agents.  So
> > instead we decided that using explicit APIs for this is better.
> =

> Explicit API for what? Don't your proposal allow multiple agents as
> well?

How many applications do you expect to handle vCards and vCalendars. I
see one and that is the contacts application.

Same for WAP Push notifications. That is either the separate WAP Push
daemon or the MMS application/stack.

Having multiple agents sounds nice on paper, but I don't see the real
use case inside a system. You really don't wanna receive a vCard or
vCalendar twice. That would confuse the user.

> > Please
> > see the detailed proposal in doc/smartmessaging-api.txt and
> > doc/pushnotification-api.txt.
> =

> Honestly, if this is really a proposal, then shouldn't it have been sent
> as an RFC patch to the mailing list? It's a bit hard to comment on it
> now.
> =

> For new interfaces, I'd prefer all project participants to work
> according to the same set of rules.

Next time we will. This was an oversight on my part. I was discussing
this with Denis F2F in long details. Going forth and back between
different proposals on the table. This is the one that might sense right
away.

The API is 100% intuitive for developers having to write the vCard and
vCalendar support and also to integrate with WAP Push notifications.
They exactly what to expect and they know exactly what they get.

> > The SmartMessaging API will handle reception of vCalendars and vCards.
> > This API also covers sending of these objects.
> =

> Why array{byte} and not just string?

So if I remember this correctly then we don't know the encoding of the
vCard/vCalendar. For all intense and purposes it could be some weird
encoding that is not UTF-8. And if we don't know the encoding, we can't
convert it. If you tell me that we know the encoding, then we can change
that to a string.

> > The PushNotification API will handle WAP PUSH requests.
> > =

> > We'd like to do all of this from a plugin, so the last thing to figure
> > out is the plumbing for plugins to be able to track the lifetime of the
> > sms atom and register the interface appropriately.
> =

> Implement them as history plugins?

As history plugin or some SMS specific plugin or something else. Doesn't
matter. I am pretty much convinced that we can handle this way better
and cleaner inside plugins than trying to have one fits all D-Bus API.
We just don't have enough information on the use cases of the API to
make it that generic.

We know our use cases and for these use we write plugins that expose a
dedicated API for that use that. That is easy and simpler. Only try to
solve something that you do understand. And right now we have an idea
about Smart Messaging and the WAP Push stuff. Everything else is kinda a
bit blur in form of real use cases and really understanding is
completely.

Regards

Marcel



--===============6688650320073819127==--

