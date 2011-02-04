Content-Type: multipart/mixed; boundary="===============8559595610759935171=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 13:58:51 +0100
Message-ID: <1296824331.1520.373.camel@aeonflux>
In-Reply-To: <A459777776EB4841B844E1134E7928740157C4D3@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8559595610759935171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

> > >> I am not really getting what you are saying. oFono will reassembly
> > the
> > >> message for you piece by piece. And we are making sure fragments are
> > >> stored reliably. However once the message is complete we give it to
> > >> history for further processing. Mainly to get it stored in the
> > >> database.
> > >
> > > The part I don't get is, if you do store TPDUs reliably as you seem
> > to be required to do anyway, why not keep the assembled messages until
> > the client tells you that it is no longer interested in them?
> > > This will remove a whole class of issues with history agent's
> > availability, reliability, and performance.
> > =

> > How exactly is this different from the history plugin storing the
> > message and letting client ack it?  You can implement that now with
> > history easily enough.
> =

> True, but it will look like oFono does 90% of the work needed -- and then=
 hands it to the history plugin which basically redoes it, only to offer a =
more convenient API.

one of the really early design choices was to not expose TPDU outside of
oFono core. We do not give TPDUs to history nor do we hand them out over
D-Bus. That is a fundamental design decision and even after over 2 years
that is still the right one.

There should be only one piece of software that does handle SMS TPDU and
that piece of software is oFono. Everything else is insane since it is
guaranteed to fail. You do not wanna get involved in TPDU business from
any other piece of the software.

oFono does exactly what it needs, it spools message fragments. It does
not spool messages. Full messages spooling is up to the history plugin
if that is required.

> > Not everyone has the same requirements here, you can have systems with
> > a
> > well defined store that do not need to cross the system/session bus
> > boundary for instance.
> =

> They could use the pull-style API as well, having a push method with a 10=
0% success rate requirement is not necessary for this.

Can someone please sit down and start counting the number of D-Bus
messages and wakeup that are caused by exposing the message objects
instead of using an agent.

And without using an agent you have no access control of who acks
messages. And additionally oFono does not store the read/unread states
either. oFono does not implement a message store.

> > > In all, we need three things from the oFono SMS API:
> > > * a property listing the spooled messages;
> > > * a method to expunge some of the messages;
> > > * a signal notifying of a new message in the spool.
> > >
> > =

> > As I mentioned before, you can do that now using history anyway.  But
> > in
> > the general case I do not agree this belongs as an official API.  Who
> > guarantees acking of messages?
> =

> Control plane acking is guaranteed by oFono core itself, as we seem to ha=
ve established.
> A client then clears the spool, if the system is not dysfunctional.

I come to think that you are mixing up full SMS and TPDUs heavily here.
Please get straight what you want. As I explained above, the TPDUs are
oFono core business and not visible anywhere else. oFono only hands out
fully re-assembled messages.

> > How many messages to spool?
> =

> The filesystem is the only real limit. In a properly working system, you =
won't have to spool too many messages.

Where, when, how. As I said above, normally this should go like this:

	oFono -> history plugin -> message store
	oFono -> history plugin -> call history store

If the history plugin needs to spool, then that is fine. oFono is not
spooling for history plugin since there can be an unlimited number of
history plugin for various use cases.

> > When to throw away messages?
> =

> When the client tells you to.

Which client? What happens if you have more then one client attempting
to access the messages or even acknowledge them.

If you wanna go via Telepathy, then you most likely need a Telepathy
specific history plugin. My example gave you a basic skeleton for it and
you just need to add the on-disk spooling to it.

Regards

Marcel



--===============8559595610759935171==--

