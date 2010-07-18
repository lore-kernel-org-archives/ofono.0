Content-Type: multipart/mixed; boundary="===============7751089984732023468=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/4] make bluetooth.{c,h} a static library
Date: Sun, 18 Jul 2010 16:34:10 -0700
Message-ID: <1279496050.4572.16.camel@localhost.localdomain>
In-Reply-To: <20100718232322.GC3406@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7751089984732023468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> > > > >  Makefile.am         |    7 +++----
> > > > >  plugins/bluetooth.c |    3 ---
> > > > >  2 files changed, 3 insertions(+), 7 deletions(-)
> > > > =

> > > > why are we doing this exactly? If I missed it, please explain it ag=
ain
> > > > since I am not sure that I agree.
> > > =

> > > We are doing this for the DUN daemon. As you guys said to me it will =
be
> > > separated daemon in oFono sources, so we need bluetooth.c as a static
> > > library to reuse it in the DUN daemon.
> > =

> > we need to discuss this again. I am not sure it is the best idea to have
> > this as a separate daemon. I argue with myself forth and back on this
> > idea. One option is to do this as an oFono atom, another one is to do
> > this as a separate daemon. Currently the atom idea is winning.
> =

> Ok, so I'll wait to continue my implementation of the DUN client. I
> don't know the oFono internal too much to help on that decision.

I was talking about the server and not the client. For the client we
have to have a chat about it. I might have missed parts of the initial
discussion.
 =

> > Also there is no need to create a static library for doing this. That is
> > just wrong. We can do the build magic with autofoo properly and without
> > having to use a hack with a static library.
> =

> I meant build statically here like gatchat, without any hack with static
> library. ;)

Actually gatchat is not build statically. It is build as part of out AT
modem driver. That it is in separate directory is purely cosmetic.

Regards

Marcel



--===============7751089984732023468==--

