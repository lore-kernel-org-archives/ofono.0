Content-Type: multipart/mixed; boundary="===============5994723414490697922=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 19:17:43 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157CA1B@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <4D4C450B.7060905@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5994723414490697922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ext Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Friday, February 04, 2011 8:27 PM
> To: Zabaluev Mikhail (Nokia-MS/Helsinki)
> Cc: ofono(a)ofono.org
> Subject: Re: [RFC 2/2] doc: Add description for history agent interface
> =

> Moreover, you have to realize that there are non-text messages in that
> tpdu store that go via an entirely different path and unless there's a
> relevant plugin handling these, they will not go through history.

The relevant consumers could pull those just as well...
But this is a good argument: with plugins there is no need for a "janitor" =
to purge messages that nobody knows what to do with. Also helps if we don't=
 want unrelated consumers know about certain events.

> In the text message case we already provide the history plugin with
> _everything_ that it needs.  If you want to implement a particular API,
> then history is the right avenue to do so.  There is no inherent
> benefit
> of having oFono core do so and we do not want to introduce the concept
> of a message store into oFono anyway.
> =

> > So the ratio is 2/3 for the only event flow that is relevant for
> performance, more likely.
> > But I agree, it's a bit more efficient for simple plugins, provided
> that they never fall off the bus.
> =

> Lets put it this way, your proposal is 1.5x slower in the absolute best
> case; worse if multiple clients subscribe to the signal, purposefully
> or otherwise.

Nah, a signal delivery works like a multicast, whereas if you have multiple=
 history agents to get notified about one event, you have to make a full me=
thod roundtrip to every one of them.

> Falling off the bus has nothing to do with this performance.  You can
> make your history plugin detect the 'falling off the bus' events and
> handle them appropriately (e.g. spool messages internally until the
> consumer comes back.)

This is not implemented in the proposed patch. But I like how we are slowly=
 getting to the idea that spooling whole messages in oFono core is necessar=
y anyhow :)

Best regards,
  Mikhail

--===============5994723414490697922==--

