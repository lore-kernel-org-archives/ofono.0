Content-Type: multipart/mixed; boundary="===============7551140408227358074=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 3/7] Add message agent interface documentation
Date: Wed, 29 Sep 2010 08:56:10 +0300
Message-ID: <1285739770.3863.59.camel@tucson.research.nokia.com>
In-Reply-To: <4CA2A400.1050102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7551140408227358074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-09-29 at 04:27 +0200, ext Denis Kenzior wrote:
> Hi Aki,
> =

> On 09/27/2010 11:54 AM, Aki Niemi wrote:
> > ---
> >  doc/message-api.txt |   51 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 files changed, 51 insertions(+), 0 deletions(-)
> > =

> > diff --git a/doc/message-api.txt b/doc/message-api.txt
> > index 9e8d02f..5bdc98d 100644
> > --- a/doc/message-api.txt
> > +++ b/doc/message-api.txt
> > @@ -38,6 +38,29 @@ Methods		dict GetProperties()
> >  			message could be queued successfully, this method
> >  			returns an object path to the created Message object.
> >  =

> > +		void RegisterAgent(object path)
> > +
> > +			Registers an agent to handle received messages.
> > +
> > +			The object path defines the path of the agent that
> > +			will be called when either a text message, a vCard
> > +			object or a vCalendar object is ready to be
> > +			dispatched.
> > +
> > +			Possible Errors: [service].Error.InvalidArguments
> > +					 [service].Error.InvalidFormat
> > +					 [service].Error.InUse
> =

> So me and Marcel had a very long talk about this.  We are basically fine
> using an Agent for text messaging (however, we agreed that it isn't
> really necessary, the signals and history cover all realistic use cases).

So you agree to an agent interface for receiving SMSs only? Because
there is no usable API to history, so you can't offer that as an
alternative.

My preference would've been a single agent for all text(ish) messages,
though.

There's also no need for separate signal handlers and history lookup, if
the agent interface also does spooling, or can otherwise guarantee the
agent always receives the messages.

Also, telepathy-ring won't have any use for call history; call history
is stored by the UIs along with the history of other types of calls. As
for messages, the history interface is not needed if the main message
interface works as it should.

> What we did not like is being able to register multiple agents.  So
> instead we decided that using explicit APIs for this is better.

Explicit API for what? Don't your proposal allow multiple agents as
well?

> Please
> see the detailed proposal in doc/smartmessaging-api.txt and
> doc/pushnotification-api.txt.

Honestly, if this is really a proposal, then shouldn't it have been sent
as an RFC patch to the mailing list? It's a bit hard to comment on it
now.

For new interfaces, I'd prefer all project participants to work
according to the same set of rules.

> The SmartMessaging API will handle reception of vCalendars and vCards.
> This API also covers sending of these objects.

Why array{byte} and not just string?

> The PushNotification API will handle WAP PUSH requests.
> =

> We'd like to do all of this from a plugin, so the last thing to figure
> out is the plumbing for plugins to be able to track the lifetime of the
> sms atom and register the interface appropriately.

Implement them as history plugins?

Cheers,
Aki


--===============7551140408227358074==--

