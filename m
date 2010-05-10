Content-Type: multipart/mixed; boundary="===============0006178753181530214=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] gatio: do not read if no read_handler
Date: Mon, 10 May 2010 10:12:38 -0700
Message-ID: <20100510101238.2fea78ef@kcaccard-MOBL3>
In-Reply-To: <201005100911.52873.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0006178753181530214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 10 May 2010 09:11:52 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Kristen,
> =

> > If no read_handler specified, leave data alone in case someone
> > else wants to read it.
> > ---
> >  gatchat/gatio.c   |    4 ++++
> >  gatchat/gsmdial.c |   12 ++++--------
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> > =

> > diff --git a/gatchat/gatio.c b/gatchat/gatio.c
> > index 61b0260..b4a3806 100644
> > --- a/gatchat/gatio.c
> > +++ b/gatchat/gatio.c
> > @@ -91,6 +91,10 @@ static gboolean received_data(GIOChannel *channel,
> >  GIOCondition cond, if (cond & G_IO_NVAL)
> >  		return FALSE;
> > =

> > +	/* if nobody wants this data, leave it alone */
> > +	if (io->read_handler =3D=3D NULL)
> > +		return TRUE;
> > +  =

> =

> This is a really bad idea, we should never have cases where the read hand=
ler =

> is unset, and if we do we should end up closing the socket when the buffe=
r is =

> full.

In your implementation of g_at_chat_suspend, you set the read handler to NU=
LL.


--===============0006178753181530214==--

