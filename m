Content-Type: multipart/mixed; boundary="===============1253045730126218315=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Sun, 05 Dec 2010 13:40:19 +0100
Message-ID: <1291552819.4795.121.camel@aeonflux>
In-Reply-To: <AANLkTimjMFz1c9U3P8YKALLwdCw+0W82+nuDRb49XsS3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1253045730126218315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > where is this timed running? I prefer the plugin just send a D-Bus
> > message to the timed directly instead of a Get/Changed API kind of
> > thing.
> =

> AFAIK, timed is in system bus. However, I fail to see how you can make
> this any simpler. In the end, one of the two entities has to implement
> a service that the other one uses. There also needs to be some
> synchronization for when the entities start up. A getter/signal API is
> also what timed uses in Harmattan, but of course if you have a better
> idea, I'm all ears.

is timed actually open source and I can have a look at it?

What is the advantage of oFono storing the time value from NITZ and
provide it over a getter/signal API. In that case we also need to store
a timestamp when we received the NITZ result. Otherwise the value has no
real meaning since we can not correlate it to anything.

That said, ofonod is not responsible for time tracking and so is not the
modem. This means that our time source is inaccurate by definition. Ans
so is our timestamp. And that makes the NITZ information useless that
retreive via a getter method. What do you wanna do with an inaccurate
time information?

Instead of trying to keep track of time inside oFono, I would propose
that we just send a method call with the currently received NITZ and
only when we receive them to a timed (if started).

Regards

Marcel



--===============1253045730126218315==--

