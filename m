Content-Type: multipart/mixed; boundary="===============4427161910657429075=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv5] plugin: Add ste modem initd integration
Date: Tue, 11 Jan 2011 14:05:42 -0800
Message-ID: <1294783542.3873.39.camel@aeonflux>
In-Reply-To: <4D2CD1FE.4070601@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4427161910657429075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >>> so these are declared as get_modems(void) btw. The compiler should ha=
ve
> >>> warned you about this.
> >>
> >> I don't get a compiler warning for this one, not even with -Wall
> >> -Wextra -Wpedantic on GCC 4.4.3.
> >> But a new rule in the coding-style should perhaps be added, e.g:
> >>
> >> M15: Use void if function has no parameters
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> A function with no parameters must use void in the parameter list.
> >> Example:
> >> 1)
> >> void foo(void)
> >> {
> >> }
> >>
> >> 2)
> >> void foo()	// Wrong
> >> {
> >> }
> > =

> > please go ahead and send a patch for this. I am happily adding it.
> > =

> =

> Sorry I'm not following why this is a good idea?

we have always declared functions with no parameters as (void) and not
as (). At least I have.

Regards

Marcel



--===============4427161910657429075==--

