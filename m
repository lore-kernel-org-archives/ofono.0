Content-Type: multipart/mixed; boundary="===============1313845204333186186=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] Remove superfluous definitions of _GNU_SOURCE
Date: Wed, 17 Oct 2018 10:03:12 -0500
Message-ID: <0c3424d8-7346-3db7-3161-ba70a80723c2@gmail.com>
In-Reply-To: <20181017102304.5857-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1313845204333186186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 10/17/2018 05:23 AM, Jonas Bonn wrote:
> There are a large number of files in the tree that define _GNU_SOURCE
> despite not actually using features hidden behind this flag.  This patch
> removes all these definitions in one fell swoop...
> ---
> =

> I realize that it's not quite kosher in ofono to send pathes that touch
> more than directory.  Breaking this up into separate patches doesn't
> really make sense though, given its nature.  If the list insists,
> though, I can break this up into a series of ~50 patches...
> =


Yes, fair enough.  But:

drivers/mbimmodem/mbim.c: In function =E2=80=98receive_header=E2=80=99:
drivers/mbimmodem/mbim.c:423:16: error: implicit declaration of function =

=E2=80=98TEMP_FAILURE_RETRY=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
   ssize_t len =3D TEMP_FAILURE_RETRY(read(fd,
                 ^~~~~~~~~~~~~~~~~~


tools/tty-redirector.c: In function =E2=80=98accept_handler=E2=80=99:
tools/tty-redirector.c:249:8: error: implicit declaration of function =

=E2=80=98accept4=E2=80=99; did you mean =E2=80=98accept=E2=80=99? [-Werror=
=3Dimplicit-function-declaration]
   nfd =3D accept4(fd, (struct sockaddr *) &addr, &addrlen, SOCK_CLOEXEC);
         ^~~~~~~
         accept


Anyway, I was nice and fixed these for you.  It compiles cleanly for me =

and I applied this patch.

Regards,
-Denis

--===============1313845204333186186==--

