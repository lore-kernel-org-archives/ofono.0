Content-Type: multipart/mixed; boundary="===============7252900263368581775=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/4] make bluetooth.{c,h} a static library
Date: Sun, 18 Jul 2010 16:10:21 -0700
Message-ID: <1279494621.4572.13.camel@localhost.localdomain>
In-Reply-To: <20100718230522.GB3406@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7252900263368581775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> > >  Makefile.am         |    7 +++----
> > >  plugins/bluetooth.c |    3 ---
> > >  2 files changed, 3 insertions(+), 7 deletions(-)
> > =

> > why are we doing this exactly? If I missed it, please explain it again
> > since I am not sure that I agree.
> =

> We are doing this for the DUN daemon. As you guys said to me it will be
> separated daemon in oFono sources, so we need bluetooth.c as a static
> library to reuse it in the DUN daemon.

we need to discuss this again. I am not sure it is the best idea to have
this as a separate daemon. I argue with myself forth and back on this
idea. One option is to do this as an oFono atom, another one is to do
this as a separate daemon. Currently the atom idea is winning.

Also there is no need to create a static library for doing this. That is
just wrong. We can do the build magic with autofoo properly and without
having to use a hack with a static library.

Regards

Marcel



--===============7252900263368581775==--

