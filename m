Content-Type: multipart/mixed; boundary="===============1689941314421828909=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 18:07:07 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157C97A@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <4D4C31E4.1060008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1689941314421828909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ext Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Friday, February 04, 2011 7:06 PM
> To: ofono(a)ofono.org
> Cc: Zabaluev Mikhail (Nokia-MS/Helsinki)
> Subject: Re: [RFC 2/2] doc: Add description for history agent interface
> =

> > I totally agree. But it means that you have code in oFono to reliably
> store an ordered collection of stuff in a filesystem. I wouldn't like
> MeeGo developers to maintain very similar code in a different
> component, just for API adaptation reasons.
> =

> No we do not.  We have code to reliably store tpdus, fragments not
> re-assembled messages.  It is not ordered or anything else you make it
> out to be.  Why don't you actually read the sms_assembly code and tell
> me if it is usable for anything else.  The code for storing assembled
> messages would be _completely_ different.

Why, you already cache fragments by their respective message refs efficient=
ly.
The only thing missing is a thin API to provide a view on complete messages.

> > D-Bus messages at initialization of a storage-capable client:
> >
> > 1. client connects to the oFono signal NewMessage.
> > 2a. client calls ListMessages.
> > 2b. oFono returns spooled messages.
> >
> > If there are any messages, two more are needed:
> >
> > 3a. client calls ExpungeMessages.
> > 3b. oFono returns.
> >
> > When a new message is received:
> >
> > 1. oFono emits a NewMessage signal.
> > 2a. client calls ExpungeMessages.
> > 2b. oFono returns.
> >
> > Now if we implement a history plugin to serve this API, there will be
> all of the above plus the history plugin registration and event storage
> roundtrips.
> =

> You are proving Marcel's point here, the Agent has about 1/2 as many
> round trips as your proposal.
> =

> 1. client calls RegisterAgent()

An interesting question here: should oFono core monitor NameOwnerChanged fo=
r the agent's service name, just in case it disappears from the bus? What's=
 the failure mode for this case?

> 2. For each new message the agent's HandleMessage() method is called

2a. agent returns.

So the ratio is 2/3 for the only event flow that is relevant for performanc=
e, more likely.
But I agree, it's a bit more efficient for simple plugins, provided that th=
ey never fall off the bus.

Best regards,
  Mikhail

--===============1689941314421828909==--

