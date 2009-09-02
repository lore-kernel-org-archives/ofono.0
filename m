Content-Type: multipart/mixed; boundary="===============4657965112512124746=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 18:38:29 +0300
Message-ID: <200909021838.29834.remi@remlab.net>
In-Reply-To: <200909021000.23069.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4657965112512124746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le mercredi 2 septembre 2009 18:00:22 Denis Kenzior, vous avez =C3=A9crit :
> Actually this one is missing from the API proposal.  Marcel already wanted
> the context type (internet, mms, wap, etc) information.  I've updated the
> proposed API in git.

This is not going to work.

Depending on the operator, you may have more than one "type" for a single =

context (e.g. WAP+MMS), or worse, multiple contexts of the same type (e.g. =

Internet with only Web and Internet with full IP).

> As discussed previously, we want oFono to manage this data, since it can =
do
> this by using the IMSI.  So if you insert a different operator SIM your A=
PN
> settings are magically updated for that operator.

I have a feeling this does not work either. If I upgrade my subscription, t=
he =

APN may change while not the IMSI, no?

> > In my proposal the "Status" variable was a three-state variable,
> > having the states "attached", "detached" and "suspended". "Suspended"
> > was specified to mean that the GPRS was attached, but temporarily not
> > available (for instance because of a 2G phone call or temporary loss
> > of cellular connectivity). In the IRC discussion someone said that
> > this property would not be part of Denis's API because the tri-state
> > variables were bad and the "suspended" status was not supported by
>
> So the general rule is that if a feature isn't explicitly allowed in
> 27.007, we do not support it.  There are exceptions to this of course. =

> 27.007 only supports two states for context: activated and deactivated.

Our general rule is that if we have a UI requirement, or better an actual u=
se =

case for it, we support it. Suspended GPRS fits both.

> > spec 27.007. However, the problem is that Maemo 5 already has UI
> > support for indicating that the connection is suspended, and that
> > makes it harder to drop the feature. Could the "suspended" status enum
> > still be left there, and just have the modems that don't support the
> > feature to never go to "suspended" mode?
>
> I'd rather not.
>
> If this feature is really required, then some sort of heuristic can be
> applied.  (e.g. Powered on, Attached on, but context is deactivated most
> likely means temporary unavailability of resources)

Is this some kind of joke? Don't you know the difference between pause and =

stop on your MP3 player and between suspend to memory and power off on your =

computer?

Second guessing does not fit in my definition of "easy to use self-
documenting" for an API.

> This really belong in the kernel.  Only the kernel can reliably know when=
 a
> network interface has been brought down and notify the interested
> applications with the statistics.

You're missing the point.

Yes, any body can extract the statistics for a running context. But data =

counters are cumulating. To compute the sum properly, there are but two =

options:
# Either the GPRS middleware requests kernel per-interface statistics right =

before destroying the interface, and sums with the earlier total.
# Or the modem does it internally.

There is no way some random userland interface application can do it just b=
y =

requesting the kernel, since it cannot know when to request those statistic=
s.

> Nokia hardware supports this explicitly, but many others don't.

That's irrelevant. Hardware support helps in the sense that it can include =

statistics for contexts external to Ofono. If the hardware does not support =

it, then it needs to be done manually in the GPRS middleware.

That won't make the requirement go away.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/

--===============4657965112512124746==--

