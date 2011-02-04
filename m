Content-Type: multipart/mixed; boundary="===============1203772656988809786=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 11:01:39 -0800
Message-ID: <1296846099.1520.394.camel@aeonflux>
In-Reply-To: <A459777776EB4841B844E1134E7928740157C9DC@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1203772656988809786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

> > > Why, you already cache fragments by their respective message refs
> > efficiently.
> > > The only thing missing is a thin API to provide a view on complete
> > messages.
> > =

> > we are not storing the complete message. We give it to the history API.
> =

> Somehow we never got to the "because" part in this discussion. Or is it a=
 dogma in oFono?

because oFono is NOT a message storage.

Every system will have a different message storage. We have history API
for abstracting the storage problem.

> > > > > D-Bus messages at initialization of a storage-capable client:
> > > > >
> > > > > 1. client connects to the oFono signal NewMessage.
> > > > > 2a. client calls ListMessages.
> > > > > 2b. oFono returns spooled messages.
> > > > >
> > > > > If there are any messages, two more are needed:
> > > > >
> > > > > 3a. client calls ExpungeMessages.
> > > > > 3b. oFono returns.
> > > > >
> > > > > When a new message is received:
> > > > >
> > > > > 1. oFono emits a NewMessage signal.
> > > > > 2a. client calls ExpungeMessages.
> > > > > 2b. oFono returns.
> > > > >
> > > > > Now if we implement a history plugin to serve this API, there
> > will be
> > > > all of the above plus the history plugin registration and event
> > storage
> > > > roundtrips.
> > > >
> > > > You are proving Marcel's point here, the Agent has about 1/2 as
> > many
> > > > round trips as your proposal.
> > > >
> > > > 1. client calls RegisterAgent()
> > >
> > > An interesting question here: should oFono core monitor
> > NameOwnerChanged for the agent's service name, just in case it
> > disappears from the bus? What's the failure mode for this case?
> > =

> > You do have read my RFC patch, right? It does exactly this.
> =

> Sorry, I only jumped into the discussion after it has started and did not=
 read the patch.
> But now that I do, I see an additional AddMatch and a GetOwnerName in thi=
s flow.
> =

> And the failure mode of the agent disconnecting is... to drop events on t=
he floor???

Who said that? D-Bus is an asynchronous message bus with a method call
and a method return message. Where do you see events being dropped?

> > > > 2. For each new message the agent's HandleMessage() method is
> > called
> > >
> > > 2a. agent returns.
> > >
> > > So the ratio is 2/3 for the only event flow that is relevant for
> > performance, more likely.
> > > But I agree, it's a bit more efficient for simple plugins, provided
> > that they never fall off the bus.
> > =

> > What has falling off the bus to do with this?
> =

> If the whole setup is unreliable, advantages in performance are less pert=
inent.

There is nothing unreliable here from an oFono point of view. If your
agent crashes then that is the agent problem.

Regards

Marcel



--===============1203772656988809786==--

