Content-Type: multipart/mixed; boundary="===============5670901176056705860=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Wed, 02 Feb 2011 17:43:46 +0100
Message-ID: <1296665027.1520.332.camel@aeonflux>
In-Reply-To: <E9010BA84901F04DBE0FC93A424E0E45DF41C8@008-AM1MPN1-036.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5670901176056705860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

> here's a few comments about the SMS delivery part. These apply to =

> the history plugin interface as well, so not specifically only about =

> this patchset.

and this is just a RFC so I really want comments.

> > +		void MessageReceived(dict info)
> > +
> > +			Incoming text message.
> > +
> > +			The info dictionary contains 'Identifier', 'Sender',
> > +			'Text', 'LocalTime' and 'RemoteTime' properties.
> > +
> > +			Possible Errors: None
> =

> If this is the primary way to deliver SMS'es reliably, then this =

> raises some problems. Take these more as discussion points. I'm looking
> this in terms of gaps to what we have implemented in past
> products (e.g. N900).

The history API is the primary way to get messages stored reliable in a
database. This D-Bus API is intended to get accross the system/session
bus boundary and allow this for Tracker integration.

For example with commhistory-daemon or something similar.

> - This history agent has no error handling for SMS storage. In case =

>   device storage is full, or device is malfunctioning otherwise, =

>   the messages should not be acked to network as stored.
> 	- This relates to another TODO -> persistant storage of RX-TPDUs
> 	  for incomplete messages. If we've acked a TPDU to network,
>  	  we must have stored it to persistant storage.

Where are we not doing this. We do store the fragments. If it is a
complete message, we signal it directly.

> - The history agent does not wait until the agent replies it has =

>   handled the message, but instead it calls agent_request_dispatch  =

>   and then already returns to core (which acks the message to modem). So =

>   if you run out of battery (or some more abrupt cause) at this =

>   point, you will lose messages.
> 	- The smshistory ofono plugin at http://repo.meego.com/MeeGo/builds/trun=
k/daily/handset/repos/source/smshistory-0.1.8-1.7.src.rpm
> 	  ... solves this part, but I wonder whether it's ok to block
> 	  the ofono event loop until disk i/o is fully synced (this can
>         take suprisingly long on a loaded system).

I know this actually. The missing piece is the storing to disk here to
spool the SMS history and call history in case no agent is present.

> I'd prefer to have something like:
> http://people.freedesktop.org/~wjt/telepathy-spec-import_stored_messages/=
spec/Connection_Interface_Stored_Messages.html =

> =

> This approach has many benefits:
>  - it allows more flexibility to how the persistant i/o is =

>    implemented (you don't have to complete i/o during DBus
>    method->reply, or during a single function callback),
>  - the agent can recover if device is shutdown when there are
>    some messages in the TPDU spool, but not acked to message
>    store (upon restart, commhistory client will ask any pending
>    messages from the spool)

How is this any better? If all messages get send when the agents
registers to oFono. And we can easily use D-Bus results to either delete
messages from the spool or not. Since D-Bus is asynchronous and that
will just work out fine.

> This has been succesfully used in N900 for reliable delivery of =

> SMS'es. In N900/MeeGo this would be used by commhistorydaemon (
> http://wiki.meego.com/Architecture/Documentation/Communications/Telephony=
_IM )
> which stores the messages to Tracker, and upon completing
> commit to persistant storage, it removes the message from
> message spool with a explicit DBus method (StoredMessages.ExpungeMessages)
> =

> Any comments to this?

See comment above. This is nothing different than just using the agent
callback to retrieve them.

> PS You could of course solve this out-of-ofono by having =

>    one more disk spool in between, but then you'd have =

>    three spools already:
>      - the yet-to-be-implemented RX-TPDU spool (plugins don't have =

>        visibility to TPDUs so this must be done in core)
>      - out-of-tree spool for full messages (something like the existing
>        smshistory plugin)
>      - final store (e.g. Tracker on MeeGo)
>    But I'd much rather live with just two spools (one for TPDUs
>    and the final storage).

This is not just about SMS actually. It is also for call history. So the
history plugin needs to take care of the spooling and from there it can
go directly into the database like Tracker.

Regards

Marcel



--===============5670901176056705860==--

