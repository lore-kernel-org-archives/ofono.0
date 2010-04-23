Content-Type: multipart/mixed; boundary="===============3617082235331138637=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix: transaction id usage in gisi/server.c
Date: Fri, 23 Apr 2010 16:34:44 +0200
Message-ID: <1272033284.22838.81.camel@localhost.localdomain>
In-Reply-To: <0f719e09b0048c8e277f38b1937eeb11@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3617082235331138637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> >> Casting to or from void is not necessary.
> > =

> > Oh, it is. If a struct sockaddr_pn structure is casted directly to
> > struct sockaddr, gcc will issue alignment warning on ARM.
> =

> The cast-align warning is a can of false positives. First that warning
> should probably not be enabled. It does nothing on x86, and it's a waste =
of
> time with ARM and other pointer-picky platforms.

I don't have an ARM platform easy available to test this, but this can
be fixed by just memcpy the data structures.

> Most importantly, using -Werror _by_default_ is a _damn_idiotic_ idea. Be=
en
> there, done that. One cannot know what weird warning any given compiler or
> version thereof will ever return. And then I don't need to mention "bugs"
> in header files from underlying components. Even changing GCC optimization
> levels can yield different conflicting warnings. That's known to happen f=
or
> uninitialized values detection, which relies on optimization-dependent co=
de
> analysis as an example.

The rant about -Werror doesn't help. We are using it to catch nasty
constructs that might fail on any given platform. We have used -Werror
inside BlueZ and ConnMan for a long time now. Yes, sometimes new GCC
warnings come up and we fix that, but it was always good to have these.
And yes, it is true that you need to use -O2 to enable a bunch of these
warnings.

So in conclusion, the -Werror stays and we need to fix the code to
compile cleanly on any given platform. It is possible, so lets get this
done. Feel free to post the warnings on the mailing list and I am more
than happy to look into it.

Regards

Marcel



--===============3617082235331138637==--

