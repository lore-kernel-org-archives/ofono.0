Content-Type: multipart/mixed; boundary="===============6941489102158807032=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH] Fix: transaction id usage in gisi/server.c
Date: Fri, 23 Apr 2010 15:46:28 +0200
Message-ID: <0f719e09b0048c8e277f38b1937eeb11@chewa.net>
In-Reply-To: <h2g80fd4e751004230607t327144f8ze035f37c184c1cdf@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6941489102158807032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 23 Apr 2010 16:07:11 +0300, Pekka Pessi <ppessi@gmail.com> wrote:
> 2010/4/23 Denis Kenzior <denkenz@gmail.com>:
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(void *)&spn, (sizeof spn)) !=3D
> (sizeof req)) {
>>
>> Casting to or from void is not necessary.
> =

> Oh, it is. If a struct sockaddr_pn structure is casted directly to
> struct sockaddr, gcc will issue alignment warning on ARM.

The cast-align warning is a can of false positives. First that warning
should probably not be enabled. It does nothing on x86, and it's a waste of
time with ARM and other pointer-picky platforms.

Most importantly, using -Werror _by_default_ is a _damn_idiotic_ idea. Been
there, done that. One cannot know what weird warning any given compiler or
version thereof will ever return. And then I don't need to mention "bugs"
in header files from underlying components. Even changing GCC optimization
levels can yield different conflicting warnings. That's known to happen for
uninitialized values detection, which relies on optimization-dependent code
analysis as an example.

Note that recent GCC versions allow turning only some warnings as errors
with -Werror... and -Wno-error.... That's much saner; for instance calling
a function without prototype is clearly a bug and it is quite reasonable to
make it an error.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============6941489102158807032==--

