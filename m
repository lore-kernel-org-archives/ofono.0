Content-Type: multipart/mixed; boundary="===============3670232802201335988=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Code standards
Date: Thu, 28 May 2009 10:08:12 -0500
Message-ID: <200905281008.13228.denkenz@gmail.com>
In-Reply-To: <354ee9be34719bf307ce077240498e6c@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3670232802201335988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> I am not wondering what the cosmetic style is. I am wondering what parts =
of
> the C language are used. Namely many (most?) C programmers claim to use
> ANSI C a.k.a. C89 even though there are using lots of GNU C and/or C99
> extensions. Inline functions, C++-styled comments, non-constant variable
> initializers, variadic macros, named initializers for structs and
> fixed-size integer types and (v)snprintf() are perhaps the most commonly

There is no formal written down standard.  Do keep in mind that oFono is a =

core linux daemon, hence we don't care about compilers other than gcc.  Tha=
t =

means we use lots of _GNU_SOURCE and gcc extensions, especially when they m=
ake =

the code simpler and easier to follow.

As a simple rule: if a certain style element has been used in oFono before,=
 it =

is safe to assume it can be used again.  However, the maintainers have the =

final say on coding style issues.

> used C99 features. Restricted pointers, variable-sized arrays, mixed
> variables and code (including C++-style for() loops), new printf() format
> modifiers (e.g. %zu for size_t), booleans and compound initializers are
> arguably more "controversial" or less commonly used, but nevertheless
> standard.
> I tend pretty much all of them (and avoid GNU-specifics like a :? b)
> because I don't care about legacy compilers like gcc 2.x or MSVC, but I
> don't want to start a religion war.
>
> A related issue is how careful/pedantic use of integer types should be.
> Kernel core or glib tend to be sloppy about int vs (s)size_t.
>
> > When using ./bootstrap-configure is used it enables a certain set of GCC
> > warnings and it should be warnings free. So that is good measurement for
> > the style details ;)
>
> As a matter of fact, current HEAD is failing here with gcc 4.3:
> ../../src/voicecall.c: In function =E2=80=98ofono_voicecall_notify=E2=80=
=99:
> ../../src/voicecall.c:1239: error: =E2=80=98v=E2=80=99 may be used uninit=
ialized in
> this function

This was not being reported on gcc 4.3.2, but has been fixed upstream =

nevertheless.

Regards,
-Denis


--===============3670232802201335988==--

