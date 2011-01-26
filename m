Content-Type: multipart/mixed; boundary="===============8377974639356234813=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Don't use c++ keyword in public header files
Date: Wed, 26 Jan 2011 10:58:45 +0100
Message-ID: <1296035925.1520.102.camel@aeonflux>
In-Reply-To: <AANLkTi=DcdFHC1yUE16-gVvXzU9nz-rhdeErq3TwvwqQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8377974639356234813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> >> >> -                     const char *old, const char *new,
> >> >> +                     const char *p_old, const char *p_new,
> >> >>                       ofono_sim_lock_unlock_cb_t cb, void *data);
> >> >>       void (*lock)(struct ofono_sim *sim, enum ofono_sim_password_t=
ype type,
> >> >>                       int enable, const char *passwd,
> >> >
> >> > why is this exactly a problem?
> >>
> >> I did it only because the file contains this:
> >>
> >> #ifdef __cplusplus
> >> extern "C" {
> >> #endif
> >>
> >>
> >> So I thought someone might want to write a plugin in C++ or something
> >> that includes sim.h
> >
> > and at that point you told the compiler that it is C code and not C++
> > and it should be just fine.
> =

> This only works for the link phase, because of the name mangling in C++.
> =

> > I think it will compile just fine. Try to test it ;)
> =

> It doesn't. Example:

fair enough. Send a patch that uses one of the other proposed names. And
you might wanna update the atmodem and isimodem driver as well to just
be consistent.

Regards

Marcel



--===============8377974639356234813==--

