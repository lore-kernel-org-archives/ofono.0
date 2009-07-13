Content-Type: multipart/mixed; boundary="===============6939316814867331942=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Compiler errors.
Date: Mon, 13 Jul 2009 13:26:40 +0200
Message-ID: <1247484400.9709.138.camel@localhost.localdomain>
In-Reply-To: <4A5ACA4C.2000802@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6939316814867331942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> with the latest oFono git version I'm getting the following compiler
> errors when using gcc (Ubuntu 4.3.3-5ubuntu4) 4.3.3.
> =

> ----
> =

> gcc -DHAVE_CONFIG_H -I. -I.. -I../include -I../src
> -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include   -g -O2 -Werror
> -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
> -Wdeclaration-after-statement -Wmissing-declarations -Wredundant-decls
> -Wcast-align -MT smsutil.o -MD -MP -MF .deps/smsutil.Tpo -c -o smsutil.o
> `test -f '../src/smsutil.c' || echo './'`../src/smsutil.c
> cc1: warnings being treated as errors
> ../src/smsutil.c: In function =E2=80=98sms_extract_common=E2=80=99:
> ../src/smsutil.c:1442: error: =E2=80=98dcs=E2=80=99 may be used uninitial=
ized in this
> function
> ../src/smsutil.c:1441: error: =E2=80=98udhi=E2=80=99 may be used uninitia=
lized in this
> function

I didn't see them when building the release, but some distro compilers
are a different.

Denis, care to fix these please.

Regards

Marcel



--===============6939316814867331942==--

