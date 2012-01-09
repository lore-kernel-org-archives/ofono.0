Content-Type: multipart/mixed; boundary="===============5871842178210712205=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/5] speedup: Check for supported modem capabilities first
Date: Mon, 09 Jan 2012 11:36:20 -0800
Message-ID: <1326137780.6454.151.camel@aeonflux>
In-Reply-To: <4F088E4B.7010708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5871842178210712205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >  plugins/speedup.c |   40 ++++++++++++++++++++++++++++++++++++++--
> >  1 files changed, 38 insertions(+), 2 deletions(-)
> > =

> > diff --git a/plugins/speedup.c b/plugins/speedup.c
> > index a90dfe3..f03f8f3 100644
> > --- a/plugins/speedup.c
> > +++ b/plugins/speedup.c
> > @@ -25,6 +25,7 @@
> >  =

> >  #include <errno.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> >  =

> >  #include <glib.h>
> >  #include <gatchat.h>
> > @@ -47,11 +48,15 @@
> >  #include <drivers/atmodem/atutil.h>
> >  #include <drivers/atmodem/vendor.h>
> >  =

> > +static const char *gcap_prefix[] =3D { "+GCAP:", NULL };
> > +
> >  struct speedup_data {
> >  	GAtChat *modem;
> >  	GAtChat *aux;
> >  	gboolean have_sim;
> >  	struct at_util_sim_state_query *sim_state_query;
> > +	gboolean have_gsm;
> > +	gboolean have_cdma;
> =

> It might be a good idea to use a single gboolean, or better yet an enum
> here instead.  There's no point to waste 8 bytes when a single byte can d=
o.

I did this on purpose for the Huawei driver. We can unify this later on,
but at this moment I rather see what is actually happening.

Since we keep parsing all capabilities, I wanna avoid that a later one
overwrites a previous one. That said, just using some flags would be
better anyway. Especially since we also always have have_sim as well.

However that can be done as a further optimization in the Speedup and
Huawei drivers.

Regards

Marcel



--===============5871842178210712205==--

