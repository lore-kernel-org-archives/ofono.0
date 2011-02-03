Content-Type: multipart/mixed; boundary="===============4620608869372832422=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Thu, 03 Feb 2011 12:22:57 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157B54B@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <1296675148.1520.346.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4620608869372832422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of ext Marcel Holtmann
> Sent: Wednesday, February 02, 2011 9:32 PM
> To: ofono(a)ofono.org
> Subject: RE: [RFC 2/2] doc: Add description for history agent interface
> =

> > > How is this any better? If all messages get send when the agents
> > > registers to oFono. And we can easily use D-Bus results to either
> > > delete
> > > messages from the spool or not. Since D-Bus is asynchronous and
> that
> > > will just work out fine.
> >
> > Am I right in assuming that the SMS history roundtrip is not
> performed before acking the constituent TPDUs to the network? If it is,
> we have problems even regardless of D-Bus method call timeouts.
> =

> we are not delivering TPDUs to history, we are delivering messages.
> oFono will reassemble the segments for you. This is oFono's job.
> =

> I am not really getting what you are saying. oFono will reassembly the
> message for you piece by piece. And we are making sure fragments are
> stored reliably. However once the message is complete we give it to
> history for further processing. Mainly to get it stored in the
> database.

The part I don't get is, if you do store TPDUs reliably as you seem to be r=
equired to do anyway, why not keep the assembled messages until the client =
tells you that it is no longer interested in them?
This will remove a whole class of issues with history agent's availability,=
 reliability, and performance.

> > Is it necessary/more practical to register a history service callable
> by oFono, rather than just signal change events and provide methods for
> a client to acknowledge that it has handled them?
> >
> > I can see a few reasons why the explicit history service API might be
> needed:
> >
> > 1. The history service may be activated on demand by a well-known
> name.
> > If this is in fact mandatory, we'll have problems in making
> telepathy-ring serve as the history plugin. We want it in the storage
> path for architectural simplicity: commhistory daemon is by design a
> Telepathy logger that works basically the same way for all connection
> managers.
> =

> oFono is running as system service. It can not interact directly with
> Tracker or Telepathy since both are only available on the session bus.
> =

> If you wanna activate some session bus based history service then that
> is out of the scope of oFono.
> =

> As I explained to Kai on IRC, I would personally not go via Telepathy
> since it is one extra (or even multiple) piece in the puzzle for the
> call history and the message history reaches your database. Which is
> Tracker I presume.

It's a solved piece in the puzzle. We do it for other protocols this way an=
d are reasonably happy with it.
And sure, this is out of oFono scope.

> If you can accept this extra risk factors in the architecture and
> ensure
> that everything is reliable that is fine with me. You do might have to
> design your unique history plugin that interacts directly with TP-ring
> then. And to that extend also has its own spool.

It does not have to, if we can implement StoredMessages in terms of oFono.
If we could expunge messages from oFono spool explicitly rather than by ser=
ving a method call roundtrip, it would be natural. In all, we need three th=
ings from the oFono SMS API:
* a property listing the spooled messages;
* a method to expunge some of the messages;
* a signal notifying of a new message in the spool.

And this obviates the need to have a history agent service, if I understood=
 correct that you actually don't care about enforcing reliable storage for =
call events on oFono side.

> > 2. You don't want multiple entities to observe events pertaining to
> oFono communication history and be able to control spooling while not
> being regulated by oFono.
> > If this is a concern, I think it's outweighed by greater simplicity
> and flexibility, and the idea that access policy should be defined
> outside of the implementation.
> =

> The example that I sent around here was clearly limited to one consumer
> and one consumer only. And that on purpose. I think that every storage
> entity. Being it commhistory alone, or Tracker alone or all together
> with TP-ring, they need a special history plugin to serve the exact
> purpose.

So a platform integrating oFono cannot choose to implement call and message=
 logging separately. It needs to supply the whole hog in one plugin, and fi=
lter out the events it is not interested in at this level.

> > 3. For call history, you need reliable storage of call events before
> you can proceed handling the call with the interactive client
> signaling.
> > I thought this is entirely up to the application and as such does not
> have to be in scope for oFono. Correct me if I'm wrong.
> =

> oFono is not decided on how this reliable storage of history is done.
> It
> is up to the history plugin. As said above, you might really need one
> exactly for your specific needs.
> =

> I would be more than happy to be able to transfer this directly into
> Tracker or Telepathy, but as outlined above that is not possible
> because
> of the session vs system bus problem.

It is certainly possible, if the client is the one responsible for the fina=
l storage, and oFono simply keeps incoming SMSs until a client tells it to =
drop them.

Best regards,
  Mikhail

--===============4620608869372832422==--

