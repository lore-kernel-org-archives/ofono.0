Content-Type: multipart/mixed; boundary="===============8698477759014855930=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: Code standards
Date: Thu, 28 May 2009 10:13:23 +0200
Message-ID: <354ee9be34719bf307ce077240498e6c@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8698477759014855930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


    Hello,

> > I assume the coding styles are the "usual" ones, and the last thing I
want is =

> > to start a flame war about those. But which C dialect is Ofono supposed
to be =

> > written in? plain C89, C89 syntax + C99 library, full C99, GNU C... ?

> the coding style of oFono is the same as for the Linux kernel, BlueZ,
> ConnMan, obexd etc. So basically checkpatch.pl patches are fine.

I am not wondering what the cosmetic style is. I am wondering what parts of
the C language are used. Namely many (most?) C programmers claim to use
ANSI C a.k.a. C89 even though there are using lots of GNU C and/or C99
extensions. Inline functions, C++-styled comments, non-constant variable
initializers, variadic macros, named initializers for structs and
fixed-size integer types and (v)snprintf() are perhaps the most commonly
used C99 features. Restricted pointers, variable-sized arrays, mixed
variables and code (including C++-style for() loops), new printf() format
modifiers (e.g. %zu for size_t), booleans and compound initializers are
arguably more "controversial" or less commonly used, but nevertheless
standard.
I tend pretty much all of them (and avoid GNU-specifics like a :? b)
because I don't care about legacy compilers like gcc 2.x or MSVC, but I
don't want to start a religion war.

A related issue is how careful/pedantic use of integer types should be.
Kernel core or glib tend to be sloppy about int vs (s)size_t.

> When using ./bootstrap-configure is used it enables a certain set of GCC
> warnings and it should be warnings free. So that is good measurement for
> the style details ;)

As a matter of fact, current HEAD is failing here with gcc 4.3:
../../src/voicecall.c: In function =E2=80=98ofono_voicecall_notify=E2=80=99:
../../src/voicecall.c:1239: error: =E2=80=98v=E2=80=99 may be used uninitia=
lized in
this function

-- =

R=C3=A9mi


--===============8698477759014855930==--

