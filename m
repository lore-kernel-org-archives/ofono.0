Content-Type: multipart/mixed; boundary="===============4676466080766027172=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: DBus APIs
Date: Wed, 13 May 2009 11:51:01 -0500
Message-ID: <200905131151.01568.denkenz@gmail.com>
In-Reply-To: <4A0AE49E.8000408@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4676466080766027172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Wednesday 13 May 2009 10:17:50 Sebastian Mancke wrote:
> Hi,
>
> I just saw the new project and was wondering why there is a completely
> new project for this purpose.
>
> For me, ofone looks very similar to the freesmartphone.org initiative.
> Did you take a deep look into other existing projects? What are your
> opinions not to join those efforts?

We had a very deep look actually, and not only freesmartphone, but also =

Qtopia.  These projects are very similar to oFono on the surface, but their =

APIs just do not fill our needs.  E.g. to have a telephony stack that is GC=
F-
certification ready and can be used by UI developers with minimal effort on =

their part.

In the case of Qtopia it carries too much legacy baggage. In the case of FS=
O: =

any API that exposes such low-level details as SMS DCS will never be good =

enough.  UI developers simply should never have to care.

>
> In the case of freesmartphone.org I appreciate the goal of focusing on
> the design of the DBus APIs, instead of 'just' an implementation. It
> would be really cool to get alternative Implementations (e.g. written in
> C) for those APIs. On the other hand it would be too bad not to regard
> the experiences they made.

You're assuming that oFono developers do not have previous telephony =

experience themselves.  Not a fair assumption at all ;)  We have our own id=
eas =

and as pointed out above, we did learn from the FSO project.

Regards,
-Denis

--===============4676466080766027172==--

