Content-Type: multipart/mixed; boundary="===============2455398666585390275=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Wed, 02 Feb 2011 18:14:53 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157A1C4@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <1296665027.1520.332.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2455398666585390275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of ext Marcel Holtmann
> Sent: Wednesday, February 02, 2011 6:44 PM
> To: ofono(a)ofono.org
> Subject: RE: [RFC 2/2] doc: Add description for history agent interface
> =

> > here's a few comments about the SMS delivery part. These apply to
> > the history plugin interface as well, so not specifically only about
> > this patchset.
> =

> and this is just a RFC so I really want comments.
> =

> > > +		void MessageReceived(dict info)
> > > +
> > > +			Incoming text message.
> > > +
> > > +			The info dictionary contains 'Identifier', 'Sender',
> > > +			'Text', 'LocalTime' and 'RemoteTime' properties.
> > > +
> > > +			Possible Errors: None
> >
> > If this is the primary way to deliver SMS'es reliably, then this
> > raises some problems. Take these more as discussion points. I'm
> looking
> > this in terms of gaps to what we have implemented in past
> > products (e.g. N900).
> =

> The history API is the primary way to get messages stored reliable in a
> database. This D-Bus API is intended to get accross the system/session
> bus boundary and allow this for Tracker integration.
> =

> For example with commhistory-daemon or something similar.
> =

> > - This history agent has no error handling for SMS storage. In case
> >   device storage is full, or device is malfunctioning otherwise,
> >   the messages should not be acked to network as stored.
> > 	- This relates to another TODO -> persistant storage of RX-TPDUs
> > 	  for incomplete messages. If we've acked a TPDU to network,
> >  	  we must have stored it to persistant storage.
> =

> Where are we not doing this. We do store the fragments. If it is a
> complete message, we signal it directly.
> =

> > - The history agent does not wait until the agent replies it has
> >   handled the message, but instead it calls agent_request_dispatch
> >   and then already returns to core (which acks the message to modem).
> So
> >   if you run out of battery (or some more abrupt cause) at this
> >   point, you will lose messages.
> > 	- The smshistory ofono plugin at
> http://repo.meego.com/MeeGo/builds/trunk/daily/handset/repos/source/sms
> history-0.1.8-1.7.src.rpm
> > 	  ... solves this part, but I wonder whether it's ok to block
> > 	  the ofono event loop until disk i/o is fully synced (this can
> >         take suprisingly long on a loaded system).
> =

> I know this actually. The missing piece is the storing to disk here to
> spool the SMS history and call history in case no agent is present.
> =

> > I'd prefer to have something like:
> > http://people.freedesktop.org/~wjt/telepathy-spec-
> import_stored_messages/spec/Connection_Interface_Stored_Messages.html
> >
> > This approach has many benefits:
> >  - it allows more flexibility to how the persistant i/o is
> >    implemented (you don't have to complete i/o during DBus
> >    method->reply, or during a single function callback),
> >  - the agent can recover if device is shutdown when there are
> >    some messages in the TPDU spool, but not acked to message
> >    store (upon restart, commhistory client will ask any pending
> >    messages from the spool)
> =

> How is this any better? If all messages get send when the agents
> registers to oFono. And we can easily use D-Bus results to either
> delete
> messages from the spool or not. Since D-Bus is asynchronous and that
> will just work out fine.

Am I right in assuming that the SMS history roundtrip is not performed befo=
re acking the constituent TPDUs to the network? If it is, we have problems =
even regardless of D-Bus method call timeouts.

> This is not just about SMS actually. It is also for call history. So
> the
> history plugin needs to take care of the spooling and from there it can
> go directly into the database like Tracker.

Is it necessary/more practical to register a history service callable by oF=
ono, rather than just signal change events and provide methods for a client=
 to acknowledge that it has handled them?

I can see a few reasons why the explicit history service API might be neede=
d:

1. The history service may be activated on demand by a well-known name.
If this is in fact mandatory, we'll have problems in making telepathy-ring =
serve as the history plugin. We want it in the storage path for architectur=
al simplicity: commhistory daemon is by design a Telepathy logger that work=
s basically the same way for all connection managers.

2. You don't want multiple entities to observe events pertaining to oFono c=
ommunication history and be able to control spooling while not being regula=
ted by oFono.
If this is a concern, I think it's outweighed by greater simplicity and fle=
xibility, and the idea that access policy should be defined outside of the =
implementation.

3. For call history, you need reliable storage of call events before you ca=
n proceed handling the call with the interactive client signaling.
I thought this is entirely up to the application and as such does not have =
to be in scope for oFono. Correct me if I'm wrong.

Best regards,
  Mikhail


--===============2455398666585390275==--

