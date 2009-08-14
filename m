Content-Type: multipart/mixed; boundary="===============4389394671219505111=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Missing file in repo
Date: Fri, 14 Aug 2009 10:07:34 -0500
Message-ID: <200908141007.35744.denkenz@gmail.com>
In-Reply-To: <e6430ef40597b86b1d4af03634f1c964@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4389394671219505111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> Seems like a file is missing in GIT:
>
> In file included from ../../plugins/example_history.c:33:
> ../../src/driver.h:22:25: error: ofono/types.h: No such file or directory

types.h is a new include that has been added.  The current automake magic =

seems to not handle this case well.  make clean; make inside include/ shoul=
d =

stop the compiler complaining.

Regards,
-Denis

--===============4389394671219505111==--

