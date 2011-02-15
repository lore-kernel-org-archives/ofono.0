Content-Type: multipart/mixed; boundary="===============6445633564482172162=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Makefile: rerun genbuiltin on reconfigure.
Date: Tue, 15 Feb 2011 15:44:53 -0800
Message-ID: <1297813493.2519.9.camel@aeonflux>
In-Reply-To: <AANLkTinHd+yrYdcEY7NWWztB53aOtByrTKdwPPseYAJ2@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6445633564482172162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> >> -src/builtin.h: src/genbuiltin $(builtin_sources)
> >> +src/builtin.h: src/genbuiltin config.status
> >>       $(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
> >
> > so depending on config.status is fine, but why no longer on
> > $(builtin_sources)?
> =

> I didn't see a point for that dependency, it triggers unneeded
> rerunning of genbuiltin as far as I see?

fair enough. Let's try if this gives us any problems. Patch has been
applied.

Regards

Marcel



--===============6445633564482172162==--

