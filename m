Content-Type: multipart/mixed; boundary="===============7489711598576380351=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: api property notification order
Date: Sun, 01 Jan 2012 18:14:46 -0600
Message-ID: <4F00F6F6.8050501@gmail.com>
In-Reply-To: <CAHiDW_HcL72aqnazPCSB8LrepEAbJkm161U77QJTpzKqrhWTNQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7489711598576380351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 01/03/2012 03:55 AM, Jussi Kukkonen wrote:
> Hi,
> =

> I'm wondering if there could be some additional promises made by the
> API about the order of certain property changes and method call
> returns. I realize what I'm talking about is fairly close to an API
> change so it's more like a discussion starter than a ready suggestion.
> =

> The exact problem I ran into is that property changes that are a
> result of a API method call are notified _after_ the method call

In general most operations that affect a single property are implemented
as 'method return, then signal' semantics.  However, there are a few
exceptions and oFono really does not make any guarantees on the order.
The reason this was chosen is that it tends to work a bit nicer with
certain D-Bus bindings than the alternative.  Other than the
aforementioned reason, I do not believe there is a fundamental advantage
to one order or the other in such cases, but I'd love to hear any
arguments arguing otherwise from a UI-writer perspective.

> returns. From an API user point of view that is wrong. As an example I
> thought this would be a fairly logical way to handle PIN resets:
>   * property change SimManager.PinRequired=3D"puk" -> show pin reset UI t=
o user
>   * user enters PUK and new PIN -> call SimManager.PinReset()
>   * wait for method to return, present any errors. In particular
> org.ofono.Error.Failed:
>     "It looks like you entered the wrong PUK. You can try again X more
> times before the SIM is permanently locked"
> Doing that will mislead the user really badly as the Retries-property
> hasn't been decreased yet...
> =


Ah, but the problem here is really not the ordering.  The problem is
that this is a fairly complicated transaction, requiring several calls
to the driver and affecting several attributes at once. Not only do the
pin retries have to be checked, but also what the new PIN required is or
whether the SIM is blocked forever. e.g. you might actually have run out
of PUK retries and blocked your SIM forever.  To add additional
complexity, not all modem drivers support querying pin retries, or we
simply do not have the AT command details available...

What is happening here is that the method return is generated purely on
the success / failure of the pin reset operation, not

> From my point of view the order of events should be:
>  1. properties that are less likely to trigger UI actions themselves
> (e.g. "Retries", "ServiceNumbers")
>  2. properties that can be expected to trigger UI actions themselves
> (e.g. "PinRequired")
>  3. method call returns
> The distinction between 1 and 2 is sugar coating but unless method
> calls return after property changes, UI development will be more
> complex than I thought.
> =


In general I'm open to the idea of querying pin retries and pin type
before returning from PIN/PUK related method calls.  However, this
probably needs to be studied a bit more carefully for feasibility and
impact.

Regards,
-Denis

--===============7489711598576380351==--

