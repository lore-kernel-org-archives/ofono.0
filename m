Content-Type: multipart/mixed; boundary="===============2338217083541107466=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] gatio: do not read if no read_handler
Date: Mon, 10 May 2010 10:22:17 -0700
Message-ID: <20100510102217.68f925dc@kcaccard-MOBL3>
In-Reply-To: <201005101223.05054.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2338217083541107466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 10 May 2010 12:23:04 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Kristen,
> =

> > On Mon, 10 May 2010 09:11:52 -0500
> > =

> > Denis Kenzior <denkenz@gmail.com> wrote:
> > > Hi Kristen,
> > >
> > > > If no read_handler specified, leave data alone in case someone
> > > > else wants to read it.
> > > > ---
> > > >  gatchat/gatio.c   |    4 ++++
> > > >  gatchat/gsmdial.c |   12 ++++--------
> > > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/gatchat/gatio.c b/gatchat/gatio.c
> > > > index 61b0260..b4a3806 100644
> > > > --- a/gatchat/gatio.c
> > > > +++ b/gatchat/gatio.c
> > > > @@ -91,6 +91,10 @@ static gboolean received_data(GIOChannel *channe=
l,
> > > >  GIOCondition cond, if (cond & G_IO_NVAL)
> > > >  		return FALSE;
> > > >
> > > > +	/* if nobody wants this data, leave it alone */
> > > > +	if (io->read_handler =3D=3D NULL)
> > > > +		return TRUE;
> > > > +
> > >
> > > This is a really bad idea, we should never have cases where the read
> > > handler is unset, and if we do we should end up closing the socket wh=
en
> > > the buffer is full.
> > =

> > In your implementation of g_at_chat_suspend, you set the read handler to
> >  NULL.
> > =

> =

> Correct, with the intent that someone else sets the read handler (e.g. =

> g_at_ppp)

What if you receive data after the read handler is set to NULL, but before
someone else sets the read handler?  shouldn't we safe guard against that?

--===============2338217083541107466==--

