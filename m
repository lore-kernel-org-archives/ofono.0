Content-Type: multipart/mixed; boundary="===============7538635667767757917=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 13:27:16 -0600
Message-ID: <4D4C5314.8090401@gmail.com>
In-Reply-To: <A459777776EB4841B844E1134E7928740157CA1B@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7538635667767757917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

>> In the text message case we already provide the history plugin with
>> _everything_ that it needs.  If you want to implement a particular API,
>> then history is the right avenue to do so.  There is no inherent
>> benefit
>> of having oFono core do so and we do not want to introduce the concept
>> of a message store into oFono anyway.
>>
>>> So the ratio is 2/3 for the only event flow that is relevant for
>> performance, more likely.
>>> But I agree, it's a bit more efficient for simple plugins, provided
>> that they never fall off the bus.
>>
>> Lets put it this way, your proposal is 1.5x slower in the absolute best
>> case; worse if multiple clients subscribe to the signal, purposefully
>> or otherwise.
> =

> Nah, a signal delivery works like a multicast, whereas if you have multip=
le history agents to get notified about one event, you have to make a full =
method roundtrip to every one of them.
>

If you have multiple history agents going over D-Bus, that is your
problem ;)

>> Falling off the bus has nothing to do with this performance.  You can
>> make your history plugin detect the 'falling off the bus' events and
>> handle them appropriately (e.g. spool messages internally until the
>> consumer comes back.)
> =

> This is not implemented in the proposed patch. But I like how we are slow=
ly getting to the idea that spooling whole messages in oFono core is necess=
ary anyhow :)

Seriously, please go back to like, late 2009 archives on oFono and check
the history patches proposed back then.  You are seriously not adding
anything new to the discussion, just rehashing the same old arguments.
OBVIOUSLY you need to spool if you use a D-Bus based API, want
reliability and an agent is not connected.

But the assertion that the core has to perform the spooling is just
plain wrong.  There are cases when you do not need to spool, period
(e.g. well known filesystem store).  These are all details that are _out
of the scope_ of oFono and belong in the history plugin.

Regards,
-Denis

--===============7538635667767757917==--

