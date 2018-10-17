Content-Type: multipart/mixed; boundary="===============6241280557804957437=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] Remove superfluous definitions of _GNU_SOURCE
Date: Wed, 17 Oct 2018 13:55:00 +0200
Message-ID: <413B384A-9DBF-489B-AB1B-0D94228F484F@holtmann.org>
In-Reply-To: <8704db57-f6ef-59bc-985c-a91ec08a611a@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6241280557804957437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>>> There are a large number of files in the tree that define _GNU_SOURCE
>>> despite not actually using features hidden behind this flag.  This patch
>>> removes all these definitions in one fell swoop...
>>> ---
>>> =

>>> I realize that it's not quite kosher in ofono to send pathes that touch
>>> more than directory.  Breaking this up into separate patches doesn't
>>> really make sense though, given its nature.  If the list insists,
>>> though, I can break this up into a series of ~50 patches...
>>> =

>>> /Jonas
>> Do all files and the project compile?
> =

> Yes.  At least with the configuration I've got, which is mostly the defau=
lt.
> =

> There are ~5 files where _GNU_SOURCE features are actually used.  Those, =
of course, retain the definition.

I found musl most strict in this regards while glibc is rather relaxed. If =
this compiles with musl cleanly, I am fine.

Regards

Marcel


--===============6241280557804957437==--

