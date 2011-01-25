Content-Type: multipart/mixed; boundary="===============2197580422113515887=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Don't use c++ keyword in public header files
Date: Tue, 25 Jan 2011 15:58:43 +0100
Message-ID: <1295967523.1520.51.camel@aeonflux>
In-Reply-To: <AANLkTi=sGNer4hcBGvMLSdYpMsj_y98cK517N2r+S9Dz@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2197580422113515887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> >> -                     const char *old, const char *new,
> >> +                     const char *p_old, const char *p_new,
> >>                       ofono_sim_lock_unlock_cb_t cb, void *data);
> >>       void (*lock)(struct ofono_sim *sim, enum ofono_sim_password_type=
 type,
> >>                       int enable, const char *passwd,
> >
> > why is this exactly a problem?
> =

> I did it only because the file contains this:
> =

> #ifdef __cplusplus
> extern "C" {
> #endif
> =

> =

> So I thought someone might want to write a plugin in C++ or something
> that includes sim.h

and at that point you told the compiler that it is C code and not C++
and it should be just fine.

> > And if you really wanna do that, then please not something cryptic like
> =

> No, I don't want. If nobody will use C++, I'm fine the way it is. Then
> we might want to remove that ifdef, because it will not compile
> anyway.

I think it will compile just fine. Try to test it ;)

Regards

Marcel



--===============2197580422113515887==--

