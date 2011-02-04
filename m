Content-Type: multipart/mixed; boundary="===============2784263686526830297=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 16:52:42 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157C82C@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <1296824331.1520.373.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2784263686526830297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of ext Marcel Holtmann
> Sent: Friday, February 04, 2011 2:59 PM
> To: ofono(a)ofono.org
> Subject: RE: [RFC 2/2] doc: Add description for history agent interface
> =

> one of the really early design choices was to not expose TPDU outside
> of
> oFono core. We do not give TPDUs to history nor do we hand them out
> over
> D-Bus. That is a fundamental design decision and even after over 2
> years
> that is still the right one.

I totally agree. But it means that you have code in oFono to reliably store=
 an ordered collection of stuff in a filesystem. I wouldn't like MeeGo deve=
lopers to maintain very similar code in a different component, just for API=
 adaptation reasons.

> > > Not everyone has the same requirements here, you can have systems
> with
> > > a
> > > well defined store that do not need to cross the system/session bus
> > > boundary for instance.
> >
> > They could use the pull-style API as well, having a push method with
> a 100% success rate requirement is not necessary for this.
> =

> Can someone please sit down and start counting the number of D-Bus
> messages and wakeup that are caused by exposing the message objects
> instead of using an agent.

D-Bus messages at initialization of a storage-capable client:

1. client connects to the oFono signal NewMessage.
2a. client calls ListMessages.
2b. oFono returns spooled messages.

If there are any messages, two more are needed:

3a. client calls ExpungeMessages.
3b. oFono returns.

When a new message is received:

1. oFono emits a NewMessage signal.
2a. client calls ExpungeMessages.
2b. oFono returns.

Now if we implement a history plugin to serve this API, there will be all o=
f the above plus the history plugin registration and event storage roundtri=
ps.

> And without using an agent you have no access control of who acks
> messages.

You do, it's controlled by the security framework in D-Bus.
Without checking security tokens, you cannot trust the agent, either.

> And additionally oFono does not store the read/unread states
> either.

It doesn't have to in my proposal.

> oFono does not implement a message store.

... while implementing a large part of the functionality needed for a simpl=
e intermediate message spool.

> > > > In all, we need three things from the oFono SMS API:
> > > > * a property listing the spooled messages;
> > > > * a method to expunge some of the messages;
> > > > * a signal notifying of a new message in the spool.
> > > >
> > > Who
> > > guarantees acking of messages?
> >
> > Control plane acking is guaranteed by oFono core itself, as we seem
> to have established.
> > A client then clears the spool, if the system is not dysfunctional.
> =

> I come to think that you are mixing up full SMS and TPDUs heavily here.
> Please get straight what you want. As I explained above, the TPDUs are
> oFono core business and not visible anywhere else. oFono only hands out
> fully re-assembled messages.

That's what I mean too.

> > > How many messages to spool?
> >
> > The filesystem is the only real limit. In a properly working system,
> you won't have to spool too many messages.
> =

> Where, when, how.

The spool is cleared at a time when a client is running, for example when t=
he user session starts up.
The storage agent's lifetime does not have to be tied to the lifetime of oF=
ono, as one benefit.

> As I said above, normally this should go like this:
> =

> 	oFono -> history plugin -> message store
> 	oFono -> history plugin -> call history store
> =

> If the history plugin needs to spool, then that is fine. oFono is not
> spooling for history plugin since there can be an unlimited number of
> history plugin for various use cases.

If you collapse "history plugin" into oFono under a more handy pull-style A=
PI, there can just as well be unlimited number of client usages for various=
 use cases. Moreover, some of the actually confirmed use cases, in MeeGo no=
 less, can be implemented in a simpler, less wasteful way.

> > > When to throw away messages?
> >
> > When the client tells you to.
> =

> Which client? What happens if you have more then one client attempting
> to access the messages

This is not a crime and may actually be useful?

> or even acknowledge them.

This means either that the system is misconfigured, or the access control i=
s too permissive.

> If you wanna go via Telepathy, then you most likely need a Telepathy
> specific history plugin. My example gave you a basic skeleton for it
> and
> you just need to add the on-disk spooling to it.

That's what we will most likely do, but it's an unnecessary stage.

Best regards,
  Mikhail

--===============2784263686526830297==--

