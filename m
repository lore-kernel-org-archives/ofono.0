Content-Type: multipart/mixed; boundary="===============0819347227755313792=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus v5 14/17] automake: fix generation of symlinks for
 headers
Date: Fri, 06 Aug 2010 09:53:54 -0700
Message-ID: <1281113634.9561.2.camel@localhost.localdomain>
In-Reply-To: <1281061343.12579.119.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0819347227755313792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-08-05 at 19:22 -0700, Marcel Holtmann wrote: =

> Hi Inaky,
> =

> > When running 'make distcheck' from a vpath build directory (ie: one
> > that is not where the source lives), the target headers in
> > include/ofono are not generated properly due to a typo in the
> > Makefile.am, that is using _srcdir where _buildir should be being
> > used.
> > ---
> >  Makefile.am |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > =

> > diff --git a/Makefile.am b/Makefile.am
> > index b64ce8e..28d1e77 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -446,7 +446,7 @@ include/ofono/version.h: include/version.h
> >  =

> >  include/ofono/%.h: include/%.h
> >  	$(AM_V_at)$(MKDIR_P) include/ofono
> > -	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
> > +	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
> =

> are we having the same problem in ConnMan. I am seeing only builddir be
> used for the version.h generation.

Sorry, not groking what do you mean. So yes, this does exactly the same
thing as done for version.h, where it works pretty well.

Haven't tried connman, but it will have the same problem if you use a
similar construct.


--===============0819347227755313792==--

