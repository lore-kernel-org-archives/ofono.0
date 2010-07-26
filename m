Content-Type: multipart/mixed; boundary="===============4800202697038272043=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 12/20] struct tx_queue_entry: add a destructor
Date: Mon, 26 Jul 2010 11:48:43 -0700
Message-ID: <1280170123.26204.170.camel@localhost.localdomain>
In-Reply-To: <4C4A2269.1050404@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4800202697038272043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-23 at 16:14 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> >> tx_queue_entry * here.  Casting the destructor in g_foo_foreach is
> >> acceptable.
> > =

> > Heh, I'd rather have it like this: Repeat after me in a 1000-loop: casts
> > are evil and should be avoided for they muck the code by hiding warnings
> > when you change things and miss updating all the sites ... =

> > =

> =

> I fully agree, but the extra silly NULL argument makes this worse than
> the cast.  And to be clear, g_foo_foreach is about the only place we
> explicitly allow casts.  If you feel you need to be pedantic, then write
> a GFunc specifically to do the foreach bit.
> =

> e.g. tx_queue_entry_free(struct tx_queue_entry *);
> =

> txq_foreach_free(gpointer foo, gpointer user)
> {
>   struct tx_queue_entry *bar =3D foo;
>   tx_queue_entry_free(bar);
> }
> =


Done


--===============4800202697038272043==--

