Content-Type: multipart/mixed; boundary="===============2345992812587998769=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Wed, 02 Feb 2011 13:23:59 +0000
Message-ID: <E9010BA84901F04DBE0FC93A424E0E45DF41C8@008-AM1MPN1-036.mgdnok.nokia.com>
In-Reply-To: <1296581340-21570-2-git-send-email-marcel@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2345992812587998769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

here's a few comments about the SMS delivery part. These apply to =

the history plugin interface as well, so not specifically only about =

this patchset.

On 01 Feb 2011, Marcel Holtmann wrote:
> +		void MessageReceived(dict info)
> +
> +			Incoming text message.
> +
> +			The info dictionary contains 'Identifier', 'Sender',
> +			'Text', 'LocalTime' and 'RemoteTime' properties.
> +
> +			Possible Errors: None

If this is the primary way to deliver SMS'es reliably, then this =

raises some problems. Take these more as discussion points. I'm looking
this in terms of gaps to what we have implemented in past
products (e.g. N900).

- This history agent has no error handling for SMS storage. In case =

  device storage is full, or device is malfunctioning otherwise, =

  the messages should not be acked to network as stored.
	- This relates to another TODO -> persistant storage of RX-TPDUs
	  for incomplete messages. If we've acked a TPDU to network,
 	  we must have stored it to persistant storage.

- The history agent does not wait until the agent replies it has =

  handled the message, but instead it calls agent_request_dispatch  =

  and then already returns to core (which acks the message to modem). So =

  if you run out of battery (or some more abrupt cause) at this =

  point, you will lose messages.
	- The smshistory ofono plugin at http://repo.meego.com/MeeGo/builds/trunk/=
daily/handset/repos/source/smshistory-0.1.8-1.7.src.rpm
	  ... solves this part, but I wonder whether it's ok to block
	  the ofono event loop until disk i/o is fully synced (this can
        take suprisingly long on a loaded system).

I'd prefer to have something like:
http://people.freedesktop.org/~wjt/telepathy-spec-import_stored_messages/sp=
ec/Connection_Interface_Stored_Messages.html =


This approach has many benefits:
 - it allows more flexibility to how the persistant i/o is =

   implemented (you don't have to complete i/o during DBus
   method->reply, or during a single function callback),
 - the agent can recover if device is shutdown when there are
   some messages in the TPDU spool, but not acked to message
   store (upon restart, commhistory client will ask any pending
   messages from the spool)
 =

This has been succesfully used in N900 for reliable delivery of =

SMS'es. In N900/MeeGo this would be used by commhistorydaemon (
http://wiki.meego.com/Architecture/Documentation/Communications/Telephony_I=
M )
which stores the messages to Tracker, and upon completing
commit to persistant storage, it removes the message from
message spool with a explicit DBus method (StoredMessages.ExpungeMessages)

Any comments to this?

PS You could of course solve this out-of-ofono by having =

   one more disk spool in between, but then you'd have =

   three spools already:
     - the yet-to-be-implemented RX-TPDU spool (plugins don't have =

       visibility to TPDUs so this must be done in core)
     - out-of-tree spool for full messages (something like the existing
       smshistory plugin)
     - final store (e.g. Tracker on MeeGo)
   But I'd much rather live with just two spools (one for TPDUs
   and the final storage).


--===============2345992812587998769==--

