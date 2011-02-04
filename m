Content-Type: multipart/mixed; boundary="===============7132528340602021822=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 11:22:07 -0800
Message-ID: <1296847327.1520.397.camel@aeonflux>
In-Reply-To: <A459777776EB4841B844E1134E7928740157CA1B@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7132528340602021822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

> > In the text message case we already provide the history plugin with
> > _everything_ that it needs.  If you want to implement a particular API,
> > then history is the right avenue to do so.  There is no inherent
> > benefit
> > of having oFono core do so and we do not want to introduce the concept
> > of a message store into oFono anyway.
> > =

> > > So the ratio is 2/3 for the only event flow that is relevant for
> > performance, more likely.
> > > But I agree, it's a bit more efficient for simple plugins, provided
> > that they never fall off the bus.
> > =

> > Lets put it this way, your proposal is 1.5x slower in the absolute best
> > case; worse if multiple clients subscribe to the signal, purposefully
> > or otherwise.
> =

> Nah, a signal delivery works like a multicast, whereas if you have multip=
le history agents to get notified about one event, you have to make a full =
method roundtrip to every one of them.

So how many consumers of history events to you expect in a system. My
proposal limited this clearly to 1 and only 1. That was on purpose.

> > Falling off the bus has nothing to do with this performance.  You can
> > make your history plugin detect the 'falling off the bus' events and
> > handle them appropriately (e.g. spool messages internally until the
> > consumer comes back.)
> =

> This is not implemented in the proposed patch. But I like how we are slow=
ly getting to the idea that spooling whole messages in oFono core is necess=
ary anyhow :)

Let me repeat this. The oFono core is not a message spooling system or a
message storage. If spooling is needed it needs to be done in the
history plugin.

Regards

Marcel



--===============7132528340602021822==--

