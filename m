Content-Type: multipart/mixed; boundary="===============1826982447238483803=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 4/4] atmodem/lte: proto and authentication handling
Date: Mon, 15 Oct 2018 12:08:30 -0500
Message-ID: <5785f114-4a21-1613-b98c-96be19d2f891@gmail.com>
In-Reply-To: <87a9d0c5-0ddf-f165-eff5-69c0ee8f3a3a@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1826982447238483803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>> +
> =

> The above isn't wrong, but I question the need for the atomic =

> constructs.=C2=A0 ofono isn't a thread-safe library.
> =

> I see that there other uses of atomic accessors in the codebase, but I =

> believe these are remnants of a past approach with other ambitions... =

> Denis will set me right if I'm wrong about this because this mostly =

> predates my involvement with ofono. :)

oFono was never thread safe, and as you point out, atomic operations are =

not really necessary.  But glib uses atomics for reference counting, so =

we stuck to that.  Also Marcel at some point evangelized that g_atomic =

is the one true way (TM) of implementing reference counting.

With ell we don't use atomics at all.

So given the above, I find both approaches acceptable.

Regards,
-Denis

--===============1826982447238483803==--

