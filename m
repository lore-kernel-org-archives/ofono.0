Content-Type: multipart/mixed; boundary="===============6220516839696946608=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 09:23:15 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157C4D3@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <4D4AD3CC.5070206@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6220516839696946608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ext Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Thursday, February 03, 2011 6:12 PM
> To: ofono(a)ofono.org
> Cc: Zabaluev Mikhail (Nokia-MS/Helsinki)
> Subject: Re: [RFC 2/2] doc: Add description for history agent interface
> =

> >> I am not really getting what you are saying. oFono will reassembly
> the
> >> message for you piece by piece. And we are making sure fragments are
> >> stored reliably. However once the message is complete we give it to
> >> history for further processing. Mainly to get it stored in the
> >> database.
> >
> > The part I don't get is, if you do store TPDUs reliably as you seem
> to be required to do anyway, why not keep the assembled messages until
> the client tells you that it is no longer interested in them?
> > This will remove a whole class of issues with history agent's
> availability, reliability, and performance.
> =

> How exactly is this different from the history plugin storing the
> message and letting client ack it?  You can implement that now with
> history easily enough.

True, but it will look like oFono does 90% of the work needed -- and then h=
ands it to the history plugin which basically redoes it, only to offer a mo=
re convenient API.

> Not everyone has the same requirements here, you can have systems with
> a
> well defined store that do not need to cross the system/session bus
> boundary for instance.

They could use the pull-style API as well, having a push method with a 100%=
 success rate requirement is not necessary for this.

> > In all, we need three things from the oFono SMS API:
> > * a property listing the spooled messages;
> > * a method to expunge some of the messages;
> > * a signal notifying of a new message in the spool.
> >
> =

> As I mentioned before, you can do that now using history anyway.  But
> in
> the general case I do not agree this belongs as an official API.  Who
> guarantees acking of messages?

Control plane acking is guaranteed by oFono core itself, as we seem to have=
 established.
A client then clears the spool, if the system is not dysfunctional.

> How many messages to spool?

The filesystem is the only real limit. In a properly working system, you wo=
n't have to spool too many messages.

> When to throw away messages?

When the client tells you to.

Best regards,
  Mikhail

--===============6220516839696946608==--

