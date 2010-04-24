Content-Type: multipart/mixed; boundary="===============4519501846029192094=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH] Fix: clean-local target
Date: Sat, 24 Apr 2010 09:57:10 +0300
Message-ID: <201004240957.11094.remi@remlab.net>
In-Reply-To: <1272039918.22838.89.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4519501846029192094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le vendredi 23 avril 2010 19:25:18 Marcel Holtmann, vous avez =C3=A9crit :
> Hi Pekka,
> =

> >  Makefile.am |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 86ccf1b..db7e33e 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -426,5 +426,5 @@ include/ofono/%.h: include/%.h
> >  	$(AM_V_at)$(MKDIR_P) include/ofono
> >  	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
> >
> > -clean-local: include/ofono
> > -	@$(RM) -r $<
> > +clean-local:
> > +	$(RM) -rf include/ofono
> =

> what is this trying to fix?

Not -pointlessly- build include/ofono just before removing it.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/
http://fi.linkedin.com/in/remidenis

--===============4519501846029192094==--

