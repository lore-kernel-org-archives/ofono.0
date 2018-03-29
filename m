Content-Type: multipart/mixed; boundary="===============6591936402945213907=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 12/12] qmi: use standard endian macros
Date: Thu, 29 Mar 2018 12:53:06 -0500
Message-ID: <d825cd9f-02f2-761a-f64a-2b8495604b0f@gmail.com>
In-Reply-To: <62bc7d95-5651-1f04-99f9-81b338b3549e@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6591936402945213907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

> But what I really don't get is is what the point is of ell providing =

> functionality that's already provided in libc.=C2=A0 GLib did this for =

> portability reasons, but ell targets Linux and that means glibc, uclibc, =

> and musl and they all provide these standard things.=C2=A0 libell as a =

> complement to libc makes sense; there are aspects of libell that are =

> _seriously_ awesome.=C2=A0 But l_strdup, endian macros, l_malloc, etc. ar=
e =

> just reinventing the wheel, as you put it yesterday.=C2=A0 As a programme=
r, I =

> know the semantics of strdup... but now I need to use l_strdup, the =

> semantics of which I can't know without checking; this, unfortunately, =

> is a good way of scaring people away from your project.

Yes, there is a bit of reinvention inside ell.  I would argue it is very =

tiny actually, contained inside ell/util.h.  Mostly it is to make ell =

look similar enough to glib so that people feel comfortable using it and =

to make code migration from glib to ell relatively painless and =

straightforward.

We are using glib across many large projects (BlueZ, oFono, ConnMan, =

neard, etc) and ell inside iwd.  The ones using glib will move to ell =

eventually.  So familiarity with how stuff works (and looks like) trumps =

everything else.  E.g. it is much easier to just convert g_new to l_new =

than calloc.  Or g_strdup to l_strdup.  And once you wrapped l_new and =

provided l_free, it just makes sense to add l_malloc.

Regards,
-Denis

--===============6591936402945213907==--

