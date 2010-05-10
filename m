Content-Type: multipart/mixed; boundary="===============1642770942580364600=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatio: do not read if no read_handler
Date: Mon, 10 May 2010 12:23:04 -0500
Message-ID: <201005101223.05054.denkenz@gmail.com>
In-Reply-To: <20100510101238.2fea78ef@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1642770942580364600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> On Mon, 10 May 2010 09:11:52 -0500
> =

> Denis Kenzior <denkenz@gmail.com> wrote:
> > Hi Kristen,
> >
> > > If no read_handler specified, leave data alone in case someone
> > > else wants to read it.
> > > ---
> > >  gatchat/gatio.c   |    4 ++++
> > >  gatchat/gsmdial.c |   12 ++++--------
> > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/gatchat/gatio.c b/gatchat/gatio.c
> > > index 61b0260..b4a3806 100644
> > > --- a/gatchat/gatio.c
> > > +++ b/gatchat/gatio.c
> > > @@ -91,6 +91,10 @@ static gboolean received_data(GIOChannel *channel,
> > >  GIOCondition cond, if (cond & G_IO_NVAL)
> > >  		return FALSE;
> > >
> > > +	/* if nobody wants this data, leave it alone */
> > > +	if (io->read_handler =3D=3D NULL)
> > > +		return TRUE;
> > > +
> >
> > This is a really bad idea, we should never have cases where the read
> > handler is unset, and if we do we should end up closing the socket when
> > the buffer is full.
> =

> In your implementation of g_at_chat_suspend, you set the read handler to
>  NULL.
> =


Correct, with the intent that someone else sets the read handler (e.g. =

g_at_ppp)

Regards,
-Denis

--===============1642770942580364600==--

