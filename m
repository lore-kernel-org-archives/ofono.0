Content-Type: multipart/mixed; boundary="===============6659662389569762426=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] qmi: add LTE atom driver
Date: Thu, 01 Mar 2018 09:06:02 -0600
Message-ID: <482133b8-755c-3249-2374-bb20110839e6@gmail.com>
In-Reply-To: <4884d76b-6fe5-bc62-3815-ebf21a333b84@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6659662389569762426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>> Please merge patch 1 & 2 together, that's how we usually do it anyway.
> =

> OK.=C2=A0 I broke those up because I thought you were super-pedantic abou=
t =

> breaking out patches so they were per-file... what's the rule here? =

> Per-directory?

It is per-directory, with the build system being the exception.  E.g. if =

you're adding foo/bar/baz.c to Makefile.am, then Makefile.am changes =

should go with the baz.c changes.  Any files touched that are directly =

related and in the same directory can be grouped together.

If in doubt, keep things separate.  I can easily squash them together =

before pushing.

Regards,
-Denis

--===============6659662389569762426==--

