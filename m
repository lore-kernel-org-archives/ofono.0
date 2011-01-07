Content-Type: multipart/mixed; boundary="===============2505820261485662441=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] Fix compile warning at MeeGo The gcc version is MeeGo
 4.5.1
Date: Thu, 06 Jan 2011 19:28:30 -0800
Message-ID: <1294370910.2501.16.camel@aeonflux>
In-Reply-To: <FC2FB65B4D919844ADE4BE3C2BB739AD34CC43F8@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2505820261485662441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> > >  src/call-forwarding.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> > > index 512f223..36ba4f1 100644
> > > --- a/src/call-forwarding.c
> > > +++ b/src/call-forwarding.c
> > > @@ -246,7 +246,7 @@ static gboolean is_cfu_enabled(struct
> > ofono_call_forwarding *cf,
> > >  static void sim_set_cf_indicator(struct ofono_call_forwarding *cf)
> > >  {
> > >  	gboolean cfu_voice;
> > > -	struct ofono_call_forwarding_condition *cond;
> > > +	struct ofono_call_forwarding_condition *cond =3D NULL;
> > >
> > >  	cfu_voice =3D is_cfu_enabled(cf, &cond);
> > =

> > I really hate trying to fix compiler warnings like this.
> > =

> >         /*
> >          * For now we only support Voice, although Fax & all Data
> >          * basic services are applicable as well.
> >          */
> >         for (; l; l =3D l->next) {
> >                 cond =3D l->data;
> > =

> >                 if (cond->cls > BEARER_CLASS_VOICE)
> >                         continue;
> > =

> >                 if (out)
> >                         *out =3D cond;
> > =

> >                 return TRUE;
> >         }
> > =

> >         return FALSE;
> > =

> > So this is clearly a false positive. The only why this would fail is
> This is not a false positive, it is quite possible not to reach the "for(=
;;)" branch, and uninitialized the *cond.
> I have added
> *out =3D NULL;
> Out of the branch, and found that the warning gone.
> So here I think gcc is right, and we need the patch.

it is a false positive.

The only caller that uses the cond value is sim_set_cf_indicator. And it
only uses conf if the return value is TRUE. So where can this go wrong?

Regards

Marcel



--===============2505820261485662441==--

