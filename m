Content-Type: multipart/mixed; boundary="===============1235153105595982290=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Wed, 02 Feb 2011 20:32:28 +0100
Message-ID: <1296675148.1520.346.camel@aeonflux>
In-Reply-To: <A459777776EB4841B844E1134E7928740157A1C4@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1235153105595982290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

> > How is this any better? If all messages get send when the agents
> > registers to oFono. And we can easily use D-Bus results to either
> > delete
> > messages from the spool or not. Since D-Bus is asynchronous and that
> > will just work out fine.
> =

> Am I right in assuming that the SMS history roundtrip is not performed be=
fore acking the constituent TPDUs to the network? If it is, we have problem=
s even regardless of D-Bus method call timeouts.

we are not delivering TPDUs to history, we are delivering messages.
oFono will reassemble the segments for you. This is oFono's job.

I am not really getting what you are saying. oFono will reassembly the
message for you piece by piece. And we are making sure fragments are
stored reliably. However once the message is complete we give it to
history for further processing. Mainly to get it stored in the database.

> > This is not just about SMS actually. It is also for call history. So
> > the
> > history plugin needs to take care of the spooling and from there it can
> > go directly into the database like Tracker.
> =

> Is it necessary/more practical to register a history service callable by =
oFono, rather than just signal change events and provide methods for a clie=
nt to acknowledge that it has handled them?
> =

> I can see a few reasons why the explicit history service API might be nee=
ded:
> =

> 1. The history service may be activated on demand by a well-known name.
> If this is in fact mandatory, we'll have problems in making telepathy-rin=
g serve as the history plugin. We want it in the storage path for architect=
ural simplicity: commhistory daemon is by design a Telepathy logger that wo=
rks basically the same way for all connection managers.

oFono is running as system service. It can not interact directly with
Tracker or Telepathy since both are only available on the session bus.

If you wanna activate some session bus based history service then that
is out of the scope of oFono.

As I explained to Kai on IRC, I would personally not go via Telepathy
since it is one extra (or even multiple) piece in the puzzle for the
call history and the message history reaches your database. Which is
Tracker I presume.

If you can accept this extra risk factors in the architecture and ensure
that everything is reliable that is fine with me. You do might have to
design your unique history plugin that interacts directly with TP-ring
then. And to that extend also has its own spool.

> 2. You don't want multiple entities to observe events pertaining to oFono=
 communication history and be able to control spooling while not being regu=
lated by oFono.
> If this is a concern, I think it's outweighed by greater simplicity and f=
lexibility, and the idea that access policy should be defined outside of th=
e implementation.

The example that I sent around here was clearly limited to one consumer
and one consumer only. And that on purpose. I think that every storage
entity. Being it commhistory alone, or Tracker alone or all together
with TP-ring, they need a special history plugin to serve the exact
purpose.

> 3. For call history, you need reliable storage of call events before you =
can proceed handling the call with the interactive client signaling.
> I thought this is entirely up to the application and as such does not hav=
e to be in scope for oFono. Correct me if I'm wrong.

oFono is not decided on how this reliable storage of history is done. It
is up to the history plugin. As said above, you might really need one
exactly for your specific needs.

I would be more than happy to be able to transfer this directly into
Tracker or Telepathy, but as outlined above that is not possible because
of the session vs system bus problem.

Regards

Marcel



--===============1235153105595982290==--

