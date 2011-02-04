Content-Type: multipart/mixed; boundary="===============8551103488945408495=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 18:32:08 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157C9B3@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <1296839713.1520.388.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8551103488945408495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of ext Marcel Holtmann
> Sent: Friday, February 04, 2011 7:15 PM
> To: ofono(a)ofono.org
> Subject: RE: [RFC 2/2] doc: Add description for history agent interface
> =

> > > Can someone please sit down and start counting the number of D-Bus
> > > messages and wakeup that are caused by exposing the message objects
> > > instead of using an agent.
> >
> > D-Bus messages at initialization of a storage-capable client:
> >
> > 1. client connects to the oFono signal NewMessage.
> =

> So that are two D-Bus messages via AddMatch already.

There doesn't need to be a reply, but yeah, just in case dbus-daemon refuse=
s.

> > 2a. client calls ListMessages.
> > 2b. oFono returns spooled messages.
> =

> These are already 4 D-Bus messages.

Right... but this is done once in the client's process lifetime.

> > If there are any messages, two more are needed:
> >
> > 3a. client calls ExpungeMessages.
> > 3b. oFono returns.
> =

> And another 2 for each message.

No, it's for the whole list of spooled messages.

> > When a new message is received:
> >
> > 1. oFono emits a NewMessage signal.
> > 2a. client calls ExpungeMessages.
> > 2b. oFono returns.
> =

> These are another 3 per message.
> =

> And this does not include any status updates in case of submission
> failed or delivery failed etc.

Um, that's for the outbound queue?
But those would be just signals; the plugin serves a full call roundtrip in=
 these cases?

> > You do, it's controlled by the security framework in D-Bus.
> > Without checking security tokens, you cannot trust the agent, either.
> =

> So your proposal is to make the messages available to everybody and
> then
> put a security framework around it to not let everybody see and access
> them. Instead of just controlling initial access to who gets the
> messages by controlling access to the agent.

You mean, the first caller to register an agent gets inherent trust, no fur=
ther access control needed?

> > > > > > In all, we need three things from the oFono SMS API:
> > > > > > * a property listing the spooled messages;
> > > > > > * a method to expunge some of the messages;
> > > > > > * a signal notifying of a new message in the spool.
> > > > > >
> > > > > Who
> > > > > guarantees acking of messages?
> > > >
> > > > Control plane acking is guaranteed by oFono core itself, as we
> seem
> > > to have established.
> > > > A client then clears the spool, if the system is not
> dysfunctional.
> > >
> > > I come to think that you are mixing up full SMS and TPDUs heavily
> here.
> > > Please get straight what you want. As I explained above, the TPDUs
> are
> > > oFono core business and not visible anywhere else. oFono only hands
> out
> > > fully re-assembled messages.
> >
> > That's what I mean too.
> =

> So if that is clear, why do we bother with the ACK thing again?

Dennis asked about acking; I assumed he actually means who drives removal o=
f messages from the spool.

> > > > > How many messages to spool?
> > > >
> > > > The filesystem is the only real limit. In a properly working
> system,
> > > you won't have to spool too many messages.
> > >
> > > Where, when, how.
> >
> > The spool is cleared at a time when a client is running, for example
> when the user session starts up.
> > The storage agent's lifetime does not have to be tied to the lifetime
> of oFono, as one benefit.
> =

> I still don't get why messages need to be explicitly represented and
> acked. The agent just works fine and no race conditions. Spooled
> messages can just replayed once the agent registers.

Hm, is it a push API that desperately wants to be an inverted pull API as w=
ell? :)

> The basic security principle is to expose as less as possible. Think
> about that for a bit.

I'd defer to the security framework in matters of security, not to race con=
ditions in registering an agent.

Regards,
  Mikhail

--===============8551103488945408495==--

