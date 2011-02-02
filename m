Content-Type: multipart/mixed; boundary="===============5152748220748004127=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Thu, 03 Feb 2011 00:06:37 +0100
Message-ID: <1296687997.1520.353.camel@aeonflux>
In-Reply-To: <E9010BA84901F04DBE0FC93A424E0E45010962D1@008-AM1MPN1-035.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5152748220748004127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

> >> - The history agent does not wait until the agent replies it has
> >>   handled the message, but instead it calls agent_request_dispatch
> >>   and then already returns to core (which acks the message to modem).
> > =

> > I know this actually. The missing piece is the storing to disk here to
> > spool the SMS history and call history in case no agent is present.
> =

> Ok. I just didn't see any mention of disk/file spooling in this
> patchset (nor in other existing plugins except the out-of-tree
> smshistory) one, and was not sure whether it is proposed to have
> spooling before or after the DBus hop.
> =

> But yes, if indeed your intention was specifically to add spooling
> to the ofono-side plugin already, I agree that would work.

I should have put a comment in the code to not confuse people ;)

> Although, the plugin needs to store to disk _always_, even if agent =

> is available. Or wait until the Dbus method reply is received (which
> I don't think is feasible). Otherwise following can happen:
>  =

>  - history_sms_received() called
>  - agent available, MessageReceived() called not async so not
>    waiting for reply
>  - history_sms_received() returns to src/sms.c, TPUs cleared/acked
>  -> zap, out of battery -> message potentially lost
> =

> This can be solved by spooling always.

Yes, it needs to always spool.

But you did realize that we are doing this in oFono right already for
all things. You can zap the battery out and oFono will recover.

> >> I'd prefer to have something like:
> >> http://people.freedesktop.org/~wjt/telepathy-spec-
> >> import_stored_messages/spec/Connection_Interface_Stored_Messages.html
> > =

> > How is this any better? If all messages get send when the agents
> > registers to oFono. And we can easily use D-Bus results to either
> > delete messages from the spool or not. Since D-Bus is asynchronous
> > and that will just work out fine.
> =

> Your plugin patch did not have/mention this functionality (message
> goes to /dev/null if no agent is registered), but if this is
> supposed to be there, then agreed, this'd work.
>  =

> So I think this comes down to how the history agent acknowledges
> the messages over DBus. E.g. single DBus MessageReceived method =

> with ok/nok response, or an explicit acknowledge method/signal (the
> StoredMessages telepathy implements the latter approach).
> =

> The main functional difference is the possibility to have
> multiple agents (as Mikhail noted), but this is perhaps something
> to debate whether it is really needed or not.

Multiple agents is a bad idea. I am not allowing this on purpose. It is
also not really needed anyway. There should be one path and one path
only towards the database storage.

Per design oFono is not this database storage.

> Otherwise, what I'm still not sure about is whether it's sane to =

> have possibly very long req-reply roundtrips, and e.g. multiple pending =

> calls of e.g. MessageReceived waiting for reply. I know it _can_ be =

> done, but is it a robust design and will it cause grey hairs to agent =

> implementors.. (I know many dbus bindings have default timeouts of =

> roughly ~30s for method calls -> dunno if this can cause havoc). I freely =

> admit my dbus skills/experience is not sufficient, so feedback is =

> welcome.

If the D-Bus timeout will at any time become a problem then your whole
system is in deep trouble. You can just set a proper D-Bus timeout to
begin with including dbus-daemon -1 default which translates to some
large default timeout.

> Based on my very informal poll, more people have voted for
> explicit acks in Telepathy style, but not all, so good arguments
> for/against are welcome.

This is an explicit ACK via the agent. It is just a lot less D-Bus
message to achieve the same result.

Sorry, but Telepathy is pretty much wasteful with D-Bus message. So I am
pretty skeptic here and rather go with a sane approach that uses the
minium number of D-Bus messages and still receiving the same result.

Regards

Marcel



--===============5152748220748004127==--

