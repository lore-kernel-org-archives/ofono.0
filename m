Content-Type: multipart/mixed; boundary="===============5414387352267520069=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: [PATCH 4/4] make bluetooth.{c,h} a static library
Date: Sun, 18 Jul 2010 20:23:22 -0300
Message-ID: <20100718232322.GC3406@vigoh>
In-Reply-To: <1279494621.4572.13.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5414387352267520069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2010-07-18 16:10:21 -0700]:

> Hi Gustavo,
> =

> > > >  Makefile.am         |    7 +++----
> > > >  plugins/bluetooth.c |    3 ---
> > > >  2 files changed, 3 insertions(+), 7 deletions(-)
> > > =

> > > why are we doing this exactly? If I missed it, please explain it again
> > > since I am not sure that I agree.
> > =

> > We are doing this for the DUN daemon. As you guys said to me it will be
> > separated daemon in oFono sources, so we need bluetooth.c as a static
> > library to reuse it in the DUN daemon.
> =

> we need to discuss this again. I am not sure it is the best idea to have
> this as a separate daemon. I argue with myself forth and back on this
> idea. One option is to do this as an oFono atom, another one is to do
> this as a separate daemon. Currently the atom idea is winning.

Ok, so I'll wait to continue my implementation of the DUN client. I
don't know the oFono internal too much to help on that decision.
 =

> Also there is no need to create a static library for doing this. That is
> just wrong. We can do the build magic with autofoo properly and without
> having to use a hack with a static library.

I meant build statically here like gatchat, without any hack with static
library. ;)

-- =

Gustavo F. Padovan
http://padovan.org

--===============5414387352267520069==--

