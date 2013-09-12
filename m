Content-Type: multipart/mixed; boundary="===============4055558049004998761=="
MIME-Version: 1.0
From: Zhang, Caiwen <caiwen.zhang@intel.com>
Subject: RE: [PATCH] fix ofonod crash when pin is blocked
Date: Thu, 12 Sep 2013 00:53:57 +0000
Message-ID: <DA62CA5DDF4CA640AA25B1684E5D141101D85F2F@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <5230AFE6.6050204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4055558049004998761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > When is blocked, gprs/network atom is removed, it will remove the SIM
> > SPN watch which is added when it is created.
> > If at that time, SIM atom has been removed ofonod will crash due to
> > "sim->spn_watches" is NULL.
> >
> =

> This description makes no sense.  The SIM atom is never removed due to a
> blocked PIN, so can you please provide a more clear description of the is=
sue?
> =

> > There is the same issue about network registration status watch.
> > ---
> >   src/watch.c |    3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/src/watch.c b/src/watch.c index dfb01fb..906c559 100644
> > --- a/src/watch.c
> > +++ b/src/watch.c
> > @@ -53,6 +53,9 @@ gboolean __ofono_watchlist_remove_item(struct
> ofono_watchlist *watchlist,
> >   	GSList *p;
> >   	GSList *c;
> >
> > +	if (watchlist =3D=3D NULL)
> > +		return;
> > +
> =

> This fix is wrong, you're likely just covering up the symptom, not the ca=
use.
> oFono operates on the principle of crash-early, so that bugs are easier t=
o detect
> and find.
> =

> What is the real reason why the watchlist is NULL at the point in time th=
is
> function is being called?

Yes, you are right. The correct comment should be "If at that time, "spn_wa=
tch" has been removed ofonod will crash due to
"sim->spn_watches" is NULL."

"spn_watch" is removed at "sim_free_main_state" function when SIM PIN is bl=
ocked. This is done before gprs/network atom is removed.

About network registration status watch, the original comment is true.

Regards,
Caiwen

--===============4055558049004998761==--

