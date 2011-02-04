Content-Type: multipart/mixed; boundary="===============4029806719498898386=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 18:15:13 +0100
Message-ID: <1296839713.1520.388.camel@aeonflux>
In-Reply-To: <A459777776EB4841B844E1134E7928740157C82C@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4029806719498898386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

> > one of the really early design choices was to not expose TPDU outside
> > of
> > oFono core. We do not give TPDUs to history nor do we hand them out
> > over
> > D-Bus. That is a fundamental design decision and even after over 2
> > years
> > that is still the right one.
> =

> I totally agree. But it means that you have code in oFono to reliably sto=
re an ordered collection of stuff in a filesystem. I wouldn't like MeeGo de=
velopers to maintain very similar code in a different component, just for A=
PI adaptation reasons.

we are storing fragments reliable with a specific efficient way of doing
so. There is nothing generic about it.

> > > > Not everyone has the same requirements here, you can have systems
> > with
> > > > a
> > > > well defined store that do not need to cross the system/session bus
> > > > boundary for instance.
> > >
> > > They could use the pull-style API as well, having a push method with
> > a 100% success rate requirement is not necessary for this.
> > =

> > Can someone please sit down and start counting the number of D-Bus
> > messages and wakeup that are caused by exposing the message objects
> > instead of using an agent.
> =

> D-Bus messages at initialization of a storage-capable client:
> =

> 1. client connects to the oFono signal NewMessage.

So that are two D-Bus messages via AddMatch already.

> 2a. client calls ListMessages.
> 2b. oFono returns spooled messages.

These are already 4 D-Bus messages.

> If there are any messages, two more are needed:
> =

> 3a. client calls ExpungeMessages.
> 3b. oFono returns.

And another 2 for each message.

> When a new message is received:
> =

> 1. oFono emits a NewMessage signal.
> 2a. client calls ExpungeMessages.
> 2b. oFono returns.

These are another 3 per message.

And this does not include any status updates in case of submission
failed or delivery failed etc.

> Now if we implement a history plugin to serve this API, there will be all=
 of the above plus the history plugin registration and event storage roundt=
rips.
> =

> > And without using an agent you have no access control of who acks
> > messages.
> =

> You do, it's controlled by the security framework in D-Bus.
> Without checking security tokens, you cannot trust the agent, either.

So your proposal is to make the messages available to everybody and then
put a security framework around it to not let everybody see and access
them. Instead of just controlling initial access to who gets the
messages by controlling access to the agent.

I go for the latter idea and controlling a single access point instead
of having to deal with multiple. Just good security principle.

> > And additionally oFono does not store the read/unread states
> > either.
> =

> It doesn't have to in my proposal.
> =

> > oFono does not implement a message store.
> =

> ... while implementing a large part of the functionality needed for a sim=
ple intermediate message spool.

Let me repeat. oFono does NOT implement a message store. We are storing
intermediate fragments if needed. That is different.

> > > > > In all, we need three things from the oFono SMS API:
> > > > > * a property listing the spooled messages;
> > > > > * a method to expunge some of the messages;
> > > > > * a signal notifying of a new message in the spool.
> > > > >
> > > > Who
> > > > guarantees acking of messages?
> > >
> > > Control plane acking is guaranteed by oFono core itself, as we seem
> > to have established.
> > > A client then clears the spool, if the system is not dysfunctional.
> > =

> > I come to think that you are mixing up full SMS and TPDUs heavily here.
> > Please get straight what you want. As I explained above, the TPDUs are
> > oFono core business and not visible anywhere else. oFono only hands out
> > fully re-assembled messages.
> =

> That's what I mean too.

So if that is clear, why do we bother with the ACK thing again?

> > > > How many messages to spool?
> > >
> > > The filesystem is the only real limit. In a properly working system,
> > you won't have to spool too many messages.
> > =

> > Where, when, how.
> =

> The spool is cleared at a time when a client is running, for example when=
 the user session starts up.
> The storage agent's lifetime does not have to be tied to the lifetime of =
oFono, as one benefit.

I still don't get why messages need to be explicitly represented and
acked. The agent just works fine and no race conditions. Spooled
messages can just replayed once the agent registers.

> > As I said above, normally this should go like this:
> > =

> > 	oFono -> history plugin -> message store
> > 	oFono -> history plugin -> call history store
> > =

> > If the history plugin needs to spool, then that is fine. oFono is not
> > spooling for history plugin since there can be an unlimited number of
> > history plugin for various use cases.
> =

> If you collapse "history plugin" into oFono under a more handy pull-style=
 API, there can just as well be unlimited number of client usages for vario=
us use cases. Moreover, some of the actually confirmed use cases, in MeeGo =
no less, can be implemented in a simpler, less wasteful way.

There is no waste inside oFono right now and there is not waste via the
history plugin. Right now I don't really know how much more clearer I
can explain this.

> > > > When to throw away messages?
> > >
> > > When the client tells you to.
> > =

> > Which client? What happens if you have more then one client attempting
> > to access the messages
> =

> This is not a crime and may actually be useful?

And other clients can do that as easily and way more reliable and with
more status information (like read/unread) via the message store. And
that is what you really wanna do anyway.

> > or even acknowledge them.
> =

> This means either that the system is misconfigured, or the access control=
 is too permissive.

The basic security principle is to expose as less as possible. Think
about that for a bit.

> > If you wanna go via Telepathy, then you most likely need a Telepathy
> > specific history plugin. My example gave you a basic skeleton for it
> > and
> > you just need to add the on-disk spooling to it.
> =

> That's what we will most likely do, but it's an unnecessary stage.

I am getting a bit tired of explaining this over and over again. It is
not an unnecessary step. oFono is not a message store and it does not
store full messages for you. oFono works on fragments and fragments
alone.

Regards

Marcel



--===============4029806719498898386==--

